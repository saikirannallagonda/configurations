#!/bin/bash

# Set the source of your backup (change if needed)
BACKUP_SRC="/mnt/SSD1/asus1"
LOGFILE="$HOME/restore_backup_log.txt"

# List your user folders to restore
FOLDERS=("Desktop" "Documents" "Downloads" "Music" "Pictures" "Videos")

# List your dotfiles to restore (add more as needed)
DOTFILES=(".vimrc" ".bashrc" ".config" ".gitconfig")

echo "Restore started at $(date)" | tee -a "$LOGFILE"

# Restore user folders
for folder in "${FOLDERS[@]}"; do
    SRC="$BACKUP_SRC/$folder"
    DEST="$HOME/$folder"
    if [ -d "$SRC" ]; then
        if [ ! -d "$DEST" ]; then
            mkdir -p "$DEST"
            echo "Created $DEST" | tee -a "$LOGFILE"
        fi
        echo "Copying $folder..." | tee -a "$LOGFILE"
        cp -av "$SRC/." "$DEST/"
        echo "$folder done." | tee -a "$LOGFILE"
    else
        echo "Source folder $SRC does not exist, skipping." | tee -a "$LOGFILE"
    fi
done

# Restore dotfiles
for dotfile in "${DOTFILES[@]}"; do
    SRC="$BACKUP_SRC/$dotfile"
    DEST="$HOME/$dotfile"
    if [ -e "$SRC" ]; then
        echo "Copying $dotfile..." | tee -a "$LOGFILE"
        cp -av "$SRC" "$DEST"
        echo "$dotfile done." | tee -a "$LOGFILE"
    else
        echo "Dotfile $SRC does not exist, skipping." | tee -a "$LOGFILE"
    fi
done

echo "Restore completed at $(date)" | tee -a "$LOGFILE"

