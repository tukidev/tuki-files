#
# ~/.bash_profile
#

export PATH="/home/tuki/.local/bin:$PATH"
export NNN_OPTS="H" 
export EDITOR='lvim' 
export VISUAL='lvim'

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
