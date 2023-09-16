#!/bin/bash

install_miscellaneous_tools() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_miscellaneous_tools_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_miscellaneous_tools_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_miscellaneous_tools_debian
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_miscellaneous_tools_opensuse() {
    sudo zypper install tree neofetch
}

install_miscellaneous_tools_arch() {
    sudo pacman -S tree neofetch
}

install_miscellaneous_tools_debian() {
    sudo apt-get install tree neofetch
}