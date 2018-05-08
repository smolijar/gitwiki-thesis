The goal of this thesis is to create a wiki system suitable for community software projects.

In the first chapter the goal is elaborated and core terms used in the text are explained.
The users's needs are analyzed in the business process model and a viable solution for the problem of permission control with unified behavior across the UIs is proposed.
With all the necessary data available, the system is defined through the requirements model.
The functional requirements are further elaborated into the use-case model.

Acquiring the system definition in the analyses the existing wiki systems are reviewed.
The systems are rated with regard to the raised criteria and their disadvantages are identified in the context of the intended use of the system.

The system is designed to either avoid these issues by the its nature or a solution is provided.
The system design discusses its architecture, core components and UI.

The implementation chapter concludes the development process results and provides an in-depth view of selected problems faced during the implementation.

The tools used for automated testing are described in the testing chapter.
The UI is tested for usability using Jakob Nielsen's heuristics [@nn:heuristics] and in the final stage via conducted usability testing with users.

In the future, the system can be extended to provide pre-rendering of the repository's pages into HTML.
However, this requires a thorough analyses and design of the solution to handle the current parallel development capabilities of the system; for instance caching only a single branch or a user or heuristic selected subset.
Apart from this, the designed LML editor can be extended by other language modes, apart from the existing support for Markdown and Asciidoc, or by richer user interactions inspired from IDE or coding editor development.

