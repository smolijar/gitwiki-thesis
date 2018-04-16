# User access

As mentioned before, there are some fatal decisions on the table to be made, that must be resolved before even defining the system through standard tools, such as requirement model.
That is, how are the documents going to be persisted, and how users are going to access it.

To this moment in order to stay in the abstract conceptual level, which was convenient for e.g. business process modeling,
I never implied a specific VCS to use within the system, though it is given in thesis description.
Git VCS shall be used to wiki contents persistence, as given in the task.
It has many advantages, including branch model, CLI repository access via SSH and it is decentralized, which might be of convenient for Dump and Lump to work out of the office.
Apart from that, it is fairly popular.
According to [@openhub:vcs] up to 50% of existing open source projects use Git, while the second place goes to Subversion with 42%.
That goes only for open source projects.
Most of the statistics reflecting global usage of VCS are thus misleading, and in global scope with private projects included Subversion plausibly still rules over Git with usage statistics.
From various sources, e.g. mentioned in [@stackexchange:vcs], it is apparent that Git's popularity is increasing over the years though, which makes Git a reasonable choice.

Using Git as an underlaying VCS layer brings two important questions to discuss.

1. Access control gets more complicated.
In centralized VCSs, it is natural to have the feature of file locks, which is e.g. available in Subversion.
Though there are tools to simulate this in Git, it gets far more challenging.
How do we solve access control within a Git repository?

2. Git provides a useful interface for repository cloning, granting us an elegant solution for direct file access, familiar to Dump, Lump and Pump.
Users are authenticated through SSH authentication layer, once they deliver their public keys to the hosting server, which is a standard practice used by popular Git hosting providers.
The question is, how do we authenticate the user in WUI and pair them with their stored public key?

## Authorization

We need a tool for an authorization layer atop SSH to manage Git repository access for our Git hosting.
Let us go over few possible open source options we have.

There are many Git hosting services with a swarm of supportive features, such as code review, issue tracking and even access control.
These self-hosted services include e.g. Gogs [@gogs], GitBucket [@gitbucket] or GitLab [@gitlab].
This is not primary what we are after, since none of them by this time offer modular usage, to use just the mere SSH authorization layer.
I will pick GitLab as an example of this group.

Since none of the examples from said group are convenient, let us take a look on software that serves only that purpose.
Here we have two fine examples.
That is Gitorious [@gitorious] and Gitolite [@gitolite].
Gitorious however is no longer maintained, since it has been acquired by GitLab in 2015 [@gitorious:gitlab].
The fact that Gitolite, which is still maintained, was for some time used by GitLab as an authorization layer, makes it even more relevant, given GitLab's popularity.
One of the reasons for that is that GitLab faced performance issues with extensive count of repositories and users. [@gitolite:gitlab]
This might be an issue for massive corporations, but since Gitolite has reached performance issues with configuration parsing at 560K+ LOC of configuration files and 42K repositories reached by Fedora, it should be just fine for our purpose. [@gitolite:perf]


I have distinguished two examples to compare in this section as possible candidates for the authorization tool to use in the project.
Now we shall look at GitLab and Gitolite closely.

### GitLab

_"GitLab is a single application with features for the whole software development and operations (DevOps) lifecycle."_ [@gitlab:about]
It is an open source project started in 2011 with more than 1900 contributors and used by over 100K organizations as a self hosted Git server with many development supportive features [@gitlab:about].

It offers a rich, well documented GraphQL API (as well as still maintained REST API), which could be well used to our benefit for application control.

Using GitLab would solve the issue of authentication as well, because GitLab comes bundled with embedded user management service storing user data in its own database.
This I consider to be a great asset for the purpose.

