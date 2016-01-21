#!/bin/bash

#
# Downloads Emacs customizations from my github repo and links it properly.
#


pushd .. > /dev/null
git clone https://github.com/Haakon-Lotveit/emacs-lisp-odds-and-sods

pushd emacs-lisp-odds-and-sods > /dev/null
chmod +x ./setup.sh
. setup.sh

popd > /dev/null
popd > /dev/null

pushd ~

rm -rf .emacs.d

# create a symbolic link
ln ~/git/emacs-lisp-odds-and-sods/dotemacsdotd ~/.emacs.d --symbolic

popd

