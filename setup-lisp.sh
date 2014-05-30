#!/bin/bash

#
# Sets up quicklisp and slime for use with emacs.
# Run this after running setup-emacs.sh
# This is just semi-automated
# Todo is to automate everything
#

wget http://beta.quicklisp.org/quicklisp.lisp > /dev/null

echo 'remember to call (ql:quickload "quicklisp-slime-helper")'
sbcl --load quicklisp.lisp

rm quicklisp.lisp
