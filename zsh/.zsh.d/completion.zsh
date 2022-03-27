##: Competion configurations for ZShell
#

# /==> Advanced Tab completion
autoload -U compinit; compinit

# /==> Style
zstyle 'completion:complete:cd:*' ignore-patterns ''

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' menu select

zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
