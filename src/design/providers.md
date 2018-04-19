# Repository providers

The key to bringing benefits of both, radically different architectural approaches, is to create a solid abstraction layer for the repository within the application as well for the means of retrieving and publishing them -- the repository providers.

## What API must be provided?

Repository provider is a module, that can:

1. **Accept authentication data**

This could be an API key, user name etc. to use within the module, if it is accessing private repositories.

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
The paramount objective is to offer unified authorization mechanism over SSH and WUI.
Directly fiddling with the repositories stored on server is bypassing Gitolite, the SSH authorization layer, creating an anomaly in the data flow and potential asymmetry and sore spot in unified authorization.

Instead of accessing the repositories directly, with concept of providers, we could design a local provider, that would fetch repositories from and publish to the local machine over SSH.
This would assure that the application permission control, even if malfunctioned, could not be more relaxed than the Gitolite configuration.

### Repository abstraction

As mentioned, direct repository access is easier for implementation.
However if I heedlessly aimed for easy and design the system to suit the immediate needs of using Gitolite controlled repositories, I would seal the way for the project of using the benefits of approach described in point (1) in previous section _\hyperref[design-foundations]{Design foundations}_.

Not relying on the local repositories and always aiming for a mirror of a remote, creates a generic abstraction, ready to be used in both scenarios.

### In application access control

Repository provider module has control over every action of the repository: access, edit and publish.
It can, on application level, deny access depending on its own logic.
