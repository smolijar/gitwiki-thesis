# Ikiwiki

Ikiwiki is a software project licensed under GNU GPL version 2 or later[@ikiwiki:free], written in Pearl and was first released in April 2006 by Joey Hess et al.
_"Ikiwiki is a wiki compiler. It converts wiki pages into HTML pages suitable for publishing on a website."_[@ikiwiki]
What is most admirable about Ikiwiki is that it works with Subversion as well as Git, which implies a form of VCS abstraction is used throughout the system.
This is exciting but could result in the lack of some features such as in browser access control (because general implementation of this feature would be exceptionally complex) or branching model for parallel development.

Ikiwiki is, as stated, is primarily a _wiki compiler_, meaning its main goal is to compile document pages into given format (presentable format from LML).

## User access control

For the Git SSH access there is no form of user control when using Ikiwiki with Git.
Keys for accessing the repository via SSH must be set manually and are not managed by the application [@ikiwiki:keys].

Access control in WUI is possible[@ikiwiki:httpauth] through `httpauth` plug-in using CGI configuration.
This allows to create a private wiki as a whole, as well as to pinpoint the pages that require authentication (and leaving rest implicitly public).


The page selection for required authentication is defined using _PageSpec_[@ikiwiki:pagespec].
This allows to define the pages as mere list of their names but also using advanced functions for matching links to pages, date creation or users' pages.
PageSpec is a surprisingly powerful tool, as shown in the following sample.
"_For example, to match all pages in a blog that link to the page about music and were written in 2005_"[@ikiwiki:pagespec] use PageSpec displayed in listing \ref{lst:ikiwiki:pagespec}[@ikiwiki:pagespec].

```{language=lisp caption="Ikiwiki: PageSpec example" label="lst:ikiwiki:pagespec"}
blog/* and link(music) and creation_year(2005)
```

Unfortunately, the concept of authorization and authentication is mixed up as officially stated in [@ikiwiki:todo:auth] and this is a huge drawback for Ikiwiki.
Though it is technically possible to somewhat differentiate between the two using PageSpec functions `user(username)`, `ip(address)` etc. and distinguish read, write access for e.g. comments with functions `comment(glob)` and `postcomment(glob)`, the ACL is formed of a single logical expression, resulting in an unmaintainable configuration for several users with non trivial access policy.

## Direct repository access

Direct access via Git CLI is available, since Git repository can be hosted on the remote machine.

Ikiwiki must be provided SSH keys for the remote repository access and does not handle the repository serving over SSH, which is completely on administrator's responsibility.

## Document format

Ikiwiki supports mainly Markdown with extended syntax^[Using _wiki links_(`[[WikiLink#foo]]`) and its akin _directives_.]. However, via plug-ins it features support for HTML, WikiText[@wikitext], Textile[@textile] or reStructuredText[@rst].  [@ikiwiki:features]

Extensive document editing is usually expected to be handled with a direct file access in text editor.
WUI offers only a simple textarea.
Using a smarter editor in WUI has been considered and is recorded in the "todo" section [@ikiwiki:todo:wysiwyg], however, with a dead link of current version 1.6 of the plug-in.

## Branching model

It is possible to use the Markdown extension `directive` mentioned before, to reference a Git branch [@ikiwiki:gitbranch].
The existing branches [@ikiwiki:branches] are displayed as single documents in the WUI, forming one _bug_ or _todo_.
Parallel version maintenance through WUI is unlikely.

## UI

![Ikiwiki: Page preview](./src/assets/images/ikiwiki-page){#fig:ikiwiki:page width=100%}

The UI of the wiki is not affected by the underlaying VCS layer, as seen on page preview on image @fig:ikiwiki:page.
Meaning on the conceptual level as described in the introduction of the chapter; there are tools in WUI, such as the history preview, that take the advantage of the VCS background.
Atop of the wiki page content with outline by its side, there is a toolbar with with the links like _Edit_, _History_, etc. and a search form.
At the bottom there are pages linking to this and last edit meta-data.

![Ikiwiki: Page edit](./src/assets/images/ikiwiki-edit){#fig:ikiwiki:edit width=100%}

On edit page there apart from bare text-area as mentioned a standard static preview button.
This is depicted on image @fig:ikiwiki:edit.

## Summary

- PageSpec tool is powerful, but very hard to use for the basic configuration and clunky to maintain.
- SSH authorization not handled and burdensome to sync with the existing authorization settings.
- Authentication is blended with authorization.
- Bizarre Git branch usage.
- Plain-text editing.

Ikiwiki being the oldest project in the chapter suffers from historical decisions, which might have been valid at its time, nevertheless are but burdens now.
This includes complex PageSpec implementation and unfortunate fusion of authentication and authorization.
