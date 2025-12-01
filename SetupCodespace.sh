#!/bin/bash

## @file setup_dev_env.sh
## @brief Automated environment setup script.
## @details Generates color/alias config files, installs packages, PlatformIO, ESP-IDF, Doxygen, and Neovim Config.
##          Updates .bashrc to source the generated configurations.
##          Ensures execution happens in HOME and returns to original dir.

SHELLRC="$HOME/.bashrc"
COLOR_FILE="$HOME/.shell_colors.sh"
ALIAS_FILE="$HOME/.user_aliases.sh"
ESP_DIR="$HOME/esp"

## @brief Helper function to generate the color file
## @details Creates ~/.shell_colors.sh if it doesn't exist using the provided content.
generate_color_file() {
    if [ -f "$COLOR_FILE" ]; then
        echo "[INFO] $COLOR_FILE already exists. Skipping generation."
    else
        echo "[INFO] Generating $COLOR_FILE..."
        cat << 'EOF' > "$COLOR_FILE"
#! /bin/sh
####### [1] TEXT EFFECT #######
BOLD="\033[1m"
####### [2] TEXT COLOR #######
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RED="\033[31m"
####### RESET #######
NORMAL="\033[0m"
ENDCOLOR="\033[0m"
EOF
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

# ESP-IDF Shortcut
# Usage: type 'init_idf' in terminal to load ESP-IDF environment vars for that session
alias init_idf='. $HOME/esp/esp-idf/export.sh'
alias get_idf='. $HOME/esp/esp-idf/export.sh'
alias idf_init='. $HOME/esp/esp-idf/export.sh'
EOF
        chmod +x "$ALIAS_FILE"
        echo "[OK] Generated $ALIAS_FILE"
    fi
}

# ==============================================================================
# MAIN EXECUTION
# ==============================================================================

# [STEP 0] SAVE LOCATION & GO HOME
echo "----------------------------------------------------------------"
echo "[INIT] Saving current location..."
ORIGINAL_DIR=$(pwd)
echo "[INIT] Saved: $ORIGINAL_DIR"

echo "[INIT] Jumping to HOME directory (~)..."
cd ~ || { echo "Failed to go to Home directory"; exit 1; }
echo "[INIT] Now working at: $(pwd)"
echo "----------------------------------------------------------------"

# ------------------------------------------------------------------------------

echo "## 1. Setup Colors and Core Packages"
generate_color_file

# Source the colors immediately
if [ -f "$COLOR_FILE" ]; then
    source "$COLOR_FILE"
    echo -e "${GREEN}[MSG] Colors loaded successfully.${ENDCOLOR}"
fi

echo -e "${BOLD}[ACTION] Updating package lists...${ENDCOLOR}"
sudo apt-get update

echo -e "${BOLD}[ACTION] Installing core packages (duf, neofetch, nvim, make, curl, wget)...${ENDCOLOR}"
sudo apt-get install -y duf neofetch neovim make curl wget git

# ==============================================================================

echo -e "${BOLD}## 2. Setup Neovim Configuration${ENDCOLOR}"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_REPO="https://github.com/ngxx-fus/neovim-conf.git"

if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo -e "${YELLOW}[WARN] Directory $NVIM_CONFIG_DIR already exists.${ENDCOLOR}"
    echo -e "${YELLOW}[ABORT] Skipping Neovim config clone to preserve existing setup.${ENDCOLOR}"
else
    echo "[ACTION] Cloning Neovim config from $NVIM_REPO..."
    # Ensure .config exists
    mkdir -p "$HOME/.config"
    git clone "$NVIM_REPO" "$NVIM_CONFIG_DIR"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[OK] Neovim configuration installed successfully.${ENDCOLOR}"
    else
        echo -e "${RED}[ERR] Failed to clone Neovim configuration.${ENDCOLOR}"
    fi
fi

# ==============================================================================

echo -e "${BOLD}## 3. Install PlatformIO runtime and bin-utils${ENDCOLOR}"
sudo apt-get install -y python3-venv binutils python3-pip

echo "[ACTION] Installing PlatformIO Core via pip..."
python3 -m pip install -U platformio

# Add local bin to PATH for this session
export PATH=$PATH:$HOME/.local/bin

# ==============================================================================

echo -e "${BOLD}## 4. Install ESP-IDF (Espressif IoT Development Framework)${ENDCOLOR}"

# 4.1 Install Prerequisites for ESP-IDF
echo "[ACTION] Installing ESP-IDF dependencies (cmake, ninja, usb-libs)..."
sudo apt-get install -y git wget flex bison gperf python3 python3-pip python3-venv \
    cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

# 4.2 Create directory and Clone
if [ -d "$ESP_DIR/esp-idf" ]; then
    echo -e "${YELLOW}[INFO] ESP-IDF already exists at $ESP_DIR/esp-idf. Skipping clone.${ENDCOLOR}"
else
    echo "[ACTION] Creating directory $ESP_DIR and cloning ESP-IDF..."
    mkdir -p "$ESP_DIR"
    # Clone recursive is important for submodules
    git clone --recursive https://github.com/espressif/esp-idf.git "$ESP_DIR/esp-idf"
    
    echo "[ACTION] Running ESP-IDF install script (this may take a while)..."
    # Run the install script for all targets (esp32, esp32s3, etc.)
    "$ESP_DIR/esp-idf/install.sh"
    
    echo -e "${GREEN}[OK] ESP-IDF installed successfully.${ENDCOLOR}"
fi

# ==============================================================================

echo -e "${BOLD}## 5. Install documentation tools${ENDCOLOR}"
echo "[ACTION] Installing Doxygen and Graphviz..."
sudo apt-get install -y doxygen graphviz

# ==============================================================================

echo -e "${BOLD}## 6. Setup Aliases and Configure Shell${ENDCOLOR}"
generate_alias_file

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
# [STEP FINAL] RETURN TO ORIGINAL LOCATION
echo "----------------------------------------------------------------"
echo -e "${BOLD}[FINISH] Setup Complete!${ENDCOLOR}"
echo -e "${BOLD}[ACTION] Returning to original directory...${ENDCOLOR}"
cd "$ORIGINAL_DIR" || echo "Could not return to $ORIGINAL_DIR"
echo "[INFO] Back at: $(pwd)"
echo "----------------------------------------------------------------"

echo -e "Please run: ${CYAN}source $SHELLRC${ENDCOLOR} or restart your terminal."
echo -e "To use ESP-IDF, type: ${CYAN}init_idf${ENDCOLOR}"
