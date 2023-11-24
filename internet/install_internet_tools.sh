#!/bin/bash

install_internet_tools() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_internet_tools_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_internet_tools_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_internet_tools_debian
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_internet_tools_opensuse() {
    sudo zypper install discord firefox brave
}

install_internet_tools_arch() {
    sudo pacman -S firefox discord
    echo "For installing brave you should install a AUR"
    echo "It will install Yay"
    read -p "Do you want to proceed with installation? (Type 'Yes' or 'Y' to confirm): " confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
    suddo pacman -S yay
    yay -S brave
}

install_internet_tools_debian() {
    sudo apt update
    sudo apt install firefox telegram-desktop

    read "Do you want to install snapd for install discord? (Type 'Yes' or 'Y' to confirm): " -p confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi

    sudo apt install snapd
    sudo snap install discord

    sudo apt install curl

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser
}
