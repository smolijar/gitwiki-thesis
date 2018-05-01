# NodeGit

I had to familiarize myself with NodeGit, whilst building the `git` module in Gitwiki BE application.

In this section I shall go over one part of the interaction with Git repository, which is retrieving one,
which might seem banal, but there is more to it than it seems.

## Get repository

In the api of my `git` module I wanted to have a dead simple API: _Get a repository_.
This of course needs needs some parameters that are provided by the repository provider:

- URL of the repository,
- FS destination path and
- authentication data.

While the former two can be surely strings, the last is more complicated.
Luckily, NodeGit has class `Cred`[@nodegit:cred] for representing the user identity.

## Credentials

Generally `Cred` is used in all interactions inside a callback function which can react to username and URL.
Example usage  of the credential callback when setting options for cloning a repository is seen in listing \ref{lst:impl:nodegit:cred} (listing taken from [@nodegit:sshguide]).
NodeGit thus provides an abstraction for the last, complex type item.

```{language=js caption="Implementation: NodeGit -- Credentials callback" label="lst:impl:nodegit:cred"}
<<nodegit/cred.js>>
```

## Function `getRepo`

Let us go over the implementation of the function `getRepo` step by step and resolve all problems on the way.

The function is seen in listing \ref{lst:impl:nodegit:getrepo}.
It takes all the discussed parameters and no other.
The clone options object is created from the credential callback on second line and setup (curried function) is created from the object.

```{language=js caption="Implementation: NodeGit -- Getting a repository" label="lst:impl:nodegit:getrepo"}
<<nodegit/getRepo.js>>
```

Now the cloning itself is performed, delegated to the NodeGit library, which returns a Promise with the repository, or error.

If cloning succeeds, we just setup repository with prepared function, call `createLocalRefs` to which I will get in a moment and return it.

If cloning fails, we return the error, unless it is error code `EEXISTS`, which indicates that the repository could not have been cloned, since the destination path points to a non-empty directory.
This happens rather often, since we often clone the repository for the first time only and then access the cached local mirror.
On this error we lookup the repository and update it in function `retrieveCachedRepo`.


## Function `createLocalRefs`

It might not be obvious why this function exists, even for a user who uses Git CLI on daily bases.

When cloning a remote, all remote branches are stored in the local refs^[e.g. `.git/refs/remotes/origin/master`].

If the remote repository has more branches, all are correctly transfered and saved but only the default branch (`master`) is created as a _local branch_^[e.g. `.git/refs/heads/master`].
To these branches user can checkout^[By _checkout_ I mean setting the `HEAD` reference on a _branch_ -- not commit or tag; nor checking out files. Git terminology might be a little confusing at times.], but cannot in other refs cloned from the origin, since they are not _branches_ per se.

This might be puzzling for a Git CLI user, because this is very much possible in Git CLI.
Though the _local branch_^[Reference in `.git/refs/heads`] does not exist, user can indeed `git checkout <branch>` to a branch that _only exists_ in the remote refs.
This is just syntax sugar for creating a head reference on the same OID as the remote ref; which Git CLI does for you, on the first checkout into a branch that does not exist, but has a same name counterpart in remote refs.
That is the reason why the line between remote refs and head refs is blurred for even advanced users of Git.

To finally get to the bottom of the function `createLocalRefs`, it exactly solves the discussed issue.
Since there is no Git CLI behind our back to create the head refs, when they are needed, we create them ourselves to save us some trouble in the future.

The function is in the listing \ref{lst:impl:nodegit:createlocalrefs}.

```{language=js caption="Implementation: NodeGit -- Create local references" label="lst:impl:nodegit:createlocalrefs"}
<<nodegit/createLocalRefs.js>>
```

First, all available references are retrieved from the repository, from which we filter only the remote references.
Then for each remote reference, we must perform the following actions:

- Find OID, so we know onto which commit we _hook_ the new branch ^[The id is available thought synchronous method `target`, as seen on line 5 if listing \ref{lst:impl:nodegit:createlocalrefs}.]
- Get name of the remote reference (line 6) using custom parsing function^[`remoteRef.toString()` returns the full path, e.g. `refs/remotes/origin/master`, while the NodeGit API for creating a branch expects only the name of the remote, e.g. `origin/master`]
- Get the name of the branch^[Ditto, we need to get rid of the prefix, converting `refs/heads/master` to `master`] (line 7)
- Retrieve the branch (line 8)
    - Either get the existing branch (it might already exists in case of second run or default branch),
    - or create it on the given OID
- Setup the remote ref as an upstream for the new local branch (line 9)

Setting up the remote is not necessary for using the branch, but for publishing it to the remote repository.
The Git CLI user might be familiar with the command `--set-upstream` when pushing a branch to the remote for the first time.
If the branch is created from the remote by Git CLI the upstream is automatically set^[Tested on git version `2.7.4`].


## Function `retrieveCachedRepo`

This function (its implementation is in the listing \ref{lst:impl:nodegit:retrievecachedrepo}) is called with the destination, when the cloning fails due to existing folder.
It needs to:

```{language=js caption="Implementation: NodeGit -- Retrieve cached repository" label="lst:impl:nodegit:retrievecachedrepo"}
<<nodegit/retrieveCachedRepo.js>>
```

1. Create the repository abstraction using `NodeGit.Repository.open`
2. Apply the provided setup method, created in and passed form the `getRepo` function
3. Update head references with set remote upstreams

The first two require no further comment, unlike the reference update.
Let us remind ourselves that we are accessing a repository, that has been cloned some time before.
It might have been seconds or days.
To get repository that is up to date, without re-cloning it, we _pull_ each local branch from its configured upstream.^[While this method (_pull before you do anything_) is heedlessly practiced by the majority of the users, as satirically pointed out by [@xkcd:git], here the cause is justified. When applied by a _user_, it is usually to minimize risk of update conflict when pushing to a remote, but here on the other hand, it is to with current data even when utilizing this form of caching.]
This action logic is in function `updateRemoteRefs`.

## Function `updateRemoteRefs`

This method should _pull_ for each local branch with configured upstream.
While `pull` is indeed command in Git CLI, it is not available in libgit2 and eventually neither in NodeGit.
_Pull_ it is a user abstraction and shortcut for two consecutive commands: fetch and merge.

Fetch for change is a command from Git core library and it updates the remote references to match the remote.
After that, we need to update the local references to match the updated remote references, and this is achieved through merging branches^[Normally, this could result in a conflict a user would need to resolve manually. The application's philosophy is to operate with the repositories in the _"most stateless"_ fashion possible. It does not provide higher level interface for _commit_ for instance -- instead only for _commit and push to origin_. Every change is immediately mirrored to the remote, or discarded. That is the reason why there cannot be any commit pending in the local branch causing a conflict for the merging process in this phase.].
After the branches are merged, the function is done and it returns the repository.

```{language=js caption="Implementation: NodeGit -- Update branches with remote upstreams" label="lst:impl:nodegit:updateremoterefs"}
<<nodegit/updateRemoteRefs.js>>
```

As seen in listing \ref{lst:impl:nodegit:updateremoterefs} the function proceeds as follows:

1. Fetch all remote references using NodeGit's `Repository.fetchAll`
2. Create local references through a function that has already been discussed
3. Get pairs of local branch names and their upstreams, for all local branches that have an upstream configured
4. Merge the pairs

