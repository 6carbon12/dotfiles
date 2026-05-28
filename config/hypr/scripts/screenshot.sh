#!/bin/bash

DIR="$HOME/pics/screenshots"
TIMESTAMP="$(echo $(date +'%Y-%m-%d--%H-%M-%S'))"
IMG_PATH="$HOME/pics/screenshots/$TIMESTAMP.png"
SWAPPY_IMG_PATH="$HOME/pics/screenshots/$TIMESTAMP-swappy.png"
mkdir -p $DIR

GEOMETRY=$(slurp)
if [ -z "$GEOMETRY" ]; then
  # Early exit if Screenshot is canceled
  exit
fi

grim -g "$GEOMETRY" "$IMG_PATH"

wl-copy < $IMG_PATH

ACTION=$(notify-send --wait --app-name="Screenshot" --action="default=Edit in Swappy" "Screenshot Saved" "Click to annotate in Swappy" -i $IMG_PATH)

if [ "$ACTION" == "default" ]; then
  swappy -f "$IMG_PATH" -o "$SWAPPY_IMG_PATH"

  if [ -f "$SWAPPY_IMG_PATH" ]; then
    wl-copy < "$SWAPPY_IMG_PATH"
    notify-send --app-name="Screenshot" "Swappy" "Annotation saved and copied to clipboard." -i $IMG_PATH
  fi
fi
