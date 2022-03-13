#### #### #### #### #### #### ####
##   TUKI BASH CONFIGURATION    ##
#### #### #### #### #### #### ####

##
####---------------- ALIASES ----------------####
##

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias v='nvim'                   # exec lunarvim with v command
alias cl='clear'
alias cpp='rsync -ah --info=progress2'
alias tr='mv --force -t ~/.local/share/Trash '
alias trcl='rm -rf ~/.local/share/Trash/* '

alias gg='shutdown now'
alias re='reboot'
alias u='sudo pacman -Syu'
alias U='sudo yay'
alias conf='cd $HOME/.dotty/'
alias bconf='v $HOME/.dotty/bash/.bashrc'

alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
