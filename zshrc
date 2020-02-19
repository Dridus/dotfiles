#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# module_path=($module_path /usr/local/lib/zpython)
# zmodload zsh/zpython

setopt NO_SHARE_HISTORY

prompt oliver

bindkey '^r' history-incremental-search-backward


if test -f $HOME/.zshrc-local; then
    source $HOME/.zshrc-local
fi

alias sysu="systemctl --user"
alias jour="journalctl --user"

