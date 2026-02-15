# enables profiling
#zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=100000

export DIRENV_LOG_FORMAT=""  # Disable logging
export DISABLE_AUTO_TITLE="true"

function direnv() {
  unfunction "$0"
  eval "$(command direnv hook zsh)"
  $0 "$@"
}

# Prevent multiple hook executions
if [[ -z "$ZSH_ALREADY_SOURCED" ]]; then
  export ZSH_ALREADY_SOURCED=1
        
  # Only initialize these once
  if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
  fi
        
  # Customize prompt to be faster
  export GIT_PS1_SHOWDIRTYSTATE=0
  export GIT_PS1_SHOWSTASHSTATE=0
  export GIT_PS1_SHOWUNTRACKEDFILES=0
fi


unsetopt beep
unsetopt autocd
setopt hist_ignore_all_dups
bindkey -v

function zshaddhistory() {
  # Check if the command length is less than 6 characters
  if [[ ${#1} -lt 6 ]]; then
    # Return a non-zero value to prevent the command from being saved
    return 1
  fi
}

# Start niri session if not already running
if [[ -z "$XDG_CURRENT_DESKTOP" ]] || [[ "$XDG_CURRENT_DESKTOP" != "niri" ]]; then
    niri-session
fi

alias cd="z"
alias ns="nix-shell"
alias lgit="lazygit"
alias rgst='bash ~/scripts/recursive_git_status.sh'
