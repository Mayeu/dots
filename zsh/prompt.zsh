#!/bin/zsh

SPACESHIP_PROMPT_ORDER=(
  begin # Just begin again section
  user  # Username section
  #  dir           # Current directory section
  git       # Git section (git_branch + git_status)
  venv      # virtualenv section
  conda     # conda virtualenv section
  pyenv     # Pyenv section
  terraform # Terraform workspace section
  exec_time # Execution time
  line_sep  # Line break
  vi_mode   # Vi-mode indicator
  #nix_shell # Nix shell indicator
  jobs      # Background jobs indicator
  exit_code # Exit code section
  char      # Prompt character
)
