# Summary

The selected wiki systems are discussed in this chapter with regard to established criteria.
None of the systems are ready to substitute the software product of the thesis, as concluded in the defects (regarding the given criteria) in each summary.

The major issue with each solution is failing the requirement _F-2 Authorization_, which states that the authorization policy is consistent, no matter the used interface^[One user is bound by the same set of rules whether they use WUI or CLI.]
The only solution that has an in repository permission control is Wiki.js, and as stated in its section, the permission rules are stored in a database with no guarantee of consistent API provided by Wiki.js at the moment.
Interpreting the Wiki.js' permission configuration is not feasible.
Having said that, even if it were possible to obtain the ACL configuration from Wiki.js, its power is far less sophisticated than the one provided by the Gitolite configuration.
Having Wiki.js permissions compiled into the Gitolite configuration would degenerate the ACL expressiveness to the level of Wiki.js.

Apart from that, there are few other important, though less fundamental issues.

Firstly is the breach of the _F-3 Content management_ which demands support for Markdown and Asciidoc as well as modular extensibility.
Some systems, such as Wiki.js, are bound to specific formats, so extensibility is not in question.
The only system that by brief glance plausibly satisfies the requirement is Gollum, which alas failed at the following issue.

The issue majority of the systems fail to comply is _UC-6 Select a revision_.
Many systems ignore the repository's branching model and others offered an impractical implementation of it.

From the point of the UI that would distinguish Git backed wiki systems from others, the main aspect is the navigation.
While generally wiki uses namespaces as a hierarchical structure of pages, said systems usually favor directory perspective^[This is the cause of the fact that the Git repositories usually contain at least some portion of source codes, or other files that are not pages per se.] and provide a _file browser_ widget for traversing the repository directories.
This is clearly seen in Gollum for instance.

VCS revision (Git commit) is in all systems considered as an atomic^[in sense of files] change.
User cannot not create a commit via the WUI that would change the contents of the two different files for instance.
Rename, delete, create commit messages are created automatically, without the user's knowledge, while revisions changing file contents, prompt the user to describe incorporated changes manually.

In the next chapter, it is explained how are the stated issues resolved.
