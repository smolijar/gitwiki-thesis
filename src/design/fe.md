# Front-End

The FE application is built of the following composites:

 - Next.js pages^[Next.js pages are technically React components as well, only decorated with required features. Semantically however, they are distinct from simple components in a Next.js application.]
 - React components
 - Redux actions, reducers and sagas
 - other utility modules

\begin{sidewaysfigure}[!htbp]\centering
	\includegraphics[width=\textwidth]{./src/assets/diagram/fe}
	\caption{Design: Front-end application}\label{fig:design:fe}
\end{sidewaysfigure}

All crucial components and modules from categories above are on the diagram \ref{fig:design:fe}.

## Pages

The pages are React components representing individual web pages (HTTP responses) served by the server for a user's request.
Simply, they are responses for all non-API requests.

When used correctly, Next.js will return the first requested page pre-rendered on the server and all the following navigation will happen inside the FE application using Fetch API managed seamlessly by Next.js.

 - `Index` -- Homepage of the application
 - `Repo, Index` -- List of available repositories. This page delegates the rendering of the repository entries itself on the component `Index`.
 - `Repo, Edit` -- Edit page for the selected repository, reference and path. The editing logic is delegated to the `Edit` component.
 - `Repo, Tree` -- Preview of the tree or file on the path, for the given repository and reference. If the path defines a file (not a folder), its rendering is passed to the `Preview` component.

The pages are wrapped in the `Layout` component with shared components (user widget, navigation bar, footer, etc.).
Pages can pass `Breadcrumbs` or `SideMenu` component to the `Layout`.


## Components

Components represent composite or complex UI elements wrapped in a usable unit within the React application.

### Layout
- `Layout` -- HOC component wrapping page contents with reusable layout widgets. It uses `Widget` to display logged in user data in main navigation bar.
- `SideMenu` -- Context-relevant secondary navigation. This includes button triggering commit modal, thus using the related component.
- `Breadcrumbs` -- Breadcrumbs menu uses `References` component.

### User

- `User, Widget` -- Displays the login button or the logged-in user's data.
- `User, PersonalToken` -- Form control allowing the user to publish GitHub personal access token to access their repositories.

### Repo

- `Repo, References` -- Breadcrumb fragment widget, which loads available references and takes care of the navigation using Git references.
- `Repo, Revision, Modal` -- Modal window with the current changes and a form for the commit submission.
- `Repo, Index, Index` -- List of available repositories. Single repository record is delegated to the `IndexEntry` component.
- `Repo, Index, IndexEntry` -- Single repository entry component.
- `Repo, Blob, Edit` -- Form component for editing a given file.
- `Repo, Blob, Preview` -- File preview component, allowing to switch between the source code preview and the rendered document in case of supported markup file.

## React components

The components and pages from the diagram \ref{fig:design:fe} are all React components, as stated before.
The both groups are tellingly wrapped in a folder in the diagram, hence they share some features.

All _react components_ share PropTypes^[PropTypes [@react:proptypes] are a type-checking mechanism for validating React _props_ passed onto React components.] definitions from the `client` package.

Pages and components alike generally access `endpoints` for navigation (generating links)^[Endpoints are located in the `common` package, allowing the server and the `client` to access the identical set of path definitions.] and `fetchApi`, which is an interface for making requests to the server.
All Pages and some components are connected to the Redux store, from which they can access data and dispatch actions.

## Client

This package holds modules usable by the client code and not the server.
There are PropTypes definitions, which is convenient, for they are usually shared or composited.
Apart from that there is a small module for persisting user session in the _local storage_, for keeping the session in the FE application.

## Common

`Common` module is for code usable by both FE and BE.
`Endpoints` module provides definitions of the routes, which are accessed by BE router as well as used when creating navigation links within the FE application.
`FetchApi` is a proxy service for making requests to the server's API.
This module in the `Common`, not the `Client` package for the following reason:
Having the proxy capable of handling requests made by server to itself is a smart decision, which eventually allows to define initialization of the pages uniformly, regardless the fact that it is rendered in the browser or on the server due to SSR.

## Redux

The Redux package includes codes for defining and managing the FE application state.

The `Action` package defines action types constants^[This is how action is identified. Every action in Redux has a *type* property with an appropriate string identifier.] as well as the action creators, which create action objects from the given data^[Usually just setting the mentioned type property.].

The `Reducers` are functions which take the dispatched action and transform the existing state into a new one, based on the action's type.
Reducers operate in a synchronous fashion.

The `Sagas` are tools for creating side effects.
They can react to the triggered actions, but they cannot create a new state.
They can only dispatch new actions.
This is useful for asynchronous operations.

`Store` is implemented by the Redux library and only its configuration is required.
