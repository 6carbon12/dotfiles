#!/bin/bash

# Function to check the status
check() {
    if hyprctl clients | grep -q "workspace: .* (special:minimized)"; then
        echo '{"text": "●", "class": "occupied", "tooltip": "Minimized Windows"}'
    else
        echo '{"text": "", "class": "empty", "tooltip": ""}'
    fi
}

# 1. Run check immediately on startup
check

# 2. Listen to the Hyprland socket for events
# When a window is opened, closed, or moved, we re-run the check.
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    if [[ "$line" =~ ^(openwindow|closewindow|movewindow) ]]; then
        check
    fi
done
