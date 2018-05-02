# Emily -- synchronized scrolling

Apart from the heavy difficulties of how to approach the problem, as discussed in _\hyperref[synchronized-scrolling-of-the-editor-and-preview]{Synchronized scrolling of the editor and preview}_ in the design, where I explained the usage of line ninjas, the feature itself was not easy to implement.

Imagine the editor component containing the subcomponents for the preview and the source-code editor as in the listing \ref{lst:impl:emily:copmonents}. The listing shows a body of the render method of the component.

```{language=jsx caption="Implementation: Emily -- components" label="lst:impl:emily:copmonents"}
<<emily/components.js>>
```

This is minimalistic, yet logically complete schema of the components with regard to the discussed issue.
We have the `SourceCodeEditor` with a default value and an on-change handler; and the `Preview` that contains inner HTML, since we need to set it from a string acquired by the converting tool.

Both components are referenced by the higher component to access their DOM elements when performing the scroll and both also have an on-scroll handler.

The desired behavior of the on-scroll handler for `SourceCodeEditor`, is to find the editor's current line and scroll the `Preview` to match it. Vice versa for the other handler.

Scrolling any element in the DOM is possible through the changing of its attribute `offsetTop`.
Setting it to zero scrolls on the very top and any positive integer will set the scroll offset in pixels.
Setting the `offsetTop` however, triggers a scroll event, the same was as if it has been scrolled by a user.

Let us take a look on what will happen.
The interactions are displayed in the diagram @fig:impl:emily-scroll.
I assume the user interacts with the editor but the communication is symmetric in the other case.

![Implementation: Emily editor on-scroll listeners](./src/assets/diagram/emily-scroll){#fig:impl:emily-scroll width=100%}

1. The user scrolls the `Editor`, e.g. using mouse-wheel in the browser.
2. Scroll event on `Editor` is fired
3. `onEditorScroll` is triggered
4. `onEditorScroll` finds `Editor`'s line
5. `onEditorScroll` sets `Preview`'s `offsetTop`
6. Scroll event on `Preview` is fired
7. `onPreviewScroll` is triggered
8. `onPreviewScroll` finds `Preview`'s line
9. `onPreviewScroll` sets `Editor`'s `offsetTop`
10. _Repeat from point 3_

The loop theoretically runs forever.
In practice it causes irritating scroll shivering momentum on the scrolled element.

At first I naively though I could prevent this behavior, by forbidding the listeners to execute two times in a row through a variable -- meaning the other handler is required to run forcing a switched execution of the two.
I implemented this using one shared binary indicator.
This however proved insufficient in practice, because, while it fixed the issue, it introduced an opposite problem -- blocking two fast consecutive scroll events on the single component.
In testing it showed that the scroll events are fired more rapidly, than the circular loop-back is able to finish.
Subsequent events were then discarded.

A similar solution has proved to be efficient.
It uses a ternary indicator instead of a binary with values:

- **editor**: _`Editor` scrolled last. It can scroll again but the `Preview` cannot._
- **preview**: _`Preview` scrolled last. It can scroll again but the `Editor` cannot._
- **clear**: _Anyone can scroll._

The following rules apply to the listeners, regarding the indicator:

1. When the value allows you to scroll, execute and set to *your name*.
2. When the value forbids you to scroll, clear it and exit.
3. The default value of the indicator is _clear_.

An example interaction of how the circularity is broken is showed in the diagram \ref{fig:impl:emily-scroll-fix}, when the indicator's value is displayed in the notes.

![Implementation: Emily editor on-scroll listeners 2](./src/assets/diagram/emily-scroll-fix){#fig:impl:emily-scroll-fix width=100%}

The listing @lst:impl:emily:handleeditorscroll shows the authentic implementation of the `handleEditorScroll` event listener.
Lines 2 through 6 implement the indicator logic^[`null` stands for *clear* value]
After that a first visible line of the editor is computed and then preview is scrolled using the method `scrollPreviewToLine`^[This function takes the line, computes the top offset in pixels and sets the appropriate attribute in the `Preview` element.].
Before asking the editor for the line, it is prompted to reconfigure its renderer, which force updates the editor to react to the current scrolling event, allowing us to get an un-delayed line number.

```{language=jsx caption="Implementation: Emily -- editor scroll listener" label="lst:impl:emily:handleeditorscroll"}
<<emily/handleEditorScroll.js>>
```

Its counterpart implementation is in the listing \ref{lst:impl:emily:handlepreviewscroll}.

It is very similar to the previous one, though bearing some differences.
Notice that the `lastScrolled` indicator condition with the reset and the function's exit is present at the beginning of the function as in the previous case, but setting of the indicator is delayed.
This is because at this point it is not sure that the scrolling will be performed.

The editor is checked if it is scrollable in the direction.
This solves the issue of scrolling out of bounds when preview is scrolled over the generated content beyond source, like TOC, footnotes in appendix of the document etc.
The source code editor provides an API to ask if it is scrollable by the given offset (line 10).

For this API we need to know the direction of the scroll, which we get by comparing it to the editor's current location^[At this point an idea to use the scroll event data to get the direction instead of comparing the lines might occur. Alas the event provides only the offset, not the delta, so the value would need to be subtracted one way or the other.].

If it is the case, the editor is scrolled and `lastScrolled` is properly set, otherwise the function ends.

```{language=jsx caption="Implementation: Emily -- preview scroll listener" label="lst:impl:emily:handlepreviewscroll"}
<<emily/handlePreviewScroll.js>>
```