# enables profiling
#zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

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

alias cd="z"
alias ns="nix-shell"
alias lgit="lazygit"
# alias some_name='bash ./menuScript.sh'
