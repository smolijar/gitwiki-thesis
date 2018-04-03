# Goal

The target of the thesis is to explore the state of art of version controlled wiki systems,
find the most appropriate solution for designing a implementing a system with the special features vaguely described in this section and specified in analysis.

## What is a _wiki_?

The system is a version controlled, document oriented, text-based wiki software.

But what is a _wiki_? According to Oxford dictionaries it is a _"a website that allows any user to change or add to the information it contains"_ [@oald:wiki] a longer and certainly more entertaining description from [@wikiwikiweb:front] states _"The idea of a Wiki may seem odd at first, but dive in, explore its links and it will soon seem familiar. Wiki is a composition system; it's a discussion medium; it's a repository; it's a mail system; it's a tool for collaboration. We don't know quite what it is, but we do know it's a fun way to communicate asynchronously across the network."_.
Those are both obviously vague concepts, but set up a reasonably foundation of what wiki is.

The essential idea behind wiki has always been to put users into the role of not just mere consumers, but producers of the content, which is the true concept as well as the most commonly used example of _Web 2.0_.
Wiki is a platform for document oriented, organically created structured content.

Documents are typically managed by administrators (performing corrections, topic creation etc.) and written by a community of users.
The community users have easy access for document editing and thus it is easy to access and become a contributor.
An in-browser solution for article editing is expected, for users to collaborate,
for if users feel uncomfortable, or face a steep learning curve, they might become discouraged from their participation and then the wiki cannot thrive without updated content.

Apart from the editing interface, it is expected of a wiki to provide documents of a common topic, that binds the community of contributers.
_Wikipedia_ [@wikipedia] is an encyclopedia,
_WikiWikiWeb_ [@wikiwikiweb], often considered to be the first wiki, was designed to discuss design patterns,
or _Wiktionary_ [@wiktionary] as a community developed multilingual open dictionary are all fine examples of such trait.

### Side-note on wiki topic

The reasonable question before we proceed would be: _"What is the topic of gitwiki"_?
_Gitwiki_ is not a _wiki_ as Wikipedia.
It is a _wiki software_ which can be used to create a topic oriented _wiki_.
A great example of a wiki software is Github Wikis [@github:wikis], for instance.
It is a part of Github web application that allows users to provide e.g. user manuals to software repositories etc.
Github Wikis have no topic though it is expected to be used to create an elaborate software documentation.


## Real world usage of the system

While the target system is potentially a universal document management platform, usable for a wide variety of applications,
an example archetypal usage scenario has been set. 
The system is considered for the purpose of design decision making, interface design etc as a platform for API documentation or user manual collaborative creation.

This brings us to the following subsection of defining the special traits of the system, which makes it distinguish itself amongst others.

Before we move on, other applications I the system should satisfy with little effort would be
a publishing platform, 
collaborative maintenance of large documents that are too large for online services such as Google Docs [@gdocs] or Microsoft Word Online [@mso:word-online],
a students' hub or
a university's tool for final thesis writing and submission.


## Distinctive features

* **Emphasize lightweight markup languages**

Markdown has become more or less a standard for README and documentation, and no wonder.
It is easy to learn, intuitive to read even if you are not familiar with the syntax, machine readable and it has many tools for comfortable writing for users familiar with RTEs.
Once familiar with the basic syntax, it is not an issue to write documents in a simple text editor.

Most of these features, though not necessarily all are typical for most LMLs.
A form of a simpler markup language is used in almost every wiki system.
The reason to favor Markdown [@gruber:markdown] and Asciidoc [@asciidoctor] over Wikitext [@wikitext], used by MediaWiki for example, is that the former are rooted in the developer community.
It brings advantage of familiar syntax to users for the archetypal usage as well as prioritized special syntax features, such as source code snippets etc.

* **Focus on advanced users**

As already mentioned, easy to use interface is a core feature of a wiki system.
The problem is that majority of wiki UI rely on many new users making very few contributions to the content.
That means that that the UI must be fool-proof, forgiving and guide the user through editing process.

Our documentation platform is not like that. Our users write often.
It is part of their job and they know the syntax by heart.
They do not need the system to slow them down by clicking formatting buttons for the few formatting options e.g. Markdown has.

The system should by all means provide an intuitive interface, but not on for the cost of use efficiency of the advanced users.

* **Use robust non-linear VCS**

We want to be able to track changes and their authors as well as be able to return to previous revision.
This feature is fairly common and almost required for all wiki software, because the opened collaboration might be dangerous.

What we would like for our documentation platform is to develop parallel versions of the content, to be able to maintain API documentation for distinct versions of the software for instance.
This technique is usually called "feature branch" from the software development, where the developer creates new features in version branches detached from the master branch to add the feature as a single atomic revision, when it is properly tested.

* **Provide direct access to the repository**

Many wiki systems provide only access via WUI.
This might be sufficient in many cases, when the only presentation of the content is on the web in the exactly same form.
It is a common practice that user manuals are linked together into a single large document, that is provided as a whole in a printable or online format.
It is not important what tools are used to do so, but it is important to provide the user (or their script or plug-in) to access the files directly for easy access.

This access should be provided for read as well as write operations, to allow users to edit the repository in their own environment.
