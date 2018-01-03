# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# if running bash
if [ -n "$BASH_VERSION" ]; then
   # include .bashrc if it exists
   if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
   fi
fi

# Load nix environment
. /Users/m/.nix-profile/etc/profile.d/nix.sh

if [ -e /home/m/.nix-profile/etc/profile.d/nix.sh ]; then . /home/m/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

