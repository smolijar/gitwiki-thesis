# Wiki.js

Wiki.js is a modern powerful wiki software powered by Node.js, Markdown and Git[@wikijs], developed by Nicolas Giard et al.
With initial release in September 2016, Wiki.js is the youngest contestant.

Being designed with the specific technologies in mind, specialized features are ought to be expected from the project.
As far as non functional requirements and technological restrains go, Wiki.js is by far the closest to our project, being a Node.js application, backed by Git only^[The abstraction of used VCS could potentially be a thread, as seen with Gitit not supporting branches] and favoring modern popular LML like Markdown.

After installation user is prompted to run configuration wizard^[Configuration can also be set in the `config.yml` configuration file.], where user can set wiki name, configure MongoDB^[Which is used for user data, not wiki's contents.] default permissions (e.g. is wiki public to anonymous users by default) and remote Git repository and SSH authentication.

## User access control

Wiki.js is the first project in the chapter to offer a strong ACL mechanism.

Within the WUI, administrator can set permissions for individual user or managed groups by setting.
The permission rule, added to user or group consists of following settings:

* Permission -- either _Read only_ or _Read and write_
* Path
    * _Path starts_ with or _Path match exactly_
    * Path string
* Access -- either _Allow_ or _Deny_

Though the described setting is not as complex or powerful^[Meaning it does not provide as complex expressions as seen in Ikiwiki's PageSpec, for instance.], it is most fitting for our example.
A relatively easy way to restrict access within repository in a name-space manner.

Though I did not find it in the documentation on brief inspection, after examination of the MongoDB database data of running Wiki.js, I found out that permissions are actually stored in the database, rather than in files.

This means that ACL is not implicitly version controlled nor available for direct access.

## Direct repository access

Contents are stored in a Git repository. This can be either just local, or mirrored to the remote over SSH or basic authentication.

Repository can by its nature then be accessed directly and Wiki.js should handle[@wikijs:git] the synchronization on its own.
Git repository is clean, formed only of the Markdown documents.
All meta-data are detached from the repository and saved in the MongoDB.

Wiki.js however does not handle direct repository access and it is in the hands of the user again.

## Document format

Wiki.js only supports Markdown as the sole document format.
This can be seen as an user restriction as well as the potential however, for Wiki.js to peruse perfection in tools specialized for Markdown.

The same way Gitit used Pandoc format YAML preamble for meta-data, Wiki.js uses a similar trick.
For Markdown does not support any meta-data syntax, Wiki.js is using Markdown comments^[At least its most supported syntax of comments. Since there is no consensual cannon specification of the Markdown grammar, it is defined by its various implementations, whose sometimes unexpected behavior can be compared in [@babelmark].] for meta-data.
This syntax can be used to define page title for instance as seen in listing \ref{lst:wikijs:comment}.

```{language=html caption="Wiki.js: Markdown meta comments" label="lst:wikijs:comment"}
<!-- TITLE: Home -->
<!-- SUBTITLE: A quick summary of Home -->

# Header
```

## Branching model

Branching model is not supported.
Wiki.js can change the remote branch for synchronization, but requires change in configuration.

This is a similar approach to the one taken by Gollum, which effectively requires restart to lock onto a different branch.

This is an interesting feature, which could be actually used for a parallel development, running multiple Wiki.js instances and mirroring to the single repository onto different branches.
This might be useful strategy for developing few not-related wikis, mirroring in a single repository.
This approach however is not very useful for managing several versions of the same repository of a single project, as described in business process model.

## UI

![Wiki.js: Page preview](./src/assets/images/wikijs-page){#fig:wikijs:page width=100%}

Wiki.js offers UI (image @fig:wikijs:page) which has the same widgets as we have seen before though visually distinguished from other project which is most probably an effect of the fact that Wiki.js is the youngest contestant.
Apart from website navigation there is a document navigation placed under it in left sidebar.

![Wiki.js: Page edit](./src/assets/images/wikijs-edit){#fig:wikijs:edit width=100%}

Wiki.js offers custom Markdown editor with features focused on the language, as seen in figure @fig:wikijs:edit.
The editor features hybrid life preview of formatted source code (using proportional sizes and font styles and colors for formatted markup), as well as toolbar for users unfamiliar with Markdown, who can use editor as a form of RTE.

