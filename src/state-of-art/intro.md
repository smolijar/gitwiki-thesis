# Introduction

In this section I shall compare several existing OSS wiki systems, that by design and feature set most strongly resemble traits described in previous chapter.

Since the requirements are too restrictive, I shall examine systems using Git VCS for data storage, regardless of how they satisfy remaining demands.

I shall discuss the remaining requirements individually with each suspect and describe where it excels and where it inferior.
The remaining desired features, apart from Git VCS in back-end are:

* **User access control**
    * How powerful is it?
    * What security scopes are available? Protected branches, paths etc.?
    * Is the configuration version controlled?

* **Direct repository access**
    * Is there direct access via Git CLI available?
    * How is authentication handled with web login and (presumably) SSH key pairing?

* **Document format**
    * What languages are supported?
    * Is Markdown or Asciidoc supported?
    * Is it possible to modularly add new LMLs?
    * What features are supported by the editor?

* **Branching model**
    * Is Git branching model available in wiki; e.g. can multiple branches be maintained independently?

* **UI**
    * How is UI handled for common screens like file index, page detail and page edit?^[This might be interesting, to observe how UI is affected by the fact that system runs on VCS Git. UI might shift slightly from "document hub" (known from common wiki software like MediaWiki[@mediawiki] or DokuWiki[@dokuwiki]) to more broad perspective of generic repository browser.]


I have defined the acceptance and quality criteria.
Based on former I shall inspect several popular systems that either run on VCS Git or can be configured to use it as a primary content repository.
These systems are Wiki.js, Gollum, Gitit and ikiwiki.