#!/bin/bash

service="$1.service"

toggle_service() {
  status=$(systemctl is-active $service)
  if [[ $status == "active" ]]; then
    exec sudo /bin/systemctl stop $service
  elif [[ $status == "inactive" ]]; then
    exec sudo /bin/systemctl start $service
  fi
}

toggle_service
