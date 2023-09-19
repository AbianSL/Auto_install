#!/bin/bash

source ../tools.sh

install_programming_environment() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_programming_environment_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_programming_environment_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_programming_environment_debian
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_lunar_vim() {
    echo "Installing LunarVim..."
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
}

install_programming_environment_opensuse() {
    sudo zypp
}

install_programming_environment_arch() {
    AUR_MANAGER="$(search_aur_manager)"
    echo "Using $AUR_MANAGER as AUR manager."
    AUR_MANAGER -S --needed visual-studio-code-bin
    sudo pacman -S git make python npm node cargo rust python-pip
}

install_programming_environment_debian() {
    sudo 
}
