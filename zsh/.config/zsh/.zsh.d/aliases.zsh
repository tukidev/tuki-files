#
#      /=====<< Aliases For My ZShell >>=====/
#

alias cd='z'
alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'
alias v='nvim'
alias cl='clear'
alias jk='z $HOME;clear'
alias cpp='rsync -ah --info=progress2'
alias tr='mv -ft ~/.local/share/Trash '
alias ltr='ll ~/.local/share/Trash '
alias trcl='rm -rfv ~/.local/share/Trash/{*,.*} '

alias qq='shutdown now'
alias re='reboot'
alias u='sudo pacman -Syu'
alias U='sudo yay'

# [ configurations ]
alias conf='cd $HOME/.dotty/'
alias bconf='v $HOME/.dotty/bash/.bashrc'
alias zconf='v $HOME/.dotty/zsh/.config/zsh/.zshrc'
alias vconf='v $HOME/.dotty/nvim/.config/nvim/init.lua'

# [ notes ]
alias lnote='v $HOME/me/notes/life/plans.norg'

alias mkd='mkdir -p'
# alias d='dirs -v'
# for index ({1..9}) alias "$index"="cd "+"${index}"; unset index

alias g='git'
alias G='lazygit'
alias gs='g status'
alias gc='g commit -m'
alias ga='g add'
# alias gaa='ga -A'
# alias gca='g commit -a -m'
alias gi='g init;echo "|=========<< New Project >>=======|" >> README.md;ga README.md;gc "Init commit."'

alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

alias l='exa --icons -s=type'
alias ll='exa --icons -lF --no-time --git -s=type'
alias la='exa --icons -alF --no-time --git -s=type'
alias lA='exa --icons -alF -B --git -s=type'
alias ld='exa --icons -DlF --no-time -s=type'
alias lda='exa --icons -aDlF --no-time -s=type'
alias ldA='exa --icons -aDlF -B --git -s=type'

# [ cargo ]
alias car='cargo run'
alias cach='cargo check'
alias canew='cargo new'

alias fda='fd -HI'

alias rdp='/usr/lib/xdg-desktop-portal -vr & /usr/lib/xdg-desktop-portal-wlr'

alias tt='thokr'
