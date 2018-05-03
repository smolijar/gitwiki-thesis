In this chapter I shall subdue the designed wireframes to a static form of usability testing, the heuristic analysis.

Jakob Nielsen's heuristics[@nn:heuristics] will be used to analyze the existing wireframes.
I will go through the 10 points of the heuristic individually and discuss how the design holds up to them.

_The names and brief descriptions are directly quoted from [@nn:heuristics]._

# Analysis

1. **Visibility of system status**
_"The system should always keep users informed about what is going on, through appropriate feedback within reasonable time."_

The trying part of the system status are the pending changes.
Though the system provides a summary through the commit modal, perhaps the status should be visible even without the extra interaction, at least in form of a binary indicator _clear -- no changes_ vs _modified -- some pending changes_.

The repository index is missing the breadcrumbs menu, which should be available, no matter it is less important than in the tree traversing.

2. **Match between system and the real world**
_"The system should speak the users' language, with words, phrases and concepts familiar to the user, rather than system-oriented terms. Follow real-world conventions, making information appear in a natural and logical order."_

The system uses terminology taken from Git documentation users are familiar with through Git CLI.
The layout follows conventional guides utilizing application-wide navigation bar, context related optional side-bar and main content area.

What is confusing is the usage of tabular menu for views of the file as well as for the actions upon it.
Perhaps the tabular menu should only hold the different read-only views of the file and write-operations moved elsewhere.

3. **User control and freedom**
_"Users often choose system functions by mistake and will need a clearly marked 'emergency exit' to leave the unwanted state without having to go through an extended dialogue. Support undo and redo."_

This is achieved through the cumulative changes.
The need of the user to commit is thusly reduced to the bare minimum, when they can review changes before submitting.

4. **Consistency and standards**
_"Users should not have to wonder whether different words, situations, or actions mean the same thing. Follow platform conventions."_

Terminology is brief and as stated, terms reflect the Git lexemes.

5. **Error prevention**
_"Even better than good error messages is a careful design which prevents a problem from occurring in the first place. Either eliminate error-prone conditions or check for them and present users with a confirmation option before they commit to the action."_

There is a great error potential in discarding the changes in the commit modal.
Confirm prompt should be used.

6. **Recognition rather than recall**
_"Minimize the user's memory load by making objects, actions, and options visible. The user should not have to remember information from one part of the dialogue to another. Instructions for use of the system should be visible or easily retrievable whenever appropriate."_

The global UI is minimalistic from the perspective of individual elements or menu items.
Most of the navigation is formed by the content of the repository.
The usage of UI elements is consistent and predictable.

The confinement arises from the repository index, which does not distinguish the repository's origins.
As stated in design, the repositories can be from the server or from a remote provider.
This should be visible from the index.

7. **Flexibility and efficiency of use**
_"Accelerators — unseen by the novice user — may often speed up the interaction for the expert user such that the system can cater to both inexperienced and experienced users. Allow users to tailor frequent actions."_

The system was designed with this feature at mind.
It is mostly delivered through direct SSH repository access and notable in the editor UI, utilizing the shortcuts and features seen in coding editors and IDEs.

8. **Aesthetic and minimalist design**
_"Dialogues should not contain information which is irrelevant or rarely needed. Every extra unit of information in a dialogue competes with the relevant units of information and diminishes their relative visibility."_

Only viable information is displayed.
Some UI elements are compactly composed in order to diminish distraction, such as use of reference menu in breadcrumbs.

9. **Help users recognize, diagnose, and recover from errors**
_"Error messages should be expressed in plain language (no codes), precisely indicate the problem, and constructively suggest a solution."_

No error messages are present in the current design.

10. **Help and documentation**
_"Even though it is better if the system can be used without documentation, it may be necessary to provide help and documentation. Any such information should be easy to search, focused on the user's task, list concrete steps to be carried out, and not be too large."_

No form of user documentation is present and should not be required since the systems UI reflects trends seen at popular services like GitHub.

# Patching the wireframes

Here is a list of changes I applied to the wireframes to mend the issues pointed out in the previous section.
Each bullet also includes a number of the figure with corrected wireframe.

![Wireframe: Repository index after heuristic analysis](./src/assets/images/ui/index-fixed){#fig:ui:index-fix width=100%}

![Wireframe: File preview  after heuristic analysis](./src/assets/images/ui/blob-fixed){#fig:ui:blob-fix width=100%}


- Added breadcrumbs menu to repository index -- image @fig:ui:index-fix
- Visually distinguishable (via icons) provider indication added -- image @fig:ui:index-fix
- Restructured tabular menu and moved items resembling actions into side menu -- image @fig:ui:blob-fix
- Added simple indicator to pending changes for the commit^[Similar mechanism is used in Git CLI, when CLI prompt is decorated to indicate there are pending changes in working directory, index or in stash.] -- image @fig:ui:blob-fix
- Prompt confirm for discarding the changes in modal commit will be required.
