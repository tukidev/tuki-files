#!/bin/bash

entries="Bluetooth INotifyCron Firewall Network MongoDB PostgreSQL"
selected=$(printf '%s\n' $entries | wofi --conf=$HOME/.config/wofi/config.services --style=$HOME/.config/wofi/style.css | awk '{print tolower($1)}')

case $selected in
  bluetooth)
    exec $HOME/.config/scripts/service-toggle.sh bluetooth;;
  incrond)
    exec $HOME/.config/scripts/service-toggle.sh incrond;;
  firewall)
    exec $HOME/.config/scripts/service-toggle.sh firewalld;;
  network)
    exec $HOME/.config/scripts/service-toggle.sh NetworkManager;;
  mongodb)
    exec $HOME/.config/scripts/service-toggle.sh mongodb;;
  postgresql)
    exec $HOME/.config/scripts/service-toggle.sh postgresql;;
esac

