# Requirements model

Since the system tackles both web application as well as SSH access to repositories, it provides two UIs.
The former shall be referred to as WUI and latter as CLI.

## Functional requirements

Wiki system works with text files formatted in a specific markup syntax.
System must provide support for Asciidoc[@asciidoctor] and Markdown[@gruber:markdown] and must allow extensibility for other LMLs.
The set of at least two mentioned LMLs possibly extended by additional ones will be referred to as *supported markup*.

 - F-1\. **Authentication**

  User authenticates via external authority.
  After successful authentication, system provides means for user to upload their public SSH key to unlock CLI.

 - F-2\. **Authorization**

  Each authenticated user accessing the system is denied or allowed access according to current ACL settings respectively, regardless the used interface.
  Authentication methods may very for the WUI and CLI access, but the authorization layer's behavior is consistent in this matter.

 - F-3\. **Content management**

  Authorized users can manage the wiki's contents.
  Users can preform general CRUD operations on any content, based on their authorization level.

  The system uses VCS to track changes in the content.
  Submitted changes create new revisions in a history log, which can be accessed to review individual revisions or restore content from a specific point in time.

  The content consists primarily of text files for the convenience of VCS, however it might include binary (e.g. media) files as well.

  The system will provide convenient editing interface for text files in *supported markup* in form of a specialized editor.

  It is not necessary, nor desired to cover all possible user interaction in WUI.
  The paramount priority is to offer editing interface for *supported markup*.

 - F-4\. **Content browsing**

  Users can browse published content; this action may or may not require authorization based on current ACL for WUI.
  Authorized users can access repository directly via CLI.

  WUI provides interface for repository file browsing relevant to the given (or current by default) repository revision,
  as well as a search, a file preview and a list of available revisions with their changes.
  File preview in *supported markup* will interpret the markup and display a rendered document.

 - F-5\. **Authorization management**

  With the sufficient authorization access, user can edit ACL for selected repositories.
  For each registered user and individual repository a read write access can be explicitly allowed or disallowed.

## Non-functional requirements

- NF-1\. **Storage**

  The system will store all the data only in a set of Git [@git] repositories on single server machine.
  That includes the wiki's content itself as well as e.g. ACL.

  The system may use other technologies for other data than wiki's contents and ACL when convenient for e.g. cache, session management etc.

- NF-2\. **UI**

  The system will provide WUI as well as an SSH direct access (CLI) to Git repositories.

- NF-2\. **Platform**

  The system will be implemented in JS (the web client interface) and Node.js (server-side).
