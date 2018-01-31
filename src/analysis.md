# Analysis

## Requirements model


### Functional requirements

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

  With sufficient authorization, or administration access, user can edit ACL for given repositories.
  For each registered user and individual repository a read write access can be explicitly allowed or disallowed.
