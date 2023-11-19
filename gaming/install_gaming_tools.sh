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
    echo "For Installing Steam and wine, you need to enable the multilib repository."
    read -p "Do you want to enable it now? (y/n)" confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ $confirmation == "y" ]; then
        sudo cp multilib_enable.txt /etc/pacman.conf
        sudo pacman -Syu
        sudo pacman -S wine steam
    fi
    sudo pacman -S lutris
}

install_gaming_tools_debian() {
    sudo apt-get install wine
    echo "To install steam, you need to enable the multiverse repository."
    read -p "Do you want to enable it now? (y/n)" confirmation
    confirmation="$(echo $confirmation | tr '[:upper:]' '[:lower:]')"
    if [ $confirmation == "y" ]; then
        sudo add-apt-repository multiverse
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install steam steam-installer
    fi
    sudo apt-get install curl
    wget https://github.com/lutris/lutris/releases/download/v0.5.13/lutris_0.5.13_all.deb
    chmod u+x lutris_0.5.13_all.deb
    ./lutris_0.5.13_all.deb
}
