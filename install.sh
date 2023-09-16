#!/bin/bash

# Import the functions from separate files
source programming/install_programming_lang_packages.sh
source gaming/install_gaming_tools.sh
source miscellaneous/install_miscellaneous_tools.sh

# Detect the current distribution
if [ -f /etc/os-release ]; then
    source /etc/os-release
    case $ID_LIKE in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_programming_lang_packages_opensuse
            install_gaming_tools_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_programming_lang_packages_arch
            install_gaming_tools_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_programming_lang_packages_debian
            install_gaming_tools_debian
            ;;
        *)
            echo "Unsupported distribution detected."
            exit 1
            ;;
    esac
else
    echo "Unable to detect the system's distribution."
    exit 1
fi

echo "Programming language-related packages and gaming tools have been installed successfully."

