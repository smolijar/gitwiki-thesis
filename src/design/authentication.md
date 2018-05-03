# Authentication

In the previous section I implied I would use GitHub OAuth 2 for authentication.
The reader might assume that by that I bound or tailored the project to GitHub's specific needs.

At first I would like to annihilate this false conclusion.
I use GitHub authentication as a form of authentication, but it does not mean that this sets course of the project in any major way.
The same way, any form of external authority could be used as an authentication provider.
I will not deny that any SCM service^[Though including GitLab, BitBucket and similar] is more suitable for authentication provider, because it provides the user's SSH public keys if setup properly.

In the same manner I could have used Google, Yahoo or any other service with OAuth or OpenID protocol support.
GitHub is a reasonable choice in scope of OSS projects hosting statistics.

![Design: Authentication via external provider](./src/assets/diagram/login){#fig:design:auth width=100%}


The sequence diagram @fig:design:auth displays the authentication process using external authority.
Provided that the authority has SSH public key of the user, setting up the new user for using Gitolite can be automated within the first login.
The diagram follows the basics of OAuth 2.
After the user selects the authority, e.g. GitHub, a request is sent to application's BE, which makes an authorization request for the given authority, doing which it provides required scopes of the authorization.
The scope names are arbitrary and specific to each provider, thus configured in the application -- the names of the scopes in the diagram are purely illustrative.
The authority redirects the user to a page with a HTML form, where the user logs in and authorizes Gitwiki for given scopes.
After submitting the form back to the authority, it is processed and returned to the defined callback URI, the BE endpoint, whence the application finishes the authentication process acquiring the access token.
That can be used to fetch the user data.
Provided that the authority has means of obtaining the user's SSH keys, they are retrieved.
The user info is stored with either username from the user data, or in the case of lack of such data or conflict with the existing user, a generated one.
The user is stored with his Gitolite username and its keys as well.