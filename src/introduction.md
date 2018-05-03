There is a large variety of specialized tools that can be used for managing wikis.
Most of the systems however, are focused on ease of use for the new or unexperienced users, and lack features desired by the advanced users, such as software developers.
The thesis tackles to solve the issue by developing a wiki system for the unexperienced and the advanced users alike, to provide an interface for developing complex, structured documents.

The means of achieving the goals, namely the potential to satisfy the advanced users are of architectural nature.
They include, but are not limited to, the incorporation of years tested technologies to design the system upon.
One of which is Git, which is a powerful VCS growing in popularity amongst OSS community and even corporate development.
Another is an emphasis on using LML for the document notation.
LMLs, like Markdown or Asciidoc are favored over binary document formats for their readability and line-oriented snapshot versioning potential; and even over complex and difficult to write markup languages, like \LaTeX or HTML for their simplicity.
A strong aspect of the system supporting efficiency and comfort for use for the advanced users is to provide apart from a WUI a CLI via Git.
The two interfaces will provide equal access options for the users.
For better support of the collaborative development, the system will feature access control.

In the chapter _\hyperref[chapter:goal]{Thesis' Goal}_ I will elaborate the assignment instructions and explain what is considered a _wiki system_.

A high abstraction concept of the system from the user perspective will be demonstrated on the business process model in _\hyperref[chapter:analysis]{Analysis}_.
The following section in the chapter will resolve fundamental architectural decisions regarding user access, force restrictions on the system requirements.
Finally the system will be defined through the conventional means of requirements and use case model and then the relations between the individual use cases and the functional requirements will be commented on.

Having the system definition from the analysis, I will review the existing wiki systems that use the Git VCS and review them from the perspective of criteria defined in the analysis.
Doing which I will point out the defects of the systems regarding the criteria in the summary.

Solutions for the discovered imperfections in the systems will be proposed in the chapter _\hyperref[chapter:design]{Design}_.
Apart from that, the chapter will discuss the major libraries to be used in the system that impact the design of the system. In the chapter the architecture of the system will be presented and description of its core components will be provided.
A low fidelity prototype of the UI will be designed.

In the following chapter _\hyperref[chapter:design]{UI testing}_ I will perform a static usability testing without live testers using a UI heuristic, present the results and propose remedy for the identified issues.

The implementation information will be briefly summarized in the chapter _\hyperref[chapter:implementation]{Implementation}_ and selected obstacles I faced during the realization will be discussed along with the applied solution.

The technologies used for automated testing along with the materials, process and the conclusion of the usability testing will be included in the final chapter _\hyperref[chapter:testing]{Testing}_.