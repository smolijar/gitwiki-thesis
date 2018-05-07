# Emily

This section solves the issues from the design chapter with an additional issue of event recursive invocation in the synchronized scrolling.

## Solving the feature bag C

### Live-preview of the document

Live preview is not an issue from the implementation perspective, but it creates a clear restriction on the LMLs that are supported: The language needs to have an in-browser solution for rendering the source markup into HTML.
Majority, if not all LMLs do satisfy this condition, because they usually originate from the web domain.

### Document outline preview

Displaying the TOC, based on the document headlines is a simple matter, provided that a tool for generating HTML is available.
All that is required is to parse the HTML, select the heading tags and form a hierarchical structure.

The first issue is excluding headlines from the outline.
This is required since AsciiDoc has this feature^[It is achieved by adding a `discrete` attribute to the heading.].
This lays a second requirement on the LML module, a function to decide for an HTML headings, whether it is excluded from the outline.
Since AsciiDoc utilizes CSS classes to propagate the generic attributes to HTML, the function for the AsciiDoc module merely checks the existence of a `discrete` CSS class in the HTML heading.

It is expected of the outline to serve as a navigation as well.
Upon clicking the heading is looked up in the source code.

The solution used relies on concept of _line ninjas_^[Line ninja is a name for hidden elements in code that are traceable by machine, but invisible to user.], which is designed for the synchronized scrolling.
As a side effect it labels the HTML output with elements bearing the corresponding line number in the source code.
With it, the line number can be extracted from the HTML heading and the source code lookup is trivial.

### Synchronized scrolling of the editor and preview

Line ninja^[The name was created while developing a prototype to simplify terminology.]

The idea behind this is to smuggle the ninjas, into as many lines of the source code as possible.
The ninjas must comply with the following rules:

1. Ninja is a string
2. Ninja contains an encoded number, representing its line number in the source code
3. When the HTML is rendered from the LML source code containing ninjas, each ninja is left intact by the transformation and remains the identical string to the ninja before the transformation
4. Ninja does not alter the LML -- if ninjas are removed from the HTML, the result is identical to HTML acquired from source without including ninjas


Number four is the most difficult to implement, and it is impossible to solve generally for all LMLs.

Thus a function `safelyInsert` is required by the LML module.
It takes two arguments, a source code line of the LML and a string content.
It returns a string representing the line but including the given string.
This function assures that the markup is never altered by this change (if the content was removed after the HTML transformation).
The function is very difficult to implement even for given LML, therefore the editor is fault tolerant towards it and works even if the function does not cover all the cases^[If the function fails to plant the content in the line, it return the line only.].

Eventually this function `safelyInsert` is used for smuggling ninjas into the LML source code.
This way, they can be found in the resulting HTML and the editor can detect the breakpoints of source code lines,
the only thing that remains is hiding the ninjas in the preview, which can be achieved via CSS.


This allows for the two way synchronization and also solves the issue with heading lookup as mentioned in issue with outline.

Since the ninjas are used in the outline, it is necessary for it to function properly that the `safelyInsert` performs the insert on every heading line.
This is the only requirement for the function.

#### An example of line ninjas

For illustration, an example of the usage of line ninjas is demonstrated.

Assume a Markdown source code in the listing \ref{lst:impl:emily:ninja1}.
This is the plain source.
As mentioned, before converting the document, the ninjas are inserted using the `safelyInsert` function.
Its result is in the listing \ref{lst:impl:emily:ninja2}.
Not all ninjas are perfectly smuggled into the code, as apparent.
This depends on the implementation of the LML module.

All inserted ninjas satisfy the stated conditions: none of the destroy the markup, all bear the number of the source line and all of them are kept intact, when converted into HTML.
This can be verified in the resulting HTML in the listing \ref{lst:impl:emily:ninja3}.
All that remains to be done, is converting the ninjas into HTML markup, which does not shatter the resulting document.
Using regular expressions is sufficient in this case.
All the ninjas are converted into tags as seen in the listing \ref{lst:impl:emily:ninja4}.

Even using hidden spans leaves tracks in the rendered result and contrived CSS rulse must be used to clean them.
Example of the CSS is in the listing \ref{lst:impl:emily:ninja5}.


```{language=md caption="Implementation: Line ninjas -- Markdown" label="lst:impl:emily:ninja1"}
# Header

A paragraph

Second paragraph with styles *italic*, **bold**, and `monospace`. Itemized list follows:

* ein
* zwo
* drei
```

```{language=md caption="Implementation: Line ninjas -- Markdown with ninjas" label="lst:impl:emily:ninja2"}
# Header @@@1@@@
@@@2@@@
A paragraph @@@3@@@

Second paragraph with styles *italic*, **bold**, and `monospace`. Itemized list follows: @@@5@@@
@@@6@@@
* ein @@@7@@@
* zwo @@@8@@@
* drei @@@9@@@
```

```{language=html caption="Implementation: Line ninjas -- HTML with ninjas" label="lst:impl:emily:ninja3"}
<div class="markdown-body">
  <h1 id="header-1-">Header @@@1@@@</h1>
  <p>@@@2@@@
     A paragraph @@@3@@@
  </p>
  <p>Second paragraph with styles <em>italic</em>, <strong>bold</strong>, and <code>monospace</code>. Itemized list follows: @@@5@@@
     @@@6@@@
  </p>
  <ul>
     <li>this one @@@7@@@</li>
     <li>that one @@@8@@@</li>
     <li>the other one @@@9@@@</li>
  </ul>
</div>
```

