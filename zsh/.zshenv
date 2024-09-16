export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZDOTDIR2="$ZDOTDIR/.zsh.d"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export EDITOR="nvim"
export VISUAL="nvim"

export OBSIDIAN_USE_WAYLAND=1

export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
