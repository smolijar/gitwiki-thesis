# Gollum

Gollum is an OSS wiki system in Ruby developed since 2009 that powers[@wikiwikiweb:gollum] GitHub Wikis.
The Gollum, though being a wiki system, is quite different from other systems mentioned in this chapter.
While its differences make it destined to fail in many criteria, it still might prove useful to review the system, notably from the UI perspective, especially given the fact that is have been used in GitHub Wikis.

While Gollum does have wrappers or extensions that do provide, e.g. user authentication and permission control like [@omnigollum], the bare library is _just WUI_ for repository management with focus on LMLs.

Gollum program is run in directory with an existing repository and WEBrick HTTP server starts, which can be accessed via browser.
This allows users to manipulate the repository through WUI.

## User access control

As mentioned, Gollum does not handle no form of user control; neither authentication, nor authorization -- every visitor can perform any operation on the repository through WUI.

## Direct repository access

Direct repository access is by all means available, though as expected from the nature of the system behavior, it is handled by user outside of Gollum.

## Document format

Gollum by default supports Markdown and RDoc[@rdoc].
This can be even extended to AsciiDoc, Creole[@creole], MediaWiki, Org[@org], Pod[@pod], ReStructuredText and Textile.

With extensions this is the largest set of supported languages.

## Branching model

Gollum can actually work with various branches.
It can be launched on any branch using the program argument from CLI `gollum --ref=dev`.
The default option is `master`.

## UI

![Gollum: Page preview](./src/assets/images/gollum-page){#fig:gollum:page width=100%}

As seen in page preview in image @fig:gollum:page, Gollum is visually minimalistic, yet the user widgets and layout remains still very same.
There are navigational options hidden under _All_ and _Files_ options in the toolbar above the page.

There exceptionally impressive UI for page editing.
This is whence Gollum truly excels.
Not only are many document formats supported, as discussed, but Gollum also provides a toolbar (seen in figure @fig:gollum:edit) customized for given format and features preview as well as live preview^[That is available when started with option `--live-preview`].

![Gollum: Page edit](./src/assets/images/gollum-edit){#fig:gollum:edit width=100%}
