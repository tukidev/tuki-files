#
# ~/.bashrc
#

source ~/.git-prompt.sh

####------------ EXPORTS ------------####
export NNN_OPTS="H" 
export EDITOR='lvim' 
export VISUAL='lvim'


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

####------------ PROMPT ------------####o
#colors:
BLACK="\e[00;30m"
DARY_GRAY="\e[01;30m"
RED="\e[00;31m"
BRIGHT_RED="\e[01;31m"
GREEN="\e[00;32m"
BRIGHT_GREEN="\e[01;32m"
BROWN="\e[00;33m"
YELLOW="\e[01;33m"
BLUE="\e[00;34m"
BRIGHT_BLUE="\e[01;34m"
PURPLE="\e[00;35m"
LIGHT_PURPLE="\e[01;35m"
CYAN="\e[00;36m"
BRIGHT_CYAN="\e[01;36m"
LIGHT_GRAY="\e[00;37m"
WHITE="\e[01;37m"
ENDCOLOR="\e[m"

function parse_git_status {
  STATUS="$(git status 2> /dev/null)"

  if [[ $? -ne 0 ]]; then printf ""; return; fi
  
  if echo $STATUS | grep -c "renamed:"          &> /dev/null; then printf "[↻]"; else printf ""; fi
  if echo $STATUS | grep -c "branch is ahead:"  &> /dev/null; then printf "[↥]"; else printf ""; fi
  if echo $STATUS | grep -c "new file:"         &> /dev/null; then printf "[+]"; else printf ""; fi
  if echo $STATUS | grep -c "Untracked files:"  &> /dev/null; then printf "[✗]"; else printf ""; fi
  if echo $STATUS | grep -c "modified:"         &> /dev/null; then printf "[•]"; else printf ""; fi
  if echo $STATUS | grep -c "deleted"           &> /dev/null; then printf "[-]"; else printf ""; fi
}

parse_git_branch() {
  BRANCH=`__git_ps1 "%s"`
  if [ ! "$BRANCH" == "" ] 
  then
      STAT=`parse_git_status`
      printf "${GREEN}( ${BRANCH}${RED}${STAT}${GREEN}) "
    else
      echo ""
  fi
}

# PS1="${WHITE}[${PURPLE}\u${WHITE} ${CYAN} \w${YELLOW}\`__git_ps1 ' ( %s)'\`${WHITE}]${ENDCOLOR}  "
PS1="${WHITE}〚${PURPLE} \u${WHITE} ${CYAN} \w${WHITE}〛\`(parse_git_branch)\`${ENDCOLOR} "
PROMPT_DIRTRIM=2

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

alias v='lvim'                   # exec lunarvim with v coomand
alias cl='clear'
alias gg='shutdown now'
alias rr='reboot'
alias upd='sudo pacman -Syu'
# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tuki/Soft/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tuki/Soft/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tuki/Soft/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tuki/Soft/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

##
## Powerline setup
##
# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# . /usr/share/powerline/bindings/bash/powerline.sh

export PATH="/home/tuki/.local/bin:$PATH"
