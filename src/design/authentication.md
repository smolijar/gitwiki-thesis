# Authentication

In the previous section it is implied that GitHub OAuth 2.0 is used for the authentication.
That however does not bind the project to GitHub's specific needs.

The GitHub authentication is used as a form of authentication, but it does not set course of the project in any major way.
The same way, any form of external authority can be used as an authentication provider.
Any SCM service^[Including GitLab, BitBucket and similar] is more suitable for the role of the authentication provider, because they provide the user's SSH public keys.

In the same manner Google, Yahoo or any other service with OAuth 2.0 or OpenID Connect protocol support could be used instead.
GitHub is a reasonable choice in the scope of OSS projects hosting statistics.

![Design: Authentication via external provider](./src/assets/diagram/login){#fig:design:auth width=100%}


The sequence diagram @fig:design:auth displays the authentication process of using an external authority.
Provided that the authority has the user's public key, setting up the new user for using Gitolite can be automated within the first login.
The diagram follows the basics of OAuth 2.0.
After the user selects the authority, e.g. GitHub, a request is sent to application's BE, which makes an authorization request for the given authority, doing which it provides required scopes of the authorization.
The scope names are arbitrary and specific to each provider, thus configured in the application -- the names of the scopes in the diagram are purely illustrative.
The authority redirects the user to a page with a HTML form, where the user logs in and authorizes Gitwiki for the given scopes.
After submitting the form back to the authority, it is processed and returned to the defined callback URI, the BE endpoint, whence the application finishes the authentication process, acquiring the access token.
The token can be used to fetch the user data.
Provided that the authority has means of obtaining the user's SSH keys, they are retrieved.
The user info is stored with either username from the user data, or a generated one, in the case of lack of such data or conflict with the existing user.
The user is stored with his Gitolite username and its keys as well.
