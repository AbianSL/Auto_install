# Function to confirm installation
confirm_installation() {
    echo "The following components will be installed:"
    if [ "$INSTALL_PROGRAMMING" = true ]; then
        echo "  - Programming language-related packages"
    fi
    if [ "$INSTALL_GAMING" = true ]; then
        echo "  - Gaming tools (Steam, Lutris, Wine)"
    fi
    if [ "$INSTALL_MISC" = true ]; then
        echo "  - Miscellaneous tools (tree, neofetch)"
    fi

    read -p "Do you want to proceed with installation? (Type 'Yes' or 'Y' to confirm): " confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"  # Convert to lowercase
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
}

