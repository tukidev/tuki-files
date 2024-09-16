# ~/.bash_profile

export PATH="/home/tuki/.local/bin:$PATH"
export NNN_OPTS="H" 
export EDITOR='nvim' 
export VISUAL='nvim'
# export DRI_PRIME=1

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
