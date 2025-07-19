#!/bin/bash

SRC="$HOME"
DEST="/mnt/SSD1/asus1"
LOGFILE="$SRC/backup.log"

ITEMS=(
    "Desktop"
    "Documents"
    "Music"
    "Pictures"
    "Videos"
    ".vimrc"
    ".bashrc"
    ".git"
    ".gitignore"
    ".gitconfig"
    ".config"
    "backup.bat"
    "backup.sh"
    "restore_backup.sh"
    "LICENSE"
    "README.md"
)

# Check if destination is mounted
if ! mountpoint -q "$(dirname "$DEST")"; then
  echo "Backup drive is not mounted." | tee -a "$LOGFILE"
  exit 1
fi

# Create destination if it doesn't exist
mkdir -p "$DEST"

echo "Starting backup at $(date)" | tee -a "$LOGFILE"

for item in "${ITEMS[@]}"; do
  if [ -e "$SRC/$item" ]; then
    rsync -av --delete "$SRC/$item" "$DEST/" >> "$LOGFILE" 2>&1
    echo "Backed up: $item" | tee -a "$LOGFILE"
  else
    echo "[ERROR] Skipped (not found): $item" | tee -a "$LOGFILE"
  fi
done

echo "Backup finished at $(date)" | tee -a "$LOGFILE"
