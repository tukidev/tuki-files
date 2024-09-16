#!/bin/bash
# Kill and restart waybar whenever its config files change


WAYBAR_CONFIG_DIR="$HOME/.config/waybar"

WAYBAR_CONFIG="$WAYBAR_CONFIG_DIR/config.jsonc"
WAYBAR_STYLE="$WAYBAR_CONFIG_DIR/style.css"

CONFIG_FILES="$WAYBAR_CONFIG $WAYBAR_STYLE"

# trap "killall -SIGUSR2 waybar" EXIT

# killall waybar
# while pgrep -x waybar >/dev/null; do sleep 1; done

# run waybar with configs
# waybar --config ${WAYBAR_CONFIG} --style ${WAYBAR_STYLE}

# waybar --config $WAYBAR_CONFIG --style $WAYBAR_STYLE

while true; do
    inotifywait -e modify $CONFIG_FILES
    killall -SIGUSR2 waybar
    sleep 1
done
