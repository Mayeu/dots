#! /usr/bin/env bash
# Don't edit that file for your local environment, create a env.local.sh file
# instead and overwrite anything there.

##
#  Required variable
##

## Section ##

# Var description
#export VAR=

##
#  Optional variable
##

##
# Load personal env.local.sh override
##
if test -e env.local.sh; then
  source env.local.sh
fi

##
# Aliases
##

# Here we define a set of alternative name for variable, useful when the same token should be used with a different name
# Those alias MUST be set after any local overwrite

# export NEW_VAR="$VAR"
