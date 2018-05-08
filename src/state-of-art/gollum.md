# Gollum

Gollum is an OSS written in Ruby developed since 2009 that powers [@wikiwikiweb:gollum] GitHub Wikis.
The Gollum, though being a wiki system, is rather different from the other systems mentioned in this chapter.
While its differences make it destined to fail in many criteria, it proves useful to review the system, notably from the UI perspective, especially given the fact that it has been used in GitHub Wikis.

While Gollum does have wrappers or extensions that do provide, e.g. user authentication and permission control, for instance [@omnigollum], the bare library is _just a WUI_ for the repository management with the focus on LMLs.

## User access control

Gollum does not handle any form of user control; neither authentication, nor authorization -- every visitor can perform any operation on the repository through the WUI.

## Direct repository access

Direct repository access is possible, though it is handled by the user outside of Gollum.

## Document format

Gollum by default supports Markdown and RDoc [@rdoc].
This can be even extended to AsciiDoc, Creole [@creole], MediaWiki, Org [@org], Pod [@pod], reStructuredText and Textile. With the extensions this is the largest set of supported markup languages.

## Branching model

Gollum can actually work with various branches.
It can be launched on any branch using the program argument from CLI `gollum --ref=dev`.
The default option is `master`.

## UI

![Gollum: Page preview](./src/assets/images/gollum-page){#fig:gollum:page width=100%}

Gollum is visually minimalistic, yet the user widgets and layout remains still very same, as appereant from the image @fig:gollum:page.
There are navigational options hidden under the _All_ and the _Files_ options in the toolbar above the page.

There is an exceptionally impressive UI for page editing.
Not only there are many document formats supported, as discussed, but Gollum also provides a toolbar (seen in figure @fig:gollum:edit) customized for the given format.
Apart from that, it features a static as well as a live preview^[That is available when started with option `--live-preview`].

![Gollum: Page edit](./src/assets/images/gollum-edit){#fig:gollum:edit width=100%}

## Summary

- Gollum is just a web interface for the repository editing and lacks any form of permission control or even authentication.
- The software supports many LMLs.
- Gollum provides superior document editing UI with impressive options including toolbars for users unfamiliar with the syntax and a live-preview.
- The direct repository access is not managed by the application.
- Gollum features inconvenient branch support, requiring multiple instances to run in order to manage parallel versions.

Gollum steps out of the line amongst considered systems, being "a mere" WUI for repository management.
It has an exceptional LML support with an admirable UI.
