#!/bin/bash

# Obviously, we need root permissions for the script, so this checks for that.
# Taken from http://www.cyberciti.biz/tips/shell-root-user-check-script.html
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

###############################################################################
### Before we begin installing stuff, set up some basic stuff, like         ###
### disabling the shopping suggestions from the lens. I'm not a fan. ;)     ###
###############################################################################

# Disable the shopping suggestions, etc.
source ./fixubuntu.sh

# Disable apport, so I don't get bothered with 400 "Crash reports"
# where nothing has crashed. This is supposed to be disabled when it has
# shipped, but it doesn't always. So I'll do it manually.
cat /etc/default/apport | sed s/enabled=1/enabled=0/g > /etc/default/apport 
service apport stop

###############################################################################
### Some of the programs we want are not in the normal repositories.        ###
### So we add more repos with PPAs. Which are a brilliant idea.             ###
### Thanks Canonical!                                                       ###
### After that, we update our package listings, install any upgrades,       ###
### agree to the EULAs of some companies (Oracle and MS), and then we're    ###
### _finally_ ready to go.                                                  ###
###############################################################################

echo 'Adding PPA repositories'
# New emacs and stuff
add-apt-repository ppa:cassou/emacs             --yes
# Oracle Java
add-apt-repository ppa:webupd8team/java         --yes
# FFMPEG support
add-apt-repository ppa:mc3man/trusty-media      --yes
# Global menu bar in Java GUIs.
add-apt-repository ppa:danjaredg/jayatana       --yes
# The GIMP (Green Is My Pepper) image editor
add-apt-repository ppa:otto-kesselgulasch/gimp  --yes

# Update to get hold of new listings.
# We might as well upgrade any out of date packages while we're at it.
echo 'Updating and upgrading system'
apt-get update
apt-get upgrade --assume-yes 

# We have to agree to licensing terms from Microsoft and Oracle.
# Babysitting this stuff defeats the purpose of automated installs.
# We want "Push play, walk away", not "Push play, then stay and watch".
echo 'Accepting EULAs without reading them'
echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' \
    | /usr/bin/debconf-set-selections
echo 'ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true' \
    | /usr/bin/debconf-set-selections

###############################################################################
### This is just one massive call to apt-get to install stuff.              ###
### There are comments breaking the packages into sections for a clearer    ###
### view of things. In the future, I may just put those things into their   ###
### own files or something, but I think the way it is now is easier to read ###
### and edit. When I install 6412 packages though, I'll source stuff out.   ###
###############################################################################

echo 'Installing software'
apt-get install \
ubuntu-restricted-extras    \
gnome-tweak-tool            \
unity-tweak-tool            \
libreoffice-style-sifr      \
ubuntu-wallpapers*          \
libappindicator1            \
gtk2-engines-murrine:i386   \
gtk2-engines-pixbuf:i386    \
sni-qt:i386                 \
synaptic                    \
tasksel                     \
rar                         \
p7zip                       \
libavcodec-extra            \
gstreamer0.10-plugins-good  \
gstreamer0.10-plugins-bad   \
gstreamer0.10-plugins-ugly  \
gstreamer1.0-plugins-good   \
gstreamer1.0-plugins-bad    \
gstreamer1.0-plugins-ugly   \
swi-prolog                  \
ghc ghc-doc                 \
sbcl sbcl-doc               \
r-base r-recommended        \
openjdk-7-jdk               \
openjdk-7-doc               \
icedtea-7-plugin            \
oracle-java7-installer      \
oracle-java8-installer      \
oracle-java8-set-default    \
virtualbox                  \
git-all                     \
build-essential             \
maven maven2                \
ant ant-doc                 \
emacs-snapshot-el           \
emacs-snapshot-gtk          \
emacs-snapshot              \
gimp gimp-data              \
gimp-plugin-registry        \
gimp-data-extras            \
texlive-full                \
--assume-yes        


