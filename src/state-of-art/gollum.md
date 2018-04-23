# Gollum

Gollum is an OSS wiki system in Ruby developed since 2009 that powers[@wikiwikiweb:gollum] GitHub Wikis.
The Gollum, though being a wiki system, is quite different from the other systems mentioned in this chapter.
While its differences make it destined to fail in many criteria, it still might prove useful to review the system, notably from the UI perspective, especially given the fact that it has been used in GitHub Wikis.

While Gollum does have wrappers or extensions that do provide, e.g. user authentication and permission control like [@omnigollum], the bare library is _just WUI_ for the repository management with the focus on LMLs.

The Gollum program is run in directory with an existing repository and WEBrick HTTP server starts, which can be accessed via browser.
This allows the users to manipulate the repository through WUI.

## User access control

As mentioned, Gollum does not handle any form of user control; neither authentication, nor authorization -- every visitor can perform any operation on the repository through the WUI.

## Direct repository access

Direct repository access is by all means available, though as expected from the nature of the system behavior, it is handled by the user outside of Gollum.

## Document format

Gollum by default supports Markdown and RDoc[@rdoc].
This can be even extended to AsciiDoc, Creole[@creole], MediaWiki, Org[@org], Pod[@pod], reStructuredText and Textile.

With the extensions this is the largest set of supported markup languages.

## Branching model

Gollum can actually work with various branches.
It can be launched on any branch using the program argument from CLI `gollum --ref=dev`.
The default option is `master`.

## UI

![Gollum: Page preview](./src/assets/images/gollum-page){#fig:gollum:page width=100%}

As seen in page preview in image @fig:gollum:page, Gollum is visually minimalistic, yet the user widgets and layout remains still very same.
There are navigational options hidden under _All_ and _Files_ options in the toolbar above the page.

There is an exceptionally impressive UI for page editing.
This is whence Gollum truly excels.
Not only there are many document formats supported as discussed, but Gollum also provides a toolbar (seen in figure @fig:gollum:edit) customized for given format and it features a static as well as a live preview^[That is available when started with option `--live-preview`].

![Gollum: Page edit](./src/assets/images/gollum-edit){#fig:gollum:edit width=100%}


## Summary

- Gollum is just a web interface for repository editing and lacks any form of permission control or even authentication.
- Software supports many LMLs
- Superior document editing UI with impressive options including toolbars for users unfamiliar with the syntax and live-preview.
- Direct access not considered by the application.
- Possible, though inconvenient branch support, requiring multiple instances to run in order to manage parallel versions.

Gollum steps out of the line amongst considered systems, being "a mere" WUI for repository management.
It has an exceptional LML support with an admirable UI.