As far as access control goes, it offers fine control over Git branches via user groups using the _protected branches_^[Protected branches are means of restricting user access based on Git branches. It usually distinguishes between _read_, _write_ and _master_ permission, which allows force updates, delete etc.][@gitlab:branches], which is a feature well known amongst similar services.
This however remains to be the only level of control it offers within a single repository.
A file locking feature exists in GitLab, but is only available in GitLab Premium, where it is available since GitLab Premium 8.9 [@gitlab:files].

One of the problems with GitLab is, as officially stated, that it is a _single application_.
I cannot be used modularly for our specific purpose.


### Gitolite

_"Gitolite allows you to setup git hosting on a central server, with fine-grained access control and many more powerful features."_ [@gitolite]
Gitolite, presumably developed since 2009^[September 17, 2009 is the first tagged release on GitHub, v0.50] is an open source authorization layer atop SSH to control user access over Git repositories.

The advantage over GitLab for our usage is that it does just what we need, so I will not need to use a large monolithic application to leave most of its features unused.

Gitolite unlike GitLab offers a truly powerful access control configuration.
It features "wild card" regular-expression defined repository names [@gitolite:wild], and a much more advanced feature similar to _protected branches_ from Gitolite.
This offers means of controlling not only branch names, but even tags, paths within a repository and even push meta rules, such as file count changed per push, all using its _vref_^[Abbreviation for virtual reference] and _refex_^[Neologism formed of _reference_ and _regex_] [@gitolite:vref] as seen in listing \ref{lst:gitolite:sample}.


```{language=elixir caption="Gitolite configuration example" label="lst:gitolite:sample"}
repo foo
    RW+                     =   @alldevs

    -   VREF/COUNT/5        =   @juniordevs
    -   VREF/NAME/Makefile  =   @juniordevs
```

The sample Gitolite configuration \ref{lst:gitolite:sample} taken from [@gitolite:vref] showcases access settings for repository _foo_.
It grants unrestricted read-write access (`RW+`^[the "`+`" symbol means advanced access to e.g. force push branches]) to all developers (group called `@alldevs`) and then restricts access to junior developers (restriction using "`-`" symbol) to push more than 5 files and to change the `Makefile`.

This configuration sample demonstrates the power of fine grain access control Gitolite offers, which is not just superior to GitLab in its power and expressiveness, but is also stored in simple configuration files in a Git repository available through Gitolite itself.

Apart from that, Gitolite features group management like GitLab.

### Summary

I decided to choose Gitolite over GitLab.
The stated advantages, namely rich concept of virtual references for access control and accessible version controlled permissions configuration outweigh the single, yet considerable drawback, which is need for custom authentication.

### How Gitolite works

Before resolving the second issue of user access revealed earlier, which is approach to unified authentication mechanism on over SSH and WUI, let us take a look on how Gitolite authentication and authorization works.

This is important because the system will need to have means of authenticating user on the web as well as check authorization rules for repository access, which behaves in the exactly same fashion as the one over SSH.

Note that these are neither installation instructions, nor in depth explanation of Gitolite works inside.
Just bare essential to understand it's basic concepts.

#### Install

Gitolite is a program typically installed under a new user called _git_.
It takes over its home directory and makes necessary changes to it.
Git user's home directory holds all repositories, including the administration access control configuration repository, as well as registered public keys for authentication keeps updated additional files for successful SSH authentication.

The Gitolite installation requires one public key for initialization.
This first key (its user) has access to configuration repository.

#### Adding a user

Users are added by changing the `gitolite-admin` repository.
It contains the folder with public keys and configuration file for authorization.
New user is added by pushing commits adding their public key to the `gitolite-admin` repository.
This repository on Gitolite server is the only one to have a `post-update` hook, which takes care of creating a record in `authorized_keys`^[Implicitly located in `.ssh/authorized_keys`], allowing the new user to authenticate via `git` UNIX user onto the Gitolite server.

#### Authentication

It should be obvious from previous paragraph, that Gitolite does not carry out any form of authentication at all.
It is relying on the SSH layer to perform a secure authentication via key-pair authentication.
Gitolite must just take a good care of managing the `authorized_keys` file.

