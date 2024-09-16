swayidle -w \
	timeout 900 'hyprctl dispatcher dpms off' \
	resume 'hyprctl dispatcher dpms on' \
	timeout 1800 'systemctl suspend' \
	timeout 4800 'systemctl hibernate' \
	before-sleep 'swaylock -f -i ~/.config/swww/Catppuccin-Mocha/aesthetic_deer.png'
