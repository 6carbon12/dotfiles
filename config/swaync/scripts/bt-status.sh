#!/bin/sh
if bluetoothctl show | grep -q "Powered: yes"; then
  echo true
else
  echo false
fi
