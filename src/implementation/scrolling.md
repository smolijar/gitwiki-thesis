# Emily -- synchronized scrolling

Apart from the heavy difficulties of how to approach the problem, as discussed in \hyperref[synchronized-scrolling-of-the-editor-and-preview]{Synchronized scrolling of the editor and preview} in chapter design, where I explained the usage of line ninjas, the feature itself was not easy to implement.

Imagine the editor component containing the subcomponents for preview and editor as in listing \ref{lst:impl:emily:copmonents} (body of the render method of the component).

```{language=jsx caption="Implementation: Emily -- components" label="lst:impl:emily:copmonents"}
<<emily/components.js>>
```

This is minimalistic, yet logically complete schema of the components with regard to discussed issue.
We have editor with default value and on-change handler; and preview that contains inner HTML, since we need to set it from string as acquired by the converting tool.

Both components are referenced by the higher component to access their DOM elements when performing the scroll and both also have the on-scroll handler.

The desired behavior of an on-scroll handler for Editor, is to find the Editor current line and scroll Preview to match it and vice versa.

Scrolling any element in DOM is possible through changing of its attribute `offsetTop`.
Setting it to zero scrolls on the very top and any positive integer will set the scroll offset in pixels.
Setting offsetTop however, triggers the scroll event, the same was as if it has been scrolled by a user.

Let us take a look on what will happen.
The interactions are displayed in the diagram [@fig:impl:emily-scroll].
I assume the user interacts with the editor but the communication is symmetric in the other case.

![Implementation: Emily editor on-scroll listeners](./src/assets/diagram/emily-scroll){#fig:impl:emily-scroll width=100%}

1. User will trigger the scroll on the `Editor`, e.g. using mouse-wheel in browser.
2. Scroll event on `Editor` is fired
3. `onEditorScroll` is triggered
4. `onEditorScroll` finds `Editor`'s line
5. `onEditorScroll` sets `Preview`'s `offsetTop`
6. Scroll event on `Preview` is fired
7. `onPreviewScroll` is triggered
8. `onPreviewScroll` finds `Preview`'s line
9. `onPreviewScroll` sets `Editor`'s `offsetTop`
10. _Repeat from point 3_

The loop theoretically runs forever, in practice causes irritating scroll shivering momentum on the scrolled element.

At first I naively though I could prevent this behavior, by forbidding the listeners to execute two times in a row through a variable -- meaning the other handler is required to run forcing switched execution of the two.
I implemented this using one shared binary indicator.
This however proved insufficient in practice, because, while it fixed the issue, it introduced an opposite problem -- blocking two fast consecutive scroll events on the single component.
In testing it showed that the scroll events are fired more rapidly, than the circular loop-back is able to finish.
Subsequent events were then discarded.

A similar solution proved to be efficient.
It uses a ternary indicator instead of binary with values:

- **editor**: _`Editor` scrolled last. It can scroll again but the `Preview` cannot._
- **preview**: _`Preview` scrolled last. It can scroll again but the `Editor` cannot._
- **clear**: _Anyone can scroll._

The following rules apply to the listeners, regarding the indicator:

1. When the value allows you to scroll, execute and set to *your name*.
2. When the value forbids you to scroll, clear it and exit.
3. The default value of the indicator is _clear_.

An example interaction of how the circularity is broken is showed in the diagram \ref{fig:impl:emily-scroll-fix}, when the indicator's value is displayed in the notes. 

![Implementation: Emily editor on-scroll listeners 2](./src/assets/diagram/emily-scroll-fix){#fig:impl:emily-scroll-fix width=100%}

The listing show the authentic implementation of the `handleEditorScroll` event listener.
Lines 2 through 6 implement the indicator logic^[`null` stands for *clear* value]
After that a first visible line of the editor is computed and then preview is scrolled using a method `scrollPreviewToLine`, which takes the line, computes the top offset in pixels and sets the appropriate attribute.
Before asking the editor for the line, it is prompted to reconfigure its renderer, which force updates the editor to react to the current scrolling event, allowing us to get un-delayed line number. 

```{language=jsx caption="Implementation: Emily -- editor scroll listener" label="lst:impl:emily:handleeditorscroll"}
<<emily/handleEditorScroll.js>>
```

Its counterpart implementation is in the listing \ref{lst:impl:emily:handlepreviewscroll}.

It is very similar to the previous one, though bearing some differences.
Notice that the `lastScrolled` indicator condition with reset and exist is present at the beginning of the function as in previous case, but setting of the indicator is delayed.
This is because at this point it is not sure that the scrolling will be performed.

The editor is checked if it is scrollable in the direction.
This solves the issue of scrolling out of bounds when preview is scrolled over generated content, like TOC, footnotes in appendix of the document etc.
The source code editor provides an API to ask if it is scrollable by the given offset (line 10).

For this API we need to know the direction of the scroll, which we get by comparing it to the editor's current location^[At this point an idea to use the scroll event data to get the direction instead of comparing the lines might occur. Alas the event provides only offset, not delta so the value would need to be subtracted one way or the other.].

If it is the case, editor is scrolled and `lastScrolled` is properly set, otherwise the function ends.

```{language=jsx caption="Implementation: Emily -- preview scroll listener" label="lst:impl:emily:handlepreviewscroll"}
<<emily/handlePreviewScroll.js>>
```