# Gitit

Gitit[@gitit] is a wiki software by John MacFarlane written in Haskell.
It made its initial release in November 2008 and brings many interesting features on the table.
The strongest feature theme seen throughout the project is its flexibility, which can be seen in VCS and document format options as well.

Gitit can use either a Git, Darcs[@darcs] or Mercurial[@mercurial] repository.
The rather remarkable document format options shall be discussed later in appropriate section.

From my short experience with the software, it incomparable to Ikiwiki^[Ikiwiki software and its home/documentation wiki are developed in a single repository[@ikiwiki:git], with very confusing user manual and installation instructions scattered in the documentation wiki. I did not manage to run the wiki software locally within the limited time.].
I had Gitit set up in literally 2 minutes with basic configuration.


## User access control

In spite of Gitit having many revolutionary ideas, user access control frankly seems to be its weakest link in the strong chain.
Gitit user manual does not mention any form of permission management within the content repository.

The only tools it offers for user restriction are:
* set global permission level for anonymous users and
* require correct answer for access question before registering a new user.

These options are available in configuration as seen in its sample in \ref{lst:gitit:conf},
which is a snippet from Gitit config^[Which is a result of `gitit --print-default-config`].

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

Gitit provide permission control only in global scope.
It does however let user choose, whether to use implicit user file storage for new users, or allow GitHub OAuth 2, setting the client's credentials in configuration file.

## Direct repository access

Direct repository access is on the same level of support as was thee case with Ikiwiki.
The system does not provide nor cares of external access to the Git repository.
If user wished to permit such access, it is solely their responsibility, and it all happens outside of Gitit.

## Document format

This is where Gitit truly excels beyond its rivals.
It might lack specialized tools for selected LMLs, but it offers
1. Large variety of supported languages
2. Export of the page into even richer set of document formats, including other LMLs (Markdown, MediaWiki, AsciiDoc, etc.), typesetting formats (e.g. \LaTeX, ConTeXt), office document formats, DocBook, sideshow formats and much more, using Pandoc[@pandoc].

Documents are implicitly written in Pandoc's extended version of Markdown.
In document preamble (YFM), meta-data including format can be set, as seen in \ref{lst:gitit:preamble}.
The supported formats include reStructuredText, LaTeX, HTML, DocBook and Emacs Org-mode markup. [@gitit]

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

Gitit WUI does not work with branches.
It faces is premise restrains by supporting Darcs VCS which does not have[@darcs:branches] a branch support.
Git repository itself is not limited to use a single branch, but the application only assumes linear development.

## UI
![Gitit: Page preview](./src/assets/images/gitit-page){#fig:gitit:page width=100%}

The UI, though appearing more modern, is fairly similar to previous entry Ikiwiki as seen on page detail in image @fig:gitit:page.
There are some improvements, that include navigation tools, like _All pages_ index and _Categories_^[Categories can be assigned to individual pages in preamble as seen in listing \ref{lst:gitit:preamble}].
Minor, yet welcoming change is that links atop the page contents are tabular.
These are semantically more tab widgets, than navigation links.
This design option, known from other popular wiki software, like [@mediawiki] is a welcoming change, that eliminates some user confusion with navigation and current state of the system.

![Gitit: Page edit](./src/assets/images/gitit-edit){#fig:gitit:edit width=100%}

As half expected of format variability, no tool is used for document editing, but plain textarea. The form UI and component layout is in this case almost identical to the previous entry, as seen in image @fig:gitit:edit.

## Summary

- Gitit can be backed by a Git, Mercurial or Darcs repository.
- System lack any form of authorization options and leaves only for user to select private or public wiki.
- A wide variety of supported markup is provided.
- Notable export options are offered via Pandoc conversion tool.
- Interesting usage of YFM is used for meta-data, which is independent of LML from Pandoc's perspective.

Gitit profits from its generic approach of using a Pandoc meta document format, allowing it to store meta-data in unified manner as well as providing extensive export abilities.
