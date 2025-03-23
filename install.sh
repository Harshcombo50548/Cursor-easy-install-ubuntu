#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to show progress
show_progress() {
    local step=$1
    local total=$2
    local title=$3
    local width=50
    local progress=$((width * step / total))
    local bar=$(printf "%${progress}s" | tr ' ' '█')
    local spaces=$(printf "%$((width - progress))s")
    echo -e "${CYAN}Step $step/$total: $title${NC}"
    echo -e "[${GREEN}$bar${NC}${spaces}] ${YELLOW}$((step * 100 / total))%${NC}"
    echo ""
}

# Function to wait for user confirmation
wait_for_confirmation() {
    echo -e "${YELLOW}$1${NC}"
    read -p "Press Enter to continue..."
    echo ""
}

# Function to check if a program is installed
check_install() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${YELLOW}Installing $1...${NC}"
        sudo apt-get update -qq
        sudo apt-get install -y $1
        echo -e "${GREEN}$1 installed successfully.${NC}"
    else
        echo -e "${GREEN}$1 is already installed.${NC}"
    fi
}

# Check for required tools
check_dependencies() {
    echo -e "${BLUE}Checking dependencies...${NC}"
    check_install curl
    check_install unzip
    check_install xdg-open
    echo ""
}

# Clear the screen
clear

# Show ASCII art
echo -e "${CYAN}"
cat << "EOF"
  _____  _    _  _____   _____  ____  _____  
 / ____|| |  | ||  __ \ / ____|/ __ \|  __ \ 
| |     | |  | || |__) | (___ | |  | | |__) |
| |     | |  | ||  _  / \___ \| |  | |  _  / 
| |____ | |__| || | \ \ ____) | |__| | | \ \ 
 \_____| \____/ |_|  \_\_____/ \____/|_|  \_\
                                             
     Ultimate Setup Wizard for Ubuntu
EOF
echo -e "${NC}"

echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║          C.U.R.S.O.R Setup             ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"

read -p "Resize terminal now? (recommended 100+ cols) [y/N]: " resize
[[ "$resize" =~ ^[yY]$ ]] && read -p "Resize then press Enter..."

clear

# Show ASCII art (again after resize)
echo -e "${CYAN}"
cat << "EOF"
  _____  _    _  _____   _____  ____  _____  
 / ____|| |  | ||  __ \ / ____|/ __ \|  __ \ 
| |     | |  | || |__) | (___ | |  | | |__) |
| |     | |  | ||  _  / \___ \| |  | |  _  / 
| |____ | |__| || | \ \ ____) | |__| | | \ \ 
 \_____| \____/ |_|  \_\_____/ \____/|_|  \_\
                                             
     Ultimate Setup Wizard for Ubuntu
EOF
echo -e "${NC}"

# Check dependencies
check_dependencies

# STEP 1: Install Extensions
show_progress 1 6 "Installing Extensions"

# Define variables for extensions
DOWNLOAD_URL="https://github.com/Harshcombo50548/Cursor-easy-install-ubuntu/releases/download/v1.0.0/extensions.zip"
DOWNLOAD_DIR="$HOME/Downloads"
ZIP_FILE="$DOWNLOAD_DIR/extensions.zip"
EXTRACT_DIR="$HOME/Desktop"

# Create directories if they don't exist
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$EXTRACT_DIR"

# Download the extensions.zip file
echo -e "${BLUE}Downloading extensions.zip from GitHub...${NC}"
if ! curl -L "$DOWNLOAD_URL" -o "$ZIP_FILE"; then
    echo -e "${RED}Error: Failed to download extensions.zip. Check your internet connection or the URL.${NC}"
    exit 1
fi

# Verify the file was downloaded
if [ ! -f "$ZIP_FILE" ]; then
    echo -e "${RED}Error: Downloaded file not found.${NC}"
    exit 1
fi

# Unzip the file to the target directory
echo -e "${BLUE}Extracting extensions.zip to $EXTRACT_DIR...${NC}"
if ! unzip -o "$ZIP_FILE" -d "$EXTRACT_DIR"; then
    echo -e "${RED}Error: Failed to unzip the file. Please make sure unzip is installed.${NC}"
    exit 1
fi

# Clean up by removing the zip file
echo -e "${BLUE}Cleaning up...${NC}"
rm -f "$ZIP_FILE"

echo -e "${GREEN}Extensions installed successfully!${NC}"
echo ""

# STEP 2: Open Cursor Install Page
wait_for_confirmation "Now we'll open the Cursor downloads page in your browser."

show_progress 2 6 "Opening Cursor Download Page"
echo -e "${BLUE}Opening Cursor download page...${NC}"
xdg-open https://www.cursor.com/downloads

wait_for_confirmation "Please download and install Cursor from the website. When you're done, press Enter to continue."

