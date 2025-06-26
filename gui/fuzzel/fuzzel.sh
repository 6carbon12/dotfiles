#!/bin/zsh

# This is a custom script to launch my apps using fuzzel dmenu

# All the shown choices, Icons are shown via NFs
choices=$(cat <<EOF
  BTOP
  Firefox
  Kitty
  Pavucontrol
  VLC
󰵆  VirtualBox
EOF
)

# Show the dmenu and all its entries
selection=$(printf "%s\n" "$choices" | fuzzel --dmenu --prompt :)

# Launching the apps if they are selected
case "$selection" in
    *Kitty) gtk-launch kitty ;;
    *btop) kitty -e btop ;;
    *Firefox) gtk-launch firefox ;;
    *Pavucontrol) gtk-launch org.pulseaudio.pavucontrol ;;
    *VLC) gtk-launch vlc ;;
    *VirtualBox) gtk-launch virtualbox ;;
esac

