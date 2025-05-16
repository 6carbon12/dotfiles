#!/bin/zsh

# This is a custom script to launch my apps using fuzzel dmenu

# All the shown choices, Icons are shown via NFs
choices=$(cat <<EOF
  Alacritty
K  Kitty
  btop
  Firefox
  EOG
  Pavucontrol
  Spotify
  VLC
EOF
)

# Show the dmenu and all its entries
selection=$(printf "%s\n" "$choices" | fuzzel --dmenu --prompt :)

# Launching the apps if they are selected
case "$selection" in
    *Alacritty) gtk-launch Alacritty ;;
    *Kitty) gtk-launch kitty ;;
    *btop) alacritty -e btop ;;
    *Firefox) gtk-launch firefox ;;
    *EOG) gtk-launch eog ;;
    *Pavucontrol) gtk-launch org.pulseaudio.pavucontrol ;;
    *Spotify) gtk-launch spotify ;;
    *VLC) gtk-launch vlc ;;
esac

