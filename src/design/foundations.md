# Design foundations

As I discussed the basic concepts of Gitwiki with my supervisor Ing. Jakub Jirůtka, two conceptually different approaches to the core design arose, even before official thesis instructions have been written.

1. **Remote repository, limited permission control**

This is the approach more or less taken by all reviewed systems in the previous chapter.
The premise is to allow the users to work with their existing repositories and remain their remote locations.
The implementation I had in mind was akin to how Wiki.js handled this issue
-- the application works with the local mirror of the repository which is kept synchronized with the remote, thanks to provided access data, like repository link and security configuration (HTTP basic or SSH key-pair authentication).


This approach has the following features:

* Easy setup and installation (no need to configure SSH server)
* Central public application instance can be used by many users, who can drop in or out at their convenience
* Possibly larger base of users would be addressed due to previous mention of public access

2. **Local repository, potentially extensive permission control**

This is approach used usually by larger SCM services like GitLab.
The system would be not only WUI for the repository but also a hosting service.
This would give the application ultimate control over hosted repositories.
Custom Git hosting service implementation would allow to create (or use existing software for that) complex permission control layer for remote access.

* More challenging for unexperienced users to setup the hosting service
* Central application instance is not feasible
    * users are not likely to give away their repositories to unknown provider
    * decentralized organization administration is hard to tackle, even with a sophisticated tool as Gitolite
* Thus, few users would actually get to use the system

Driven by my desire to reach out to as many users as possible I did not want to leave the former suggestion, though I understood the power of the latter.
Thusly I decided to thrive for the solution a true Meme Queen would suggest: _"Why not both?"_

In the next section I shall describe the concept of _repository providers_, which is a solution I designed to overcome this obstacle.