#!/usr/bin/env zsh

function gtss() {
  gt stack submit
}

function gtsf() {
  gt stack restack
}

function gts() {
  gt repo sync --delete --restack
}
