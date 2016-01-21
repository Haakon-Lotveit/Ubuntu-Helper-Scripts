#!/bin/bash

#
# Downloads Emacs customizations from my github repo and links it properly.
#

pushd ~

rm -rf .emacs.d

#link
ln ~/git/emacs-lisp-odds-and-sods/dotemacsdotd ~/.emacs.d --symbolic

popd

