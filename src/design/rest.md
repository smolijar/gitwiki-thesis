# RESTful API

In this section the crucial parts of the RESTful API of the BE application are documented.

For the type definition in this chapter, the Flow type alias [@flow:alias] syntax is used.
Since some object types are reused in the data, common _entity_ types are described in the listing \ref{lst:design:types}.

The overall overview of the API is presented in the table \ref{tbl:design:rest}.
The following subsections describe the individual API endpoints.
Only parts of the API that are interesting from the perspective of either data or design are covered in the chapter.
The major logical issue is the design of a commit creation in REST architecture, which is discussed later in the section.

```{language=ts caption="Entity types definitions" label="lst:design:types"}
type Entry = {
  name: string, // "README.md"
  path: string, // "path/to/README.md"
  isDirectory: bool, // false
  sha: string, // "673d6dcc58fdd8ef6530177ef90bb2c5d1748c34"
};
type Blob = Entry & {
  content: string, // "# Hello world\n\ntodo"
}
type Reference = {
  ref: string, // "refs/remotes/origin/master"
  group: string, // "remotes"
  name: string, // "master"
  compoundName: string ,// "origin/master"
}
type Change = {
  path: string, // "path/to/README.md"
  content: string, // "new content"
  remove?: bool,
}
type Repository = {
  name: string, // "gitwiki"
  description: string, // "Git based wiki system"
  provider: string, // "github"
}
```

\begin{table*}[]\centering
\caption{RESTful API overview}\label{tbl:design:rest}
\csvautobooktabular{src/design/rest/all.csv}
\end{table*}



## Tree

### `GET /api/v1/repos/{provider}/{name}/tree/{ref}/{path}`

```{language=ts caption="REST: GET Tree response" label="lst:design:tree:return"}
{
  tree: Array<Entry>, // Current tree
  blob?: Blob, // Current blob entry with content
}
```
\begin{table*}[]\centering
\caption{REST: GET Tree response codes}\label{tbl:design:rest:tree:get:res}
\csvautobooktabular[separator=semicolon]{src/design/rest/tree.csv}
\end{table*}

The tree defined by the relative path `{path}` from repository `{name}` from provider `{provider}` at Git reference `{ref}` is returned.
The response JSON structure is defined in the listing \ref{lst:design:tree:return}.
Its response codes are displayed in the table \ref{tbl:design:rest:tree:get:res}

### `PATCH /api/v1/repos/{provider}/{name}/tree/{ref}/{path}`

```{language=ts caption="REST: PATCH Tree request body" label="lst:design:tree:body"}
{
  changes: Array<Change>, // Changes to commit
  message: string, // commit message
}
```

A Git commit with supplied changes and given commit message on the repository defined by the request's URL as in the previous example is created.
Use user's credentials as _commiter_ and _author_ from `Authorization` header.

The `PATCH`^[The `PATCH` method does not have as strictly defined semantics by the conventions in the RESTful APIs unlike methods `POST`, `PUT` or `DELETE`, which could be used instead.] is unusual with regard to RESTful APIs.
However, there is a very special scenario calling for special solution, which is the `PATCH` method.
If a `POST` method would be invoked on the tree instead, its semantics would be *creating* a tree and _not_ updating (following the RESTful conventions).
Updating (and creating alike) could be achieved by using a `PUT` method.
When using `PUT` or `POST` however, it is expected to provide the resource, in this case the tree (not _changes_).
Following the conventions, the `DELETE` method should be used only for the rare case of only removing a single file or subtree.
This concept is very confusing and allows only one change per commit.

Using `POST` on a resource `/commits`^[Hypothetical idea, the resource does not exist in the API] allows to perform multiple changes in one commit.
However the commit data are not available in the FE.
What is available, is a sequence of changes describing the commit.
Thus using `POST` is again not an ideal solution with regard to RESTful API.
Instead a `PATCH` is used.

The JSON structure of the request body is defined in the listing \ref{lst:design:tree:body}.
Its response codes are in the table \ref{tbl:design:rest:tree:get:res} (ditto).

### `GET /api/v1/repos/{provider}/{name}/refs`

```{language=ts caption="REST: GET Refs response" label="lst:design:refs:res"}
Array<Reference>
```

Retrieve the available refs from the repository defined by the URL.
The JSON structure of the response is defined in the listing \ref{lst:design:refs:res}.
Its response codes are listed in the table \ref{tbl:design:rest:tree:get:res} (ditto).

## Repository

The repository section contains an endpoint for listing the available repositories.
It has standard return codes as discussed in the previous endpoints (excluding 404) and returns JSON of `Array<Repository>` as defined in the listing \ref{lst:design:types}.

## Auth

Auth section provides endpoints for fetching user data, the authentication via GitHub and uploading GitHub personal access token, which is used for cloning GitHub repositories via HTTPS.
