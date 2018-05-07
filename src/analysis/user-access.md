# User access

As mentioned in the previous section, there are issues that need to be resolved, before approaching the rest of the analysis.
Because the impact of the resolutions, it is required to completed even before defining the system through standard tools, such as the requirement model.
That is the way the documents are persisted, and how the users access it.

To this moment in order to remain at the abstract conceptual level, which was convenient for e.g. business process modeling,
it has not been implied a specific VCS is used within the system, though it is stated in thesis assignment instructions.
Git VCS is used for wiki contents persistence, as instructed.
It has many advantages, including a branch model, a CLI repository access via SSH and it is decentralized, which is convenient for Dump and Lump (the developers) when working out of the office, as pointed out by an observation in the business process model.
Apart from that, it is fairly popular.
According to [@openhub:vcs] up to 50% of the existing open source projects use Git, while the second place goes to Subversion with 42%.
This applies only for the open source projects.
Most of the statistics reflecting the global usage of VCSs are thus misleading, and in global scope, with the private projects included, Subversion plausibly still rules over Git with usage statistics.
From various sources, e.g. mentioned in [@stackexchange:vcs], it is apparent that Git's popularity is increasing over the years nevertheless, which makes Git a reasonable choice.

Using Git as an underlaying VCS layer brings two important questions to discuss.

1. Access control gets more complicated.
In a centralized VCSs, it is natural to have the feature of file locks, which is e.g. available in Subversion.
Though there are tools to simulate this in Git, it becomes far more challenging.
How is the access control within a Git repository solved?

2. Git provides a useful interface for repository cloning, granting an elegant solution for the direct file access, familiar to Dump, Lump and Pump.
Users are authenticated through an SSH authentication layer, once they deliver their public keys to the hosting server.
This is a standard practice used by the popular Git hosting providers.
How is the user authenticated and how is the identity paired with the stored public key?

## Authorization

A tool for an authorization layer atop the SSH to manage Git repository access for the Git hosting is required.
The possible open source options available are discussed.

There are many Git hosting services with a swarm of supportive features, such as the code review, issue tracking and even access control.
These self-hosted services include e.g. GitBucket [@gitbucket], GitLab [@gitlab] or Gogs [@gogs].
None of the services are suitable, since none of them by this time offer a modular usage, to utilize just the mere SSH authorization layer.
GitLab is selected from the group to demonstrate this.

Since none of the examples from the said group are convenient^[Not impossible -- they can be used. They are inconvenient however, because the system requires to be used as a whole, while only utilizing a mere fraction of it. The provided SCM features are not to be used.], software that serves only authorization purpose is discussed.
There are two examples: Gitorious [@gitorious] and Gitolite [@gitolite].
Gitorious is no longer maintained, since it has been acquired by GitLab in 2015 [@gitorious:gitlab].
The fact that Gitolite, which is still maintained, was for a time used by GitLab as an authorization layer, renders it even more relevant, given the GitLab's popularity.
One of the reasons for that is that GitLab faced performance issues with an extensive count of repositories and users. [@gitolite:gitlab]
This might become an issue for the massive corporations, but since Gitolite performance issues with configuration parsing occurred at over 560 thousand LOC of configuration files and 42 thousand repositories reached by Fedora, it is sufficient for the purpose. [@gitolite:perf]


Two examples are distinguished to compare in this section as possible candidates for the authorization tool to use in the project.
GitLab and Gitolite are inspected for the purpose closely in the rest of the subsection.

### GitLab

_"GitLab is a single application with features for the whole software development and operations (DevOps) lifecycle."_ [@gitlab:about]
It is an open source project started in 2011 with more than 1900 contributors and used by over 100 thousand organizations as a self hosted Git server with many development supportive features [@gitlab:about].

It offers a rich, well documented GraphQL API (as well as a still maintained RESTful API), which would become beneficial for the application control.

Using GitLab solves the issue of authentication as well, because GitLab comes bundled with an embedded user management service, storing user data in its own database.
This is consider a great asset for the purpose.

Regarding the access control, GitLab offers standard control over Git branches via user groups using the _protected branches_^[Protected branches are means of restricting the user access based on Git branches. It usually distinguishes between _read_, _write_ and _master_ permission, which allows force updates, delete etc.][@gitlab:branches], which is a feature well known amongst similar services.
This however remains to be the only level of control it offers within a repository.
A file locking feature exists in GitLab, but is only available in GitLab Premium, where it is available since GitLab Premium 8.9 [@gitlab:files].

