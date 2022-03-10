#### #### #### #### #### #### ####
##   TUKI BASH CONFIGURATION    ##
#### #### #### #### #### #### ####

####    ANACONDA CONFIGURATION    ####

## Contents within this block are managed by 'conda init'
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
