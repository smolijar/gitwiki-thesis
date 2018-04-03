## Gitolite

### Installation guide
~~~{#lst:gitolite:ws .sh caption="Gitolite: Workstation setup"}
# install git
sudo apt-get install openssh-server git
# generate a keypair
ssh-keygen -t rsa -b 4096 -C "gitolite-admin" -f "$HOME/.ssh/gitolite-admin"
# copy the "~/.ssh/gitolite-admin.pub" to server
~~~

~~~{#lst:gitolite:srv .sh caption="Gitolite: Server setup"}
# install ssh server and git
sudo apt-get install openssh-server git

# create new `git` user with home directory and set password
sudo useradd -m git
sudo passwd git

# switch to git user
su - git

# download and install gitolite
cd $HOME
git clone https://github.com/sitaramc/gitolite
mkdir -p bin
gitolite/install -to $HOME/bin # use abs path in argument

# setup gitolite with copied admin key from workstation
$HOME/bin/gitolite setup -pk /tmp/gitolite-admin.pub


## PERSMISIONS
sudo chmod -R 0775 /home/git/

 ~ sudo groupadd gitolite
 ~ sudo usermod -a -G gitolite smolijar 
 ~ sudo chgrp -R gitolite /home/git/
 ~ sudo chmod -R 2775 /home/git/

# SET /etc/ssh/sshd_config StrictModes no
~~~

PRAVA PRO GITOLITE https://unix.stackexchange.com/questions/37164/ssh-and-home-directory-permissions

