# Cursor Installer for Ubuntu

This project is designed to help you easily install **Cursor** on an Ubuntu machine. It provides a series of 6 scripts that you can run sequentially for a smooth installation experience. The process is simple: clone the repository and execute the scripts one by one.

### Installation Steps

1. **Clone the repository to desktop**:
    ```bash
    git clone https://github.com/Harshcombo50548/Cursor-easy-install-ubuntu.git ```

2. **Run the installation scripts**:

    The following scripts are available to install **Cursor** and some useful configurations. You can skip any script based on your preferences (e.g., if you don't want to import Visual Studio Code extensions into Cursor).

    - `ME_FIRST!!!.sh`: Setup and prerequisites (run first).
    - `1___open_cursor_downloads.sh`: Open the Cursor download page.
    - `2___open_temp_mail.sh`: Open a temporary email provider for registration.
    - `3___update_and_install_fuse.sh`: Update system packages and install FUSE (needed for running AppImages).
    - `4___install_cursor_appimage.sh`: Download and install Cursor as an AppImage.
    - `5___import_vscode_to_cursor.sh`: Import useful Visual Studio Code extensions into Cursor (optional).

    Run each script one by one in the terminal:
    ```bash
    ./ME_FIRST!!!.sh
    ./1___open_cursor_downloads.sh
    ./2___open_temp_mail.sh
    ./3___update_and_install_fuse.sh
    ./4___install_cursor_appimage.sh
    ./5___import_vscode_to_cursor.sh
    ```

    You can skip the `5___import_vscode_to_cursor.sh` script if you don’t want to import VSCode extensions.

### Prerequisites

- Ubuntu (tested on Ubuntu 20.04)
- A terminal with sudo privileges
- An active internet connection

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to contribute to this project by opening issues or submitting pull requests but there is no promises of fulfilling these requests.

Enjoy Cursor on your Ubuntu machine!
