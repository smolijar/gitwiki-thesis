The implementation of the system is in the development for seven months, since October 2017.
The source codes to this day sum up to 4\ 161\ LOC and 770\ commits.
The detail stats are displayed in the table \ref{impl:stats}.
The implementation is software, published from its early stages on GitHub.

The Emily editor source codes are separated from the main system for the potential of being used as an independent component, because of the rich and rather outstanding feature set mentioned in the design chapter.
This lead to splitting the project into two distinct repositories:

 - `grissius/gitwiki` [@gitwiki] and
 - `grissius/emily-editor` [@emily].

The repositories are published under the MIT and BSD 2-Clause Licenses respectively.
Their user manuals and installation instructions are in appendices, along with their designed logotypes in the images \ref{fig:emily-logo} and \ref{fig:gitwiki-logo}.

\begin{table*}[]
\centering
\caption{Implementation repository statistics}
\label{impl:stats}
\begin{tabular}{@{}llll@{}}
\toprule
Repository              & lines of code  & Commits & Releases \\ \midrule
grissius/gitwiki      & 1 820 & 206     & 10        \\
grissius/emily-editor & 2 341 & 564     & 23       \\
\bottomrule
\end{tabular}
\end{table*}

The repositories are public -- potentially anyone can contribute to the source code via PR.
To the day of submission of the thesis however, the author is the sole contributor of the two projects.

Both projects have been developed with good manners at heart, thus both include:

- a readme file,
- a version file with current version of the project,
- and a changelog file following the _keepachangelog_ [@keepachangelog] _standard_^[Though being perhaps the only changelog guideline (thusly it is referred to it as standard) its format is more akin to best practices and reccomendation on how to write the changelog.].

The projects also:

- adhere to _Semantic Versioning 2.0.0_ [@semver] with published releases via Git tags on GitHub repositories,
- follow the Airbnb JS style guide [@airbnb:standard] using ESLint and
- have been developed via a feature branch workflow.

The editor `grissius/emily-editor` is published on npm [@npm:emily].

This introduction sums up the aggregate information about the implementation source codes.
In the following section  the notable dependencies used in the system are mentioned.
In the rest of the chapter, instead of describing the development process as a whole, covers some of the major difficulties that appeared throughout the implementation process and describes the solutions provided for each one.

