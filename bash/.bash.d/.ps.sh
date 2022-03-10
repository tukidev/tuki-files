#### #### #### #### #### #### ####
##   TUKI BASH CONFIGURATION    ##
#### #### #### #### #### #### ####

####    TERMINAL's PS    ####

source ~/.bash.d/.constants.sh
source ~/.bash.d/.methods.sh

## ---- ---- ---- ---- PS1 ---- ---- ---- ---- ##

PS1="${WHITE}[${PURPLE} :\u${WHITE} ${CYAN} :\w${WHITE}] \`(parse_git_branch)\`${ENDCOLOR} "

## ---- ---- ---- ---- ---- ---- ---- ---- ---- ##

PROMPT_DIRTRIM=2    # pwd depth for \w section
