# Wiki.js

Wiki.js is a modern capable wiki software powered by Node.js, Markdown and Git[@wikijs], developed by Nicolas Giard et al.
With the initial release in September 2016, Wiki.js is the youngest contestant.

Being designed with the specific technologies in mind, specialized features are ought to be expected from the project.
As far as non functional requirements and technological restrains go, Wiki.js being a Node.js application, backed by Git only^[The abstraction of used VCS could potentially be a threat, as seen with Gitit not supporting branches] and favoring modern popular LML like Markdown, is by far the closest to our project.

After the installation user is prompted to run configuration wizard^[Configuration can also be set in the `config.yml` configuration file.], where user can set wiki's name, configure MongoDB^[Which is used for user data, not wiki's contents.] default permissions (e.g. is wiki public to anonymous users by default) and remote Git repository and SSH authentication.

## User access control

Wiki.js is the first project in the chapter to offer a strong ACL mechanism.

Within the WUI, administrator can set permissions for individual user or managed groups via settings.
The permission rule, added to user or group consists of following settings:

* Permission -- either _Read only_ or _Read and write_
* Path
    * _Path starts with_ or _Path match exactly_
    * Path string
* Access -- either _Allow_ or _Deny_

Though the described ACL interface is not as complex or as powerful^[Meaning it does not provide as complex expressions as seen in Ikiwiki's PageSpec, for instance.], it is most fitting for our example
-- a relatively easy way to restrict access within repository in a name-space manner.

Though I did not find it in the documentation on brief inspection, after examination of the MongoDB database data of running Wiki.js, I found out that permissions are actually stored in the database, rather than in files.

This means that ACL is not implicitly version controlled nor available for the direct access.

## Direct repository access

Contents are stored in a Git repository. This can be either just local, or mirrored to the remote over SSH or basic authentication.

Repository can by its nature then be accessed directly and Wiki.js should handle[@wikijs:git] the synchronization on its own.
Git repository is clean, formed only of the Markdown documents.
All meta-data are detached from the repository and saved in the MongoDB.

Wiki.js however does not handle direct repository access^[in sense of a hosting service] and it is in the hands of the user again.

## Document format

Wiki.js only supports Markdown as the sole document format.
This can be seen as a disadvantage in form of a user restriction as well as an advantage however -- the potential for Wiki.js to peruse perfection in the tools specialized for Markdown.

The same way Gitit used the Pandoc format's YFM for meta-data, Wiki.js uses a similar trick.
For Markdown does not support any meta-data syntax, Wiki.js is using Markdown's comments^[At least its most supported syntax of comments. Since there is no consensual cannon specification of the Markdown grammar, it is defined by its various implementations, whose sometimes unexpected behavior can be compared in [@babelmark].] for meta-data.
This syntax can be used to define page title for instance as seen in listing \ref{lst:wikijs:comment}.

```{language=html caption="Wiki.js: Markdown meta comments" label="lst:wikijs:comment"}
<!-- TITLE: Home -->
<!-- SUBTITLE: A quick summary of Home -->

# Header
```

## Branching model

Branching model is not supported.
Wiki.js can change the remote branch for synchronization, but requires the change in configuration.

This is a similar approach to the one taken by Gollum, which effectively requires a restart to lock onto a different branch.

This is an interesting feature, which could be actually used for a parallel development, running multiple Wiki.js instances and mirroring to the single repository onto different branches.
This might be useful strategy for developing few not-related wikis, mirroring in a single repository.
This approach however is not very useful for managing several versions of the same repository of a single project, as described in the business process model.

## UI

![Wiki.js: Page preview](./src/assets/images/wikijs-page){#fig:wikijs:page width=100%}

Wiki.js offers UI (image @fig:wikijs:page) which has the same widgets as we have seen before though visually distinguished from other project which is most probably an effect of the fact that Wiki.js is the youngest contestant.
Apart from the website navigation there is a document TOC navigation placed under it in the left sidebar.

![Wiki.js: Page edit](./src/assets/images/wikijs-edit){#fig:wikijs:edit width=100%}

Wiki.js offers custom Markdown editor with features focused on the language, as seen in figure @fig:wikijs:edit.
The editor features a hybrid live preview of formatted source code (using proportional sizes and font styles and colors for the formatted markup), as well as toolbar for users unfamiliar with Markdown, who can use editor as a form of RTE.

## Summary

- A user friendly, relatively powerful permission control is provided.
- Possible though inconvenient branch support.
- SSH authorization not handled and burdensome to sync with the existing authorization settings, since front-end and back-end API decoupling is in progress a scheduled[@wikijs:dev] for version `2.0`.
- Only Markdown is supported
- Hybrid advanced RTE is provided.
- Git repository mirroring is available.

Wiki.js provides convenient user permission configuration, modern UI and specialized Markdown editor.
