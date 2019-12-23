#!/usr/bin/env zsh
#
# Just begin again
#
# Quote is a supa-dupa cool tool for making your life healtier.

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_BEGIN_SHOW="${SPACESHIP_BEGIN_SHOW=true}"
SPACESHIP_BEGIN_PREFIX="${SPACESHIP_BEGIN_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_BEGIN_SUFFIX="${SPACESHIP_BEGIN_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_BEGIN_SYMBOL="${SPACESHIP_BEGIN_SYMBOL="🧘‍♀️  "}"
SPACESHIP_BEGIN_COLOR="${SPACESHIP_BEGIN_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show begin status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_begin() {
  # If SPACESHIP_BEGIN_SHOW is false, don't show begin section
  [[ $SPACESHIP_BEGIN_SHOW == false ]] && return

  # Check if begin command is available for execution
  spaceship::exists shuf || return

  # Use quotes around unassigned local variables to prevent
  # getting replaced by global aliases
  # http://zsh.sourceforge.net/Doc/Release/Shell-Grammar.html#Aliasing
  local 'quote_status'

  random="$(shuf -i 1-100 -n 1)"

  if [[ $random -le 1 ]]; then
    begin_status="Breath, and just begin again 🙏"
  fi

  # Exit section if variable is empty
  [[ -z $begin_status ]] && return

  # Display begin section
  spaceship::section \
    "$SPACESHIP_BEGIN_COLOR" \
    "$SPACESHIP_BEGIN_PREFIX" \
    "$SPACESHIP_BEGIN_SYMBOL$begin_status" \
    "$SPACESHIP_BEGIN_SUFFIX"
}
