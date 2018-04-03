# Business process model

In this section, being a part of the problem analysis, I shall formalize abstract needs of the users in form of a business process model, which will serve as a bridge to specifying system requirements.

As stated before, the system at hand has potential to be far more than a documentation platform.
For the discussion of user's needs and preferences, the mentioned referential application shall be used throughout the thesis.

In the scenarios I assume a part of development team is working on a user manual for their software product.
The team consists of:

* the head of the department, who takes care of project management of the user manual,
* several developers, who are familiar with their software module and write manual for their code,
* a reviewer, who fixes typos, grammar, stylistics etc and
* a publisher who takes the source codes and produces the final manual for DTP and print.

The department is using markdown, since all developers who are writing the most of the texts are familiar with it and use it efficiently.

## Workflow

\begin{sidewaysfigure}[!htbp]\centering
	\includegraphics[width=\textwidth]{./src/assets/diagram/bp-workflow}
	\caption{Business proces: workflow}\label{fig:bp:workflow}
\end{sidewaysfigure}

In diagram \ref{fig:bp:workflow}, there is a possible scenario of the department's workflow on updating user manual after software release.
The head of the department orchestrates the team to start working on manual for new version.
Two developers keep updating the manual pages, each for their module.
Pages are reviewed by the reviewer.
When they are satisfied with the text, it is submitted to publisher, who will bundle the pages and create a single readable and printable document, which is submitted back to the head of the department.

Here we can make few reasonable observations:

* If a logical mistake appeared in the final product, the head would like to know who made it.
The same way a source code can be reviewed and individual lines annotated. VCS and revision updates are required.
* Publisher needs direct access to the files.
* First developer only writes in pages regarding module A, second for module B. Publisher only needs read access to the files. Some mistakes could be avoided if the VCS repository could be divided into namespaces and edited separately with access control.
* If a hotfix is created that requires a change in user manual, it is demanded to patch previous version of the manual, without introducing changes already applied to current version of the manual.
In the same manner as applying changes to source code. This calls for VCS with parallel branch support.