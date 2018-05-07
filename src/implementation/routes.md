# Routes

This section tackles the problem of unified, scalable configuration of application's HTTP routing logic, and reusing the setup in BE and FE alike.

The routing in the application, needs to:

- bind routes on Express.js routers and
- provide navigation inside FE Next.js application.

It is a common practice to duplicate the string route definitions, which might be feasible for a small application, or one that does not utilize formatted URLs to this extent.
Otherwise (in this case), the routing becomes unmaintainable as the application grows.

## Independent routing logic

Having the BE and FE completely independent with each other is the easiest approach.
The problem appeared when more than few routes that required formatting its arguments appeared.
This required a refactor of the logic into an in-component helper functions as seen in listing \ref{lst:impl:routes:1}.

```{language=jsx caption="Implementation: Generating routes via inline functions" label="lst:impl:routes:1"}
import Link from 'next/link';

const link = pipe(
  concat('/repo/'),
  join('/'),
  filter(identity),
  props(['name', 'ref', 'path'])
);

// ...
const query = { name, ref, path };
const pathname = '/repo/tree'
const href = { pathname, query }
return(
  <Link
    href={href}
    as={link(query)}>
    <a>{name}</a>
  </Link>
);
```

Since this is the first time the Next.js Link syntax is mentioned, it is briefly explained what the component does.
Next.js provides implementation of the client-side navigation, when the application runs in the browser and takes care of the communication with the server.
This is done not through a standard `<a>` anchor tag, but via a HOC `Link`.

