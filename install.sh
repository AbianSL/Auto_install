#!/bin/bash

# Import the functions from separate files
source programming/install_programming_lang_packages.sh
source gaming/install_gaming_tools.sh
source miscellaneous/install_miscellaneous_tools.sh
source prog_environment/install_programming_environment.sh

# Variables for options
INSTALL_PROGRAMMING=false
INSTALL_GAMING=false
INSTALL_MISC=false
INSTALL_PROGRAMMING_ENV=false

# Function to display usage information
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  +a, --add-all                Add all categories of tools."
    echo "  +p, --add-programming        Add programming language-related packages."
    echo "  +g, --add-gaming             Add gaming tools (Steam, Lutris, Wine)."
    echo "  +m, --add-miscellaneous      Add miscellaneous tools (tree, neofetch)."
    echo "  +e, --add-programming-env    Add programming environments (VSCode, Android Studio, LunarVim)."
    echo "  -a, --remove-all             Remove all categories of tools."
    echo "  -p, --remove-programming     Remove programming language-related packages."
    echo "  -g, --remove-gaming          Remove gaming tools (Steam, Lutris, Wine)."
    echo "  -m, --remove-miscellaneous   Remove miscellaneous tools (tree, neofetch)."
    echo "  -e, --remove-programming-env Remove programming environments (VSCode, Android Studio, LunarVim)."
    echo "  -h, --help                   Display this help message."
    exit 1
}

# Function to detect the Linux distribution
detect_distribution() {
    if command -v apt-get &> /dev/null 2>&1; then
      DISTRIBUTION="debian"
    elif command -v pacman &> /dev/null 2>&1; then
      DISTRIBUTION="arch"
    elif command -v dnf &> /dev/null 2>&1; then
      DISTRIBUTION="fedora"
    elif command -v zypper &> /dev/null 2>&1; then
      DISTRIBUTION="opensuse"
    else
      echo "Your distribution is not supported by this script."
      exit 1
    fi 

}

# Function to confirm installation
confirm_installation() {
    echo "The following components will be installed:"
    if [ "$INSTALL_PROGRAMMING" = true ]; then
        echo "  -- Programming language-related packages --"
        echo "     It will install the next packages:      "
        echo "       c++ compiler                          "
        echo "       ruby interpreter                      "
        echo "       python interpreter                    "
        echo "       Java Jre and JDK                      "
        echo "       Prolog interpreter                    "
    fi
    
    if [ "$INSTALL_GAMING" = true ]; then
        echo "  -- Gaming tools --  "
        echo "     It will install: "
        echo "       Steam          "
        echo "       Wine           "
        echo "       Lutris         "
    fi
    
    if [ "$INSTALL_MISC" = true ]; then
        echo "  -- Miscellaneous tools --  "
        echo "     It will install:        "
        echo "       Neofetch              "
        echo "       tree                  "
    fi

    if [ "$INSTALL_PROGRAMMING_ENV" = true ]; then
        echo "  -- Programming environments --  "
        echo "     It will install:             "
        echo "       Visual Studio Code         "
        echo "       Android Studio             "
        echo "       LunarVim                   "
    fi

    if [ "$INSTALL_PROGRAMMING" = false ] && [ "$INSTALL_GAMING" = false ] && [ "$INSTALL_MISC" = false ]; then
        echo "Nothing will be installed."
        exit 1
    fi

    read -p "Do you want to proceed with installation? (Type 'Yes' or 'Y' to confirm): " confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
}

# Check for command-line arguments
if [ $# -eq 0 ]; then
    usage
fi


detect_distribution

# Process command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        +a|--add-all)
            INSTALL_PROGRAMMING=true
            INSTALL_GAMING=true
            INSTALL_MISC=true
            ;;
        -a|--remove-all)
            INSTALL_PROGRAMMING=false
            INSTALL_GAMING=false
            INSTALL_MISC=false
            ;;
        +p|--add-programming)
            INSTALL_PROGRAMMING=true
            ;;
        -p|--remove-programming)
            INSTALL_PROGRAMMING=false
            ;;
        +g|--add-gaming)
            INSTALL_GAMING=true
            ;;
        -g|--remove-gaming)
            INSTALL_GAMING=false
            ;;
        -m|--add-miscellaneous)
            INSTALL_MISC=false
            ;;
        +m|--remove-miscellaneous)
            INSTALL_MISC=true
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Invalid option: $key"
            usage
            ;;
    esac
    shift
done

confirm_installation

# Install or remove selected categories of tools
if [ "$INSTALL_PROGRAMMING" = true ]; then
    echo "Installing programming language-related packages on $DISTRIBUTION..."
    install_programming_lang_packages $DISTRIBUTION
fi

if [ "$INSTALL_GAMING" = true ]; then
    echo "Installing gaming tools (Steam, Lutris, Wine) on $DISTRIBUTION..."
    install_gaming_tools $DISTRIBUTION
fi

if [ "$INSTALL_MISC" = true ]; then
    echo "Installing miscellaneous tools (tree, neofetch) on $DISTRIBUTION..."
    install_miscellaneous_tools $DISTRIBUTION
fi

if [ "$INSTALL_PROGRAMMING_ENV" = true ]; then
    echo "Installing programming environments (VSCode, Android Studio, LunarVim) on $DISTRIBUTION..."
    install_programming_environment $DISTRIBUTION
fi

echo "Installation complete."
