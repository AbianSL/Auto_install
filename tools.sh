#!/bin/bash

search_aur_manager() {
    aur_managers=("yay" "trizen" "paru")
    
    echo "Searching for a AUR manager..."
    
    sleep 1

    for manager in "${aur_managers[@]}"; do
        if command -v "$manager" &>/dev/null; then
            echo "Found $manager as AUR manager."
            return $manager
        fi
    done
    
    echo "No AUR manager found."
    
    sleep 1

    echo "Do you want to install yay? (Type 'Yes' or 'Y' to confirm): " confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
    
    echo "Installing yay..."
    sudo pacman -S --needed yay
    
    sleep 1

    echo "Installation of yay finished."
    return "yay"
}
