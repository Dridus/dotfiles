PREZTO_DIR=$(nix-build --no-out-link -A zsh-prezto "<nixos>")
if [ ! -f ${ZDOTDIR:-$HOME}/.zpreztorc ]; then
  ln -s ${PREZTO_DIR}/runcoms/zpreztorc ${ZDOTDIR:-$HOME}/.zpreztorc
fi
source ${PREZTO_DIR}/init.zsh

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# module_path=($module_path /usr/local/lib/zpython)
# zmodload zsh/zpython

setopt NO_SHARE_HISTORY

prompt oliver

bindkey '^r' history-incremental-search-backward

zstyle ':prezto:load' pmodule 'environment' 'terminal'
zstyle ':prezto:module:terminal' auto-title 'yes'
zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'

if test -f $HOME/.zshrc-local; then
    source $HOME/.zshrc-local
fi

alias ls="exa"
alias sysu="systemctl --user"
alias jour="journalctl --user"
function nghci
{
  set -x
  nix-shell -p "haskellPackages.ghcWithPackages (p: with p; [$@])" --run ghci
}

[ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ] && . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
