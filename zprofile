#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export PAGER='less'

typeset -x SCALA_HOME="/usr/share/scala/scala"
typeset -x MAVEN_OPTS="-Xmx2G"
typeset -x JAVA_OPTS="-Xms512M -Xmx2G"
typeset -x EDITOR="vim"
typeset -x VISUAL="vim"

path=(
    /usr/local/bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/Library/Python/2.7/bin
    $HOME/.stack/programs/x86_64-osx/ghc-7.10.3/bin
    $path[@]
)

# $HOME/Library/Python/2.7/bin/powerline-daemon -q
# . $HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

typeset -x JAVA_HOME="$(/usr/libexec/java_home)"
typeset -x EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"


#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
