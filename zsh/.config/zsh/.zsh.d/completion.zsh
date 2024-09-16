##: Competion configurations for ZShell
#

# /==> Advanced Tab completion
autoload -U compinit; compinit
_comp_options+=(globdots)           # With hidden files

# /==> Style
# zstyle ':completion:*' ignore-parents parent pwd          # /=> don't cmp the curr directory
# zstyle ':completion:*:(rm|cp|mv):*' ignore-line other     # /=> don't cmp the same filenames again

zstyle ':completion:*' special-dirs false                   # /=> remove `.` and `..` form cmp

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no
zstyle ':completion:*' menu select

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# conda-zsh-completion option's
zstyle ':completion::complete:*' use-cache 1
zstyle ":conda_zsh_completion:*" show-unnamed true
zstyle ":conda_zsh_completion:*" sort-envs-by-time true
