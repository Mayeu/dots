# Stop the reading of the file if non-interactive case
case $- in *i*) ;; *) return;; esac

# Load git completion
if [ -f /usr/share/git/completion/git-completion.bash ] ; then
   source /usr/share/git/completion/git-completion.bash
fi

# Load git prompt
if [ -f /usr/share/git/completion/git-prompt.sh ] ; then
   source /usr/share/git/completion/git-prompt.sh
fi

# Load all other local completion
if [ -d ~/etc/bash_completion.d ] ; then
   for file in `ls ~/etc/bash_completion.d` ; do
      source ~/etc/bash_completion.d/$file
   done
fi

# GPG agent
# ---------

if [ -f "${HOME}/.gnupg/gpg-agent.env" ]; then
   . "${HOME}/.gnupg/gpg-agent.env"
   export GPG_AGENT_INFO
   export GPG_TTY=$(tty)
   export SSH_AUTH_SOCK
   export SSH_AGENT_PID
fi

## bash history config
shopt -s histappend # as inside vim
PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoredups #ignore duplicate command in history
export HISTSIZE=10000
#export HISTIGNORE='&:[bf]g:exit:history*:rm*:cl:clear:resource:source*' #ignore some command
export HISTIGNORE='exit'

## default editor
export EDITOR=vim
export SVN_EDITOR=vim

## Path variable
export PATH=~/.gem/ruby/2.1.0/bin:~/script/:~/script/python/:~/bin/:/usr/bin/vendor_perl/:$PATH

# Go
export GOPATH=~/go
export PATH=$PATH:/usr/lib/go/site/bin

## Ledger
export LEDGER_FILE=~/account.ldg

# LS_Option
export LS_ARG='--color=auto'

## Alias
alias pseg='ps -e | grep '
alias l='ls -F ${LS_ARG}'
alias la='ls -FAC ${LS_ARG}'
alias ll='ls -Fl ${LS_ARG}'
alias lla='ls -FlA ${LS_ARG}'
alias ls='ls -F ${LS_ARG}'
alias d='date'
#alias cd='set old="$cwd"; chdir \!*'
#alias back='set back="$old"; set old="$cwd"; cd "$back"; unset back; dirs'
alias j='jobs -l'
alias resource='source ~/.bashrc; clear;'
alias cl='clear'
#alias z       suspend
alias x='exit'
alias pd='pushd'
alias pd2='pushd +2'
alias pd3='pushd +3'
alias pd4='pushd +4'
alias g='git'
alias n='notes'
alias tstamp='date +%s'

# Vim alias
alias vi="vim"
alias :e="vim"

# lp
alias lpstep1='lp -o page-set=odd -o outputorder=reverse'
alias lpstep2='lp -o page-set=even -o outputorder=reverse'

# More is less
alias more='less'

# Alias Ruby
alias r='ruby'
alias ra='rails'
alias beep='bundle exec pry'
alias beer='bundle exec rails'

# Alias & PATH haskell
alias rh='runhaskell -Wall -Werror'
PATH=~/.cabal/bin/:$PATH

# Alias elixir
alias mdg='mix deps.get && mix deps.compile'

# Alias go
alias gr='go run'

# Keyboard alias
alias kdvp='setxkbmap -layout us -variant dvp -option compose:caps -option keypad:atm -option numpad:shift3 -option kpdl:semi'
alias kus='setxkbmap -layout us'

# Host specific
############### Argon ################
if [ `hostname` == "cthulhu" ] ; then
   # PATH
   export PATH=$PATH:~/.cabal/bin
   # CDPATH
   export CDPATH=$CDPATH:~/code/
fi

# Calc shit
calc() { echo "scale=4; $*" | bc -l; }

## Prompt
GIT_PS1_SHOWDIRTYSTATE=true
hostnam=$(hostname)
usernam=$(whoami)
#PIPE="\[\033[1;30m\]"
NCOL="\[\033[0m\]"

function prompt_command {

if [[ $? != 0 ]] ; then
   PIPE="\[\033[0;31m\]"
else
   PIPE="\[\033[1;30m\]"
fi

#   Find the width of the prompt:
TERMWIDTH=${COLUMNS}

#   Add all the accessories below ...
local temp="--(${usernam}@${hostnam}:${PWD})---$(__git_ps1 | sed -e 's/ (\(.*\))/\1/')--(xx:xx)--"

let fillsize=${TERMWIDTH}-${#temp}
if [ "$fillsize" -gt "0" ]
then
   fill="qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
   #   It's theoretically possible someone could need more 
   #   dashes than above, but very unlikely!  HOWTO users, 
   #   the above should be ONE LINE, it may not cut and
   #   paste properly
   #   q because in octal q give a nice dash :)
   fill="${fill:0:${fillsize}}"
   newPWD="${PWD}"
fi

if [ "$fillsize" -lt "0" ]
then
   fill=""
   let cut=3-${fillsize}
   newPWD="../${PWD:${cut}}"
fi

export PS1="\n$PIPE\[\033(0\]lu\[\033(B\]$NCOL\
\u@\h:\${newPWD}\
$PIPE\[\033(0\]tqu\[\033(B\]$NCOL\$(__git_ps1 | sed -e 's/ (\(.*\))/\1/')$PIPE\[\033(0\]t\${fill}\[\033(B\]\[\033(0\]u\[\033(B\]$NCOL\
\$(date +%H:%M)\
$PIPE\[\033(0\]tq\[\033(B\]$NCOL\
\n$PIPE\[\033(0\]mqu\[\033(B\]$NCOL"
export PS2="  $PIPE\[\033(0\]x\[\033(B\]$NCOL"
}

PROMPT_COMMAND=prompt_command

# Make bash check its window size after a process completes
shopt -s checkwinsize

# Load private dots
if [ -f ~/.priv_dots ] ; then
   source ~/.priv_dots
fi
