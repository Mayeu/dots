#!/bin/sh
nix(){ nix-env -qa \* -P | fgrep -i "$1"; }
