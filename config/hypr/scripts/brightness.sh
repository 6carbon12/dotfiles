#!/usr/bin/env bash

# Path to store the cached bus ID
CACHE_FILE="/tmp/monitor_bus_id"

# 1. Update laptop screen immediately
brightnessctl s 1%"$1"

# 2. Get the Bus ID (from cache or detect)
if [ -f "$CACHE_FILE" ]; then
    BUS=$(cat "$CACHE_FILE")
else
    # Only runs the slow detect command if cache is missing
    BUS=$(ddcutil detect --brief | grep "I2C bus:" | head -n 1 | awk -F'-' '{print $2}')
    echo "$BUS" > "$CACHE_FILE"
fi

# 3. Update external monitor using speed optimizations
if [ -n "$BUS" ]; then
    if [[ "$1" == "+" ]]; then
        ddcutil --bus="$BUS" --sleep-multiplier .1 --noverify setvcp 10 + 10
    else
        ddcutil --bus="$BUS" --sleep-multiplier .1 --noverify setvcp 10 - 10
    fi
fi
