# Use case model

## Actors

![Use case model: Actors](./src/assets/diagram/actors){#fig:uc:actors height=60%}

The system in general recognizes three types of users.
The role hierarchy is illustrated in the diagram @fig:uc:actors.

1. Anonymous user

  The anonymous user can browse or even contribute to a public repository if its authorization policy allows that, but only via WUI.

2. Authenticated user

  The authenticated user can browse or even contribute to a public or private repository if its authorization policy allows that, via WUI or CLI.

3. Administrator

  The administrator is an authenticated user with write access to a specific repository holding the access control policy.

## Browsing

![Use case model: Browsing](./src/assets/diagram/uc-browsing){#fig:uc:browsing width=80%}

The diagram @fig:uc:browsing displays the use cases for the browsing section.

- UC-1 **Git remote access**

  User remotely modifies Git repository via the SSH standard Git interface.
  The power of the following editing interaction is limitless and not related to the described system, because the changes happen at the user's local workstation.

  The interaction of the user is either of the following types:

  1. Read operations (`clone`, `fetch`, `pull` etc.)
  1. Write operations (`push` and its variations)

  If the user is not authenticated and tries to access any repository (including the public ones)^[Necessity of this restriction has been discussed earlier in the section _User access_], operation is not permitted.

- UC-2 **Sign in**

  The user can authenticate through external authentication authority.
  If the authority provides access to the user's public key (e.g. GitHub, GitLab, etc.), on first sign in, the key is paired and CLI becomes available.

- UC-3 **Traverse tree**

  User can list files in the currently selected repository.
  File names are visible and recognized file types are distinguishable in the list.

  If list item is a directory, user can select the item to navigate to the directory sublist.
  In same manner, user can traverse the tree back to root folder.

- UC-4 **Show file**

  User can display contents of the text file.
  If the file is a _supported markup_ document, the rendered preview is available.

  The preview of binary files is not supported.

- UC-5 **Select repository**

  User can select a repository.
  This affects the _Traverse tree_ UC.

- UC-6 **Select revision**

  User can select a revision for the selected repository.
  This affects the _Traverse tree_ and _Show file_ UC.


## Content management

![Use case model: Content management](./src/assets/diagram/uc-content){#fig:uc:content width=100%}

The diagram @fig:uc:content displays the use cases for the content management section.

- UC-7 **Change content**

  If the user is not authenticated or unauthorized to perform edits on the selected repository, use case scenario ends.

  User performs any of the *Edit contents* or *Manage files* use cases in any order.
  User must perform the *Create a revision* use case to complete scenario.

- UC-8 **Edit contents**

  The user is presented an interactive editor.
  If user is editing a *supported markup* document, an editor with specialized features for the given language is provided.

  If the file is not a *supported markup* document yet it is a text file, user can edit its contents in simple textarea.
  Otherwise, the editing is not possible.

  The user edits the contents of the file.
  When they are done, they submit the results.

- UC-9 **Manage files**

  The user can rename, edit or delete files in the repository if they are given access.

- UC-10 **Create revision**

  The user types a descriptive short message to describe their revision.
  The user confirms the revision.


## Access control

![Use case model: Access control](./src/assets/diagram/uc-access){#fig:uc:access width=80%}

The diagram @fig:uc:access displays the use cases for the user access control section.

- UC-11 **Manage user access permissions**

  The administrator can edit a special repository containing the authorization policy.
  In this file they can create user groups, grant or revoke access on read and write levels to the existing repositories and their namespaces.

# Use case - functional requirements coverage

The use cases are a mere elaboration and further specification of the functional requirements, with detailed interaction of the user and the system.
Therefore by the definition, all use cases shape at least one functional requirement, and each functional requirement is implemented by at least one use case.

![Use case - functional requirements coverage](./src/assets/diagram/uc-req){#fig:uc:req height=100%}

The diagram proves @fig:uc:req proves that it is so.