# Authentication

In previous chapter I implied I would use GitHub OAuth 2 for authentication.
The reader might assume that I bound or tailor the project to GitHub specific needs.

At first I would like to annihilate this false conclusion.
I use GitHub authentication as a form of authentication, but it does not mean that this sets course of the project in any major way.
The same way, any form of external authority could be used as an authentication provider.
I will not deny that any SCM service^[Though including GitLab, BitBucket and similar] is more suitable for authentication provider, because it provides user's SSH public keys if setup properly.

In the same manner I could have used Google, Yahoo or any other service with OAuth or OpenID protocol support.
GitHub is a reasonable choice in scope of OSS projects hosting statistics

![Analysis: Authentication via external provider](./src/assets/diagram/login){#fig:design:auth width=100%}


The sequence diagram @fig:design:auth displays the authentication process using external authority.
Provided that the authority has SSH public key of user, setting up the new user for using Gitolite can be automated within the first login.
The diagram follows the basics of OAuth 2.
After user selects the authority, e.g. GitHub, request is sent to application back-end, which makes an authorize request for given authority, doing which it provides required scopes of authorization.
The scope names are arbitrary and specific to each provider, thus configured in application -- the names of scopes in diagram are purely illustrative.
The authority redirects user to a page with a HTML form, where user logs in and authorizes Gitwiki for given scopes.
After submitting the form back to authority, it is processed and returned to callback URI, the back-end endpoint, whence the application finishes the authentication process acquiring the access token.
That can be used to fetch user data.
Provided that the authority has means of obtaining user's SSH keys, they are retrieved.
User info is stored with either username from the user data, or in case of lack of such data or conflict with existing user, a generated one.
User is stored with this Gitolite username and its keys as well.