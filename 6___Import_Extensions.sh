#!/bin/bash

# Define source directory (Ubuntu desktop) and target directory (Cursor config)
SOURCE_DIR=~/Desktop
TARGET_DIR=~/.config/Cursor/User
EXTENSIONS_TARGET_DIR=~/.cursor/extensions

# Create target directories if they don't exist
mkdir -p "$TARGET_DIR"
mkdir -p "$EXTENSIONS_TARGET_DIR"

# Function to backup and copy a file
copy_file() {
    local file=$1
    if [ -f "$TARGET_DIR/$file" ]; then
        mv "$TARGET_DIR/$file" "$TARGET_DIR/$file.backup"
        echo "Backed up existing $file to $file.backup"
    fi
    if [ -f "$SOURCE_DIR/$file" ]; then
        cp "$SOURCE_DIR/$file" "$TARGET_DIR/$file"
        echo "Copied $file to $TARGET_DIR"
    else
        echo "Warning: $file not found on desktop."
    fi
}

# Copy settings.json and keybindings.json
echo "Copying settings and keybindings..."
copy_file "settings.json"
copy_file "keybindings.json"

# Copy the entire extensions folder
echo "Copying extensions folder..."
if [ -d "$SOURCE_DIR/extensions" ]; then
    # Remove existing extensions to avoid conflicts (optional: comment out if you want to merge)
    rm -rf "$EXTENSIONS_TARGET_DIR"/*
    cp -r "$SOURCE_DIR/extensions/"* "$EXTENSIONS_TARGET_DIR/"
    echo "Extensions copied to $EXTENSIONS_TARGET_DIR"
else
    echo "Error: extensions folder not found on desktop. Please place it at $SOURCE_DIR/extensions."
    echo "Skipping extension installation."
fi

echo "Import process finished. Restart Cursor to apply changes."