```{language=html caption="Implementation: Line ninjas -- HTML with ninjas in tags" label="lst:impl:emily:ninja4"}
<div class="markdown-body">
  <h1 id="header-1-">Header <span class="ninja">1</span></h1>
  <p><span class="ninja">2</span>
     A paragraph <span class="ninja">3</span>
  </p>
  <p>Second paragraph with styles <em>italic</em>, <strong>bold</strong>, and <code>monospace</code>. Itemized list follows: <span class="ninja">5</span>
     <span class="ninja">6</span>
  </p>
  <ul>
     <li>this one <span class="ninja">7</span></li>
     <li>that one <span class="ninja">8</span></li>
     <li>the other one <span class="ninja">9</span></li>
  </ul>
</div>
```

```{language=css caption="Implementation: Line ninjas -- CSS" label="lst:impl:emily:ninja5"}
.ninja {
  display: inline-flex;
  visibility: hidden;
  width: 0;
  height: 0;
}
```

### Reorganizing sections in document using outline

With sufficient LML abstraction and line ninjas, line number of the selected heading can be detected. The same applies for the previous or the following heading.
Using this technique, the sections can be moved around without having further requirements of the LML mode.


## Synchronized scrolling loop

Imagine the editor component containing the subcomponents for the preview and the source-code editor as in the listing \ref{lst:impl:emily:copmonents}.
The listing shows a body of the render method of the component.

```{language=jsx caption="Implementation: Emily -- components" label="lst:impl:emily:copmonents"}
<<emily/components.js>>
```

This is a minimalistic, yet logically complete schema of the components with regard to the discussed issue.
There is the `SourceCodeEditor` with a default value and an on-change handler; and the `Preview` that contains inner HTML, since it needs to be set from a string acquired by the converting tool.

Both components are referenced by the higher component to access their DOM elements when performing the scroll and both also have an on-scroll handler.

The desired behavior of the on-scroll handler for `SourceCodeEditor`, is to find the editor's current line and scroll the `Preview` to match it.
Vice versa for the other handler.

Scrolling any element in the DOM is possible through the changing of its attribute `offsetTop`.
Setting it to zero scrolls on the very top and any positive integer sets the scroll offset in pixels.
Setting the `offsetTop` however, triggers a scroll event, the same was as if it has been scrolled by a user.

The interactions are displayed in the diagram @fig:impl:emily-scroll.
It is assumed that the user interacts with the editor but the communication is symmetric in the other case.

![Implementation: Emily editor on-scroll listeners](./src/assets/diagram/emily-scroll){#fig:impl:emily-scroll width=100%}

1. The user scrolls the `Editor`, e.g. using mouse-wheel in the browser.
2. Scroll event on `Editor` is fired.
3. `onEditorScroll` is triggered.
4. `onEditorScroll` finds `Editor`'s line.
5. `onEditorScroll` sets `Preview`'s `offsetTop`.
6. Scroll event on `Preview` is fired.
7. `onPreviewScroll` is triggered.
8. `onPreviewScroll` finds `Preview`'s line.
9. `onPreviewScroll` sets `Editor`'s `offsetTop`.
10. _Repeat from point 3_

The loop theoretically runs forever.
In practice it causes irritating scroll shivering momentum on the scrolled element.

The solution uses a ternary indicator with values:

- **editor**: _`Editor` scrolled last. It can scroll again but the `Preview` cannot._
- **preview**: _`Preview` scrolled last. It can scroll again but the `Editor` cannot._
- **clear**: _Anyone can scroll._

The following rules apply to the listeners, regarding the indicator:

1. When the value allows you to scroll, execute and set to *your name*.
2. When the value forbids you to scroll, clear it and exit.
3. The default value of the indicator is _clear_.

An example interaction of how the circularity is broken is showed in the diagram \ref{fig:impl:emily-scroll-fix}, when the indicator's value is displayed in the notes.

![Implementation: Emily editor on-scroll listeners 2](./src/assets/diagram/emily-scroll-fix){#fig:impl:emily-scroll-fix width=100%}

The listing \ref{lst:impl:emily:handleeditorscroll} shows the authentic implementation of the `handleEditorScroll` event listener.
Lines 2 through 6 implement the indicator logic^[`null` stands for *clear* value]
After that a first visible line of the editor is computed the preview is scrolled using the method `scrollPreviewToLine`^[This function takes the line, computes the top offset in pixels and sets the appropriate attribute in the `Preview` element.].
Before asking the editor for the line, it is prompted to reconfigure its renderer, which force updates the editor to react to the current scrolling event, allowing us to get an un-delayed line number.

```{language=jsx caption="Implementation: Emily -- editor scroll listener" label="lst:impl:emily:handleeditorscroll"}
<<emily/handleEditorScroll.js>>
```

Its counterpart implementation is in the listing \ref{lst:impl:emily:handlepreviewscroll}.

It is very similar to the previous one, though bearing some differences.
The `lastScrolled` indicator condition with the reset and the function's exit is present at the beginning of the function as in the previous case, but setting of the indicator is delayed.
This is because at this point it is not sure that the scrolling is performed.

The editor is checked if it is scrollable in the direction.
This solves the issue of scrolling out of bounds when preview is scrolled over the generated content beyond source, such as TOC, footnotes in appendix of the document etc.
The source code editor provides an API to ask if it is scrollable by the given offset (line 10).

For this API it is required to know the direction of the scroll, which can be acquired by comparing it to the editor's current location^[At this point an idea to use the scroll event data to get the direction instead of comparing the lines might occur. Alas the event provides only the offset, not the delta, so the value would need to be subtracted one way or the other.].

If it is the case, the editor is scrolled and `lastScrolled` is properly set, otherwise the function ends.

```{language=jsx caption="Implementation: Emily -- preview scroll listener" label="lst:impl:emily:handlepreviewscroll"}
<<emily/handlePreviewScroll.js>>
```