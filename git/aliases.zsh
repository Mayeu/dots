#!/bin/sh
#if command -v hub >/dev/null 2>&1; then
#  alias git='hub'
#fi

alias g='git'
#alias gl='git pull --prune'
alias gpu='git pull --prune'
alias glg="git log --graph --decorate --oneline --abbrev-commit"
alias glog='glg'
alias glga="glg --all"
alias gp='git push'
alias gpa='git push origin --all'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch -v'
alias ga='git add'
alias gap='git add -p'
#alias gaa='git add -A'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gs='git status'
#alias gs='git status -sb'
#alias gpr='gp && git pr'
#alias glnext='git log --oneline $(git describe --tags --abbrev=0 @^)..@'
alias gfa='git fetch --all'
alias grrf='git rm -rf'

#if command -v svu >/dev/null 2>&1; then
#  alias gtpatch='echo `svu p`; git tag `svu p`'
#  alias gtminor='echo `svu m`; git tag `svu m`'
#fi

gi() {
	curl -s "https://www.gitignore.io/api/$*"
}
