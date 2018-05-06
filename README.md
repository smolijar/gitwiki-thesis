# GitWiki

## Sections to read

* :octopus:: I reviewed
* :ram:: @smoliji suggestions incorporated

### Meta sections
* [Acknowledgements](./src/meta/thanks.md) :octopus:
* [Abstract (cs)](./src/meta/abstract-cs.md) :octopus:
* [Keywords (cs)](./src/meta/keywords-cs.md) :octopus:
* [Abstract](./src/meta/abstract.md) :octopus:
* [Keywords](./src/meta/keywords.md) :octopus:


### Tru sections
#### [Introduction](./src/introduction.md) :octopus:
#### [Goal](./src/goal.md) :octopus: :ram:
#### Analysis
* [Business process](./src/analysis/business-process.md) :octopus: :ram:
* [Persona](./src/analysis/persona.md) :octopus: :ram:
* [User access](./src/analysis/user-access.md) :octopus: :ram:
* [Requirements](./src/analysis/requirements.md) :octopus: :ram:
* [Use case](./src/analysis/use-case.md) :octopus: :ram:

#### [State-of-the-art](./src/state-of-art/_intro.md) :octopus: :ram:
* [Ikiwiki](./src/state-of-art/ikiwiki.md) :octopus: :ram:
* [Gitit](./src/state-of-art/gitit.md) :octopus: :ram:
* [Gollum](./src/state-of-art/gollum.md) :octopus: :ram:
* [Wiki.js](./src/state-of-art/wikijs.md) :octopus: :ram:
* [Summary](./src/state-of-art/_summary.md) :octopus: :ram:

#### [Design](./src/design/_intro.md) :octopus: :ram:
* [Foundations](./src/design/foundations.md) :octopus: :ram:
* [Repository Providers](./src/design/providers.md) :octopus: :ram:
* [Authentication](./src/design/authentication.md) :octopus: :ram:
* [Tools](./src/design/tools.md) :octopus: :ram:
* [Architecture](./src/design/architecture.md) :octopus: :ram:
* [Rest API](./src/design/rest.md) :octopus: :ram:
* [UI](./src/design/ui.md) :octopus: :ram:
* [Front end](./src/design/fe.md) :octopus: :ram:
* [Emily](./src/design/emily.md) :octopus: :ram:
* [Summary](./src/design/_summary.md) :octopus: :ram:

#### [UI wireframe testing](./src/heuristics.md) :octopus: :ram:
#### [Implementation](./src/implementation/_intro.md) :octopus:
* [Tools](./src/implementation/tools.md) :octopus:
* [Gitolite Permissions](./src/implementation/gitolite-permissions.md) :octopus:
* [Routes](./src/implementation/routes.md) :octopus:
* [Nodegit](./src/implementation/nodegit.md) :octopus:
* [Emily — synchronized scrolling](./src/implementation/scrolling.md) :octopus:

#### Testing
* [Automatic testing](./src/test/auto.md) :octopus:
* [Usability testing](./src/test/usability.md) :octopus: :construction:

#### [Conclusion](./src/conclusion.md) :octopus:


### Appendix sections
* [MI-NUR project highlights](./src/nur.md) :octopus:
* [Emily user manual](./src/readme/emily.md) :octopus:
* [Gitwiki user manual](./src/readme/gitwiki.md) :construction:
* [Emily logo](./src/logo/emily.md) :octopus:
* [Gitwiki logo](./src/logo/gitwiki.md) :construction:


## PDF generate

`make arara` For full blown render (re-render diagrams, transform all markdown sources, bibtex and multiple xelatex passes)

`make pdf` for only minor changes (only latex + markdown, one pass)

### Requirements

Not sure it’s complete. More like notes for myself anyway.
* xelatex (typesetting)
* texlive-full (probably too greedy, lazy to nitpick the subpackages)
* pandoc (for markdown to latex)
* plantuml (for UML diagrams; must be available under this name in PATH)
* inkscape (for SVG to PDF)