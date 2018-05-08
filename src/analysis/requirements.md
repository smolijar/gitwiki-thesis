# Requirements model

Since the system tackles both web application as well as the SSH access to the repositories, it provides two UIs.
The former is referred to as WUI and latter as CLI throughout the text.

## Functional requirements

Wiki system works with text files formatted in a specific markup syntax.
System must provide support for AsciiDoc [@asciidoctor] and Markdown [@gruber:markdown] and must allow extensibility for other LMLs using modules.
The set of at least two mentioned LMLs (possibly extended by additional ones) is referred to as *supported markup*.

 - F-1\. **Authentication**

  User authenticates via an external authority.
  After the successful authentication, system provides means for user to upload their public SSH key to unlock CLI.
  Alternatively the application retrieves the SSH public key from the authority provider.

 - F-2\. **Authorization**

  Each authenticated user accessing the system is denied or allowed access according to the current ACL settings respectively, regardless the used interface.
  The authentication methods may vary for the WUI and CLI access, but the behavior of the authorization layer is consistent.

 - F-3\. **Content management**

  Authorized users can manage the contents of the wiki.
  Users can preform general CRUD operations on any content, based on their level of authorization.

  The system uses VCS to track changes in the content.
  Submitted changes create new revisions in a history log, which can be accessed to review individual revisions or restore content from a specific point in time.

  The content consists primarily of text files for the convenience of VCS, however it might include binary (e.g. media) files as well.

  The system provides convenient editing interface for document files in *supported markup* format.
  This interface is provided by a specialized editor.

  It is not necessary, nor desired to cover all possible user interaction in WUI.
  The paramount priority is to offer editing interface for the *supported markup* documents.

 - F-4\. **Content browsing**

  Users can browse the published content; this action may or may not require authorization based on the current ACL for WUI.
  The authorized users can access repository directly via CLI.

  The WUI provides an interface for repository file browsing relevant to the current repository revision,
  as well as a file preview and a list of available revisions with their changes.
  File preview of the *supported markup* documents interprets the markup and displays a rendered document.

 - F-5\. **Authorization management**

  With the sufficient authorization access, user can edit ACL for the selected repositories.
  For each registered user and individual repository a read write access can be explicitly allowed or disallowed.

## Non-functional requirements

- NF-1\. **Storage**

  The system stores all the data only in a set of Git [@git] repositories on single server machine.
  That includes the contents of wiki itself as well as e.g. ACL.

  The system may use other technologies for other data when convenient for e.g. cache, session management etc.

- NF-2\. **UI**

  The system provides WUI as well as an SSH direct access (CLI) to the Git repositories.

- NF-3\. **Platform**

  The system is implemented in JS (the web client interface) and Node.js (server-side).
