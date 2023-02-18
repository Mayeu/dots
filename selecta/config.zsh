#! /usr/bin/env zsh

# z & selecta integration
# if selecta is present, set that as the default behaviour of z command
# https://gist.github.com/paulbellamy/274860335ba4c6661f859a118852b9be
#if which ${_Z_CMD:-z} 2>&1 1>/dev/null && which selecta 2>&1 1>/dev/null; then
#  z_selecta() {
#    if [ $# -gt 0 ]; then
#      _z "$@" 2>&1
#    else
#      _z "$(_z |& awk '{print $2}' | selecta)" 2>&1
#    fi
#  }
#  alias ${_Z_CMD:-z}='z_selecta'
#fi
