#!/bin/bash

img="$(echo $(date +'%Y-%m-%d--%H-%M-%S.png'))"

hyprctl dispatch setprop activewindow opaque on
slurp | grim -g - ~/pics/screenshots/"$img" 
# Can't use activewindow since it can change if there are more than one window in the workspace
hyprctl clients -j | jq -r '.[].address' | xargs -I {} hyprctl dispatch setprop address:{} opaque off
wl-copy < ~/pics/screenshots/"$img"
