# Design foundations

There are two conceptually different approaches to the implementation of the unified authorization layer for both WUI and CLI:

1. allow remote repositories, while losing the control over them, or
2. keep the repositories managed exclusively by the system, allowing for firm permission control potential.

## Remote repository, limited permission control

This is the approach more or less taken by all the reviewed systems in the previous chapter.
The premise is to allow the users to work with their existing repositories and remain their remote locations.
The implementation is akin to how Wiki.js tackles the issue
-- the application works with the local mirror of the repository, which is kept synchronized with the remote, thanks to provided access data, such as repository link and security configuration (either the HTTP Basic or the SSH key-pair authentication).

The implementation possess the following attributes:

* Easy setup and installation (no need to configure the SSH server)
* Central public application instance can be used by the community, users can drop in or out at their convenience
* Possibly larger base of users would be addressed due to the previous attribute

## Local repository, potentially extensive permission control

This approach is used by the larger SCM services like GitLab.
The system is not just a web application but also a Git hosting service.
This gives the application ultimate control over the repositories.
The custom Git hosting service allows to create a complex permission control layer for remote access (or utilize an existing software for the purpose).

* More challenging for unexperienced users to setup the hosting service
* Central application instance is not feasible
    * users are not likely to give away their repositories to an unknown provider
    * decentralized ACL administration is difficult to tackle, even with a sophisticated tool as Gitolite
* Thus, few users actually get to use the system


## Conclusion

The former design likely reaches to more users, while the latter provides powerful control over the repositories, allowing for a solid authorization layer.

The concept of _repository providers_ is described in the following section, which provides a solution to overcome the obstacle of having both: the remote repositories and the firm control over the local ones in parallel.
