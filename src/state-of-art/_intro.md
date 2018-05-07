In this chapter, several existing OSS wiki systems are compared.
The systems are selected when their design and feature set most strongly resemble the traits discussed in the previous chapter.

Since the requirements are highly restrictive, only the systems using Git VCS for data storage are present, regardless of the satisfaction of the remaining demands.

The remaining requirements are discussed individually with each system.
It is described where they excel and where they are inferior.
The remaining desired features, apart from Git VCS in the BE, are:

* **User access control**
    * How powerful it is
    * What security scopes are available (protected branches, namespaces etc.)
    * The integration of the configuration into the VCS

* **Direct repository access**
    * The direct access via Git CLI available
    * How the authentication is handled with the web login and the SSH key pairing respectively

* **Document format**
    * Variety of the supported languages
    * Support for Markdown and Asciidoc
    * Extensibility for the new LMLs
    * Language feature support

* **Branching model**
    * The Git branching model support
    * Parallel version development

* **UI**
    * The incorporation of the Git VCS into the UI^[It is useful, to observe how the UI is affected by the fact that the system runs on the VCS Git. UI presumably shifts slightly from a "document hub" (known from common wiki software like MediaWiki [@mediawiki] or DokuWiki [@dokuwiki]) to a broader perspective of a generic repository browser.]


The acceptance and quality criteria is defined.
Based on the former the several popular systems that either run on the VCS Git or are able to use it as a primary content repository are inspected.
The systems Wiki.js, Gollum, Gitit and Ikiwiki, complete the list of all major OSS projects, which are backed, or can be in that matter, by Git.

Some items on the list are not repository hosting services per se, for instance Gollum, which is only a WUI for managing a Git repository.
Since the number of the project passing the acceptance criterion is thin as it is, Gollum is included as well, for its UI research value.

The list can be extended if plug-ins or extensions are considered.
This way popular platforms such as MediaWiki or DokuWiki could be included.
Extensions are excluded however, and only platforms which are designed to work with a VCS repository are considered, for the reason of having a greater research value of the design and the UI specifics regarding the Git incorporation.
