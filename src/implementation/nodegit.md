# NodeGit

Whilst building the `git` module in Gitwiki BE application NodeGit is used.

In this section one part of the interaction with Git repository is discussed
The interaction is retrieving a repository.

## Get repository

In the `git` module, a dead simple API: _Get a repository_ is desired.
This of course needs some parameters that are provided by the repository provider:

- URL of the repository,
- FS destination path and
- authentication data.

While the former two can surely be strings, the last is more complicated.
NodeGit has a class `Cred` [@nodegit:cred] for representing the user identity.

## Credentials

Generally `Cred` is used in all interactions inside a callback function which can react to the used username and the URL.
Example usage  of the credential callback, when setting options for cloning a repository, is seen in the listing \ref{lst:impl:nodegit:cred} (the listing is taken from [@nodegit:sshguide]).
NodeGit thus provides an abstraction for the last item of complex type.

```{language=js caption="Implementation: NodeGit -- Credentials callback" label="lst:impl:nodegit:cred"}
<<nodegit/cred.js>>
```

## Function `getRepo`

The implementation of the function `getRepo` is discussed step by step and all the problems on the way are resolved.

The function is seen in the listing \ref{lst:impl:nodegit:getrepo}.
It takes all the discussed parameters.
The clone options object is created from the credential callback on the second line and setup (curried function) is created from it.

```{language=js caption="Implementation: NodeGit -- Getting a repository" label="lst:impl:nodegit:getrepo"}
<<nodegit/getRepo.js>>
```

Then the cloning itself is performed, delegated to the NodeGit library, which returns a Promise with the repository or error.

If the cloning succeeds, the repository needs to be set up with the prepared function and `createLocalRefs` is called, which is discussed in a moment, and result is returned.

If the cloning fails, the encountered error is returned, unless it is the error code `EEXISTS`, which indicates that the repository could not have been cloned, since the destination path points to a non-empty directory.
This happens rather often, since the repository is often cloned for the first time only and then the cached local mirror is accessed on consecutive queries.
On this error the repository is retrieved and updated it in the function `retrieveCachedRepo`.


## Function `createLocalRefs`

The existence of the function requires a comment, even for the people using Git CLI on their daily bases.
When cloning a remote, all remote branches are stored in the local references^[e.g. `.git/refs/remotes/origin/master`].
If the remote repository has more branches, all are correctly transfered and saved, but only the default branch (`master`) is created as a _local branch_^[e.g. `.git/refs/heads/master`].
To these branches user can checkout^[_Checking out_ refers to setting the `HEAD` reference on a _branch_ -- not commit or tag; nor checking out files. Git terminology might be a little confusing at times overusing this word.], but they cannot checkout in other references cloned from the origin, since they are not _branches_ per se.

This is very much possible in Git CLI however.
Though the _local branch_^[Reference in `.git/refs/heads`] does not exist, user can indeed `git checkout <branch>` to a branch that _only exists_ in the remote references in Git CLI.
This is just a syntax sugar for creating a head reference on the same OID as the remote reference; which Git CLI does for the user, on the first checkout into a branch that does not exist, but has a counterpart in the remote references of the same name.
That is the reason why the line between remote references and head references is blurred for even advanced users of Git.

To finally get to the bottom of the function `createLocalRefs`, it exactly solves the discussed issue.
Since there is no Git CLI behind NodeGit to create the head references, when they are needed, it is required to create them manually.
The function is in the listing \ref{lst:impl:nodegit:createlocalrefs}.

```{language=js caption="Implementation: NodeGit -- Create local references" label="lst:impl:nodegit:createlocalrefs"}
<<nodegit/createLocalRefs.js>>
```

At first, all available references are retrieved from the repository, from which are filtered only the remote references.
Then for each remote reference, the following actions must be performed:

- Find the OID, so it is known onto which commit to _hook_ the new branch^[The OID is available through a synchronous method `target`, as seen on line 5 if listing \ref{lst:impl:nodegit:createlocalrefs}.]
- Get name of the remote reference (line 6) using a custom parsing function^[`remoteRef.toString()` returns the full path, e.g. `refs/remotes/origin/master`, while the NodeGit's API for creating a branch expects only the name of the remote, e.g. `origin/master`]
- Get the name of the branch^[Ditto, prefix must be removed, converting `refs/heads/master` to `master`] (line 7)
- Retrieve the branch (line 8)
    - Either get an existing branch (it might already exists in case of the second run or default branch),
    - or create it on the given OID
- Setup the remote reference as an upstream branch for the new local branch (line 9)

Setting up the remote is not necessary for using the branch locally, but for publishing it to the remote repository.
The Git CLI user is familiar with the argument `--set-upstream` when pushing a branch to a remote for the first time.
If the branch is created from the remote by Git CLI the upstream is automatically set^[Tested on git version `2.7.4`].


## Function `retrieveCachedRepo`

This function (its implementation is in the listing \ref{lst:impl:nodegit:retrievecachedrepo}) is called with the destination, when the cloning fails due to an existing, non-empty destination folder.
It needs to:

```{language=js caption="Implementation: NodeGit -- Retrieve cached repository" label="lst:impl:nodegit:retrievecachedrepo"}
<<nodegit/retrieveCachedRepo.js>>
```

1. Create the repository abstraction using the NodeGit's `Repository.open`
2. Apply the provided setup method, created in and passed form the `getRepo` function
3. Update the head references with a set remote upstreams

The first two require no further comment, unlike the reference update.
A repository that has been cloned some time before is being accessed.
To get the repository that is up to date, without re-cloning it, each local branch is _pulled_ from its configured upstream.^[While this method (_pull before you do anything_) is heedlessly practiced by the majority of the users, as satirically pointed out by [@xkcd:git], here the cause is justified. When applied by a _user_, it is usually to minimize the risk of an update conflict when pushing to a remote. Here on the other hand, it is to gain access to the current data, even when utilizing this form of caching.]
This action logic is in the function `updateRemoteRefs`.

## Function `updateRemoteRefs`

This method _pulls_ for each local branch with configured upstream.
While `pull` is indeed command in Git CLI, it is not available in libgit2 and eventually neither in NodeGit.
_Pull_ is a user abstraction and shortcut for the two consecutive commands: `fetch` and `merge`.

`Fetch` for change is actually a command from Git core library and it updates the remote references to match the remote.
After that (to complete the *pull*), it is required to update the local references to match the fresh remote references.
This is achieved through hard resetting branches.
After the branches are reset, the function is done and it returns the repository.

```{language=js caption="Implementation: NodeGit -- Update branches with remote upstreams" label="lst:impl:nodegit:updateremoterefs"}
<<nodegit/updateRemoteRefs.js>>
```

As seen in the listing \ref{lst:impl:nodegit:updateremoterefs} the function proceeds as follows:

1. Fetch all remote references using NodeGit's `Repository.fetchAll`
2. Create local references through a function that has already been discussed
3. Get pairs of local branches and their upstreams
4. For each pair:
    - Retrieve the commit of the upstream
    - Hard reset the branch to the commit

