#!/usr/bin/env zsh

function gtss() {
  gt submit --stack
}

function gtsf() {
  echo 'Nope, use gtr'
}

function gtr() {
  gt restack
}

function gts() {
  gt repo sync --delete --restack
}
