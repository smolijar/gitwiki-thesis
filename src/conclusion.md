The goal of this thesis was to create a wiki system suitable for community software projects.

In the first chapter I elaborated the goal and explained core terms it uses.
Then I analyzed the users's needs in the business process model and proposed a viable solution for the problem of permission control with unified behavior across the UIs.
With all the necessary data available, I designed the system through the requirements model.
The functional requirements have been further elaborated in the use-case model.

Acquiring the system definition in the analyses I discovered and reviewed the existing wiki systems, rated them with regard to the raised criteria and identified their disadvantages in the context of the intended use of the system.

I designed the system to either avoid the disadvantages by the its nature or I provided solutions for them.
The system design discusses its architecture, core components and UI.

The implementation chapter concludes the development process results and provides an in-depth view of selected problems I faced during the implementation.

The tools used for automated testing are described in the testing chapter.

The UI has been tested for usability using Jakob Nielsen's heuristics[@nn:heuristics] and in the final stage via usability testing with users I conducted.

In the future, the system could be extended to provide pre-rendering of the repository's pages into HTML.
However, this would require a thorough analyses and design of the solution to handle the current parallel development capabilities of the system, for instance caching only a single branch or a user or heuristic selected subset.
Apart from this, the designed LML editor could be extended by other language modes, apart from the existing support for Markdown and Asciidoc, or by richer user interactions inspired from IDE or coding editor development.