The `Link` accepts (amongst others) the following React *props*^[React component's properties, are in the API documentation referred to as *props*.]:

- **href**
    - This can be either a string, referring to the name of the page^[`repo/tree` will load the component in `pages/repo/tree.js`],
    - or an object, as seen in the listing \ref{lst:impl:routes:1}. The containing the page string under the key `pathname` and the query parameters in `query`.

- **as**
    - When using URL parameters, they are internally handled in the Next.js application through the query parameters.
    To use them in the URL, the definition of how the URL is going to look like in *as* property is required, in form of a string.

    - The *as* property only works in the client navigation.
    The Next.js application sets the document location to match the URL alias.
    However, this is just a visual facade for the client.
    All the communication with the server is handled via the former property, the `href`.
    The FE will prompt the server for the e.g. `repo/tree?name=foo&ref=master&path=src`, no matter the alias.

This of course leads to a problem.
If the user gets to the aliased URL not via the client navigation, but for instance by opening a shared link, the server responds with 404.
The default Next.js handler, if alias URL is requested, e.g. `repo/tree/foo/master/src`, looks for page located in `pages/repo/tree/foo/master/src.js` by default logic and fails to find it, returning a *Not found* error.

This common issue is solved (as written the Next.js documentation) by creating the custom handlers, parsing the arguments from the URL and passing them to an appropriate Next.js render handler with the correct page parameter and query object.

This is already considered in the design, where  FE router is included, which does exactly that.

## Uniform route reference

Anyway, it is clear that the previous solution has some issues.
Namely:

1. In-lining the `link` functions is not ideal for re-usability, since the same endpoint link is probably generated in several distinct components.
It would be more appropriate to define the functions in separate module and import them at convenience into the components in FE.

2. As mentioned, Express.js route patterns need to be defined independently for custom BE handlers, delegating to Next.js handler.
It is inconvenient to have Express.js and Next.js routing configuration separated, since the routes refer to the same thing.

For the stated matters the current solution is insufficient when operating with multiple routes, and code got more and more complicated.

Since there is no appropriate solution for the issue the following design solves the two issues.

```{language=js caption="Implementation: Routes module -- definition" label="lst:impl:routes:2"}
const endpoints = {
  TREE: 'TREE',
  // ...
};

const routes = {
  [endpoints.TREE]: {
    generate: ({ name, ref, path }) => `/repo/tree/${[name, ref, path].filter(identity).join('/')}`,
    express: '/repo/tree/:name/:ref/:path([\\S\\s]+)?',
  },
  // ...
};

exports.endpoints = endpoints;
exports.generate = endpoint => routes[endpoint].generate;
exports.expressPattern = endpoint => routes[endpoint].express;
```


The route definition module example is in the listing \ref{lst:impl:routes:2}.
The user can access the endpoint constants and the `express` route definition and the `generate` function for the FE are side by side.

```{language=js caption="Implementation: Routes module -- back-end" label="lst:impl:routes:3"}
const { expressPattern, endpoints } = require('../../src/routes');

const router = express.Router();

router.get(expressPattern(endpoints.TREE), (req, res) => {
  // ...
});
```

Using the module in BE is fairly easy and readable, as seen in \ref{lst:impl:routes:3}.

```{language=jsx caption="Implementation: Routes module -- front-end" label="lst:impl:routes:4"}
import Link from 'next/link';
import { endpoints, generate } from '../../src/routes';
// ...
const query = { name, ref, path };
const pathname = '/repo/tree'
const href = { pathname, query }
return(
  <Link
    href={href}
    as={generate(endpoints.TREE)(query)}>
    <a>{name}</a>
  </Link>
);
```
How the shared route definition is used in the FE is shown in the listing \ref{lst:impl:routes:4}.

## Uniform route definitions

The previous solution using constants works well for creating an abstraction for the endpoints and places the definitions next to each other, making the code more organized.

There is still room for improvement, however.


The listing \ref{lst:impl:routes:2} features a redundancy, though not painfully obvious.
The `express` pattern holds the very same information as the function `generate`, only in different notation.
A uniform notation of singleton record can be used to represent the route.

The redundancy is more obvious when working with static routes, as showcased in the listing \ref{lst:impl:routes:5}, where the two records are literally identical, apart from one being a function the other the literal value itself.

```{language=js caption="Implementation: Routes module -- definition of a static route" label="lst:impl:routes:5"}
const routes = {
  [endpoints.INDEX]: {
    generate: () => '/repo',
    express: '/repo',
  },
  // ...
};
```

After a research it is discovered what package is used in the Express.js routing^[This is not default JS regular expressions syntax, though it resembles it. JS `RegExp` does not have a support for the named capture groups.].
The Express.js has a function to parse the pattern and extract the parameters.
The custom generate function is just the direct inverse of the parse function, which is provided by the same library.
The package `path-to-regexp` is not only used [@path-to-regexp] by Express.js, but moreover it provides the desired function `compile`, an inverse to `parse`.
All `generate` function are thus redundant, obsolete and can be generated with help of this library.

The difference is obvious from the definition in the listing \ref{lst:impl:routes:6}, where the impact is the most drastic, removing the duplicate isomorphic definitions.

```{language=js caption="Implementation: Routes uniform definition module -- definition" label="lst:impl:routes:6"}
const endpoints = {
  front: {
    tree: '/repo/:provider/:name/tree/:ref/:path([\\S\\s]*)?',
    index: '/repo',
    // ...
  },
};
exports = endpoints;
```

The usage of the new route definition in the BE is almost identical, the wrapper function disappeared, returning the `express` pattern from the endpoint, as seen in the listing \ref{lst:impl:routes:7}.

```{language=js caption="Implementation: Routes uniform definition module -- back-end" label="lst:impl:routes:7"}
const { front } = require('../../common/endpoints');

const router = express.Router();

router.get(front.tree, (req, res) => {
  // ...
});
```

On the FE, all the missing `generate` functions are substituted with a single `compile` function form the package `path-to-regexp` as seen in the listing \ref{lst:impl:routes:8}.

```{language=jsx caption="Implementation: Routes uniform definition module -- front-end" label="lst:impl:routes:8"}
import Link from 'next/link';
import { compile } from 'path-to-regexp';
import { front } from '../common/endpoints';
// ...
const query = { name, ref, path };
const pathname = '/repo/tree'
const href = { pathname, query }
return(
  <Link
    href={href}
    as={compile(front.tree)(query)}>
    <a>{name}</a>
  </Link>
);
```