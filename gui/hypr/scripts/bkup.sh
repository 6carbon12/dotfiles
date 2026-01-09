#!/bin/bash
set -e

MOUNT="/mnt"

mountpoint -q "$MOUNT" || { 
  notify-send "DRIVE NOT MOUNTED";
  exit 1; 
}

if ! [ -f $MOUNT/backup.sh ]; then
  notify-send "DRIVE IS NOT A BACKUP DRIVE";
  exit 1; 
fi

notify-send "BACKUP STARTED..."
kitty --class float-term --override window_padding_width=80 $MOUNT/backup.sh
