#! /usr/local/bin/zsh

# Go in the dots folder
alias dots="pushd ${DOTFILES}"

# Upload something to my fav paste service
alias paste.cccp.io="${BIN_DIR}/goploader --lifetime=1w"

# Get the current week number
alias weeknumber="date +%V"

# Jump to my infrastructure project
alias zi="z infra"

# Mount the local media-center
alias media-mount="sshfs m@purism:/media/nas/nas /Users/Shared/media-center"
