#!/usr/bin/env bash

MODE="$1"
AWWW_DIR="$HOME/.local/share/awww"
mkdir -p "$AWWW_DIR"

case "$MODE" in
  start)
    IMAGE=$(find "$AWWW_DIR" -maxdepth 1 -type f | head -n 1)
    awww img -o HDMI-A-1,eDP-1 "$IMAGE"
    ;;

  set)
    NEW_IMAGE="$2"

    # Validate that a second argument was passed and that it is an existing file
    if [[ -z "$NEW_IMAGE" || ! -f "$NEW_IMAGE" ]]; then
      echo "Error: Please provide a valid path to an image."
      echo "Usage: $0 set /path/to/image.jpg"
      exit 1
    fi

    echo "Clearing old images and setting new image: $NEW_IMAGE"

    # Delete the current file(s) in the directory
    rm -f "$AWWW_DIR"/*

    # Copy the new file into the directory
    cp "$NEW_IMAGE" "$AWWW_DIR/"

    # Get the absolute path of the newly copied file
    TARGET_IMAGE="$AWWW_DIR/$(basename "$NEW_IMAGE")"
    awww img -o HDMI-A-1,eDP-1 --transition-type any --transition-fps 60 "$TARGET_IMAGE"
    ;;

  *)
    # Fallback if the user types something else or runs the script without arguments
    echo "Usage: $0 {start|set} [path_to_new_image]"
    exit 1
    ;;
esac
