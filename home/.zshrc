# enables profiling
#zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=100000

unsetopt beep
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
