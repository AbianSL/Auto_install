#!/bin/bash

install_programming_lang_packages() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_programming_lang_packages_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_programming_lang_packages_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_programming_lang_packages_opensuse() {
    sudo zypper install -y gcc-c++ make cmake ruby java python3 python2-prolog kotlin
}

install_programming_lang_packages_arch() {
    sudo pacman -S --noconfirm gcc make cmake ruby jdk8-openjdk jre8-openjdk python python2 swi-prolog kotlin
}

install_programming_lang_packages_debian() {
    sudo apt-get update
    sudo apt-get install -y g++ make cmake ruby-full openjdk-11-jdk openjdk-11-jre python3 python-prolog golang-kotlin
}
