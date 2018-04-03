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


## Real world usage of the system?

While the target system is potentially a universal document management platform, usable for a wide variety of applications,
an example archetypal usage scenario has been set. 
The system is considered for the purpose of design decision making, interface design etc as a platform for API documentation or user manual collaborative creation.

This brings us to the following subsection of defining the special traits of the system, which makes it distinguish itself amongst others.

Before we move on, other applications I the system should satisfy with little effort would be
a publishing platform, 
collaborative maintenance of large documents that are too large for online services such as Google Docs [@gdocs] or Microsoft Word Online [@mso:word-online],
a students' hub or
a university's tool for final thesis writing and submission.
