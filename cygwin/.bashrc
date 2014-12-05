# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# =================================================================================================
# Termiate colors
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
            *) color_prompt=;;
esac

export TERM=xterm-256color

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  	# We have color support; assume it's compliant with Ecma-48
	  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	  # a case would tend to support setf rather than setaf.)
	  color_prompt=yes
  else
	  color_prompt=
  fi
fi

# =================================================================================================
# Setup PS1
# Color definition
OFF="\e[0m"
BOLD="\e[1m"
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

# Append git info
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git\/\1)/'
}

source ~/.git-prompt.sh
export GIT_PS1_SHOWUPSTREAM="verbose name"

# Add hg queue information into prompt
function parse_hg_queue {
  # Display the name of active queue
  hg qqueue --active 2> /dev/null | sed -e 's/\(.*\)/(hg\/\1/' | awk 'BEGIN { ORS=""; } { print $1; }'

  # Display the number of applied and unapplied patches.
  hg qseries -v 2> /dev/null | awk  \
  '
    BEGIN {
      A = 0;  # A = applied patches
      U = 0;  # U = unapplied patches
      ORS=""; # Change ORS to "" to prevent newline in PS1
    }

    $2 ~ /A/ { A++; } # 1 A patch_name
    $2 ~ /U/ { U++; } # 0 U patch_name

    END {
      if (A != 0 || U != 0)
        print "/a-" A "/u-" U ")"
    }
  '
}

export PS1="\[${CYAN}\]\u@\[${GREEN}\]\w\[${BLUE}\]\$(__git_ps1 \" (git/%s)\")"
PS1+="\[${OFF}\]\$ "

# =================================================================================================
# color setting of commands
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# =================================================================================================
# aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# =================================================================================================
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# =================================================================================================
# Path
add_path () {
  for d; do
    case ":$PATH:" in
     *":$d:"*) :;;
     *) PATH=$d:$PATH;;
    esac
  done
}

add_path ~/adt-bundle-linux-x86_64/sdk/tools/
add_path ~/adt-bundle-linux-x86_64/sdk/platform-tools/
add_path ~/.local/bin
