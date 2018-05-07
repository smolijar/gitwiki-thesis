# UNIX permissions with Gitolite

As discussed in the analysis, Gitolite requires a single UNIX user to operate with.
The remote users can use this Gitolite's user account to access the Git repositories using SSH.
To prevent configuration errors and simplify the Gitolite setup process, it is encouraged to use a clean user account, with new UID for Gitolite.

Since application needs to access `gitolite` CLI, installed in home directory of the user, and Gitolite recommends using a clean account, we face the following dilemma:

1. Either run the application under the Gitolite's UNIX user,
2. or run the application under any user, but solve the UNIX permissions.

The former represents the easier way -- it is only required to install all application dependencies either globally or under this user. This brings two disadvantages:

- If the system already has another user set up to run similar applications, the administrator is required to possibly create redundancy.
- It pollutes the user with non-Gitolite data.
This might not even unnecessarily complicate the Gitolite maintenance, but also, more importantly goes directly against the recommendations from Gitolite's manual.
Disobeying the manual might discourage some users and also it will complicate the Gitolite installation, which itself is not trivial.

The latter is more complicated.
When using another UNIX user, it requires an (executable) access to the Gitolite CLI program and also, all problems which arise from running the program in such manner solve, because it was not clearly designed with this scenario at mind.

The encountered issues are now discussed.

## Run gitolite CLI under another user

With default installation, the CLI program, located at `/home/git/bin/gitolite`^[I presume Gitolite uses UNIX user *git*, as in installation manual, and its home directory is set according to the Gitolite installation manual as well, using the default location.], is out of the box executable and lists valid help of the program.

However, when running the Gitolite with arguments that do something, e.g. `/home/git/bin/gitolite list-repos` an error occurs.
The output of the operation under user _smolijar_^[This is a placeholder username used in the log files. In this section it refers to name of the account bound to Gitolite] is in the listing \ref{lst:impl:gitolite:logs}.

```{language=make caption="Implementation: Gitolite log error 1" label="lst:impl:gitolite:logs"}
FATAL: errors found but logfile could not be created
FATAL: /home/smolijar/.gitolite/logs/gitolite-2018-04.log: No such file or directory
FATAL: die	chdir /home/smolijar/.gitolite failed: No such file or directory<<newline>>
```

The problem is seemingly banal.
Gitolite plausibly utilizes the `$HOME` variable.
It is creating logs in *smolijar's* home directory in a non-existent folder and tries to access the same folder.
It should operate on the user it is configured with, in this case the _git_ user.
The output after setting the `$HOME` variable to `/home/git` is in the listing \ref{lst:impl:gitolite:logs2}.

```{language=make caption="Implementation: Gitolite log error 2" label="lst:impl:gitolite:logs2"}
FATAL: errors found but logfile could not be created
FATAL: /home/git/.gitolite/logs/gitolite-2018-04.log: Permission denied
FATAL: cli	gitolite	list-repos
```

With the `$HOME` variable updated, the Gitolite is successfully convinced to use the default directory.
This however, brings another failure, which is an unknown error and insufficient permissions to log it.
The unknown error might very possibly be caused by the same problem -- the insufficient permissions to access Gitolite's files.

From the logs it is apparent and access to the _git's_ home directory is required.
At least with the write access for the `~/logs/` to successfully log the errors and the read access for the `/repositories`, which is most probably the cause of the unknown error.

Since we need to allow the access for another user, there are two options, setting permissions for user and for the group.
Exposing any home directory _to all_ users is an incredible security threat, even more so, considering the home directory holds the entrusted repositories.
Thus setting permission for the group is the remaining solution.

### Setup UNIX group

A UNIX group is created and setup in the following steps:

1. Create group _gitolite_: `sudo groupadd gitolite`
2. Add Gitolite and current user to the group: `sudo usermod -a -G gitolite git && sudo usermod -a -G gitolite smolijar`
3. Change the _git_ home repository's group ownership recursively: `sudo chgrp -R gitolite /home/git/`
4. Allow the user to write in selected folders: `sudo chmod -R 2775 /home/git/.gitolite`

### SSH Secure mode

This is a side issue encountered when greedily setting the group's permission for the whole home directory `/home/git/` and not just the `.gitolite` sub-folder.

After setting up the permissions like so, Gitolite CLI seemingly works, while the Gitolite SSH interface stops working, rejecting all the connections with error regarding a missing repository.

_"This is the default behavior for SSH. It protects user keys by enforcing `rwx------` on `$HOME/.ssh` and ensuring only the owner has write permissions to `$HOME`. If a user other than the respective owner has write permission on the `$HOME` directory, they could maliciously modify the permissions on `$HOME/.ssh`, potentially hijacking the user keys, `known_hosts`, or something similar. In summary, the following permissions on `$HOME` will be sufficient for SSH to work."_[@stackexchange:ssh]

SSH for security reasons kills any incoming connections to a users, whose home folder is by its standards insecure.

This can be bypassed by disabling the SSHD option _strict modes_^[Defining `StrictModes no` in `sshd_config`, usually located in `/etc/ssh/sshd_config`.].
This of course is dangerous and should not be performed on a machine, where the administrator does not have full control over the users, or cannot deny that a user with a configured remote access in the `authorized_keys` has a write access in their home directory.
If Gitolite is set up properly and only provides authorized access via Gitolite CLI^[As described in the analysis, Gitolite authorizes new users but instead of providing them with the full access, it only allows them to run the Gitolite program.], it is be due its `command` option safe.

*However, this is not required if setting the relaxed permissions only on the sub folder, as suggested in the previous section!*

### Owner of log files

Even when fixing the issue with SSH, later on, after both users have been using Gitolite for some time, yet another issue is nigh.

It is again a permission problem, and again with log files.
The issue triggers the same error, as shown in \ref{lst:impl:gitolite:logs2}, but this can happen for either of the users.

The problem is that _the other account_, in this case _smolijar_, creates a new log file, when the log files are swapped or new log is created.
The log file is created with the correct GID (thanks to the `setguid` bit), by the user _smolijar_, but with the wrong permissions (no group access).

This is solved when the default set of permissions is set for the new files in the log folder.
A similar problem is discussed in [@stackexchange:def-perm].
The desired effect can be achieved using the `setfacl` command:

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
The results of before (listing \ref{lst:impl:gitolite:acl1}) and after (listing \ref{lst:impl:gitolite:acl2}) are present.
Three new lines with default permissions are added.
Now all the newly created log files by the user _smolijar_ have the desired relaxed permissions for the group.

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
