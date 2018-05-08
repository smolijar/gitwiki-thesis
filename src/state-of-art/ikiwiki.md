# Ikiwiki

Ikiwiki is a software project licensed under GNU GPL version 2 or later [@ikiwiki:free], written in Perl and was first released in April 2006 by Joey Hess et al.
_"Ikiwiki is a wiki compiler. It converts wiki pages into HTML pages suitable for publishing on a website."_ [@ikiwiki]
What is the most admirable about Ikiwiki is that can use Subversion as well as Git, which implies a form of VCS abstraction is used throughout the system.
This can result however, in the lack of features such as access control (because general implementation of this feature is exceptionally complex) or Git specific features such as branching model for parallel development.

Ikiwiki is, as stated, primarily a _wiki compiler_, meaning its main goal is to compile the document pages into the selected format (presentable format from LML).

## User access control

For the Git SSH access there is no form of user control when using Ikiwiki with Git.
Keys for accessing the repository via SSH must be set manually and are not managed by the application [@ikiwiki:keys].

Access control in the WUI is possible [@ikiwiki:httpauth] through the `httpauth` plug-in using the CGI configuration.
This allows to create a private wiki as a whole, as well as to pinpoint the pages that require authentication (and leaving rest implicitly public).


The subset of pages that require authentication is defined using _PageSpec_ [@ikiwiki:pagespec].
This allows to define the pages as a mere list of their names, but also using advanced functions for matching links to the pages, date creation or pages created by the given user.
PageSpec is a surprisingly powerful tool, as shown in the following demonstration.
"_For example, to match all pages in a blog that link to the page about music and were written in 2005_" [@ikiwiki:pagespec] use PageSpec displayed in the listing \ref{lst:ikiwiki:pagespec}. [@ikiwiki:pagespec]

```{language=lisp caption="Ikiwiki: PageSpec example" label="lst:ikiwiki:pagespec"}
blog/* and link(music) and creation_year(2005)
```

The concept of authorization and authentication is intertwined, as officially stated in [@ikiwiki:todo:auth].
Though it is technically possible to somewhat differentiate between the two using PageSpec functions `user(username)`, `ip(address)` etc. and distinguish read, write access for e.g. comments with functions `comment(glob)` and `postcomment(glob)`, the ACL is formed of a single logical expression, resulting in an unmaintainable configuration, when used for several users with a non-trivial access policy.

## Direct repository access

The direct access via Git CLI is available, since Git repository can be hosted on the remote machine.

Ikiwiki must be provided the SSH keys for the remote repository access.
Serving the repository over SSH is not provided by the software.

## Document format

Ikiwiki supports primarily Markdown with extended syntax^[Using _wiki links_(`[[WikiLink#foo]]`) and its akin _directives_.].
However, via plug-ins it features support for HTML, WikiText [@wikitext], Textile [@textile] or reStructuredText [@rst]. [@ikiwiki:features]

Extensive document editing is expected to be handled with a direct file access in custom environment.
The WUI offers only a simple textarea.
Using a RTE in the WUI has been considered and is recorded in the "todo" section [@ikiwiki:todo:wysiwyg], however, with an outdated link to the current version 1.6 of the plug-in.

## Branching model

It is possible to use the mentioned Markdown extension `directive`, to reference a Git branch [@ikiwiki:gitbranch].
The existing branches [@ikiwiki:branches] are displayed as single documents in the WUI, forming one _bug_ or a _todo_.
Parallel version maintenance through WUI is unlikely.

## UI

![Ikiwiki: Page preview](./src/assets/images/ikiwiki-page){#fig:ikiwiki:page width=100%}

On the conceptual level as described in the introduction of the chapter, the UI of the wiki is not affected by the underlaying VCS layer, as seen on the page preview on the image @fig:ikiwiki:page.
There are tools in WUI however, such as the history preview, that take the advantage of the VCS background.
Atop of the content of the wiki page with outline by its side, there is a toolbar with links including _Edit_, _History_, etc. and a search form.
At the bottom, there are pages linking to this page and last edit meta-data.

![Ikiwiki: Page edit](./src/assets/images/ikiwiki-edit){#fig:ikiwiki:edit width=100%}

On the edit page there is a standard static preview button.
This is depicted on the image @fig:ikiwiki:edit.

## Summary

- The PageSpec tool is powerful, but very hard to use for the basic configuration and is maladroit to maintain.
- The SSH authorization is not handled and burdensome to sync with the existing authorization settings.
- The Authentication is blended with the authorization.
- The usage of Git branch is unusual.
- Plain-text editing is provided.

Ikiwiki, being the oldest project in the chapter, suffers from the historical decisions, which might have been relevant at its time.
Nevertheless, they are but burdens now.
This includes complex PageSpec implementation and unfortunate fusion of the authentication and  the authorization.
