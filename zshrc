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

# Customize to your needs...
BASE16_SHELL="$HOME/.config/base16-shell/base16-solarized.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# module_path=($module_path /usr/local/lib/zpython)
# zmodload zsh/zpython

prompt agnoster

bindkey '^r' history-incremental-search-backward

typeset -x SCALA_HOME="/usr/share/scala/scala"
typeset -x MAVEN_OPTS="-Xmx2G"
typeset -x JAVA_OPTS="-Xms512M -Xmx2G"
typeset -x EDITOR="vim"

typeset -x GHC_DOT_APP="/Applications/ghc-7.10.1.app"

path=(
    /usr/local/bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/Library/Python/2.7/bin
    $HOME/.stack/programs/x86_64-osx/ghc-7.10.2/bin
    $HOME/3rd/elm/sandbox/.cabal-sandbox/bin
    $HOME/3rd/yi/.cabal-sandbox/bin
    $path[@]
)

# $HOME/Library/Python/2.7/bin/powerline-daemon -q
# . $HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

typeset -x JAVA_HOME="$(/usr/libexec/java_home)"
typeset -x EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"


if test -f $HOME/.zshrc-local; then
    source $HOME/.zshrc-local
fi

export NVM_DIR="/Users/ross/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
