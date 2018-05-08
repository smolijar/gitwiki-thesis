# Repository providers {#sec:repository-providers}

The key to bringing the benefits of both, radically different architectural approaches, is to create a solid abstraction layer for the repository within the application, as well as for the means of retrieving and publishing them -- the repository providers.

## Repository provider's API

Repository provider is a module that can:

1. **Accept authentication data** -- Accept an API key, username etc. to use within the module, when it is accessing private repositories.

2. **List available repositories** -- Return a list of available repositories it has access to, based on the authentication information.

3. **Obtain a repository** -- Clone a repository from an existing remote into a temporary space, likely FS^[Also remote FS or any other abstraction, which can be accessed to perform changes in the Git working directory], or update its references if it already exists.
This action either returns a repository abstraction or fails due to a network error, an unauthorized access etc.

4. **Create a revision and publish** -- The provider can block the action and result in an error, or pass the revision to the repository abstraction for commit.
The abstraction applies the commit and publishes selected branch to its upstream on the remote repository.
Provider can disallow this action based on its implementation or response of the remote.

## The advantages of using repository providers

### Unified approach

Using a tool, such as Gitolite, it is possible to tamper with the original repositories, which are eventually located on server's FS.
While tempting in the short run, it is very short-sighted.

Utilizing direct FS access needlessly over-complicates the core logic, forking it into working with an authentic original, and a mirror of a remote.
This effectively branches the behavior of the publishing process for instance, and closes the gate to concurrency control.

Therefore, for design purposes it is far mote suitable to treat local repositories as remote, handled by an unified provider interface.

### Repository abstraction

Treating the local repositories as remotes proves beneficial.
Not relying on the local repositories and always aiming for the mirror of a remote, creates a generic abstraction, ready to be used in both scenarios.

### Application access control

The repository provider module has control over every action of the repository: access, edit and publish.
It can, deny access depending on its own logic.
This is required for the local provider.
The paramount objective is to offer unified authorization mechanism over SSH and WUI.

Instead of accessing the repositories directly, with the concept of the providers, a local provider can be designed.
It fetches the repositories from (and publishes to) the local machine over SSH.

Simulating the the user's remote control over SSH would be an ideal solution, if it was possible^[This requires user's SSH private key.].
Instead, the behavior is simulated through the application logic.
Gitolite provides a CLI with a sufficient API to tell the user, which Gitolite user has access to which repository.

Even though the Gitolite configuration is stored in text files, it is better to use the Gitolite CLI tool to parse the permissions.
The configuration can be rather complicated, as seen the listing \ref{lst:gitolite:sample}.
Thus, it is better to use an existing parser, delivered by the same system.

A security bug in application results in exposing the repository data to the users, bypassing the Gitolite security system^[The application requires the master SSH key-pair to clone any repository.].
As mentioned earlier, the only way to go through the Gitolite-standard SSH access (and not actually bypass it) requires the users' private keys, acquiring which is naturally not possible, as it would compromise the core security principles of asymmetric cryptography.

Letting the repository providers perform additional authorization check, creates a mechanism flexible enough to create even as complex provider as the local provider, which communicates with Gitolite.

The local provider interactions are shown in detail in the diagram @fig:design:local-provider.

## Designed providers

To showcase the flexibility of the system, as described in the two design pillars in the _\hyperref[design-foundations]{design foundations}_, one additional provider is designed.
GitHub repository provider is chosen for its popularity amongst the OSS community.

This brings two main advantages for Gitwiki:

* GitHub is still easily the most popular SCM service in comparison to GitLab or BitBucket.
Addressing the GitHub's user base is more efficient than other services' providers.
* GitHub, being an OAuth 2.0 provider, is used in the system as an authentication authority. Moreover the user's public keys can be loaded into Gitolite from GitHub through its API.

### Local repository provider

![Design: Local provider interactions](./src/assets/diagram/local-provider){#fig:design:local-provider width=100%}

The diagram @fig:design:local-provider displays an interaction of the local provider with Gitolite for actions:

1. *List repositories*,
2. *Get a repository* and
3. *Create a commit*.

The provider communicates with the application's wrapper for Gitolite CLI.
Gitolite CLI can be requested to list repositories and answer, whether a user can access given repository.

When anonymous user asks for repositories, Gitolite lists for repositories accessed by user `@all`.
This is a special user^[or a repository placeholder, based on the given context] placeholder for _all users_.
This results in a query for the authorization configuration: _What repositories can be accessed by all users?_

The design of the local provider solves the issue of unified authorization raised in summary of the previous chapter, by intertwining the application logic with Gitolite's authorization layer through the Gitolite CLI.

### GitHub repository provider

In contrast to the local provider, a GitHub repository provider is designed.
The repository provider API, allows for the providers to use any form of asynchronous communication with their resources.
In this case, GitHub's RESTful API is used.


![Design: GitHub provider interactions](./src/assets/diagram/github-provider){#fig:design:github-provider width=100%}

The diagram @fig:design:github-provider shows the GitHub provider performing the same tasks as required from the local provider.
For simplicity it is presumed that the user Alice has valid access and no errors occur.
