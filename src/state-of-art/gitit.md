# Gitit

Gitit [@gitit], a software by John MacFarlane, is written in Haskell.
It made its initial release in November 2008 and brings many features compared to the previous entry.
The strongest of which is its flexibility, which can be seen in the VCS abstraction and the document format options as well.

Gitit can use either a Git, Darcs [@darcs] or a Mercurial [@mercurial] repository.
The rather remarkable document format options are discussed later in the appropriate section.

From the user experience, it is incomparable to Ikiwiki^[Ikiwiki software and its homepage and documentation wiki are maintained in a single repository [@ikiwiki:git], with confusing user manual and installation instructions scattered in the wiki.] and can be set up in literally few minutes with basic configuration.


## User access control

In spite of Gitit having many revolutionary ideas, user access control is its weakest link in the strong chain.
Gitit user manual does not mention any form of permission management within the repository.

The only tools it offers for user restriction are:

* setting a global permission level for the anonymous users and
* requiring a correct answer for the configured access question before registering a new user.

These options are available in the configuration as seen in its sample in the listing \ref{lst:gitit:conf},
which is a snippet from the default Gitit configuration^[Which is a result of `gitit --print-default-config`].

```{language=yaml caption="Gitit: Configuration sample" label="lst:gitit:conf"}
require-authentication: modify
# if 'none', login is never required, and pages can be edited anonymously.
# if 'modify', login is required to modify the wiki (edit, add, delete
# pages, upload files).
# if 'read', login is required to see any wiki pages.

access-question:
access-question-answers:
# specifies a question that users must answer when they attempt to create
# an account, along with a comma-separated list of acceptable answers.
# This can be used to institute a rudimentary password for signing up as
# a user on the wiki, or as an alternative to reCAPTCHA.
# Example:
# access-question:  What is the code given to you by Ms. X?
# access-question-answers:  RED DOG, red dog

```

Gitit provides permission control only in the global scope.
It does however let the user select, whether to use implicit user file storage for the new users, or to allow GitHub OAuth 2.0 authentication.
With this option, setting the client's credentials in configuration file is required.

## Direct repository access

The direct repository access is on the same level of support as was the case with Ikiwiki.
The system does not provide the external access to the Git repository.
If user desires to permit such access, it is solely their responsibility.

## Document format

This is where Gitit truly excels beyond its rivals.
Though lacking the specialized tools for the selected LMLs, it offers

1. a large variety of supported languages and
2. an export option of the page into a rich set of document formats, including other LMLs (Markdown, MediaWiki, AsciiDoc, etc.), typesetting formats (e.g. \LaTeX, ConTeXt), office document formats, DocBook, sideshow formats and much more, using Pandoc [@pandoc].

The documents are implicitly written in the Pandoc's extended version of Markdown.
In a YFM (document preamble), meta-data including format can be set, as seen in listing \ref{lst:gitit:preamble}.
The supported formats include reStructuredText, LaTeX, HTML, DocBook and Org [@org] markup. [@gitit]

```{language=latex caption="Gitit: Page preamble example" label="lst:gitit:preamble"}
---
format: latex+lhs
categories: haskell math
toc: no
title: Haskell and
  Category Theory
...

\section{Why Category Theory?}

```

## Branching model

Gitit WUI does not support branching model.
It faces the restrains of the premise supporting Darcs VCS which does not have [@darcs:branches] a branch support.
Git repository itself is not limited to use a single branch, but the application only assumes linear development.

## UI
![Gitit: Page preview](./src/assets/images/gitit-page){#fig:gitit:page width=100%}

The UI, though appearing more modern, is fairly similar to the previous entry Ikiwiki, as seen on the page detail in the image @fig:gitit:page.
There are improvements, that include navigation tools: for instance _All pages_ index and _Categories_^[Categories can be assigned to individual pages in YFM as seen in listing \ref{lst:gitit:preamble}.].
Minor, yet welcoming change, is that links atop the page contents are tabular.
The links are semantically more akin to tab widgets, than navigation links.
This design option, known from other popular wiki software, e.g. [@mediawiki] is an appealing change, that eliminates user confusion with the navigation and current state of the view.

![Gitit: Page edit](./src/assets/images/gitit-edit){#fig:gitit:edit width=100%}

As expected of the format variety, no tool is used for the document editing, but plain textarea.
The form UI and the component layout is in this case almost identical to the previous entry, as seen in the image @fig:gitit:edit, though featuring a Markdown cheat-sheet.

## Summary

- Gitit can be backed by a Git, Mercurial or Darcs repository.
- System lacks any form of authorization mechanism and leaves only an option to select private or public wiki.
- A wide variety of the supported markup is provided.
- Notable export options are offered via the Pandoc conversion tool.
- Interesting usage of YFM is used for meta-data, which is independent of the LML from Pandoc's perspective.

Gitit profits from its generic approach of using a Pandoc meta document format, allowing it to store meta-data in an unified manner as well as providing extensive export abilities.
