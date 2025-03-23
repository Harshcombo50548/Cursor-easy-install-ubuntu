#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl not found. Installing curl..."
    sudo apt-get update
    sudo apt-get install -y curl
    
    # Verify installation
    if ! command -v curl &> /dev/null; then
        echo "Error: Failed to install curl. Please install it manually (sudo apt-get install curl)."
        exit 1
    fi
    echo "curl installed successfully."
fi

# Define variables
DOWNLOAD_URL="https://github.com/Harshcombo50548/Cursor-easy-install-ubuntu/releases/download/v1.0.0/extensions.zip"
DOWNLOAD_DIR="$HOME/Downloads"
ZIP_FILE="$DOWNLOAD_DIR/extensions.zip"
EXTRACT_DIR="$HOME/Desktop"  # Changed to Desktop

# Create directories if they don't exist
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$EXTRACT_DIR"

# Download the extensions.zip file
echo "Downloading extensions.zip from GitHub..."
if ! curl -L "$DOWNLOAD_URL" -o "$ZIP_FILE"; then
    echo "Error: Failed to download extensions.zip. Check your internet connection or the URL."
    exit 1
fi

# Verify the file was downloaded
if [ ! -f "$ZIP_FILE" ]; then
    echo "Error: Downloaded file not found."
    exit 1
fi

# Unzip the file to the target directory
echo "Extracting extensions.zip to $EXTRACT_DIR..."
if ! unzip -o "$ZIP_FILE" -d "$EXTRACT_DIR"; then
    echo "Error: Failed to unzip the file. Ensure 'unzip' is installed (sudo apt install unzip) and the file is valid."
    exit 1
fi

# Clean up by removing the zip file (optional)
echo "Cleaning up..."
rm -f "$ZIP_FILE"

echo "Installation complete! Extensions should now be in $EXTRACT_DIR."
