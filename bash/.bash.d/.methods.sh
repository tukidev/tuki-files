#### #### #### #### #### #### ####
##   TUKI BASH CONFIGURATION    ##
#### #### #### #### #### #### ####

source ~/.bash.d/.constants.sh

function parse_git_status {
    STATUS="$(git status 2> /dev/null)"

    if [[ $? -ne 0 ]]; then printf ""; return; fi

    if echo $STATUS | grep -c "renamed:"          &> /dev/null; then printf "[↻]"; else printf ""; fi
    if echo $STATUS | grep -c "branch is ahead:"  &> /dev/null; then printf "[↥]"; else printf ""; fi
    if echo $STATUS | grep -c "new file:"         &> /dev/null; then printf "[+]"; else printf ""; fi
    if echo $STATUS | grep -c "Untracked files:"  &> /dev/null; then printf "[?]"; else printf ""; fi
    if echo $STATUS | grep -c "modified:"         &> /dev/null; then printf "[•]"; else printf ""; fi
    if echo $STATUS | grep -c "deleted"           &> /dev/null; then printf "[✗]"; else printf ""; fi
}

parse_git_branch() {
    BRANCH=`__git_ps1 "%s"`
    if [ ! "$BRANCH" == "" ] 
    then
        STAT=`parse_git_status`
        printf "${GREEN}( ${BRANCH}${RED}${STAT}${GREEN}) "
    else
        echo ""
    fi
}
