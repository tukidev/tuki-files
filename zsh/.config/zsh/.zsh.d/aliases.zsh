#:      /=====<< Aliases For My ZShell >>=====/
#

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias v='nvim'
alias cl='clear'
alias cpp='rsync -ah --info=progress2'
alias tr='mv -ft ~/.local/share/Trash '
alias ltr='ll ~/.local/share/Trash '
alias trcl='rm -rfv ~/.local/share/Trash/{*,.*} '

alias qq='shutdown now'
alias re='reboot'
alias u='sudo pacman -Syu'
alias U='sudo yay'
alias conf='cd $HOME/.dotty/'
alias bconf='v $HOME/.dotty/bash/.bashrc'
alias zconf='v $HOME/.dotty/zsh/.zshrc'

alias dir='mkdir -p'
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd "+"${index}"; unset index

alias g='git'
alias gs='g status'
alias gc='g commit -m'
alias ga='g add'
alias gaa='ga -A'
alias gca='g commit -a -m'
alias gi='g init;echo "|=========<< New Project >>=======|" >> README.md;ga README.md;gc "Init commit."'

alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"



