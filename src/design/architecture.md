# Architecture

## Top level architecture structure

A high-abstraction design of the application's architecture is displayed in the diagram @fig:design:architecture.


![Design: Architecture of the application](./src/assets/diagram/architecture){#fig:design:architecture width=75%}

The application is decoupled into two main components, which are the FE JS application running in the client's browser and Node.js BE application.

FE application is served as a response in user agent's initial request and then communicates with the server's BE application via RESTful API as user navigates throughout the application or performs any actions that require data.

The server machine provides the role of a repository hosting service via the SSH protocol using the SSHD running on the machine.
BE application communicates with the self-hosted repository service via loop-back with configured SSH keys, as described earlier in this chapter.

The application communicates with GitHub using RESTful API and HTTPS.
As seen in the diagram, server's repositories are exposed via SSH protocol.

## BE structure

![Design: Architecture of the BE application](./src/assets/diagram/architecture-be){#fig:design:architecture:be width=100%}

The essential BE structure is showed in the diagram @fig:design:architecture:be.

### Routers and controllers

Routers bind routes defined in the endpoints to the controllers and transform known errors to HTTP codes and appropriate responses.

There is no controller for the FE requests, nor for static files.
FE requests are passed onto Next.js handlers, which responds to basic error codes and static router is as well handled by an existing service -- Express.js static router.
No further decoupling by a controller layer is necessary for the two.

The controllers always return a Promise^[for the convenience of uniform handling by routers] and prepare response after gathering the required data from the application.
The data is acquired from the repository providers or from the `Auth` package, when gathering user information.

### Repository providers

All the providers decorate and setup the parameters for the `git` module.
This includes setting the authentication callbacks, repository URLs etc.
Local provider communicates with the `gitolite` module, which is an interface for the Gitolite CLI wrapper.

Providers generally access shared configuration through `Config` module's API, which is an interface for easy access to required parts of the hierarchical configuration file.

### Git module

The Git module is a set of high-abstraction methods over Git repositories to suit Gitwiki needs.
It uses third party library NodeGit, which provides libgit2 bindings to Node.js.
The two libraries are shown in the diagram, but only for the sake of communication.
Neither is part of the implementation.
