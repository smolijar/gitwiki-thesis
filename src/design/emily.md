# Emily editor

_Emily editor_^[Formally known as _markup editor_, which was a provisional title later scraped for being too generic. _Emily editor_ name selected for (a) the acoustic resemblance to _"LML editor"_, (when spoken swiftly) and (b) it is a fancy name.] is a feature powerful web based document editor for modularly extensible LMLs.

The whole UI design of the UI of the editor took place in the [@nur:project].
This required not only the wireframe modeling, but also the definition of the editor's functionality.

## Editor's features

My lot in the project was (though not only) implementing the editor prototype, where I faced several design obstacles.

Let us take a look on the result of feature brainstorming^[This list is taken from [@nur:project] and reduced to exclude features which we have decided to discard for various reasons.] within the team in the early stage of the project:

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

I have intentionally divided the features into three groups, based on their impact on the design and eventually  implementation difficulties.

Group A are features, which cause the least of the problems.
Though some of them are definitely not trivial, they are generic problems of source code editing, thusly it can be expected, there is a library that already solves all, or majority of the issues.

Feature bag B is more challenging.
These features likely require custom implementation tailored to the editor.
While existing libraries might be used in some cases (e.g. universal access for the full-screen request API) to lighten the burden, more configuration and coding will be required for all the features to affect the new editor component.
Implementing the command palette might prove to be truly complex issue.
Though there are not many features that are easy to implement, they

 - have little effect on the other parts of the editor or future development and
 - they still represent (more or less) existing problems, which have been solved in the past, though in different contexts.

The last bag is the most difficult.
It contains features that are very specific to the domain and related problems are likely original.
As an example: the problem of synchronized scrolling of the source code and its rendered counterpart is complicated and highly domain specific.
As I found out in the research of rival editors in [@nur:project], there are very few editors that offer this feature and if so, they are fixed and specialized on sole markup language.
In the project we tackle to provide this feature though general interface for lightweight markup document centered languages.

### Solving the bag C

#### Live-preview of the document

This is not a big issue from the design perspective, but it creates a clear restriction on the LMLs that are supported:
The language needs to have an in-browser solution for rendering the source markup into HTML.

Luckily as it turns out, this is not too limiting.
Majority, if not all LMLs do satisfy this condition, because they usually originate from the web domain.

It is not surprising that Markdown causes no problems in this matter, given its nuerous implementations and Asciidoc is usable in client JS thanks to Opal, source-to-source compiler from Ruby to JS.

#### Document outline preview

Show document's TOC.
This itself is a trivial matter, given that we already have a tool to generate HTML from the source.
The only thing we need is to parse the HTML result, gather the headings and create a hierarchical structure.

However, while this would work most of the time, Asciidoc for instance has syntax for excluding a section out of the TOC.
This must be considered and thus lays second requirement on the LML apart from transformer to HTML: filter function for the HTML headings.

This is powerful enough, because Asciidoc utilizes CSS classes for easy styling.


Alas, that is not all for this feature.
From the UI perspective, it is expected to lookup the line in source code when clicking the item in TOC.
How can this be achieved?

I offer brief summary of the methods, though it took me weeks to design a proper solution and I have implemented several approaches only to watch them fail in various edge cases.

1. Name lookup

Lookup name of the heading in the source code. This is naturally faulty for there is no control over conflicts.
One could count the duplicates, but that would require detecting only the headings in source to prevent counting the phrase outside of the heading in the source code.

2. Filter heading markup, save the line number

Let us not transform the document as a whole, but let us cherry-pick the heading lines first in source code and then transform them with provided function.
Then we get the HTML heading as well as the line number in the source code we remembered.

This approach seemed good enough to me at first, using simple regular expressions to pick the valid lines and worked flawlessly for the most part.

The problem is, that matching anything in the markup using regular expressions is a road to hell, as I shall explain.

3. Keep line number

The solution I found the best after all the struggle was to rely on concept of _line ninjas_^[Line ninja is a name for hidden elements in code that are traceable by machine, but invisible to user.], which I designed for the synchronized scrolling.

