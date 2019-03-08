#!/bin/sh

# PATH
#  - my local `bin` first
#  - the GNU bin folder
#  - Homebrew specific override
#  - yarn `bin` folder
export PATH="${HOME}/bin":"/usr/local/opt/mysql-client/bin":"/usr/local/opt/make/libexec/gnubin":"/usr/local/opt/gnu-getopt/bin":"$HOME/.yarn/bin":$PATH

# MANPATH
#  - include homebrew man
export MANPATH="/usr/local/share/man:$MANPATH"
