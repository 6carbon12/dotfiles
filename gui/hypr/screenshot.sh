#!/bin/bash

img="$(echo $(date +'%Y-%m-%d--%H-%M-%S.png'))"
echo "$img"
slurp | grim -g - ~/pics/screenshots/"$(date +'%Y-%m-%d--%H-%M-%S.png')" 
wl-copy < ~/pics/screenshots/"$img"
