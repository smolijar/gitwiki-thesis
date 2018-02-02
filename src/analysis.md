# Requirements model

## Roles

The system in general recognizes only two types of users

1. Regular user

  Regular user can by either anonymous or registered.
  Anonymous user can browse or even contribute to a public repository if it's authorization policy allows that.
  Registered user can access even private repositories if they have sufficient access.

2. Administrator

  Is a user with direct access to the hosted machine.
  Since all data are stored on the server FS, administrator unlimited power over repositories with wiki and ACL content.

TODO: NOTE ABOUT ACCESS UI

## Functional requirements

Wiki system works with text files formatted in a specific markup syntax.
System must provide support for Asciidoc[@asciidoctor] and Markdown[@gruber:markdown] and must allow extensibility for other LML.
The set of at least two mentioned LMLs possibly extended by additional ones will be referred to as *supported markup*.

 - F-1\. **Authentication**

  TODO: NOT SURE ABOUT AUTH IN WUI

 - F-2\. **Authorization**

  Each authenticated user accessing the system is denied or allowed access according to current ACL settings respectively, regardless of used interface.
  Authentication methods may very for WUI and SHH access, but authorization layer's behavior is consistent in this matter.

 - F-3\. **Content management**

  Authorized users can manage wiki contents.
  Users can preform general CRUD operation on any content based on their authorization level.

  The system uses VCS to track changes in the content.
  Submitted changes create new revisions in a history log, which can be accessed to review individual revisions or restore content from a specific point in time.

  Content consists primarily of text files for the convenience of VCS, however it might include binary (e.g. media) files as well.
  System understand text file changes and can display revision differences in lines of text.
  In the case of binary files, system does not need to interpret or visualize differences for the changes in binary files.

  The system will provide convenient editing interface for text files in *supported markup* in form of a specialized editor.

 - F-4\. **Content browsing**

  Users can browse published content; this action may or may not require authorization based on current ACL for WUI.
  Authorized users can access repository directly via SSH.

  WUI provides interface for repository file browsing relevant to given (or current by default) repository revision,
  as well as search, file preview and list of available revisions with their changes.
  File preview in *supported markup* will interpret the markup and display rendered document.

 - F-5\. **Authorization management**

  With sufficient authorization or administration access, user can edit ACL for given repositories.
  For each registered user and individual repository a read write access can be explicitly allowed or disallowed.

## Non-functional requirements

- NF-1\. **Storage**

  The system will store all data only in a set of git[@git] repositories on single server machine.
  That includes the wiki content itself as well as e.g. ACL.
  System might use the server's FS for reasonable exceptions (SSH keys, cache files etc.)

- NF-2\. **UI**

  The system will provide WUI as well as an SSH direct access to git repositories.
  For non-trivial administration tasks CLI is offered (e.g. adding user).
  System's CLI should not substitute simple git commands.

- NF-2\. **Platform**

  The system will be implemented in JS (web interface) and Node.js (server-side).


# Use case model

## Actors

![Use case actors](./src/assets/diagram/actors){#fig:uc:actors}

@fig:uc:actors

TODO DESCRIBE ACTORS

## Browsing

![caption](./src/assets/diagram/browsing){#fig:uc:browsing width=100%}

@fig:uc:browsing

- UC\. **Git remote access**

  User remotely modifies git repository via SSH standard git interface.
  The power of the following editing interaction is limitless and not related to described system, for the changes happen at user's local station.

  The user's interaction falls into one of the following commands (or their similar or related)

  1. `git clone` for local repository mirror initialization,
  1. `git pull`, `git fetch` for local mirror updates,
  1. and `git push` for publishing local changes.

  If user is not registered and tries to access a private repository^[Meaning any repository with restricted access for given operation for individual user], operation is not permitted.

- UC\. **Change content**

  User if user is not authenticated or unauthorized to perform edits on given repository, use case scenario ends.

  User performs any number of *Edit contents* and *Manage files* use cases in any order.

  User must perform *Create a revision* use case to complete scenario.

- UC\. **Edit contents**

  TODO DESCRIBE MARKUP EDITING

- UC\. **Manage files**

  TODO DESCRIBE CRUD FILES, FILE RENAMING

- UC\. **Manage files**

  TODO DESCRIBE REVISION CREATION
