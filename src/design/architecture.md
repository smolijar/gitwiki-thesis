# Architecture

## Top level architecture structure

High abstraction design of the application's architecture is displayed in the diagram @fig:design:architecture.


![Design: Architecture of the application](./src/assets/diagram/architecture){#fig:design:architecture width=90%}

The application is decoupled into two main components, which are the FE JS application running in client's browser and Node.js BE application.

FE application is served as a response in initial user agent's request and then communicates with the server's BE application via REST API as user navigates throughout the application or performs any action that requires data flow, like browsing a repository or creating a revision.

The server machine provides the role of a repository hosting service via SSH protocol using SSHD running on the machine.
BE application communicates with the self-hosted repository service via loop-back with configured SSH keys, as described earlier in this chapter, when discussing _\hyperref[sec:repository-providers]{repository providers}_.

By available means it communicates with external repository providers.
The diagram @fig:design:architecture displays this for GitHub provider, which uses REST API for general purposes (available repositories etc.) and HTTPS for repository access.

As seen in the diagram, server's repositories are exposed via SSH protocol.

## BE structure


![Design: Architecture of the application](./src/assets/diagram/architecture-be){#fig:design:architecture:be width=90%}

Basic BE structure is visible on the diagram @fig:design:architecture:be.

Though the diagram might seem simple it shows all the main components.

TODO ELABORATE