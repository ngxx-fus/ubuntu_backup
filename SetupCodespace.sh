#!/bin/bash

## @file setup_dev_env.sh
## @brief Automated environment setup script.
## @details Generates color/alias config files, installs packages, PlatformIO, and Doxygen.
##          Updates .bashrc to source the generated configurations.

SHELLRC="$HOME/.bashrc"
COLOR_FILE="$HOME/.shell_colors.sh"
ALIAS_FILE="$HOME/.user_aliases.sh"

## @brief Helper function to generate the color file
## @details Creates ~/.shell_colors.sh if it doesn't exist using the provided content.
generate_color_file() {
    if [ -f "$COLOR_FILE" ]; then
        echo "[INFO] $COLOR_FILE already exists. Skipping generation."
    else
        echo "[INFO] Generating $COLOR_FILE..."
        cat << 'EOF' > "$COLOR_FILE"
#! /bin/sh

# NOTE:
# You can mix [1] and [2] (or [1] and [3])
# But can NOT mix [2] and [3] bcz it will overwrite.

####### [1] TEXT EFFECT #######
BOLD="\033[1m"
FAINT="\033[2m"
ITALIC="\033[3m"
UNDERLINED="\033[4m"

####### [2] TEXT COLOR #######
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
LIGHT_GRAY="\033[37m"
GRAY="\033[90m"
LIGHT_RED="\033[91m"
LIGHT_GREEN="\033[92m"
LIGHT_YELLOW="\033[93m"
LIGHT_BLUE="\033[94m"
LIGHT_MAGENTA="\033[95m"
LIGHT_CYAN="\033[96m"
WHITE="\033[97m"

####### [3] BACKGROUND COLOR #######
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_LIGHT_GRAY="\033[47m"
BG_GRAY="\033[100m"
BG_LIGHT_RED="\033[101m"
BG_LIGHT_GREEN="\033[102m"
BG_LIGHT_YELLOW="\033[103m"
BG_LIGHT_BLUE="\033[104m"
BG_LIGHT_MAGENTA="\033[105m"
BG_LIGHT_CYAN="\033[106m"
BG_WHITE="\033[107m"

####### RESET #######
NORMAL="\033[0m"
NORM="\033[0m"
ENDCOLOR="\033[0m"
EOF
        # Give execution permission
        chmod +x "$COLOR_FILE"
        echo "[OK] Generated $COLOR_FILE"
    fi
}

## @brief Helper function to generate the alias file
## @details Creates ~/.user_aliases.sh if it doesn't exist.
generate_alias_file() {
    if [ -f "$ALIAS_FILE" ]; then
        echo "[INFO] $ALIAS_FILE already exists. Skipping generation."
    else
        echo "[INFO] Generating $ALIAS_FILE..."
        cat << 'EOF' > "$ALIAS_FILE"
# User alias
alias ll='ls -alFt'
alias la='ls -A'
alias l='ls -CF'

# Navigation
alias internal_downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias tmp='cd /tmp'
# Note: Ensure /mnt/sda2 exists before using this alias
alias downloads='cd /mnt/sda2/linux_downloads' 

# Config editing
alias nanobashrc="sudo nano ~/.bashrc"
alias bashrc="vim ~/.bashrc"

# System updates
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"

# Git aliases
alias clone='git clone '
alias push='git push '
alias pull='git pull '
alias addall='git add -Av '
alias commit='git commit '
alias merge='git merge '
alias commitmsg='git commit -m '
alias checkout='git checkout '
EOF
        chmod +x "$ALIAS_FILE"
        echo "[OK] Generated $ALIAS_FILE"
    fi
}

# ==============================================================================
# MAIN EXECUTION
# ==============================================================================

echo "## 1. Setup Colors and Core Packages"
generate_color_file

# Source the colors immediately so we can use them in this script if needed
if [ -f "$COLOR_FILE" ]; then
    source "$COLOR_FILE"
    echo -e "${GREEN}[MSG] Colors loaded successfully.${ENDCOLOR}"
fi

echo -e "${BOLD}[ACTION] Updating package lists...${ENDCOLOR}"
sudo apt-get update

echo -e "${BOLD}[ACTION] Installing core packages (duf, neofetch, nvim, make, curl, wget)...${ENDCOLOR}"
sudo apt-get install -y duf neofetch neovim make curl wget git

# ==============================================================================

echo -e "${BOLD}## 2. Install PlatformIO runtime and bin-utils${ENDCOLOR}"
# Install python3-venv (needed for valid pip installations) and binutils
sudo apt-get install -y python3-venv binutils python3-pip

echo "[ACTION] Installing PlatformIO Core via pip..."
# Using python3 -m pip is safer than bare 'pip'
python3 -m pip install -U platformio

# Add local bin to PATH for this session so we can check version later
export PATH=$PATH:$HOME/.local/bin

# ==============================================================================

echo -e "${BOLD}## 3. Install documentation tools${ENDCOLOR}"
echo "[ACTION] Installing Doxygen and Graphviz..."
sudo apt-get install -y doxygen graphviz

# ==============================================================================

echo -e "${BOLD}## 4. Setup Aliases and Configure Shell${ENDCOLOR}"
generate_alias_file

# Check if we need to add sourcing to .bashrc
# We look for a unique marker to avoid adding it twice
MARKER="### AUTO-GENERATED SETUP_DEV_ENV START"

if grep -q "$MARKER" "$SHELLRC"; then
    echo -e "${YELLOW}[INFO] Configuration already present in $SHELLRC.${ENDCOLOR}"
else
    echo -e "${BOLD}[ACTION] Appending configuration to $SHELLRC...${ENDCOLOR}"
    cat <<EOF >> "$SHELLRC"

$MARKER
# Source custom colors
if [ -f "$COLOR_FILE" ]; then
    source "$COLOR_FILE"
fi

# Source custom aliases
if [ -f "$ALIAS_FILE" ]; then
    source "$ALIAS_FILE"
fi

# Ensure PlatformIO is in PATH
export PATH=\$PATH:\$HOME/.local/bin
### AUTO-GENERATED SETUP_DEV_ENV END
EOF
    echo -e "${GREEN}[OK] $SHELLRC updated.${ENDCOLOR}"
fi

# ==============================================================================
echo -e "${GREEN}${BOLD}## Setup Complete!${ENDCOLOR}"
echo -e "Please run: ${CYAN}source $SHELLRC${ENDCOLOR} or restart your terminal."
