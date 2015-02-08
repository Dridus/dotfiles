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

module_path=($module_path /usr/local/lib/zpython)
zmodload zsh/zpython

# prompt agnoster

bindkey '^r' history-incremental-search-backward

typeset -x SCALA_HOME="/usr/share/scala/scala"
typeset -x MAVEN_OPTS="-Xmx2G"
typeset -x JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home"
typeset -x EDITOR="vim"

# Add GHC 7.8.3 to the PATH, via http://ghcformacosx.github.io/
typeset -x GHC_DOT_APP="/Applications/ghc-7.8.3.app"

path=(
    /usr/local/bin
    $HOME/bin
    $HOME/.cabal/bin
    $HOME/Library/Python/2.7/bin
    $GHC_DOT_APP/Contents/bin
    $path[@]
)

/Users/rmm/Library/Python/2.7/bin/powerline-daemon -q
. /Users/rmm/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

typeset -x HADOOP_USER_NAME=prodrmacleod
eval "$(bash /Users/rmm/px/hadoop-conf/current/env.sh /Users/rmm/3rd/ue1b-qaB-cdh5.2.1 | sed -e 's,^export,typeset -x,')"

typeset -x JAVA_HOME="$(/usr/libexec/java_home)"
typeset -x EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"
