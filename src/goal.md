The target of the thesis is to explore the state of the art of version controlled wiki systems,
find the most appropriate solution for the design and implement a system with the special features, which vaguely described in this section and fully specified in the analysis.

# What is a _wiki_?

The system is a version controlled, document oriented, text-based wiki software.

But what is a _wiki_? According to the Oxford dictionaries it is a _"a website that allows any user to change or add to the information it contains"_ [@oald:wiki] a longer and certainly more entertaining description from WikiWikiWeb^[WikiWikiWeb is often considered to be the first wiki being launched in 1995. [@wikiwikiweb:history]]
states: _"The idea of a Wiki may seem odd at first, but dive in, explore its links and it will soon seem familiar. Wiki is a composition system; it's a discussion medium; it's a repository; it's a mail system; it's a tool for collaboration. We don't know quite what it is, but we do know it's a fun way to communicate asynchronously across the network."_^[The insecurity in the description (_"We don't know quite what it is, (...)"_) is understandable from WikiWikiWeb, since its creator chose a name and needed to explain the concept to visitors at the time, when it was not entirely sure, how the system is going to evolve.] [@wikiwikiweb:front].
Those are both obviously vague concepts, but set up a reasonable foundation of what wiki is.

The essential idea behind wiki has always been to put the users into the role of not just mere consumers, but producers of the content, which is the true feature of _Web 2.0_.
Wiki is a platform for document oriented, organically created structured content.

Documents are typically managed by moderators (who perform corrections, topic creation etc.) and written by a community of users.
The community users have an easy access for the document editing and thus it is easy for them to become a contributor.
An in-browser solution for the article editing is expected, for users to collaborate,
because if users feel uncomfortable, or face a steep learning curve, they might become discouraged from their participation and then the wiki cannot thrive without content updates.

Apart from the editing interface, it is expected of a wiki to provide documents of a common topic, that binds the community of contributers.
_Wikipedia_ [@wikipedia] is an encyclopedia,
_WikiWikiWeb_ [@wikiwikiweb] mentioned earlier, was created to discuss design patterns,
or _Wiktionary_ [@wiktionary] as a community developed multilingual open dictionary are all fine examples of such trait.

## Side-note on wiki topic

It is convenient at this point to clarify, whether there is a topic to Gitwiki.

_Gitwiki_ is not a _wiki_ as Wikipedia.
It is a _wiki software_ which can be used to create a topic oriented _wikis_.
A great example of a wiki software is GitHub Wikis [@github:wikis], for instance.
It is a part of GitHub web application that allows users to provide e.g. user manuals for software repositories etc.
GitHub Wikis have no topic though it is expected to be used to create an elaborate software documentation, for a specific software.
The resulting product is a _wiki_ as it was discussed.
It is bound to a specific topic by its contents.


# Real world usage of the system

While the target system is potentially a universal document management platform, usable for a wide variety of applications,
an example archetypal usage scenario is set.
The system is considered (for the purpose of design decision making, interface design, etc.) a platform for an API documentation (or a user manual) collaborative creation.

This defines the special traits of the system, which make it distinguish itself amongst others.

Having mentioned the general potential of the system, other applications the system should satisfy with minor effort would be:

* a publishing platform,
* a collaborative maintenance of large documents that are too large for online services such as Google Docs [@gdocs] or Microsoft Word Online [@mso:word-online],
* a students' hub,
* or a university's tool for the writing and submission of final theses.


# Distinctive features

## Emphasize lightweight markup languages

Markdown has become more or less a standard for the _readme_ files and documentation.
It is easy to learn; intuitive to read, even if you are not familiar with the syntax; machine readable and it has many tools for comfortable writing for users familiar with RTEs.
Once familiar with the basic syntax, it is not an issue to write documents in a simple text editor.

Most of these features, though not necessarily all, are typical for most LMLs.
A form of a simpler markup language is used in almost every wiki system.
The reason to favor Markdown [@gruber:markdown] and AsciiDoc [@asciidoctor] over Wikitext [@wikitext], used by MediaWiki for example, is that the former are rooted in the developer community.
LMLs bring advantage of familiar syntax to users for the archetypal usage as well as the prioritized special syntax features for development, such as source code snippets etc.

## Focus on advanced users

As already mentioned, easy to use interface is a core feature of a wiki system.
This affects the UI design of a wiki system.
It must be welcoming to new users.
The UI must be fool-proof, forgiving and guide the user through editing process.

The documentation platform is not like that.
Its users write often.
It is part of their job and they know the document syntax by heart.
They do not need the system to slow them down by clicking formatting buttons for the few formatting options e.g. Markdown has.

The system should by all means provide an intuitive interface, but not at the cost of the use efficiency for the advanced users.^[This does not mean that the UI should be unintuitive for new users, but rather it should focus on advanced features allowing the experienced user a swift interaction resembling the one they know from IDEs.]

## Use robust non-linear VCS

The raised scenario requires to be able to track changes and their authors as well as to be able to return to the previous revision.
This feature is fairly common and almost required for all wiki software, because the opened collaboration might be abused by attackers or vandals.

Developing parallel versions of the content is fitting for the scenario.
This feature could be used to be able to maintain API documentation for distinct versions of the software, for instance.
The technique is usually called "feature branch" in the software development.
The developer creates new features in separate version branches, detached from the master branch.
This allows to add the feature as a single atomic revision, when it is properly tested.

## Provide direct access to the repository

Many wiki systems provide access only via WUI.
This might be sufficient in many cases, when the only presentation of the content is on the web in the exactly same form.
It is a common practice that the user manuals are linked together into a single large document, that is provided as a whole in a printable or online format.
It is not important what tools are used to do so, but rather to provide the user (or their script or plug-in) with the access to the files directly.

This access should be provided for the read as well as the write operations, to allow users to edit the repository in their own environment.
