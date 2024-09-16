#
# ~/.bashrc
#

source ~/.bash.d/.constants.sh
source ~/.bash.d/.git-prompt.sh
source ~/.bash.d/.methods.sh
source ~/.bash.d/.defaults-endevaouros.sh
source ~/.bash.d/.ps.sh
source ~/.bash.d/.alliases.sh
# source ~/.bash.d/.conda.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen
. "$HOME/.cargo/env"
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export PATH=/opt/gcc-arm-none-eabi-10-2020-q4-major/bin:$PATH
export PATH=/home/tuki/Workspace/Software/ardupilot/ardupilot/Tools/autotest:$PATH
# source /home/tuki/venv-ardupilot/bin/activate  # commented out by conda initialize
# source /home/tuki/venv-ardupilot/bin/activate  # commented out by conda initialize
# source /home/tuki/venv-ardupilot/bin/activate  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tuki/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tuki/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tuki/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tuki/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

