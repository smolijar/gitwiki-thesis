# UI {#sec:design:ui}

In this section, the designed WUI of the application will is presented in a form of wireframes.

The most significant part of the UI is doubtlessly the editor.
For this reason, it has been designed separately by a team of students as a MI-NUR term project.
The project has been completed and successfully submitted and is available [@nur:project] online.
The project tackles not only design of the UI, but also its testing, using a heuristic analysis and conducted usability testing.
It contains evaluation of the testing methods and fixes the encountered errors.
Therefore, since the project completed all the UI development process of the editor, it is not considered in the design of the remaining parts of the system.
In the wireframes it is replaced by a simple box.

_On the UI design of the editor I have worked with a team. My colleagues contributed only to the project [@nur:project] referred to, but not included in the main content of the thesis. The wireframes from the project are available in \hyperref[chapter:ui-testing]{appendix}. I, the author of the thesis, am also the author of all the following UI design regarding materials in this section. Members of the team have not contributed to the implementation of the editor nor the system._

## Repository index

![Wireframe: Repository index](./src/assets/images/ui/index){#fig:ui:index width=100%}

The basic layout with the navigation bar is displayed on the wireframe in the image @fig:ui:index.
The navigation bar holds few menu items, a logo with a link to the homepage at the left and a user widget on the far right, as is conventional.
The footer holds basic license and ownership or contact info as expected.
This components form the layout and are present in all the screens.

This wireframe covers the *UC-5 Select repository*.

## File preview

![Wireframe: File preview](./src/assets/images/ui/blob){#fig:ui:blob width=100%}

The wireframe on the image @fig:ui:blob, presents the file preview.

The breadcrumbs menu contains not only the repository and the fragmented path navigation to the file, but more importantly, a fragment of the menu that displays the Git reference.
That is an interactive widget user can use to swap branches.
This solves another issue^[From the point of UI, the logic has been discussed in RESTful API design section.] from previous chapter's summary, which is branching model with a parallel development support.

There is a sidebar menu and the main content.
The side-menu holds the link to the commit screen and a list of the files in the current directory.
The main content is tabbed and provides an interface for switching between the following views of the current file:

 - Preview (if available)
 - Source code view
 - Editing form
 - Rename form

This tab contents always fill the box placeholder.
This wireframe covers the following use cases: *UC-4 Show file*, *UC-7 Change content*, *UC-8 Edit contents*, *UC-9 Manage files*, *UC-11 Manage user access permissions*


## Repository index

![Wireframe: Repository tree](./src/assets/images/ui/tree){#fig:ui:tree width=100%}

In the image @fig:ui:tree, there is a wireframe to the file index in the repository.
This is an expanded version of the side-menu from the previous wireframe with additional information, like SHA hash to better utilize the room given in the main content section.
This wireframe covers the *UC-3 Traverse tree* and *UC-6 Select revision*.

## Commit modal

![Wireframe: Commit screen](./src/assets/images/ui/commit){#fig:ui:commit width=100%}

A modal window is used for the commit screen, as seen in the image @fig:ui:commit.
This way it is easily accessible, no matter the current page.
The window shows a brief summary of the accumulated changes, input for the commit message and the *Cancel*, *Commit* and *Discard changes* buttons.
*UC-10 Create revision* is covered by this wireframe.
