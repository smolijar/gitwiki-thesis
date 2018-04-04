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
Most of the statistics reflecting global usage of VCS are thus misleading, and in global scope with private projects Subversion still rules over Git with usage statistics.
From various sources, e.g. mentioned in [@stackexchange:vcs], it is apparent that Git's popularity is increasing over the years, which makes Git a reasonable choice.

Using Git as an underlaying VCS layer brings two important questions to discuss.

1. Access control gets more complicated.
In centralized VCSs, it is natural to have the feature of file locks, which is e.g. available in Subversion.
Though there are tools to simulate this in Git, it gets far more challenging.
How do we solve access control within a Git repository?

2. Git provides a useful interface for repository cloning, granting us an elegant solution for direct file access, familiar to Dump, Lump and Pump.
Users are authenticated through SSH authentication layer, once they deliver their public keys to the hosting server, which is a standard practice used by popular git hosting providers.
The question is, how do we authenticate the user in WUI and pair them with their stored public key?

## Authorization

We need a tool for an authorization layer atop SSH to manage Git repository access for our Git hosting.
Let us go over few possible open source options we have.

There are many git hosting services with a swarm of supportive features, such as code review, issue tracking and even access control.
These self-hosted services e.g. include Gogs [@gogs], GitBucket [@gitbucket] or GitLab [@gitlab].
This is not primary what we are after, since none of them by this time offer modular usage, to use just the mere authorization SSH layer.
I will pick GitLab as an example of this group.

Since none of the examples from said group are convenient, let us take a look on software that serves only that purpose.
Here we have two fine examples.
That is Gitorious [@gitorious] and Gitolite [@gitolite].
Gitorious however is no longer maintained, since it has been acquired by GitLab in 2015 [@gitorious:gitlab].
The fact that Gitolite, which is still maintained, was for some time used by GitLab as an authorization layer, makes it even more relevant given GitLab's popularity.
One of the reasons for that is that GitLab faced performance issues with massive count of repositories and users. [@gitolite:gitlab].
This might be an issue for massive corporations, but since Gitolite has reached performance issues with configuration parsing at 560K+ LOC of configuration files and 42K repositories reached by Fedora, it should be just fine for our purpose. [@gitolite:perf]


## GitLab

_"GitLab is a single application with features for the whole software development and operations (DevOps) lifecycle."_ [@gitlab:about]
It is an open source project started in 2011 with more than 1900 contributors and used by over 100K organizations as a self hosted Git server with many development supportive features [@gitlab:about].

It offers a rich, well documented GraphQL API (as well as still maintained REST API), which could be well used to our benefit for application control.

Using GitLab would solve the issue of authentication as well, because GitLab comes bundled with embedded user management service storing user data in its own database.
This I consider to be a great asset for the purpose.

As far as access control goes, it offers fine control over Git branches via user groups using the _protected branches_ [@gitlab:branches], which is a feature well known amongst similar services.
This however remains to be the only level of control it offers within a single repository.
A file locking feature exists in GitLab, but is only available in GitLab Premium, where it is available since GitLab Premium 8.9 [@gitlab:files].

One of the problems with GitLab is, as officially stated, that it is a _single application_.
I cannot be used modularly for our specific purpose.
