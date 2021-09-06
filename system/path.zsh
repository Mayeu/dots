#!/bin/sh

# BIN_DIR
# My bin directory
export BIN_DIR="${HOME}/.bin"

# PATH
#  - my local `bin` first
#  - the GNU bin folder
#  - Homebrew specific override
#  - yarn `bin` folder
#  - the rest of the PATH
export PATH="${BIN_DIR}:/usr/local/opt/mysql-client/bin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/gnu-getopt/bin:{$HOME}/.yarn/bin:/usr/local/sbin:$PATH"

# MANPATH
#  - include homebrew man
export MANPATH="/usr/local/share/man:$MANPATH"

# XDG config
# Some apps (mostly linux oriented) expect XDG* variable to be set, and don't follow
# the defaults in the specs
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"
