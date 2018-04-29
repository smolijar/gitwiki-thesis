# Technologies and tools

No web application nowadays is written from a scratch.
There are various tools to fasten up the development process and make it easier.

In this section I shall state what tools and libraries I have chosen to use for the project.
There are several issues that are usually solved by an existing library.
It is discussed in this chapter and not in the implementation, because in some cases it might effect the architecture or the components of the designed system.

Since there are quite a few of system features that can be covered by existing libraries and they have much lesser overall effect on the system^[Compared to the Git SSH authorization layer e.g., which required more structured analysis], I shall not dwell on the details of the libraries and its alternatives, nor make a detail review of the similar software.

## FE framework

FE of the application is no more a trivial jQuery script with a few user interactions in browser, like it was fairly popular several years ago.
More and more tasks are expected to be performed inside a browser for better UX and more dynamic effect.

This also calls for a solution for building complex FE applications.

There are few popular solutions for FE frameworks like Angular 2, React and Vue or Ember.

I have chosen to use React, being fairly the most popular among its alternatives, and fast and easy to use, thanks to JSX syntax and its virtual DOM.

## SSR

Many websites rely too much on the FE technologies, resulting in a monolithic so-called _single-page applications_.
When almost all the logic happens in the browser and the server's HTML response contains (more or less) only the `<script>` tag, several issues arise.
The hardest problems face the clients that cannot interpret JS.

This might seem banal, for generally speaking all the users use browsers with JS engine.
The problem gets more real with non-user agents, like search engine spiders for instance.

This issue is tacked by several libraries, from which I chose to work with Next.js[@next] with native support and easy setup for React.

## FE State container

Facebook introduced[@flux] the Flux architecture in 2014 to solve the complexity of MVC's nontransparent dependencies for complex systems with many models and views via a linear unidirectional data flow.

The main idea behind Flux is to linearize the uncontrolled flow between models and views through a single component.

This component is called _dispatcher_.
It consumes _actions_ and updates the _store_ in reaction.
The _store_ defines the _view_ (_view_ renders data from _store_), and can pass new _actions_ to the dispatcher.
This flow is displayed on the diagram @fig:design:flux.

![Design: Flux architecture](./src/assets/diagram/flux){#fig:design:flux width=65%}

Flux is general architecture concept and though having its Facebook's implementation of the core modules, there are many other existing options.

One of those is Redux[@redux], which I shall use.
It also offers Redux-Saga[@redux-saga] for asynchronous action consumption (synchronous consumptions are handled by so-called _reducers_^[Modules that produce new state based on the previous state with regard to dispatched action]) and works well with Next.js.

## Git library

While there are also many libraries for working with Git repositories for Node.js, I have chosen to use NodeGit[@nodegit].

NodeGit is a binding to a popular C library libgit2, an implementation of core Git methods[@libgit2].

NodeGit shall be used for repository manipulation and its abstraction, using its JS objects.


## Node.js web application framework

Express.js will be used for the BE application as routing service and HTTP server with middle-ware management.
