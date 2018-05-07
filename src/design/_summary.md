# Summary

The chapter provides design of the system in several perspectives including abstract concepts of core features, architecture schematics, module and component diagrams, API definitions and UI design.
Though not covering all the components in the same level of detail, because of how vast the system is, the design solutions for the most crucial problems and core components are offered.

In course of the chapter, solutions for all the problems pointed out in the previous chapter _\hyperref[chapter:state]{State-of-the-art}_ is provided:

- Uniform authorization is discussed in the _\hyperref[sec:repository-providers]{Repository providers}_, where it is explained how to bind the application to the Gitolite through its CLI wrapper.
- Branching model support is discussed in the _\hyperref[rest-api]{RESTful API}_ section as well as in the _\hyperref[sec:design:ui]{UI}_ section from the user perspective.
- Modular LML solution is proposed in _\hyperref[emily-editor]{Emily editor}_, where the core features are identified. This is further elaborated in the relevant implementation section.
