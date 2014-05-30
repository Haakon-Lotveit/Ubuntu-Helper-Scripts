#!/bin/bash

######################################################################
# Sets up git, and downloads some stuff from my github repositories. #
# You might want to change things around for your own purposes.      #
# Specifically the name and email vars.                              #
######################################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


USER='Haakon Løtveit'
EMAIL='haakon_lotveit@live.no'
GIT_HOME="/home/haakon/git"

git config --global user.name "$USER"
git config --global user.email "$EMAIL"
git config --global push.default matching


# In order to build the gnome-keyring credential helper,
# we need the associated libs, then we need to build it by hand/make
# and then we can set up everything to just work beautifully.
apt-get install libgnome-keyring-dev --assume-yes

pushd /usr/share/doc/git/contrib/credential/gnome-keyring > /dev/null
make
popd > /dev/null
git config --global credential.helper\
    /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

if [ ! -d "$GIT_HOME" ]; then
    mkdir -p -- $GIT_HOME
fi


