#!/usr/bin/env bash

SRC="$1"
DEST="$HOME/.local/share/hyprpaper/wallpaper.png"

# Check if source file exists
if [[ -z "$SRC" || ! -f "$SRC" ]]; then
    echo "Error: Source file does not exist or is not provided."
    exit 1
fi

# Make sure destination directory exists
mkdir -p "$(dirname "$DEST")"

EXT="${SRC##*.}"
if [[ "$EXT" != "png" ]]; then
    if command -v ffmpeg >/dev/null 2>&1; then
        ffmpeg -y -i "$SRC" "$DEST" >/dev/null 2>&1
        echo "Converted $SRC to PNG at $DEST"
    else
        echo "Error: ffmpeg not found, cannot convert $SRC to PNG"
        exit 1
    fi
else
    cp "$SRC" "$DEST"
    echo "Copied $SRC to $DEST"
fi

# Restart hyprpaper
if command -v hyprpaper >/dev/null 2>&1; then
    hyprctl hyprpaper unload "$HOME/.local/share/hyprpaper/wallpaper.png"
    hyprctl hyprpaper preload "$HOME/.local/share/hyprpaper/wallpaper.png"
    hyprctl hyprpaper wallpaper "eDP-1,$HOME/.local/share/hyprpaper/wallpaper.png"

    echo "hyprpaper restarted."
else
    echo "Warning: hyprpaper not found, skipping restart."
fi
