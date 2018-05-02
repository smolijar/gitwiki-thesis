# Architecture

## Top level architecture structure

High abstraction design of the application's architecture is displayed in the diagram @fig:design:architecture.


![Design: Architecture of the application](./src/assets/diagram/architecture){#fig:design:architecture width=75%}

The application is decoupled into two main components, which are the FE JS application running in the client's browser and Node.js BE application.

FE application is served as a response in initial user agent's request and then communicates with the server's BE application via REST API as user navigates throughout the application or performs any action that requires data flow, like browsing a repository or creating a revision.

The server machine provides the role of a repository hosting service via SSH protocol using SSHD running on the machine.
BE application communicates with the self-hosted repository service via loop-back with configured SSH keys, as described earlier in this chapter, when discussing the _\hyperref[sec:repository-providers]{repository providers}_.

By available means it communicates with external repository providers.
The diagram @fig:design:architecture displays this for GitHub provider, which uses REST API for general purposes (available repositories etc.) and HTTPS for repository access.

As seen in the diagram, server's repositories are exposed via SSH protocol.

## BE structure


![Design: Architecture of the application](./src/assets/diagram/architecture-be){#fig:design:architecture:be width=100%}

Essential BE structure is visible on the diagram @fig:design:architecture:be.

### Routers and controllers

Routers bind routes defined in endpoints to controllers and transform known errors to HTTP codes and appropriate responses.

Notice that there is no controller for FE requests, nor for static files.
FE requests are passed onto Next.js handlers, which responds to basic error codes and static router is as well handled by an existing service -- Express.js static router.
No further decoupling by a controller is necessary.

The controllers always return a Promise^[for the convenience of uniform handling by routers] and prepare response after gathering required data from the application.

This are usually repository providers or user information from `Auth` package.

### Repository providers

All providers decorate and setup parameters for the `git` module.
This includes setting the authentication callbacks, repository URLs etc.

Local provider communicates with the `gitolite` module, which is an interface for the `gitolite` CLI wrapper.

Providers generally access shared configuration through `Config` module's API, which is an interface for easy access to required parts of the hierarchical configuration file.

### Git module

The Git module is a set of higher-abstraction methods over Git repositories to suit Gitwiki needs.

It uses third party library NodeGit, which provides libgit2 bindings to Node.js.
These two libraries are shown on the diagram, but only for the sake of communication.
They are not part of the implementation.
