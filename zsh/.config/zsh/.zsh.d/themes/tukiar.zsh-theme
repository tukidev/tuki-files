#:region NERD_FONTS
S_CAT=$'\uf61a'
S_PANDA=$'\uf8d9'
S_BUG=$'\uf188'
S_FALSE=$'\u2718'
S_FOLDER=$'\uf07b'
S_ANGLE_BRACKET=$'\u276f'
S_ANGLE_BRACKET_O=$'\ue285'
S_GIT_ICON_HEAD=$'\uf113'
S_ARROW=$'\uf061'
S_COFFEE=$'\uf0f4'
S_BOT=$'\ufba7'
S_GHOST=$'\uf79f'
S_GIT_COMMIT=$'\uf417'

# v2
S_GIT_BRANCH=''

SEP='::'

RETURN() {
    echo "\n%F{white}$S_ANGLE_BRACKET%f "
}
#:endregion

#:region GIT_THEME_STATUS
# v1
# ZSH_THEME_GIT_PROMPT_ADDED="[\uf067]"
# ZSH_THEME_GIT_PROMPT_MODIFIED="[\uf444]"
# ZSH_THEME_GIT_PROMPT_DELETED="[\u2718]"
# ZSH_THEME_GIT_PROMPT_RENAMED="[\u27a6]"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="[\uf708]"

# v2
ZSH_THEME_GIT_PROMPT_ADDED="[✓]"
ZSH_THEME_GIT_PROMPT_MODIFIED="[]"
ZSH_THEME_GIT_PROMPT_DELETED="[✗]"
ZSH_THEME_GIT_PROMPT_RENAMED="[]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="[?]"


ZSH_THEME_GIT_PROMPT_PREFIX="%f on %F{green}($S_GIT_BRANCH "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" "
ZSH_THEME_GIT_PROMPT_CLEAN=" \u2714"
#endregion

#:region FUNCTIONS

# current directory, two levels deep
directory() {
    echo " at %F{blue}[%3~]%f"
}

user_ok () {
    echo "%F{magenta}@%n%f"
}

status_err () {
    echo "%(?..%F{red}$S_FALSE%f)"
}

git_status_wrap() {
    OUT="$(git_prompt_info)"
    if [[ -n "$OUT" ]]; then
        OUT+="%F{yellow}$(git_prompt_status)%F{green})"
    fi
    echo "$OUT"
}

#:endregion


RPROMPT='$(status_err)'
PROMPT='$(user_ok)$(directory)$(git_status_wrap)$(RETURN)'
