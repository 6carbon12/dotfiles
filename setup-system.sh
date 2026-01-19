#!/bin/bash

# Configuration
SOURCE_DIR="./root"
# Create a backup suffix with a timestamp so you never overwrite previous backups
BACKUP_SUFFIX=".bak-$(date +%Y%m%d-%H%M%S)"

echo "Starting System Config Sync..."
echo "Any overwritten files will be backed up with suffix: $BACKUP_SUFFIX"

# The Magic Command
# -a: Archive mode (recursive, preserves system permissions/timestamps)
# -v: Verbose (lists files being changed)
# --checksum: Compares file CONTENT, not just modification time (slower but accurate)
# --backup: Triggers the backup logic
# --suffix: Defines what to append to the backup file
# --no-o --no-g --chown=root:root: Forces files to be owned by root on the destination
sudo rsync -av \
    --checksum \
    --backup \
    --suffix="$BACKUP_SUFFIX" \
    --no-owner --no-group --chown=root:root \
    "$SOURCE_DIR/" /

echo "-----------------------------------------------------"
echo "Sync Complete. Check output above for any changes."
