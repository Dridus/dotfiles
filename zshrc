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

prompt agnoster

function update-zsh-vi-mode-prompt {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
  zle reset-prompt
}

function zle-line-init {
  update-zsh-vi-mode-prompt
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[smkx] )); then
    # Enable terminal application mode.
    echoti smkx
  fi
module_path=($module_path /usr/local/lib/zpython)
zmodload zsh/zpython

  # Update editor information.
  zle editor-info
}

function zle-keymap-select {
  update-zsh-vi-mode-prompt
  zle editor-info
}

zle -N zle-line-init
zle -N zle-keymap-select
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
    $HOME/.cabal/bin
    $HOME/Library/Python/2.7/bin
    $GHC_DOT_APP/Contents/bin
    $path[@]
)

typeset -x HADOOP_USER_NAME=rmacleod
eval "$(bash /Users/rmm/px/hadoop-conf/current/env.sh /Users/rmm/3rd/cdh4.2.1 | sed -e 's,^export,typeset -x,')"
/Users/rmm/Library/Python/2.7/bin/powerline-daemon -q
. /Users/rmm/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
