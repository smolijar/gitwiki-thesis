I have been working on the implementation of the system for 7 months, since October 2017.
The source code to this day sum up to 3863 LOC and 725 commits.
The detail stats are displayed in the table \ref{impl:stats}.
The implementation is OSS published from its inception on GitHub.

I begin developing the Emily editor and decided to keep the editor source code separated from the main system, since I saw potential of being used as an independent component, hence the rich and rather outstanding feature set mentioned in the design chapter.

This lead to forking the project into two distinct repositories, `grissius/gitwiki`[@gitwiki] and `grissius/emily-editor`[@emily].

\begin{table*}[]
\centering
\caption{Implementation repository statistics}
\label{impl:stats}
\begin{tabular}{@{}llll@{}}
\toprule
Repository              & lines of code  & Commits & Releases \\ \midrule
grissius/gitwiki      & 1628 & 187     & 8        \\
grissius/emily-editor & 2235 & 538     & 16       \\
\bottomrule
\end{tabular}
\end{table*}

Even though the repositories are public and potentially anyone can contribute to the source code via PR; to the day of submission of the thesis I am the sole contributor to the projects with the systems implementation: `grissius/gitwiki` and `grissius/emily-editor`.

Both projects have been developed with good manners at heart, thus both include:

- the readme file,
- the version file with current version of the project,
- and the changelog file following the _keepachangelog_[@keepachangelog] _"standard"_^[Though being perhaps the only changelog guideline (thusly I refer to it as standard) its format is more akin to best practices and reccomendation on how to write the changelog.].

The projects also:

- adhere to _Semantic Versioning 2.0.0_[@semver] with published releases via Git tags on GitHub repositories and
- have been developed via feature branch workflow.

The editor `grissius/emily-editor` is published[@npm:emily] on NPM.

This introduction sums up the aggregate information about the implementation source codes and in the rest of the chapter, instead of describing the whole process, I shall cover some of the major difficulties I faced throughout the implementation process and describe the solution I provided for each one.

