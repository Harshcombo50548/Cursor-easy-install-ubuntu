#!/bin/bash

# Find the latest Cursor AppImage in Downloads
APPIMAGE=$(find ~/Downloads -iname '*Cursor*.appimage' -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)

# Check if an AppImage was found
if [ -z "$APPIMAGE" ]; then
    echo "No Cursor AppImage found in Downloads."
    exit 1
fi

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
    echo "Cursor is already in favorites."
else
    NEW_FAVES=$(echo "$CURRENT_FAVES" | sed "s/]/, 'cursor.desktop']/")
    gsettings set org.gnome.shell favorite-apps "$NEW_FAVES"
fi
