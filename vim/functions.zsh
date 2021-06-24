#! /usr/bin/env bash

# zim
#
# Usage: zim <pattern>
#
# Open in vim the first match of z with the given pattern

zim() {
  local target
  target="$(z -e "$1")"

  cd "$target"
  vim "$target"
}
