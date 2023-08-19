#!/bin/sh
# Times the screen off and puts it to background
swayidle \
  timeout  3000 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"'

# Locks the screen immediately
swaylock

### swaylock-effects
# swaylock \
# 	--screenshots \
# 	--clock \
# 	--indicator \
# 	--indicator-radius 100 \
# 	--indicator-thickness 6 \
#   --effect-scale 0.5 \
# 	--effect-blur 7x5 \
#   --effect-scale 2 \
# 	--effect-vignette 0.5:0.5 \
# 	--grace 3 \
# 	--fade-in 0.25


# Kills last background task so idle timer doesn't keep running
kill %%
