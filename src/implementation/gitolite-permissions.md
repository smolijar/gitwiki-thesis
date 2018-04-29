# UNIX permissions with Gitolite

As discussed in Analysis, Gitolite requires a single UNIX user to operate with, in order to provide SSH access to other users through it.
To prevent configuration errors and simplify the Gitolite setup process, it is encouraged to use a clean user account, with new UID for Gitolite.

Since application needs to access `gitolite` CLI, installed in home directory of the user, and Gitolite recommends using a clean account, we face the following dilemma:

1. **Either run the application under the Gitolite's UNIX user.**

This is the easier way.
We only need to install all required application dependencies either globally or under this user.

This brings two disadvantages:

- If the system already has another user set up to run similar applications, the administrator is required to possibly create redundancy.
- It pollutes the user with non-Gitolite data.
This might not even unnecessarily complicate the Gitolite maintenance, but also, more importantly goes directly against recommendations from Gitolite's manual.
Disobeying the manual might discourage some users and also it will complicate the Gitolite installation, which itself is not trivial.

2. **Or run the under any user, but solve the UNIX permissions.**

When using another UNIX user, we need (executable) access to the gitolite CLI program and also, solve all problems which arise from running the program in such manner, because it was not clearly designed handle it.

Let us take a close look on the problems we encounter.

## Run gitolite CLI under another user

With default installation, the CLI program, located at `/home/<gitoliteuser>/bin/gitolite`, is out of the box executable and lists valid help of the program.
This seems uplifting but there are more troubles than meets the eye.

However if with default configuration, you try to run Gitolite CLI with any arguments that actually do anything, for example `/home/<gitoliteuser>/bin/gitolite list-repos` the joyful expectations crumble.

The output of the operation under user _smolijar_ is in listing \ref{lst:impl:gitolite:logs}.

```{language=make caption="Implementation: Gitolite log error 1" label="lst:impl:gitolite:logs"}
FATAL: errors found but logfile could not be created
FATAL: /home/smolijar/.gitolite/logs/gitolite-2018-04.log: No such file or directory
FATAL: die	chdir /home/smolijar/.gitolite failed: No such file or directory<<newline>>
```

The problem is seemingly banal.
The gitolite probably utilizes the `$HOME` variable.
It is creating logs in my home directory in non-existent folder and tries to access the same folder.
It should operate on the user it is configured with, in my case the _git_ user.

Let us try setting the `$HOME` variable to `/home/git`, and see the output in the listing \ref{lst:impl:gitolite:logs2}.

```{language=make caption="Implementation: Gitolite log error 2" label="lst:impl:gitolite:logs2"}
FATAL: errors found but logfile could not be created
FATAL: /home/git/.gitolite/logs/gitolite-2018-04.log: Permission denied
FATAL: cli	gitolite	list-repos
```

It might come as a surprise, but setting the `$HOME` variable worked, and we have successfully convinced the Gitolite to use the default home directory.
This however, brings another failure, which is unknown error and insufficient permissions to log the error.
The unknown error might very possibly be caused by the same origin, insufficient permissions to access Gitolite's files.

From the current trials we have come to a observation that we need access to _git's_ home directory, at least with write access for `~/logs/` to successfully log errors and probably with read access for `/repositories`, which is most probably the cause of the unknown error.

Since we need to allow the access for another user, there are two options.

1. Set the UNIX permissions for _others_

This is a terrible idea on the server, non personal workstation, with any users.
As mentioned we require write access for parts of the home directory.
Exposing the home directory of any user _to all_ is incredible security threat, even more so, considering the home directory holds the entrusted repositories.

1. Set the UNIX permissions for a _group_

This is not ideal, but far better than the previous solution.
We consciously, explicitly allow the access to a given group.
This way the permissions are more controlled than just basically opening it to the public.

### Setup UNIX group

Let us create a UNIX group the open access to invited users.

1. Create group _gitolite_: `sudo groupadd gitolite`
2. Add Gitolite and current user to the group: `sudo usermod -a -G gitolite git && sudo usermod -a -G gitolite smolijar`
3. Change the _git_ home repository's group ownership recursively: `sudo chgrp -R gitolite /home/git/`
4. Allow the user to write in selected folders: `sudo chmod -R 2775 /home/git/`^[This allows other users to read and execute files. To forbid that altogether, use `2770`, which allows `R/W/E` for user and group, forbids anything to others and sets the `setguid` bit.]

### Gitolite SSH

After setting up the user group in previous steps, gitolite CLI seemingly works.
What is not imminently obvious when playing with the permissions is that the Gitolite SSH interface stopped working, even when setup correctly and tested after the installation.

After a while I realized this was issue with the permissions and further down the line found the bottom of the problem.

_"This is the default behavior for SSH. It protects user keys by enforcing `rwx------` on `$HOME/.ssh` and ensuring only the owner has write permissions to `$HOME`. If a user other than the respective owner has write permission on the `$HOME` directory, they could maliciously modify the permissions on `$HOME/.ssh`, potentially hijacking the user keys, `known_hosts`, or something similar. In summary, the following permissions on `$HOME` will be sufficient for SSH to work."_[@stackexchange:ssh]

SSH for security reasons kills any incoming connections to users, whose home folders and by its standards insecure.

This can be bypassed by disabling the SSHD option _strict modes_^[Defining `StrictModes no` in `sshd_config`, usually located in `/etc/ssh/sshd_config`.].
This of course is dangerous and should not be performed on machine, where the administrator does not have full control over the users, and can guarantee, no user with configured remote access in `authorized_keys` has write access in their home directory.
If Gitolite is set up properly and only provides authorized access via Gitolite^[As described in analysis, Gitolite authorizes new users but instead of providing them with full access, only allows them to run the Gitolite binary.], it should be due its `command` option safe.

### Owner of log files

Even when fixing the issue with SSH, later on, after both users have been using Gitolite for some time, yet another issue is nigh.

It is again a permission problem, and again with log files.
The issue triggers the same error, as shown in \ref{lst:impl:gitolite:logs2}, but this can happen for either of the users.

The problem is that _the other account_, in my case _smolijar_, creates a new log file, when the files are swapped or new log is created.
The log file is created with correct GID (thanks to the `setguid` bit), by the user _smolijar_, but with wrong permissions (no group access).

This could be solved if we could possibly set default set of permissions to be applied on selected folder.
Not being a UNIX guru, I found the answer in [@stackexchange:def-perm].
Desired effect can be achieved using the `setfacl` command:

`sudo setfacl -d -m g::rwx /home/git/.gitolite/logs/`^[The `-d` means _use default_, `-m` _modify_ with argument.]


```{language=bash caption="Implementation: Gitolite default ACL before" label="lst:impl:gitolite:acl1"}
# file: home/git2/.gitolite/logs/
# owner: git2
# group: gitolite
# flags: -s-
user::rwx
group::rwx
other::r-x
```

The ACL settings can be displayed using the `getfacl <dir>` command.
Compare the results of before (listing \ref{lst:impl:gitolite:acl1}) and after (listing \ref{lst:impl:gitolite:acl2}).

```{language=bash caption="Implementation: Gitolite default ACL after" label="lst:impl:gitolite:acl2"}
# file: home/git2/.gitolite/logs/
# owner: git2
# group: gitolite
# flags: -s-
user::rwx
group::rwx
other::r-x
default:user::rwx
default:group::rwx
default:other::r-x
```

Notice that three default lines have been added.
Now all newly created log files by my user _smolijar_ will still bear my UID (and those created by user _git_, as would normally by Gitolite would be created with _git's_ UID) but will have desired relaxed permissions for the group.
