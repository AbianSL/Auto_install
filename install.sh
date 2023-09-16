#!/bin/bash

# Import the functions from separate files
source programming/install_programming_lang_packages.sh
source gaming/install_gaming_tools.sh
source miscellaneous/install_miscellaneous_tools.sh

# Function to display usage information
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  +a, --add-all                Add all categories of tools."
    echo "  +p, --add-programming        Add programming language-related packages."
    echo "  +g, --add-gaming             Add gaming tools (Steam, Lutris, Wine)."
    echo "  +m, --add-miscellaneous      Add miscellaneous tools (tree, neofetch)."
    echo "  -a, --remove-all             Remove all categories of tools."
    echo "  -p, --remove-programming     Remove programming language-related packages."
    echo "  -g, --remove-gaming          Remove gaming tools (Steam, Lutris, Wine)."
    echo "  -m, --remove-miscellaneous   Remove miscellaneous tools (tree, neofetch)."
    echo "  -h, --help                   Display this help message."
    exit 1
}

# Function to detect the Linux distribution
detect_distribution() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        DISTRIBUTION="$ID_LIKE"
    else
        DISTRIBUTION="unknown"
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

    read -p "Do you want to proceed with installation? (Type 'Yes' or 'Y' to confirm): " confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
}
            ;;
        -m|--add-miscellaneous)
            INSTALL_MISC=true
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            ;;
        debian)
            ;;
        *)
            echo "Unsupported distribution detected."
            exit 1
            ;;
    esac
else
    echo "Unable to detect the system's distribution."
    exit 1
confirm_installation

fi

echo "Programming language-related packages and gaming tools have been installed successfully."

