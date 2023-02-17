#!/bin/sh

# Offline friendly update time
export HOMEBREW_AUTO_UPDATE_SECS=86400
# Nope
export HOMEBREW_NO_ANALYTICS=1

eval "$(/opt/homebrew/bin/brew shellenv)"
