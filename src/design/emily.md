# Emily editor

The _Emily editor_^[Formally known as _markup editor_, which was a provisional title later scraped for being too generic. _Emily editor_ name selected for (a) the acoustic resemblance to _"LML editor"_, (when spoken swiftly) and (b) it is a fancy name.] is a web based document editor component for LMLs.

The UI design of the editor took place in the [@nur:project].
This required not only the wireframe modeling, but also the definition of the editor's functionality.

## Editor's features

The result of the feature brainstorming^[This list is taken from [@nur:project] and reduced to exclude features which have been discarded for various reasons.] within the team in the early stage of the project is as follows:

### Feature bag A

 - Go to line
 - Auto-complete
 - Search
 - Syntax highlight
 - Line numbers
 - Text wrapping
 - Section folding
 - Distraction free mode

### Feature bag B

 - Full-screen mode
 - Two-column preview (source code and rendered preview)
 - Command palette
 - Status bar

### Feature bag C

 - Live-preview of the document
 - Document outline preview
 - Synchronized scrolling of the editor and preview
 - Reorganizing sections in document using outline


The features are divided into three groups, based on their impact on the design and eventually  implementation difficulties.

Group A are features causing the least of the problems.
Though including non-trivial features to design or implement, they represent generic problems of source code editing, thus it is expected to be handled by an existing solution.

Feature bag B is more challenging for the implementation.
The features likely require custom implementation tailored to the editor.
While existing libraries can be used used in some cases (e.g. universal access for the Fullscreen API), more configuration and coding is required for all the features to affect the new editor component.
Though there are not many features that are easy to implement, they

 - have little effect on the other parts of the editor or future development and
 - they still represent (more or less) existing problems, which have been solved in the past, though in different contexts.

The last bag is the most difficult.
It contains the features that are very specific to the domain and related problems are likely original.
As an example: the problem of the synchronized scrolling of the source code and its rendered counterpart is complicated and highly specific of the code nature.
As was discovered in the research of the rival editors in [@nur:project], there are very few editors that offer this feature and if so, they are fixed and specialized on a single markup language.
Emily editor tackles to provide this feature through general interface for the LMLs.

The solution to the features is discussed in the implementation chapter.

## Emily's modules

![Design: Emily editor](./src/assets/diagram/emily){#fig:design:emily width=100%}

The diagram @fig:design:emily shows the main components and modules of the editor.

### Components

The core component is the `Editor` itself, which includes the composite components `StatusBar` (the bar at the bottom), the `CommandPalette` and the `Outline` and utilizes supportive modules: `commands` for the `CommandPalette`, `autosave` and `lineNinja` definitions.

The `CommandPalette` has a supportive component for the drag&drop sorting.

### Modes

The `modes` module includes the LML modes.
There are two modes in the initial release.
Since some functionality can be generated, all modes are bootstrapped before they are ready to be used in the editor.

