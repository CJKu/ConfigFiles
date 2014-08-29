# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f /etc/bashrc ]; then
  . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

# Define alias
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias hq='hg qseries -v -s'
alias hpush='hg push -f -rtip ssh://cku@mozilla.com@hg.mozilla.org/try'

export CLICOLOR=YES

# Add PATHs...
# http://unix.stackexchange.com/a/4973
add_path () {
  for d; do
    case ":$PATH:" in
      *":$d:"*) :;;
      *) PATH=$d:$PATH;;
    esac
  done
}

add_path ~/adt-bundle/sdk/platform-tools
add_path ~/adt-bundle/sdk/tools
add_path /usr/local/bin
add_path ~/repository/moz-git-tools
add_path ~/repository/Utility

# Print the value of $PATH
function print_path () {
  echo $PATH | tr ':' '\n' | awk '{print "["NR"]"$0}'
}

# Color definition
OFF="\[\e[0m\]"
BOLD="\[\e[1m\]"
BLACK="\[\e[30m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
MAGENTA="\[\e[35m\]"
CYAN="\[\e[36m\]"
WHITE="\[\e[37m\]"

# Add git branch into prompt
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Add hg queue into prompt
function parse_hg_queue {
  hg qqueue --active 2> /dev/null | sed -e 's/\(.*\)/(\1)/' | awk 'BEGIN { ORS=""; } { print $1; }'
  hg qseries -v 2> /dev/null | awk -v ACTIVE_PATCHES=0 \
  '
    BEGIN { ORS="" }
    $2 ~ /A/ { ACTIVE_PATCHES++; }
    END { print "(" ACTIVE_PATCHES ")" }
  '
}

export PS1="\[\e[32;0m\]\u@${GREEN}\w${BLUE}\$(parse_git_branch)\$(parse_hg_queue)"
PS1+="${OFF}\$ "

# brew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
fi

# Toggle hidden files shown/hidden on Mac OS X
if [ "$(uname)" == "Darwin" ]; then
  function toggle_hidden()
  {
    if [ "$(defaults read com.apple.finder AppleShowAllFiles)" == "TRUE" ]; then
      echo "Hidden files have been hidden."
      defaults write com.apple.finder AppleShowAllFiles FALSE
    else
      echo "Hidden files have been shown."
      defaults write com.apple.finder AppleShowAllFiles TRUE
    fi
    killall Finder
  }
fi

# Mozilla export attribute
export MARIONETTE_ENV=`pwd`/marionette_env