GitLab is a _single application_, as officially stated.
It cannot be used modularly for the thesis' specific purpose.

### Gitolite

_"Gitolite allows you to setup git hosting on a central server, with fine-grained access control and many more powerful features."_ [@gitolite]
Gitolite, presumably developed since 2009^[September 17, 2009 is the first tagged release on GitHub, v0.50] is an open source authorization layer atop SSH, which controls user access to Git repositories.

The advantage over GitLab for the usage is that it manages solely authorization.
Unlike GitLab, using it does not require to inject a large monolithic application only to leave most of its features unused.

Gitolite unlike GitLab offers a truly powerful access control configuration.
It features a "wild card" regular-expression defined repository names [@gitolite:wild], and a much more advanced feature similar to _protected branches_ from GitLab.
This offers means of controlling not only branch names, but even tags, paths within the repository and even establish push meta rules, such as changed files count per push. All mentioned using its _vref_^[Abbreviation for virtual reference] and _refex_^[Neologism formed of _reference_ and _regex_] [@gitolite:vref] as seen in the listing \ref{lst:gitolite:sample}.


```{language=elixir caption="Gitolite configuration example" label="lst:gitolite:sample"}
repo foo
    RW+                     =   @alldevs

    -   VREF/COUNT/5        =   @juniordevs
    -   VREF/NAME/Makefile  =   @juniordevs
```

The sample Gitolite configuration in listing \ref{lst:gitolite:sample} taken from [@gitolite:vref] showcases the access settings for the repository _foo_.
It grants unrestricted read-write access (`RW+`^[the "`+`" symbol means advanced access to e.g. force push branches]) to all developers (group called `@alldevs`) and restricts access for the junior developers (restriction using "`-`" symbol) to push more than 5 files and to change the `Makefile`.

This configuration sample demonstrates the power of the fine grain access control Gitolite provides, which is not only superior to GitLab in its expressiveness, but is also stored in simple configuration file in a Git repository available through Gitolite itself.

Apart from that, Gitolite features a group management as does GitLab.

### Summary

The stated advantages, namely rich concept of virtual references for access control and accessible version controlled permissions configuration outweigh the single, yet considerable drawback, which is need for custom authentication.

Thus Gitolite is preferable over GitLab.

### How Gitolite works

Before resolving the second issue of user access revealed earlier, which is the approach to unified authentication mechanism on over SSH and WUI alike, details of Gitolite's authentication and authorization details are discussed.

This is important because the system needs to have means of authenticating the user on the web as well as of checking the authorization rules for the repository access, which behaves in the exactly same fashion as the one over SSH.

Note that these are neither an installation instructions, nor an in depth explanation of Gitolite works inside.
Just bare essential to understand it's basic concepts.

#### Install

Gitolite is a program typically installed under a new user called _git_.
It takes over its home directory and makes necessary changes to it.
Git user's home directory holds all repositories, including the administration repository.
The administration repository includes access control configuration, as well as the registered public keys for the authentication.
Gitolite keeps additional files updated for a successful SSH authentication (discussed later).

The Gitolite installation requires one public key for the initialization.
The first key (its user) is granted an access to configuration repository.

#### Adding a user

Users are added by changing the `gitolite-admin` repository, the mentioned administration repository.
It contains the folder with the public keys and the configuration file for the authorization.
A new user is added by pushing commits, which add their public key to the `gitolite-admin` repository.
This repository on the Gitolite server is the single one to have a `post-update` hook, which creates a record in the `authorized_keys`^[Implicitly located in `.ssh/authorized_keys`], allowing the new user to authenticate via `git` UNIX user onto the Gitolite server with SSH key-pair authentication.

#### Authentication

As is obvious from the previous paragraph, Gitolite does not implement any form of authentication.
It is relying solely on the SSH layer to perform a secure authentication via the key-pair authentication.
Gitolite must provide authentication data by cautiously managing the `authorized_keys` file.


```{language=sh caption="Gitolite git user authorized keys file" label="lst:gitolite:authkeys"}
# gitolite start
command="/home/git/bin/gitolite-shell hump",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB...VAQ== hump@station1
command="/home/git/bin/gitolite-shell dump",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB...VAQ== dump@station2
# gitolite end
```
Gitolite restricts incoming users from full access via SSH configuration.
Notice the `authorized_keys` file with running Gitolite with several users in listing \ref{lst:gitolite:authkeys}.
The file `authorized_keys` does not only contain the public keys authorized for access, one per line.
Apart from many options irrelevant at this moment, it contains an option `command`.
It _"specifies that the command is executed whenever this key is used for authentication. The command supplied by the user (if any) is ignored. (...) This option might be useful to restrict certain public keys to perform just a specific operation. An example might be a key that permits remote backups but nothing else."_ [@openbsd:ssh:command]

