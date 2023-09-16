#!/bin/bash

install_programming_lang_packages() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_gaming_tools_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_gaming_tools_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_gaming_tools_debian
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_gaming_tools_opensuse() {
    sudo zypper install -y steam lutris wine
}

install_gaming_tools_arch() {
    sudo pacman -S --noconfirm steam lutris wine
}

install_gaming_tools_debian() {
    sudo apt-get install -y steam lutris wine
}