##### Why regex matching is a bad idea

Consider the Markdown source example \ref{lst:design:emily:md}, and list of regular expressions in \ref{lst:design:emily:reg}, we will use to capture all the headings.

The Markdown example contains four valid headings _Hello world_, two of level one, and two of level two, each with standard and alternate (but valid) underline syntax.

\begin{listing}
\caption{Design: Markdown Headings}
\label{lst:design:emily:md}
\begin{minted}{md}
# Hello world

Using # you can create a heading

Hello world
===========

## Hello world

Hello world
-----------
```sh
# bash comment in src block
fortune | cowsay
```
\end{minted}
\end{listing}

```{language=js caption="Design: Markdown Heading parsing" label="lst:design:emily:reg"}
/#+\s+.+/g
/(#+\s+.+|.*\n(===|---)+)/g
/\n(#+\s+.+|.*\n(===|---)+)/g
/(^|\n)(#+\s+.+|.*\n(===|---)+)/g
```

First naive expression does not work on underline syntax.
Second fixes that but marks false positive on line 3 of the source code.
This could be repaired by requiring the line before as shown on third expression.
That fails on the first line, we must include the special `^` alternative, as seen in four expression.
That kind of works, but creates an anomaly with numbers. Since the newline is included, we are getting the line before, which we easily solve by incrementing all the numbers, _except_ there is a heading on the first line, which is an exception generated by the special symbol `^`.

All of the expressions include false positive on line 13, which is impossible to get rid of using regular expressions captures, because it is not a regular language.

Thus not only it is painful, but also generally impossible.


#### Synchronized scrolling of the editor and preview

As before, there are several available methods I will now explain.

1. Proportional scrolling

First naive idea might be linear interpolation through the document. This could work relatively well on small documents without images and other irregularities in the proportion.

It will utterly fail on larger documents, even with regular markup.

2. Synchronized cursor

This is the solution I implemented in the early prototype.
The idea is to modify the source markup before rendering and sneakily insert a mark on the cursor that will be recognized and replaced in the HTML with invisible element.

That is generally not a terrible idea, but it requires the language mode to `safelyInsert` the ninja to any given line.
Most of the time it is simple for Markdown and Asciidoc alike, though none of them have syntax for in-line comments.
To guarantee 100% coverage, with the responsibility that the markup will not be distorted is extremely difficult^[e.g. for table markup, block start or end, image markup, footnotes, detached references etc.].
Thus there still were some lines where the ninja was not available, resulting in annoying jumps in the scroll.

3. Line ninja^[I made this name while developing a prototype to simplify terminology. Initially I wanted to call the mechanism _scrollspy_, but that is already reserved for the TOC menu on side highlighting items as scrolling through the document.]

The idea behind this is to fill the holes in the previous solution, which in general on pretty markup worked quite well.
And since it is nearly impossible to implement `safelyInsert` generally, it is more convenient to develop a mechanism that is fault-tolerant.

That is -- do not place the mark only on the cursor; place it anywhere `safelyInsert` method can.
Sure there will be some lines missing, but the editor now can find the closest match and synchronize at breakpoints.

This also allows for two way synchronization and also solves the issue with heading lookup as mentioned in issue with outline.

#### Reorganizing sections in document using outline

With sufficient LML abstraction and line ninjas, we can lookup the line number of selected heading and the previous or next one.

Thanks to this sections can technically be moved around without having further requirements of the LML mode.

## Emily's modules

![Design: Emily editor](./src/assets/diagram/emily){#fig:design:emily width=100%}

The diagram @fig:design:emily shows the main components and modules of the editor.

### Components

The core component is the `Editor` itself, which includes the composite components `StatusBar` (the bottom bar), `CommandPalette` and `Outline` and utilizes supportive modules: `commands` for `CommandPalette`, `autosave` and `lineNinja` definitions.

The `CommandPalette` has a supportive component for the drag&drop sorting.

### Modes

Modes include the LML modes.
There are two modes in initial release.
Since some functionality can be generated, all modes are bootstrapped before they are ready to be used in the editor.

