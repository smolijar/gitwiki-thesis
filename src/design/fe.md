# Front-End

The FE application is built of the following composites:
 
 - Next.js pages^[Next.js pages are technically React components as well, only decorated with required features. Semantically however, they are distinct from simple components in Next.js application.]
 - React components
 - Redux actions, reducers and sagas
 - other utility modules

\begin{sidewaysfigure}[!htbp]\centering
	\includegraphics[width=\textwidth]{./src/assets/diagram/fe}
	\caption{Design: Front-end application}\label{fig:design:fe}
\end{sidewaysfigure}

All crucial components and modules from categories above are on the diagram \ref{fig:design:fe}.

## Pages

Pages are React components representing the individual web pages (HTTP responses) served by the server for a user's request.
Basically they are responses for all non-API requests.

When used correctly, Next.js will return the first requested page pre-rendered on the server and all the following navigation will happen inside the client application using XHR managed seamlessly by Next.js.

 - `Index` -- Homepage of Gitwiki
 - `Repo, Index` -- List of available repositories. This page delegates the rendering of the repository entries itself on the component `Index`.
 - `Repo, Edit` -- Edit page for selected repository, ref and path. Editing components are delegated to the `Edit` component.
 - `Repo, Tree` -- Preview of the tree or blob, based on the path, for given repository and ref. If path defines a file (not a folder), its rendering is passed to `Preview` component.

Pages are wrapped in a `Layout` component with shared components (user widget, navigation bar, footer, etc.).
Some pages may pass `Breadcrumbs` or `SideMenu` component to the `Layout`.


## Components

Components represent composite or complex UI elements wrapped in a usable unit within Reach application.

### Layout
- `Layout` -- HOC component wrapping page contents with reusable layout widgets. It uses `Widget` to display logged in user data in main navigation bar.
- `SideMenu` -- Context-relevant secondary navigation. This includes button triggering commit modal, thusly using related component.
- `Breadcrumbs` -- Breadcrumbs menu uses `References`.

### User 

- `User, Widget` -- Displays login button or logged-in user data.
- `User, PersonalToken` -- Form control allowing user to publish GitHub personal access token to access their repositories.

### Repo

- `Repo, References` -- Breadcrumb fragment widget, which loads available references and takes care of the navigation using Git references.
- `Repo, Revision, Modal` -- Modal window with current changes and form for commit completion.
- `Repo, Index, Index` -- List of available repositories. Single repository record is delegated to `IndexEntry` component.
- `Repo, Index, IndexEntry` -- Single repository entry component.
- `Repo, Blob, Edit` -- Form component for editing given file.
- `Repo, Blob, Preview` -- File preview component, allowing to switch between source code preview and rendered document in case of supported markup file.

## React components

Components and Pages from the diagram \ref{fig:design:fe} are all React components, as stated before.
Both groups are tellingly wrapped in a folder in the diagram, hence they share some features.

All _React components_ share PropTypes^[PropTypes[@react:proptypes] are type-checking mechanism for validating _props_ passed onto React components.] definitions from the `client` package.

Pages and components alike generally access `endpoints` for navigation (generating links)^[endpoints are located in the `common` package, allowing the server and the `client` to access identical set of path definitions.] and `fetchApi`, which is an interface for making requests to the server.

All Pages and some components are connected to Redux store, from which they can access data and dispatch actions.

## Client

This package holds modules usable by client code and not the server.

There are PropTypes definitions, which is convenient, for they are usually shared and composited.
Apart from that there is a small module for persisting user session in the _local storage_, for keeping the session in FE application.

## Common

`Common` module is for code usable by both FE and BE.

`Endpoints` module provides definitions of the routes, which are accessed by BE router as well as used when creating navigation links within FE application.

`FetchApi` is a proxy service for making requests to the server's API.
A fear that this module should rather be in the client is understandable.
Why would the server make requests to itself?
The answer is:
Having the proxy capable of handling requests made by server to itself is a smart decision, which eventually allows us to define initialization of the pages uniform regardless the fact that it is rendered in the browser or on the server due to SSR.

## Redux

`Redux` package includes codes for defining and managing the FE application state.

`Action` package defines action types constants^[This is how action is identified. Every action in Redux ought to have *type* property with an appropriate string identifier.] as well as action creators, which create action objects from given data^[Usually just setting the mentioned type property.].

`Reducers` are functions which take the dispatched action and based on its type, transform existing state into a new one in a synchronous fashion.

`Sagas` are like reducers in a way.
They can react to triggered actions, but they cannot create a new state.
They can only trigger new actions.
This is useful for asynchronous operations.

`Store` is implemented by the Redux library and only its configuration is required.