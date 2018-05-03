# REST API

In this section I shall document crucial parts of the REST API of BE application.

For type definition I use Flow type alias[@flow:alias] syntax.
For some objects types are reused, common _entity_ types are described in listing \ref{lst:design:types}.

The overall overview of the API is presented in the table \ref{tbl:design:rest}.

The following subsections will describe the individual API endpoints.


For the most part, there is nothing surprising in the majority of the API.
Thusly I shall only cover the sections of API that are interesting from the perspective of data or design.

The only major problem with the design was to design a commit creation in REST architecture, which is perhaps not as straightforward as it seems it the first glance.

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
\caption{REST API overview}\label{tbl:design:rest}
\csvautobooktabular{src/design/rest/all.csv}
\end{table*}



## Tree

### `GET /api/v1/repos/<provider>/<name>/tree/<ref>/<path>`

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

The tree defined by relative path `<path>` from repository `<name>` from provider `<provider>` at Git reference `<ref>` is returned.
The response JSON structure is defined in the listing \ref{lst:design:tree:return}.
Its response codes are in the table \ref{tbl:design:rest:tree:get:res}

### `PATCH /api/v1/repos/<provider>/<name>/tree/<ref>/<path>`

```{language=ts caption="REST: PATCH Tree request body" label="lst:design:tree:body"}
{
  changes: Array<Change>, // Changes to commit
  message: string, // commit message
}
```

Create a Git commit with supplied changes and given commit message on the repository defined by the request's URL as in previous example.
Use user's credentials as _commiter_ and _author_ from `Authorization` header.

It might be objected that using `PATCH`^[`PATCH` method semantics has far more relaxed specification compared to methods `POST`, `PUT`, `DELETE`, which could be used instead.] is impure with regard to REST.
However, there is a very special scenario calling for special solution, which is the `PATCH` method.
If `POST` method was to be used on the tree, it would semantically only creating tree (or subtree at given path) and _not_ updating.
Updating could be achieved by `PUT` on the tree, but then in the request the whole new subtree would need to provided.
Not to mention that `DELETE` method should be used for the exotic case or only removing a single file or subtree.
This concept is very confusing and allows only one change per commit.

Using `POST` on a resource `/commits`^[Hypothetical idea, the resource does not exist in the API] would allow to perform multiple changes in one commit.
However the commit data are not available in the FE.
What is available, is a sequence of changes on the tree describing the commit, then it cannot really be created via `POST` method.
Instead a `PATCH` is used.

The request body JSON structure is defined in the listing \ref{lst:design:tree:body}.
Its response codes are in the table \ref{tbl:design:rest:tree:get:res} (ditto).

### `GET /api/v1/repos/<provider>/<name>/refs`

```{language=ts caption="REST: GET Refs response" label="lst:design:refs:res"}
Array<Reference>
```

Get available refs from repository defined by URL.
The response JSON structure is defined in the listing \ref{lst:design:refs:res}.
Its response codes are in the table \ref{tbl:design:rest:tree:get:res} (ditto).

## Repository

Repository section contains endpoint for listing the available repositories.
It has standard return codes as discussed in previous endpoints (excluding 404) and returns JSON `Array<Repository>` as defined in listing \ref{lst:design:types}.

## Auth

Auth sections provides endpoints for fetching user data, authentication via GitHub and uploading GitHub personal access token, which is used for cloning GitHub repositories via HTTPS.