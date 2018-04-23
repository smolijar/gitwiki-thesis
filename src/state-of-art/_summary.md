# Summary

I have researched chosen wiki systems and individually discussed the criteria I have established based on the required system features.

Non of the systems are ready to substitute the software product of the thesis, as discussed in the defects (regarding to given criteria) in each summary.

The major issue with each solution was failing the requirement _F-2 Authorization_, which states that the authorization policy is consistent, no matter the used interface^[One user is bound by the same set of rules whether they use WUI or CLI.]
The only solution that had in repository permission control was Wiki.js, and as stated in its section, the permission rules are stored a database with no guarantee of consistent API provided by Wiki.js at the moment.
Reading the permission configuration is not feasible for Wiki.js.
Having said that, even if it would be possible to easily obtain ACL configuration from Wiki.js, its power is far less sophisticated than the one provided by Gitolite configuration.
Having Wiki.js permissions translated into Gitolite configuration would degenerate the configuration power to the level of Wiki.js.

Apart from that, there are few other, though important, though less fundamental issues.

First is breach of _F-3 Content management_ which demands support for Markdown and Asciidoc as well as modular extensibility. 
Some systems, like Wiki.js, are bound to specific formats, so extensibility is not in question.
The only system that by brief glance^[I had very limited time in the extent of the topic to explore each system in the detail that I would get to the source code or advanced topics of API documentation with more than a few exceptions. Judging the extensibility and the level of abstraction for LMLs is an advanced topic.] would plausibly satisfy the requirement was Gollum, which alas failed at the following issue.

Next issue majority of systems failed to comply was _UC-6 Select a revision_.
Many systems ignored the repository's branching model and other's offered impractical implementation of it.

From the point of the UI that would distinguish Git backed wiki systems from others, the main aspect is navigation.
While wiki uses namespaces as a hierarchical structure of pages, said systems usually favor directory perspective^[This is probably cause of that Git repositories usually contain at least some portion of source codes, or other files that are not pages per se.] and provide _file browser_ for traversing the repository directories.
This is clearly seen in Gollum for instance.

VCS revision (Git commit) was in all systems considered as an atomic^[in sense of files] change.
User could not create a commit via WUI that would change contents of two different files for instance.
Rename, delete, create commit messages were usually created automatically, without user's knowledge, while revisions changing file contents usually required user to describe incorporated changes manually.

In the next chapter I shall amongst other discuss how I plan to resolve the issues described in this summary.