A valid security question might be, how does Gitolite prevent full SSH access for remote user logging in via SSH as Git user on Gitolite server.
This is interesting, but is already taken care of by the SSH layer and Gitolite just needs to manage SSH files cautiously.


```{language=sh caption="Gitolite git user authorized keys file" label="lst:gitolite:authkeys"}
# gitolite start
command="/home/git/bin/gitolite-shell hump",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB...VAQ== hump@station1
command="/home/git/bin/gitolite-shell dump",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB...VAQ== dump@station2
# gitolite end
```

Let us take a look on the `authorized_keys` file with running Gitolite with several users in listing \ref{lst:gitolite:authkeys}.
The file `authorized_keys` does not only contain public keys authorized for access, one per line.
Apart from many options we do not need to worry ourselves about now, it contains an option `command`.
It _"specifies that the command is executed whenever this key is used for authentication. The command supplied by the user (if any) is ignored. (...) This option might be useful to restrict certain public keys to perform just a specific operation. An example might be a key that permits remote backups but nothing else."_ [@openbsd:ssh:command]

Which means UNIX user on a machine with running `sshd` [@openbsd:sshd] can control what command is executed for key authenticated users, which can be used to run different shell, modify the environment or as in this case, to forbid user to run anything except this single program, which is gitolite-shell with fixed username argument.

This is important for the further discussion of authentication, inasmuch as this makes other than key based authentication impossible to use.

#### Authorization

Gitolite authorization runs in two steps.
We know how it got here as mentioned before in SSH authentication.

![Gitolite two step authorization](./src/assets/diagram/gitolite){#fig:gitolite width=300}

This process is depicted on diagram @fig:gitolite.
The activity diagram, though simplifying the details to display higher order concepts, contains all essential components in the communication for the demonstration of discussed issue.
The diagram presumes that SSH authentication succeeds. 

First step is `gitolite-shell` run with username and repository name, supplied via SSH.
Here, Gitolite can deny the access, because it already knows the authenticated username, as well as repository name and action (is it a read action, like `git fetch`, or write like `git push`).
If Gitolite does not deny access at this point, Git standard command is invoked, e.g. `git-upload-pack` for cloning or pulling form a repository.

For read operations the first step would also be its final.
However that is not true for writing operations such as `push`.
For that after `gitolite-shell` command passes, `git-recieve-pack` is invoked instead.
This receives and applies data from the initial push, which eventually triggers `update` hook.
The hook does additional checks for each updated ref and may partially or totally abort the update by exiting with an error.

## Authentication

Now, knowing how the underlaying authorization layer works, we can safety say, it has been theoretically conceptually taken care of.
We know its power and its limits.
We know that user is authenticated via SSH key-pair authentication.
Can we bring the same concept to the web?

Though not technically impossible, it is not definitely a standard approach for authentication on web.
If this caught your attention, I suggest you read [@security:key-auth] for further details.
The main problem of the issue is access to the local files from JS in browser and using browser extension for that, as suggested in [@security:key-auth] seems like a terrible idea for many reasons, e.g. cross browser support and _requirement_ of user extension for something as everyday as user authentication.

For the solution we must think outside the box (and perhaps take a peep how similar services handle the exact same issue).
If we cannot authenticate user via key-pair, yet must ensure the user, no matter the authentication method, is correctly paired with the key-pair, then we cannot have the key-pair before the first authentication, as in case of SSH.
Let us use standard ways of authentication on web and let the user upload their public key via web application, performing an authorized request under the identity of authenticated user.

This solution is used by giants amongst SCM services like GitHub [@github], GitLab [@gitlab] or BitBucket [@bitbucket].

## Summary

We have successfully gone through possible ways to approach user access.
I found it imperative to discuss this issue, since e.g. authentication method might very easily alter the requirements in next section.
