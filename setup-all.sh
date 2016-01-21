#!/bin/bash

# Sets up everything, that is, calls all the scripts in a reasonable order.

#########################
# Step 1: Install stuff #
#########################

. initial-install.sh

#####################
# Step 2: Setup git #
#####################

. setup-git-stuff.sh

#######################
# Step 3: Setup emacs #
#######################

. setup-emacs.sh

echo "Eclipse and Lisp needs to be set up manually"
