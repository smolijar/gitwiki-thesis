There is a large variety of specialized tools that can be used for managing wikis.
Most of the systems however, are focused on the ease of use for the new or unexperienced users.
They lack features desired by the advanced users, such as software developers.
The thesis tackles to solve the issue by developing a wiki system for the unexperienced and the advanced users alike, to provide an interface for developing complex, structured documents.

The means of achieving the goals, namely the potential to satisfy the advanced users are of architectural nature.
They include, but are not limited to, the incorporation of years tested technologies used by developers, to design the system upon.
One of which is Git, which is a powerful VCS, growing in popularity amongst OSS community and even corporate development.
Another example is an emphasis on using a LML for the document notation.
LMLs, such as Markdown or AsciiDoc are favored over binary document formats for their readability and line-oriented snapshot versioning potential; and even over the complex and difficult to write markup languages (e.g. \LaTeX\ or HTML), for their simplicity.
A strong aspect of the system supporting efficiency and comfort of use for the advanced users is to provide a CLI via Git, apart from a WUI.
The two interfaces provide equal access options for the users.
For better support of the collaborative development, the system features access control.

In _\hyperref[chapter:goal]{the following chapter}_ the assignment instructions are elaborated and it is explained what is considered a _wiki system_.

A high abstraction concept of the system from the user perspective is demonstrated on the business process model in the _\hyperref[chapter:analysis]{analysis}_.
The following section in the chapter (_\hyperref[user-access]{User access}_), resolves  fundamental architectural decisions regarding authorization, which force restrictions on the system requirements.
Finally the system is defined through the conventional means of requirements and use case model and then the relations between the individual use cases and the functional requirements are commented on.

With the system definition from the analysis, the existing wiki systems that use the Git VCS are researched and reviewed from the perspective of criteria defined in the analysis.
Doing which, the defects of the systems regarding the criteria in the summary are pointed out.

Solutions for the discovered imperfections in the systems are proposed in the chapter _\hyperref[chapter:design]{Design}_.
Apart from that, the chapter discusses the major libraries used in the system that have impact on its design. The architecture of the system is presented and description of its core components is provided.
A low fidelity prototype of the UI is designed.

In the following chapter _\hyperref[chapter:design]{UI testing}_ a static usability testing using a UI heuristic is performed, the results and proposed corrections for the identified issues are presented.

The implementation information is briefly summarized in the chapter _\hyperref[chapter:implementation]{Implementation}_ and selected obstacles faced during the realization are discussed along with the applied solution.

The technologies used for the automated testing along with the materials, process and the conclusion of the usability testing are included in the final chapter _\hyperref[chapter:testing]{Testing}_.
