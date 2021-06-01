#! /usr/bin/env zsh

# zim
#
# Usage: zim <pattern>
#
# Open in vim the first match of z with the given pattern

function zim {
  vim "$(z -e "$1")"
}
