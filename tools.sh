#!/bin/bash

search_aur_manager() {
    local aur_managers=("yay" "trizen" "paru")
   
    # Print a message to the user at the error output
    echo "Searching for a AUR manager..." >&2
    
    sleep 1

    for manager in "${aur_managers[@]}"; do
        if command -v "$manager" &>/dev/null; then
            echo "$manager"
            return
        fi
    done
    
    echo "No AUR manager found." >&2
    
    sleep 1

    read -p "Do you want to install yay? (Type 'Yes' or 'Y' to confirm): " confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
    
    sudo pacman -S --needed yay
    
    sleep 1
    
    echo "yay"
}
