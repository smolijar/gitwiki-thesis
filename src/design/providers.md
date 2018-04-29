# Repository providers - Unified authorization {#sec:repository-providers}

The key to bringing benefits of both, radically different architectural approaches, is to create a solid abstraction layer for the repository within the application as well for the means of retrieving and publishing them -- the repository providers.

## What API must be provided?

Repository provider is a module, that can:

1. **Accept authentication data**

This could be an API key, username etc. to use within the module, if it is accessing private repositories.

2. **List available repositories**

Return a list of available repositories the provider has access to, based on the authentication information.

3. **Obtain a repository**

This means cloning it from an existing remote repository into a temporary space, likely FS^[Also remote FS or any other abstraction, which can be accessed for performing changes in Git working directory], or updating its references if it already exists.

This action either returns a repository abstraction or fails due to network errors, unauthorized access etc.

4. **Create a revision and publish**

The provider can block the action and result in an error, or pass the revision to repository abstraction.

Action publishes given reference to its setup upstream reference on remote repository.
Provider might disallow this action based on its implementation or response of the remote.


## Why are providers helpful?

There are several reasons I will cover now.

### Unified approach

Using tool such as Gitolite, it feels only natural to tamper with the source original repositories which are eventually located on server's FS.
While this might be tempting, and would save some trouble in the short run, it is very short-sighted.

Utilizing direct FS access would needlessly over-complicate core logic, forking it into working with an authentic original, and a mirror of a remote, branching the behavior of publishing process for instance, and closing the gate to concurrency control.

Therefore, for design purposes it is far mote suitable to treat local repositories as remote, handled by an unified provider interface.

### Repository abstraction

As mentioned, direct repository access is easier to implement.
However if I heedlessly aimed for the easy way and design the system to suit the immediate needs of using Gitolite controlled repositories, I would seal the way for the project of using the benefits of the approach described in point (1) in the previous section _\hyperref[design-foundations]{Design foundations}_.

Not relying on the local repositories and always aiming for a mirror of a remote, creates a generic abstraction, ready to be used in both scenarios.

### In application access control

Repository provider module has control over every action of the repository: access, edit and publish.
It can, on application level, deny access depending on its own logic.


This is required for the local provider.
The paramount objective is to offer unified authorization mechanism over SSH and WUI.

Instead of accessing the repositories directly, with concept of providers, we could design a local provider, that would fetch repositories from and publish to the local machine over SSH.
It would be superb if we could simulate the user's remote control, which alas is not possible^[We would need the user's SSH private key for that.].
Instead we will simulate the behavior though application logic.

Gitolite provides a CLI interface with humble but sufficient API to tell us, which user has access to which repository.

You might ask yourself, why don't we use the permission rules directly, since it is stored in plain files.
This could be arranged, but as showcased in section _\hyperref[gitolite]{Gitolite}_ from chapter _\hyperref[chapter:analysis]{Analysis}_, the configuration can be rather complicated.
Thus it is better to use an existing parser, delivered by the same system.

The solution is not ideal, but is the best available.
A security bug in application would result in letting users tampering with the Gitolite repositories^[For the application to clone any repository, the application needs master SSH key-pair.], bypassing the Gitolite security system.
As mentioned earlier, the only way to go through the Gitolite-standard SSH access would require users' private keys, acquiring which is naturally not possible as the result would compromise the core security principles of asymmetric cryptography.

Letting repository providers to perform additional authorization check produces mechanism flexible enough to create even complex provider as local provider communicating with Gitolite.

Local provider interactions are shown in detail in the diagram @fig:design:local-provider, though some application logic is abstracted, since its goal is to focus on the local provider.

## Designed providers

I have discussed the usage of local provider.
To showcase the flexibility of the system as described in two design pillars in _\hyperref[design-foundations]{Design foundations}_, I decided to implement one more provider.
There were several options available from Git hosting services, but for its popularity amongst OSS community I chose as leading example GitHub.

This brings two main advantages for Gitwiki:

* GitHub is still easily the most popular SCM service in comparison to GitLab or BitBucket; addressing GitHub's user base is far more efficient than other services'.
* GitHub OAuth 2 can be used in the system as authentication method and public keys can be loaded into Gitolite.

### Local repository provider

![Design: Local provider interactions](./src/assets/diagram/local-provider){#fig:design:local-provider width=100%}

Diagram @fig:design:local-provider displays the interaction of local provider with Gitolite with actions of listing repositories, getting one and creating a commit.

Notice that it communicates with application wrapper for `gitolite` CLI.
Its API allows to ask to list repositories and ask for access.

Notice that when anonymous user asks for repositories, gitolite lists for repositories accessed by user `@all`.
This is special user^[or repository placeholder based on the given context] placeholder for _all users_.
Resulting in a configuration query: _What repositories can be accessed by all users?_

Local repository provider's implementation solves the issue of unified authorization raised in summary of previous chapter by intertwining the application logic with Gitolite's authorization layer, through gitolite CLI.

### GitHub repository provider

In contrast, see remote authority repository provider, in this case GitHub.
Repository provider API allows it to use any form of communication, like in this case including GitHub's REST API calls.


![Design: Local provider interactions](./src/assets/diagram/github-provider){#fig:design:github-provider width=100%}

For comparison to the sequential diagram of a local provider, GitHub provider communication is displayed in the diagram @fig:design:github-provider.
For simplicity it is presumed that the user Alice has valid access and no errors occur.
