# Business process model

In this section, abstract needs of the users in form of a business process model are formalized.
It provides necessary data for the system requirements specification.

As stated before, the system at hand has a potential to be far more than a documentation platform.
For the discussion of the users' needs and preferences, the mentioned referential application is used throughout the thesis.

Here in business process model.
The workflow of a company using the system is described.
While taking a very specific direction, the example case is convenient for two main reasons:

1. it portraits usage of the system by software developers, who are example of _technically oriented users_, as stated in the thesis assignment instructions,
2. it is elaborate enough to demonstrate the several user types with different needs and expectations of the system. This helps to model it and its variability.

In the scenarios I assume a part of the development team is working on a user manual for their software product.
The team consists of:

* the head of the department, who takes care of the project management of the user manual development,
* several developers, who are familiar with their software module and each write a manual for their code,
* a reviewer, who fixes typos, grammar, stylistics etc. and
* a publisher who takes the source codes and produces the final manual for DTP and print purposes.

The department is using Markdown, since all the developers who are writing the most of the texts are familiar with it and use it efficiently.

In the following two subsections the interaction of the development team with the system from business process perspective is demonstrated.

## Business process scenario: Release

\begin{sidewaysfigure}[!htbp]\centering
	\includegraphics[width=0.85\textwidth]{./src/assets/diagram/bp-release}
	\caption{Business process model: Release}\label{fig:bp:release}
\end{sidewaysfigure}

In the diagram \ref{fig:bp:release}, there is a possible scenario of the department's workflow on updating user manual after software release.
The head of the department orchestrates the team to start working on the manual for the new version.
The two developers keep updating the manual pages, each for their module.
The pages are reviewed by the reviewer.
When they are satisfied with the text, it is submitted to the publisher, who will bundle the pages and create a single readable and printable document, which is submitted back to the head of the department.

A few observations from the diagram are made:

* If a logical mistake appears in the final product, the head might want to know who caused it.
The head wants to review the content the same way a source code can be reviewed, providing access for the individual annotated lines, containing the revision ID, date and author information.
VCS and revision updates are required.
* The publisher needs a direct access to the files.
* The first developer only writes in pages regarding module A, while the second for module B.
The publisher only needs a read access to the files.
Potential mistakes could be avoided, if the VCS repository was divided into namespaces and edited with access control management.

## Business process scenario: Hotfix

\begin{sidewaysfigure}[!htbp]\centering
	\includegraphics[width=0.7\textwidth]{./src/assets/diagram/bp-hotfix}
	\caption{Business process model: Hotfix}\label{fig:bp:hotfix}
\end{sidewaysfigure}

The diagram \ref{fig:bp:hotfix} showcases the department's flow of action, when a hotfix, which requires an update of the user manual, is issued.
The process is very similar to the previous scenario, because the processes are discussed at a very high level of abstraction.
The notable difference however, is that multiple maintained versions of the manual need to be accessed and updated separately.
The following observation are formed:
If a hotfix that requires a change in the user manual is created, it is demanded to patch the previous version of the manual, without introducing the changes that are already applied to the current version of the manual
-- In the same manner as changes to source code are applied.
This calls for a VCS with the parallel branch support.

## Summary

Notable conclusions from the observations are as follows:

1. The system *needs* an underlaying VCS with a branching feature, as pointed out by several observations.
A distributed VCS is utilized in order to allow participants to make contributions when out of the office.
2. The system *needs* to provide a direct access to the files. At least the read permission for the publisher.
3. The system *should* provide a direct access to the files for the revision updates as well, since the developers likely work in their own environment most of the time, at their personalized workstations.
4. The system *should* provide a simple read/write interface with no setup required for the reviewer or head of the department.
Both participants are then able to preview the pages in a more familar form compared to the Markdown source code.
5. The system  *should* provide an in-repository access control, to prevent unintended revisions.
