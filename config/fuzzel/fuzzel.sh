#!/bin/bash
# This is a custom script to launch my apps using fuzzel dmenu

# All the shown choices, Icons are shown via NFs
choices=$(cat <<EOF
  BTOP
  Firefox
  Kitty
󰏆  LibreOffice
󰑓  OBS
  Pavucontrol
󰵆  VirtualBox
EOF
)

# Show the dmenu and all its entries
selection=$(printf "%s\n" "$choices" | fuzzel --dmenu --prompt :)

# Launching the apps if they are selected
case "$selection" in
    *Kitty) gtk-launch kitty ;;
    *BTOP) kitty -e btop ;;
    *Firefox) gtk-launch firefox ;;
    *Pavucontrol) gtk-launch org.pulseaudio.pavucontrol ;;
    *VirtualBox) gtk-launch virtualbox ;;
    *OBS) obs ;;
    *LibreOffice) libreoffice ;;
esac

