# Use case model

## Actors

![Use case model: Actors](./src/assets/diagram/actors){#fig:uc:actors height=60%}

The system in general recognizes three types of users. The role hierarchy is illustrated on diagram @fig:uc:actors.

1. Anonymous user

  Anonymous user can browse or even contribute to a public repository if it's authorization policy allows that, but only via WUI.

2. Authenticated user

  Authenticated user can browse or even contribute to a public or private repository if it's authorization policy allows that, via WUI or CLI.

3. Administrator

  Administrator is an authenticated user with write access to a specific repository holding the access control policy.

## Browsing

![Use case model: Browsing](./src/assets/diagram/uc-browsing){#fig:uc:browsing width=80%}

Diagram @fig:uc:browsing displays use cases for browsing section.

- UC-1 **Git remote access**

  User remotely modifies git repository via the SSH standard Git interface.
  The power of the following editing interaction is limitless and not related to described system, for the changes happen at user's local workstation.

  The user's interaction falls into either of category:

  1. Read operations (`clone`, `fetch`, `pull` etc.)
  1. Write operations (`push` and its variations)

  If user is not authenticated and tries to access any repository (Including the public ones)^[Necessity of this restriction has been discussed earlier in section _User access_], operation is not permitted.

- UC-2 **Sign in**

  User can authenticate through external authentication provider. If external provider has user's public key (e.g. GitHub, GitLab, etc.) and is available, on first sign in, the key is paired and CLI becomes available.

- UC-3 **Traverse tree**

  User can list files in currently selected repository. File names are visible and file types, if known are distinguishable in the list.

  If list item is a directory, user can select the item to move to the directory sublist.

  In same manner, user can traverse the tree back to root folder.

- UC-4 **Show file**

  User can display contents of the text file. If the file is in _supported markup_ format, rendered document is available.

  Binary file preview is not necessary.

- UC-5 **Select repository**

  User can select active repository. This will affect the _Traverse tree_ UC.
  
- UC-6 **Select revision**

  User can select active revision for selected repository. This will affect the _Traverse tree_ and _Show file_ UC.


## Content management

![Use case model: Content management](./src/assets/diagram/uc-content){#fig:uc:content width=100%}

Diagram @fig:uc:content displays use cases for content management section.

- UC-7 **Change content**

  If user is not authenticated or unauthorized to perform edits on given repository, use case scenario ends.

  User performs any of *Edit contents* and *Manage files* use cases in any order.

  User must perform *Create a revision* use case to complete scenario.

- UC-8 **Edit contents**

  User is presented an interactive editor, if editing is file is in *supported markup*, with specialized features for given language.

  If file is not in *supported markup* format and is a text file, user can edit its contents in simple text area.
  Otherwise, editing is not possible.

  User edits the contents of the file.
  When they are done, they submit the results.

- UC-9 **Manage files**

  User can rename, edit or delete files in the repository if they are given access.

- UC-10 **Create revision**

  User types a descriptive short message to describe his revision.
  User confirms revision.


## Access control

![Use case model: Access control](./src/assets/diagram/uc-access){#fig:uc:access width=80%}

Diagram @fig:uc:access displays use cases for user access control section.

- UC-11 **Manage user access permissions**

  Administrator can edit special repository containing authorization policy.
  In this file they can create user groups, grant or revoke access to repositories and their namespaces on read and write levels.

# Use case - functional requirements coverage

Use cases are mere elaboration and further specification of functional requirements, with detailed interaction of the user and the system.
Therefore by definition, all use cases should shape at least one functional requirement, and each functional requirement should be implemented by at least one use case.

![Use case - functional requirements coverage](./src/assets/diagram/uc-req){#fig:uc:req height=100%}

Diagram proves @fig:uc:req proves that it is so.