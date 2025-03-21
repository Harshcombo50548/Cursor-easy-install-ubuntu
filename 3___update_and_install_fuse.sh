#!/bin/bash

# Exit on any error
set -e

# Function to check if command succeeded
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed. Exiting."
        exit 1
    fi
}

# Update package list
echo "Updating package list..."
sudo apt update
check_status "apt update"

# Install libfuse2
echo "Installing libfuse2..."
sudo apt install -y libfuse2
check_status "libfuse2 installation"

# Upgrade all packages
echo "Upgrading installed packages..."
sudo apt upgrade -y
check_status "apt upgrade"

echo "All tasks completed successfully!"
