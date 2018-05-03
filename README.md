# GitWiki

## Sections to read

### Meta sections
* [Acknowledgements](./src/meta/thanks.md)
* [Abstract (cs)](./src/meta/abstract-cs.md)
* [Keywords (cs)](./src/meta/keywords-cs.md)
* [Abstract](./src/meta/abstract.md)
* [Keywords](./src/meta/keywords.md)


### Tru sections
#### [Introduction](./src/introduction.md)
#### [Goal](./src/goal.md)
#### Analysis
* [Business process](./src/analysis/business-process.md)
* [Persona](./src/analysis/persona.md)
* [User access](./src/analysis/user-access.md)
* [Requirements](./src/analysis/requirements.md)
* [Use case](./src/analysis/use-case.md)

#### [State-of-the-art](./src/state-of-art/_intro.md)
* [Ikiwiki](./src/state-of-art/ikiwiki.md)
* [Gitit](./src/state-of-art/gitit.md)
* [Gollum](./src/state-of-art/gollum.md)
* [Wiki.js](./src/state-of-art/wikijs.md)
* [Summary](./src/state-of-art/_summary.md)

#### [Design](./src/design/_intro.md)
* [Foundations](./src/design/foundations.md)
* [Repository Providers](./src/design/providers.md)
* [Authentication](./src/design/authentication.md)
* [Tools](./src/design/tools.md)
* [Architecture](./src/design/architecture.md)
* [Rest API](./src/design/rest.md)
* [UI](./src/design/ui.md)
* [Front end](./src/design/fe.md)
* [Emily](./src/design/emily.md)
* [Summary](./src/design/_summary.md)

#### [UI wireframe testing](./src/heuristics.md)
#### [Implementation](./src/implementation/_intro.md)
* [Tools](./src/implementation/tools.md)
* [Gitolite Permissions](./src/implementation/gitolite-permissions.md)
* [Routes](./src/implementation/routes.md)
* [Nodegit](./src/implementation/nodegit.md)
* [Emily — synchronized scrolling](./src/implementation/scrolling.md)

#### [Conclusion](./src/conclusion.md)


### Appendix sections
* [MI-NUR project highlights](./src/nur.md)


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