# STEP 3: Open TempMail Page
show_progress 3 6 "Opening Temporary Email Service"
echo -e "${BLUE}Opening temporary email service...${NC}"
xdg-open https://www.emailnator.com/

wait_for_confirmation "Please use this email service for Cursor registration if needed. When you're done, press Enter to continue."

# STEP 4: Install Fuse
show_progress 4 6 "Installing Fuse"

echo -e "${BLUE}Updating package list...${NC}"
sudo apt update

echo -e "${BLUE}Installing libfuse2...${NC}"
sudo apt install -y libfuse2

echo -e "${BLUE}Upgrading installed packages...${NC}"
sudo apt upgrade -y

echo -e "${GREEN}Fuse installed successfully!${NC}"
echo ""

# STEP 5: Install Cursor AppImage
show_progress 5 6 "Setting Up Cursor AppImage"

echo -e "${BLUE}Looking for Cursor AppImage in Downloads folder...${NC}"
APPIMAGE=$(find ~/Downloads -iname '*Cursor*.appimage' -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)

if [ -z "$APPIMAGE" ]; then
    echo -e "${YELLOW}No Cursor AppImage found in Downloads.${NC}"
    echo -e "${YELLOW}Please make sure you downloaded the AppImage from cursor.com.${NC}"
    wait_for_confirmation "After downloading the AppImage, press Enter to continue."
    APPIMAGE=$(find ~/Downloads -iname '*Cursor*.appimage' -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)
    
    if [ -z "$APPIMAGE" ]; then
        echo -e "${RED}Still no AppImage found. Please download it manually and run Step 5 later.${NC}"
    fi
else
    # Define target directory and file
    TARGET_DIR=~/bin
    TARGET_FILE=$TARGET_DIR/cursor.appimage

    # Create target directory if it doesn't exist
    mkdir -p $TARGET_DIR

    # Move and rename the AppImage (overwriting if exists)
    mv -f "$APPIMAGE" "$TARGET_FILE"

    # Make it executable
    chmod +x "$TARGET_FILE"

    # Create a .desktop file for application menu integration
    DESKTOP_FILE=~/.local/share/applications/cursor.desktop
    APPIMAGE_PATH=$(realpath $TARGET_FILE)
    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Cursor
Exec=$APPIMAGE_PATH --no-sandbox
Terminal=false
Type=Application
Icon=application-x-executable
Categories=Development;
EOF

    # Add to the GNOME Shell favorites (taskbar)
    CURRENT_FAVES=$(gsettings get org.gnome.shell favorite-apps)
    if echo "$CURRENT_FAVES" | grep -q "'cursor.desktop'"; then
        echo -e "${BLUE}Cursor is already in favorites.${NC}"
    else
        NEW_FAVES=$(echo "$CURRENT_FAVES" | sed "s/]/, 'cursor.desktop']/")
        gsettings set org.gnome.shell favorite-apps "$NEW_FAVES"
    fi

    echo -e "${GREEN}Cursor AppImage setup completed!${NC}"
fi
echo ""

# STEP 6: Import Extensions
show_progress 6 6 "Importing Extensions"

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
        echo -e "${BLUE}Backed up existing $file to $file.backup${NC}"
    fi
    if [ -f "$SOURCE_DIR/$file" ]; then
        cp "$SOURCE_DIR/$file" "$TARGET_DIR/$file"
        echo -e "${BLUE}Copied $file to $TARGET_DIR${NC}"
    else
        echo -e "${YELLOW}Warning: $file not found on desktop.${NC}"
    fi
}

# Copy settings.json and keybindings.json
echo -e "${BLUE}Copying settings and keybindings...${NC}"
copy_file "settings.json"
copy_file "keybindings.json"

# Copy the entire extensions folder
echo -e "${BLUE}Copying extensions folder...${NC}"
if [ -d "$SOURCE_DIR/extensions" ]; then
    # Remove existing extensions to avoid conflicts (optional: comment out if you want to merge)
    rm -rf "$EXTENSIONS_TARGET_DIR"/*
    cp -r "$SOURCE_DIR/extensions/"* "$EXTENSIONS_TARGET_DIR/"
    echo -e "${GREEN}Extensions copied to $EXTENSIONS_TARGET_DIR${NC}"
else
    echo -e "${RED}Error: extensions folder not found on desktop. Please place it at $SOURCE_DIR/extensions.${NC}"
    echo -e "${RED}Skipping extension installation.${NC}"
fi

echo -e "${GREEN}Import process finished!${NC}"
echo ""

# Installation complete
echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     Installation Complete! 🎉          ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Cursor has been installed and configured on your system.${NC}"
echo -e "${YELLOW}Please restart Cursor to apply all extensions and settings.${NC}"
echo ""
echo -e "${BLUE}Happy coding!${NC}"

exit 0 