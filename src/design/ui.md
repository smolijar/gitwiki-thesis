# UI {#sec:design:ui}

In this section the designed wireframe UI will be presented.

The most significant part of the UI is doubtlessly the editor.
For that reason, I have proposed it as a subject of MI-NUR term project.
This has been accepted and I have lead and worked on the UI design with an assembled team. 
The project has been completed and successfully submitted and is available[@nur:project] online.

Therefore I will assume the editor UI is taken care of and will use a simple box in the Gitwiki wireframes.

_On the UI design of the editor I have worked with a team. They only contributed only to the project [@nur:project] referred to, but not included in this thesis. I, the author of the thesis am also the author of all the following UI design regarding materials in this section. Members of the team have not contributed to the implementation of the editor nor the system._

## Repository index

![Wireframe: Repository index](./src/assets/images/ui/index){#fig:ui:index width=100%}

On the wireframe in the image @fig:ui:index we can see a basic layout with navigation bar.
The navigation bar holds few menu items, logo with a link to the homepage at the left and on the far right side a user widget, as is conventional.
The footer holds basic license and ownership or contact info as expected.
These components form the layout and are present in all screens.

This wireframe covers the *UC-5 Select repository*.

## File preview

![Wireframe: File preview](./src/assets/images/ui/blob){#fig:ui:blob width=100%}

The wireframe on the image @fig:ui:blob, apart from existing layout, shows the file preview.

The breadcrumbs menu not only shows the repository and fragmented path navigation to the file, but more importantly, a fragment of the breadcrumbs hold Git reference.
That is an interactive widget user can use to swap branches.
This solves another issue^[From the point of UI, the logic has been discussed in REST API design section.] from previous chapter's summary, which is branching model with a parallel development support.

From the breadcrumbs menu itself, there is a sidebar menu and the main content.

The side-menu hold link to commit screen and list of files in the current directory.

The main content is tabbed and provides interface for switching between following views of the current file:
 
 - Preview (if available)
 - Source code view
 - Editing form
 - Rename form

This tab contents always fill the box placeholder.

This wireframe covers the following use cases: *UC-4 Show file*, *UC-7 Change content*, *UC-8 Edit contents*, *UC-9 Manage files*, *UC-11 Manage user access permissions*


## Repository index

![Wireframe: Repository tree](./src/assets/images/ui/tree){#fig:ui:tree width=100%}

The image @fig:ui:tree holds wireframe to file index in the repository.

This is expanded side-menu from the previous wireframe with additional information, like SHA hash to better utilize the room given in the main content section.

This wireframe covers the *UC-3 Traverse tree* and *UC-6 Select revision*.

## Commit modal

![Wireframe: Commit screen](./src/assets/images/ui/commit){#fig:ui:commit width=100%}

I have decided to use modal window for the commit screen, as seen in the image @fig:ui:commit to have it easily accessible, no matter the current page.

The window shows brief summary of the accumulated changes, input for the commit message and *Cancel*, *Commit* and *Discard changes* buttons.

*UC-10 Create revision* is covered by this wireframe.
