# Wiki.js

Wiki.js is a modern capable wiki software powered by Node.js, Markdown and Git [@wikijs], developed by Nicolas Giard et al.
With the initial release in September 2016, Wiki.js is the youngest software.

Being designed with the specific technologies in mind, the specialized features are be expected from the project.
As far as the non-functional requirements and technological restrains reach, Wiki.js, being a Node.js application, backed by Git only^[The abstraction of used VCS can potentially be a threat, as seen with Gitit not supporting branches] and favoring modern popular LML Markdown, is by far the closest to the thesis' project.

After the installation user is prompted to run the configuration wizard^[Configuration can also be set in the `config.yml` configuration file.], where user can set the name of the wiki, configure MongoDB^[Which is used for user data, not wiki's contents.], default permissions (e.g. is wiki public to anonymous users by default) and a remote Git repository with its SSH authentication data.

## User access control

Wiki.js is the first project in the chapter to offer a strong ACL mechanism.
Within the WUI, administrator can set permissions for individual users or managed groups via settings.
The permission rule, added to a user or a group consists of the following settings:

* Permission -- either _Read only_ or _Read and write_
* Path
    * _Path starts with_ or _Path match exactly_
    * Path string
* Access -- either _Allow_ or _Deny_

Though the described ACL interface is not as complex, nor as powerful as seen among others^[Meaning it does not provide as complex expressions as seen in Ikiwiki's PageSpec, for instance.], it is most fitting for the created scenario
-- a relatively easy way to restrict access within repository in a name-space manner.

Though not apparent from the documentation, after an examination of the MongoDB database data of running Wiki.js, it is obvious that they are actually stored in the database, rather than in files.
This means that ACL is not implicitly version-controlled nor available for the direct access provided by Wiki.js.

## Direct repository access

Contents are stored in a Git repository.
This can either be a local repository, or a repository mirrored to its remote over SSH or basic authentication.

Repository is by its nature accessible directly from the remote and Wiki.js handles [@wikijs:git] the synchronization on its own.
Git repository is clean, formed solely of the Markdown documents.
All meta-data are detached from the repository and saved in the MongoDB.

Wiki.js however does not handle direct repository access^[in sense of a hosting service] and it is in the hands of the administrator again.

## Document format

Wiki.js only supports Markdown as the sole document format.
This can be seen as a disadvantage in form of a user restriction as well as an advantage -- the potential for Wiki.js to peruse perfection in the tools specialized for Markdown.

The same way Gitit used the Pandoc format's YFM for meta-data, Wiki.js uses a similar trick.
Since Markdown does not support any meta-data syntax, Wiki.js uses Markdown's comments^[At least its "most supported" syntax of the comments. Since there is no consensual cannon specification of the Markdown grammar, it is defined by its various implementations. Their somewhat unexpected behavior can be compared in [@babelmark].] for meta-data.
This syntax can be used to define page title for instance as seen in the listing \ref{lst:wikijs:comment}.

```{language=html caption="Wiki.js: Markdown meta comments" label="lst:wikijs:comment"}
<!-- TITLE: Home -->
<!-- SUBTITLE: A quick summary of Home -->

# Header
```

## Branching model

The branching model is not supported.
Wiki.js can change the remote branch for synchronization, but this requires the change in the configuration.

This is a similar approach to the one taken by Gollum, which effectively requires a restart to lock onto a different branch.

This feature can be actually used for the parallel development, when running multiple Wiki.js instances and mirroring to a single repository, but onto different branches.
This strategy is useful for developing few, not-related wikis, mirroring into a single repository.
This approach however, is not useful for managing several versions of the same repository of a single project, the way it is described in the business process model.

## UI

![Wiki.js: Page preview](./src/assets/images/wikijs-page){#fig:wikijs:page width=100%}

Wiki.js offers the UI (image @fig:wikijs:page) which has the same widgets as  seen before, though visually distinguished from other project. This is plausibly an effect of the fact that Wiki.js is the youngest software.
Apart from the website navigation there is a document TOC navigation placed under it in the left sidebar.

![Wiki.js: Page edit](./src/assets/images/wikijs-edit){#fig:wikijs:edit width=100%}

Wiki.js offers custom Markdown editor with features focused on the language, as seen in figure @fig:wikijs:edit.
The editor features a hybrid live preview of the formatted source code (using proportional sizes and font styles and colors for the formatted markup), as well as a toolbar for the users, who are unfamiliar with Markdown, who can use editor as a RTE.

## Summary

- A user friendly, relatively powerful permission control is provided.
- Branch support is available, though inconvenient for the scenario.
- SSH authorization is not handled by the application and it is burdensome to synchronize with the existing authorization settings, since FE and BE API decoupling is in progress a scheduled [@wikijs:dev] for the version `2.0`.
- Only Markdown LML is supported.
- Hybrid advanced RTE is provided.
- Git repository mirroring is available.

Wiki.js provides convenient user permission configuration, modern UI and specialized Markdown editor.
