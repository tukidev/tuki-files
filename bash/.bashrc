#
# ~/.bashrc
#

source ~/.bash.d/.constants.sh
source ~/.bash.d/.git-prompt.sh
source ~/.bash.d/.methods.sh
source ~/.bash.d/.defaults-endevaouros.sh
source ~/.bash.d/.ps.sh
source ~/.bash.d/.alliases.sh
source ~/.bash.d/.conda.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen
. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
