#!/bin/bash

###############################################################################
### Installs Eclipse in Ubuntu, from their own website, not via the repos   ###
### Procedure by "Shubhmay" on askubuntu.com				    ###
### http://askubuntu.com/questions/26632/how-to-install-eclipse             ###
### You run it as: sudo ./install-eclipse /path/to/eclipse/tarball.tar.gz   ###
###############################################################################

# We need root permissions for the script, so this checks for that.
# Taken from http://www.cyberciti.biz/tips/shell-root-user-check-script.html
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ $# -eq 0 ]
  then
      echo "You must supply a tarball to install from" 1>&2
      exit 1
fi

INSTALL_FOLDER=/opt
TARBALL_FULL="$1"
TAR_FILE=$(basename "$1")

echo "Installing eclipse from $TARBALL_FULL to $INSTALL_FOLDER"
# Step 1: Make the /opt folder
if [ ! -d "$INSTALL_FOLDER" ]; then
  mkdir "$INSTALL_FOLDER"
fi


# Step 2: Put the tarball there
cp $TARBALL_FULL $INSTALL_FOLDER

# Step 3: Go to the install folder
pushd $INSTALL_FOLDER > /dev/null
# Step 4: Extract the stuff
tar xf $TAR_FILE > /dev/null
# Step 5: Then remove the old tarball
rm $TAR_FILE

#Enter the install dir
pushd eclipse > /dev/null

# Step 6: Create the desktop file
# This is silly, but it works.
# Any existing file will be clobbered like a cute baby seal in Canada.
DESKTOP='eclipse.desktop'
echo > $DESKTOP
echo '[Desktop Entry]'                            >> $DESKTOP
echo 'Name=Eclipse'                               >> $DESKTOP
echo 'Type=Application'                           >> $DESKTOP
echo 'Exec=eclipse'                               >> $DESKTOP
echo 'Terminal=false'                             >> $DESKTOP
echo 'Icon=eclipse'                               >> $DESKTOP
echo 'Comment=Integrated Development Environment' >> $DESKTOP
echo 'NoDisplay=false'                            >> $DESKTOP
echo 'Categories=Development;IDE;'                >> $DESKTOP
echo 'Name[en]=Eclipse'                           >> $DESKTOP

# Step 7: Install the desktop file
desktop-file-install "$INSTALL_FOLDER/eclipse/$DESKTOP"

# Step 8: Make the symlink to /usr/local/bin
pushd /usr/local/bin > /dev/null
ln -s "$INSTALL_FOLDER/eclipse/eclipse"
popd > /dev/null

# Step 9: Copy over the icon (or just link it.)
cp $INSTALL_FOLDER/eclipse/icon.xpm /usr/share/pixmaps/eclipse.xpm

# We're now done in /opt or wherever, and can go home
popd > /dev/null
popd > /dev/null
