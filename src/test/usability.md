# Usability testing

Apart from heuristic analysis of the UI in the chapter _\hyperref[chapter:ui-testing]{UI testing}_, a live usability testing with working prototype and real users has been conducted.

In this chapter the testing scenarios are presented and then the testing itself and proposed solutions to UI issues are briefly summarized.

## Testing scenarios

There are three short testing scenarios.
As a whole the scenarios focus on the innovative aspects of the UI, that are unusual or unseen in similar projects.

The first scenario tests user's understanding of the parallel content browsing, forcing the user to change the revision of the repository and to read a file in the repository tree in a non-default branch.

The second scenario is designed to be more relaxing for the tester, inspecting the UI of basic navigation in the tree and the file detail.

The final scenario is the most challenging.
Not only it is about the content editing but also it tests the concept of accumulating the pending changes in the application state, which is a feature not seen in any software mentioned in the chapter _\hyperref[chapter:state]{State-of-the-art}_ nor in any other wiki software mentioned in the text.

### Scenario A: Working with references

#### Introduction for the tester

You are writing a user manual for a library, you and your team is developing.
The manual is stored in the system in the repository `<repository>`.
The project adheres to semantic versioning.
Your colleague has just fixed a bug in the installation section of the user manual that has caused many problems to the users and published it under the version `<version>`.
Before deploying, check that the version of the project in the branch `<branch>` is greater than or equal to the `<version>`.
The current version of the project is stored in the `./VERSION` file, apart from using Git tags.

#### Meta information

- **Expected time of completion:** 5 minutes
- **Goals:**
    - User can find the repository index.
    - User can find the desired repository in the index and open it.
    - User recognizes the reference widget in the breadcrumbs menu as means of navigation.
    - User understands that they can change the browsed reference using the widget and how it effects the view on the repository.
    - User can use the file index and select an item to bring up the file detail.
- **Initial state:** Homepage of the application with a logged in user
- **Terminal state:** Detail of the `./VERSION` file in branch `<branch>`

#### Steps

1. Navigate to the repository index.
2. Open the repository `<repository>`.
3. Find the file `./VERSION`.
4. What is the current branch?
5. Find the contents of the file `./VERSION` in branch `<branch>`.

### Scenario B: Working with file detail

#### Introduction for the tester

Your colleague forgot a "todo" note in a comment in one of the three document files in folder `<dir>`.
The comment is on the first line of the file.
Find the content of this note so you can create an issue in your tracker.

#### Meta information

- **Expected time of completion:** 5 minutes
- **Goals:**
    - User can navigate through the index menu to said folder.
    - User can understands that side-menu index is for switching between the files in the same folder.
    - User notices the tabular menu in the file detail, and can use it to select the view they desire.
- **Initial state:** Terminal state of the previous scenario or index page of the `<repository>` repository
- **Terminal state:** Detail of the source code of the commented file

#### Steps

1. Navigate to the `<dir>` in this repository
2. Browse the files in the folder to find the one with a "todo" comment note on the first line.
Remember, that comments are not visible in the rendered document preview, but in the source code of the file.

### Scenario C: Creating a revision

#### Introduction for the tester

In the file you were just inspecting it is necessary to remove the comment and change the title of the document to `<newtitle>`.
Apart from that, in the same revision, delete the remaining two files in the folder, they are no longer needed.
Review your changes and create a commit with a message `<message>`.

#### Meta information

- **Expected time of completion:** 5 minutes
- **Goals:**
    - User understands the side-menu is context-relevant and contains actions related to the current screen.
    - User can navigate to page edit and add a change.
    - User realizes, that creating a change does not mean creating a revision.
    - User understands how the changes are accumulated in the application state.
- **Initial state:** Terminal state of the previous scenario
- **Terminal state:** Index of the repository `<repository>`

#### Steps

1. Remove the comment in the current file and change the title of the document to `<newtitle>`.
2. Delete the remaining files in the folder, except the one you have just edited.
3. Review all the pending changes.
4. Create a revision from the changes with comment `<message>`.


## The course of the testing

Four UI testers participated in the testing in total.

No acceptance form inspecting the testers' background has been submitted.
The testers were briefly introduces and thus it is known that they:

- are developers,
- know Git fairly well and use it regularly^[except for one tester, who uses Subversion in their workspace, but uses Git on personal projects],
- know Markdown syntax, two users are also familiar with AsciiDoc, one of which prefers it to Markdown.

All users qualified for the UI testing of the system.
The UI of the system's prototype testing is conducted in combination of live testing and shared screen with voice chat.
The testing provided only qualitative output in form a test log made during and after the testing.

## Outcome

The following issues are discovered during the testing:

- The link in the repository index has incorrect cursor.
*Solution: use pointer cursor to indicate the component is a link.*

- It is not apparent from the reference widget it is interactive.
Its behavior surprises users.
*Solution: add a caret icon to symbolize its function and use click event instead of hover to eliminate accidental interactions.*

- When browsing the repository tree and currently a folder is selected, duplicate file listing is visible in the main content as well as in the side-menu.
*Solution: remove the index from the side-menu when on a folder.*

- In the side-menu, the listing of the current folder is titled *index*. Users stated that using label *files* is more self-explanatory.
*Solution: change the label.*

- The users find it difficult to use the breadcrumbs menu for navigating to the root of the repository, since the menu has links for the Repository index, the current repository, the reference and path fragments.
*Solution: visually divide the repository with reference from the path in breadcrumbs menu; remove repository index link.*

- SHA hashes seem to have different lengths using a proportional font.
*Solution: use monospace font for the SHA hashes.*
