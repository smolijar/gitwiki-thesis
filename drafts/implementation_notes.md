### Implementace (neformalne)

#### Autorization layer

**Gitorious** zapadl 2015 pod Gitlab, https://about.gitlab.com/2015/03/03/gitlab-acquires-gitorious/

**Gitlab** je mozna pro nase pouziti prilis slozity, zatim jsem nenasel, jestli ma nejakou lightweight verzi, nebo jestli jde s webovym rozhranim. Potrebuje databazi.
Ma gitlab-shell, coz je cool, ale je to ne-naplno vyuzitelnej gigant.

**Gitolite** je asi nejvhodnejsi, vse ma textove, konfigurace vypada citelne. Splnuje to nejvice pozadavek na jednoduchost a pruhlednost na prvni pohled.

#### SSH GIT server

Existuji implementace typu https://www.npmjs.com/package/git-ssh-server (3 roky stary), ale asi to vubec neni treba resit. Eventy nejsou treba.