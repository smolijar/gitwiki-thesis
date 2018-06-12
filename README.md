# Git-based Wiki System

Text of my master's thesis. I actually used it formally for the development of the text. After the submission it is just a keepsake. A cool :sparkles: one though.

## Result PDFs

You can find them at [releases](https://github.com/grissius/gitwiki-thesis/releases) (where I always used to publish new PDFs for each version... ah, memories), or render them yourself!

### Thesis

`make arara` For full blown render (re-render diagrams, transform all markdown sources, bibtex and multiple xelatex passes)

`make pdf` for only minor changes (only latex + markdown, one pass)

### Defense

1. `make diagrams` (if not created from thesis)
2. `make defense`

### Requirements

Not sure it’s complete. More like notes for myself anyway.
* xelatex (typesetting)
* texlive-full (probably too greedy, lazy to nitpick the subpackages)
* pandoc (for markdown to latex)
* plantuml (for UML diagrams; must be available under this name in PATH)
* inkscape (for SVG to PDF)

## Current state of the sections

_This is irrelevant now, that it's finished. Left here from nostalgia :heart:_

* :octopus:: I reviewed
* :ram:: @smoliji suggestions incorporated
* :feelsgood:: The fascist version of myself on crack reviewed. Replacing informal words, depersonalizing, removing time references and generally making the text more boring to read.

### Meta sections
* [Acknowledgements](./src/meta/thanks.md) :octopus:
* [Abstract (cs)](./src/meta/abstract-cs.md) :octopus: :feelsgood:
* [Keywords (cs)](./src/meta/keywords-cs.md) :octopus:
* [Abstract](./src/meta/abstract.md) :octopus: :feelsgood:
* [Keywords](./src/meta/keywords.md) :octopus:


### Tru sections
#### [Introduction](./src/introduction.md) :octopus: :feelsgood:
#### [Goal](./src/goal.md) :octopus: :ram: :feelsgood:
#### Analysis
* [Business process](./src/analysis/business-process.md) :octopus: :ram: :feelsgood:
* [Persona](./src/analysis/persona.md) :octopus: :ram: :feelsgood:
* [User access](./src/analysis/user-access.md) :octopus: :ram: :feelsgood:
* [Requirements](./src/analysis/requirements.md) :octopus: :ram: :feelsgood:
* [Use case](./src/analysis/use-case.md) :octopus: :ram: :feelsgood:

#### [State-of-the-art](./src/state-of-art/_intro.md) :octopus: :ram: :feelsgood:
* [Ikiwiki](./src/state-of-art/ikiwiki.md) :octopus: :ram: :feelsgood:
* [Gitit](./src/state-of-art/gitit.md) :octopus: :ram: :feelsgood:
* [Gollum](./src/state-of-art/gollum.md) :octopus: :ram: :feelsgood:
* [Wiki.js](./src/state-of-art/wikijs.md) :octopus: :ram: :feelsgood:
* [Summary](./src/state-of-art/_summary.md) :octopus: :ram: :feelsgood:

#### [Design](./src/design/_intro.md) :octopus: :ram: :feelsgood:
* [Foundations](./src/design/foundations.md) :octopus: :ram: :feelsgood:
* [Repository Providers](./src/design/providers.md) :octopus: :ram: :feelsgood:
* [Authentication](./src/design/authentication.md) :octopus: :ram: :feelsgood:
* [Tools](./src/design/tools.md) :octopus: :ram: :feelsgood:
* [Architecture](./src/design/architecture.md) :octopus: :ram: :feelsgood:
* [Rest API](./src/design/rest.md) :octopus: :ram: :feelsgood:
* [UI](./src/design/ui.md) :octopus: :ram: :feelsgood:
* [Front end](./src/design/fe.md) :octopus: :ram: :feelsgood:
* [Emily](./src/design/emily.md) :octopus: :ram: :feelsgood:
* [Summary](./src/design/_summary.md) :octopus: :ram: :feelsgood:

#### [UI wireframe testing](./src/heuristics.md) :octopus: :ram: :feelsgood:
#### [Implementation](./src/implementation/_intro.md) :octopus: :ram: :feelsgood:
* [Tools](./src/implementation/tools.md) :octopus: :ram: :feelsgood:
* [Gitolite Permissions](./src/implementation/gitolite-permissions.md) :octopus: :ram: :feelsgood:
* [Routes](./src/implementation/routes.md) :octopus: :ram: :feelsgood:
* [Nodegit](./src/implementation/nodegit.md) :octopus: :ram: :feelsgood:
* [Emily — synchronized scrolling](./src/implementation/scrolling.md) :octopus: :ram: :feelsgood:

#### Testing
* [Automatic testing](./src/test/auto.md) :octopus: :feelsgood:
* [Usability testing](./src/test/usability.md) :octopus: :feelsgood:

#### [Conclusion](./src/conclusion.md) :octopus: :feelsgood:


### Appendix sections
* [MI-NUR project highlights](./src/nur.md) :octopus:
* [Emily user manual](./src/readme/emily.md) :octopus:
* [Gitwiki user manual](./src/readme/gitwiki.md) :octopus:
* [Emily logo](./src/logo/emily.md) :octopus:
* [Gitwiki logo](./src/logo/gitwiki.md) :octopus:
