In this chapter I shall showcase the lo-fi prototype design of the Emily editor from the MI-NUR project [@nur:project].

# Acknowledgement

Contents of this section are separated from the main content, since _all figures_ (diagram and wireframes) in this chapter are taken from the mentioned [@nur:project], which is a result of a teamwork.

The diagram and wireframes have been translated to English by myself for the purpose of the thesis.

I am the author of all texts in this chapter, which only briefly summarize or comment on the figures.
If the reader is keen for more background information and development of the UI, they may read [@nur:project].

# Task graph

The diagram @fig:taskgraph displays transition of the editor states through relations between the UI screens.

![Emily UI: Task graph](./src/assets/diagram/taskgraph){#fig:taskgraph width=100%}

# Wireframes


## The main view modes

The editor, as apparent from the diagram @fig:taskgraph, offers three display modes:

- Two column preview for common usage, wireframe @fig:emily:twocol
- Source code for focusing on the content, wireframe @fig:emily:source
- Preview for document revisions, wireframe @fig:emily:preview

![Emily UI: Wireframe: Two column preview](./src/assets/images/nur/twocol){#fig:emily:twocol width=100%}

![Emily UI: Wireframe: Source code](./src/assets/images/nur/source){#fig:emily:source width=100%}

![Emily UI: Wireframe: Preview](./src/assets/images/nur/preview){#fig:emily:preview width=100%}

## Editor interactions

There are two wireframes showcasing the interactions with the editor.
The first one, seen in figure @fig:emily:palette, demonstrates the main interface of the editor, the command palette, while the other shows all available navigational elements as seen in figure @fig:emily:other

![Emily UI: Wireframe: Command palette](./src/assets/images/nur/palette){#fig:emily:palette width=100%}

![Emily UI: Wireframe: Navigation](./src/assets/images/nur/other){#fig:emily:other width=100%}

## Display in browser

The editor is assumed to be by default an embedded editor component, seen on the figure @fig:emily:embed and @fig:emily:fullscreen.

![Emily UI: Wireframe: Embedded](./src/assets/images/nur/embed){#fig:emily:embed width=100%}

![Emily UI: Wireframe: Fullscreen](./src/assets/images/nur/fullscreen){#fig:emily:fullscreen width=100%}
