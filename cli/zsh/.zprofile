# Only launch if on tty1
if [[ "$(tty)" == "/dev/tty1" ]]; then
  exec Hyprland &> ~/.local/.hyprland.log
fi
