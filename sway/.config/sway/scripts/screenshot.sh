#!/bin/bash
 
entries="Active Screen Output Area Window"
 
selected=$(printf '%s\n' $entries | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}')
 
case $selected in
  active)
    /usr/bin/grim --notify save active;;
  screen)
    /usr/bin/grim --notify save screen;;
  output)
    /usr/bin/grim --notify save output;;
  area)
    /usr/bin/grim --notify save area;;
  window)
    /usr/bin/grim --notify save window;;
esac
