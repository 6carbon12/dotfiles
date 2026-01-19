#!/bin/bash

SEARCH_DIRS="/etc /usr"

# Regex to match the suffix: .bak-YYYYMMDD-HHMMSS
# This prevents accidental deletion of other random .bak files
MATCH_PATTERN=".*\.bak-[0-9]{8}-[0-9]{6}$"

echo "Searching for old timestamped backups in $SEARCH_DIRS..."

# Find the files
# -regextype posix-extended allows us to use the specific timestamp regex
FOUND_FILES=$(sudo find $SEARCH_DIRS -type f -regextype posix-extended -regex "$MATCH_PATTERN")

if [ -z "$FOUND_FILES" ]; then
    echo "No backup files found."
    exit 0
fi

# Show files to the user first
echo "Found the following backup files:"
echo "--------------------------------"
echo "$FOUND_FILES"
echo "--------------------------------"

# Confirmation prompt
read -p "Delete all listed files? [y/N] " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$FOUND_FILES" | sudo xargs rm -v
    echo "Cleanup complete."
else
    echo "Operation cancelled."
fi
