#!/bin/bash

install_gaming_tools() {
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
    sudo zypper install steam lutris wine
}

install_gaming_tools_arch() {
    sudo pacman -S steam lutris wine
}

install_gaming_tools_debian() {
    sudo apt-get install steam lutris wine
    echo "To install steam, you need to enable the multiverse repository."
    read echo "Do you want to enable it now? (y/n)" -p confirmation
    confirmation="${echo $confirmation | tr '[:upper:]' '[:lower:]'}"
    if [ $confirmation == "y" ]; then
        sudo add-apt-repository multiverse
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install steam steam-installer
    fi
}
