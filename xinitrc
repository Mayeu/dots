# Xressources merging
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

# Start the GnuPG agent and enable OpenSSH agent emulation
envfile="${HOME}/.gnupg/gpg-agent.env"
if test -f "$envfile" && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
   eval "$(cat "$envfile")"
else
   eval "$(gpg-agent -s --enable-ssh-support --daemon --write-env-file "$envfile")"
fi
export GPG_AGENT_INFO  # the env file does not contain the export statement
export SSH_AUTH_SOCK   # enable gpg-agent for ssh

# Background
eval $(cat ~/.fehbg)

# WM
exec i3
