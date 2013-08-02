# Stop the reading of the file if non-interactive case
case $- in *i*) ;; *) return;; esac

# Load git completion
if [ -f /usr/share/git/completion/git-completion.bash ] ; then
   source /usr/share/git/completion/git-completion.bash
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
export PATH=$PATH:~/.gem/bin:/home/mayeu/.gem/ruby/1.9.1/bin/:~/script/:~/script/python/:~/bin/:/usr/bin/vendor_perl/

## Ledger
export LEDGER_FILE=~/account.ldg

# Todo.txt config
export TODOTXT_DATE_ON_ADD=1
export TODOTXT_AUTO_ARCHIVE=0

# OS Specific
if [ `uname` == "Darwin" ] ; then
	LS_ARG='-G'
elif [ `uname` == "Linux" ] ; then
	LS_ARG='--color=auto'
fi

## Alias
alias pseg='ps -e | grep '
alias l='ls -F ${LS_ARG}'
alias la='ls -FAC ${LS_ARG}'
alias ll='ls -Fl ${LS_ARG}'
alias lla='ls -Fla ${LS_ARG}'
alias ls='ls -F ${LS_ARG}'
alias d='date'
alias mail='Mail'
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
alias h='heroku'
alias tstamp='date +%s'

# Old Arch alias 
#alias spotify='wine "C:\Program Files\Spotify\spotify.exe"'
#alias kc='killall chromium'
#alias xsset='xrandr --output LVDS1 --auto --output VGA1 --auto --right-of LVDS1'
#alias xsoff='xrandr --output LVDS1 --auto --output VGA1 --off'
#alias cp='vcp'

# Vim alias
alias vi="vim"
alias :e="vim"

# lp
alias lpstep1='lp -o page-set=odd -o outputorder=reverse'
alias lpstep2='lp -o page-set=even -o outputorder=reverse'

# Swatch
alias s='swatch'
alias so='swatch out'
alias sw='swatch what'

# Todo
alias t='todo.sh'

# Python
alias p='python'

# More is less
alias more='less'

# Alias Ruby
alias r='ruby'
alias ra='rails'
alias beep='bundle exec pry'
alias beer='bundle exec rails'

# Host specific
############### Argon ################
if [ `hostname` == "rifter" ] ; then

   if [ -f /usr/share/git/completion/git-completion.bash   ] ; then
      #BASH_COMPLETION=/etc/bash_completion
      #BASH_COMPLETION_DIR=/etc/bash_completion.d
      #export BASH_COMPLETION BASH_COMPLETION_DIR
      source /usr/share/git/completion/git-completion.bash
      source /usr/share/git/completion/git-prompt.sh
   fi

   complete -o default -o nospace -F _git g

   # Less is vim
   # alias less='/usr/share/vim/vim73/macros/less.sh'

   # Other app alias
   # export SOFA='/opt/Sofa-1.0'
   # alias sofa='/opt/Sofa-1.0/bin/runSofa'
   # alias oldsofa='/extra/Sofa/bin/runSofa'

   alias kdvp='setxkbmap -layout us -variant dvp -option compose:caps -option keypad:atm -option numpad:shift3 -option kpdl:semi'

   # function
   #function evince() {
   #   /usr/bin/evince $@ &> /dev/null
   #}
################## Cthulhu #####################
elif [ `hostname` == "cthulhu" ] ; then
   # PATH
   export PATH=$PATH:~/.cabal/bin
   # CDPATH
   export CDPATH=$CDPATH:~/code/

   # Source the git prompt
   if [ -f /usr/share/git/git-prompt.sh ]; then
      .  /usr/share/git/git-prompt.sh
   fi

   # LSCOLORS
   export LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

   # Alias
   alias kdvp='setxkbmap -layout us -variant dvp -option compose:caps -option keypad:atm -option numpad:shift3 -option kpdl:semi'
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

# Load rvm
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Load private dots
if [ -f ~/.priv_dots ] ; then
   source ~/.priv_dots
fi