Which means a UNIX user on a machine with running SSHD [@openbsd:sshd] can control what command is executed for SSH key authenticated users.
This can be used to run different a shell, modify the environment or as in this case, to forbid the users to run anything, except a specific program.
In this case it is gitolite-shell with provided username argument.

This is important for the further discussion of authentication, since it makes other than the key based authentication impossible to use.

#### Authorization

Gitolite authorization runs in two steps.

![Gitolite two step authorization](./src/assets/diagram/gitolite){#fig:gitolite width=300}

This process is depicted in the diagram @fig:gitolite.
The activity diagram, though simplifying the details to display the higher-order concepts, contains all the essential components in the communication for the demonstration of the discussed issue.
The diagram presumes that SSH authentication succeeds.

The first step in the process is to run the `gitolite-shell` with the username and the repository name, supplied via SSH by the remote user.
At this point, Gitolite can evaluate (and eventually deny) the access, because it already knows the authenticated username, as well as the repository name and the action (is it a read action, such as `git fetch`, or write, for instance `git push`).
If Gitolite does not deny access at this point, Git standard command is invoked, e.g. `git-upload-pack` for cloning or pulling form a repository.

For the read operations the first step is also its final.
However that is not true for the writing operations such as `push`.
For that, after the `gitolite-shell` command passes, `git-recieve-pack` is invoked instead.
This receives and applies the data from the initial push, which eventually triggers an `update` hook.
The hook performs additional checks for each updated reference and it may partially or totally abort the update by exiting with an error.

## Authentication

Having discussed the authorization layer and its limits, it is apparent that the system requires the SSH key-pair authentication method.

Can the same concept be utilized in the web environment?

Though not technically impossible, it is not definitely a standard approach for the authentication on web.
The discussion [@security:key-auth] contains further details on this topic.
The main problem of the issue is the access to the local files from JS in the browser.
Using a browser extension for that, as suggested in [@security:key-auth] is inappropriate and a _requirement_ of user extension an everyday authentication is unnecessarily complicated.
Using a key-pair authentication is a non-standard approach to the problem with obvious obstacles.
Thus it is not considered for the project.

The solution of authenticating a user and binding it with a SSH key is used by popular similar SCM services.

If the user cannot be authenticated via key-pair, yet it must be guaranteed that the user, no matter the authentication method, is correctly paired with the public key, then the key must be provided by the authenticated user.
Binding user and a public key is not possible in a secure way.
The solution is then to use the standard ways of authentication on the web and let the user upload their public key via a web application, performing an authorized request under the identity of authenticated user.

This solution is used by giants amongst the SCM services, including GitHub [@github], GitLab [@gitlab] or BitBucket [@bitbucket].

### The standard ways of authentication

Since the SSH key-pair authentication is impractical on the web, conventional way of authentication are briefly discussed.

A common way of authentication on the web is providing a UID (username, email, etc.) and password.
The server then retrieves the user by UID from its storage and compares the passwords (the results of hash functions with one of the inputs being the password).

Users are familiar with the method, it is simple and portable -- independent of the browser, OS etc.

Implementing this authentication in a secure fashion and keeping it up to date is challenging, and the solution has great re-usability potential.
For that reason (but not only as mentioned later) there are services that act as authentication authorities.
This allows other applications and services, regardless of the platform, to communicate via HTTPS with the authority and let it authenticate the user instead.
This contributes to re-usability of the user's _key_^[Meaning means of authentication, not a asymmetric cryptography key-pair.] they have -- not only improving their comfort but also containment of the personal data in applications specialized for that purpose.

A popular architecture of such service is OAuth 2.0.
OAuth 2.0 is primarily an authorization service.
The authority manages user's data.
An existing application can request authorization for portion of the data.
User (after a successful authentication) can grant or reject the authorization of the application for requested portion.
When the access is granted, the application can manage the data.
Requesting data about the user, the OAuth 2.0 can be used as mere authentication provider.

This is utilized by the OpenID Connect [@openid], which is a standard based on the OAuth 2.0.
It is not a general authorization provider, but an identity provider.

Using an external provider is a viable solution for the system, since it simplifies the authentication process, allows the user to use an existing identity in the system and the application to access user data if convenient.
