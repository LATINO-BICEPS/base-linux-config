#!/bin/bash

set -euo pipefail
sudo -v

if [[ $(uname) == "Darwin" ]]; then
    if ! command -v brew; then
        echo "brew not installed - https://brew.sh/"
        exit 1
    else
        brew install gh git 
    fi

elif command -v apt &>/dev/null; then
    sudo apt install -y gh git

elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm github-cli git 
fi

if ! gh auth status; then 
    gh auth login
    git config --global user.email "collinz888z@yahoo.com"
    git config --global user.name "Collin"
    git config --global core.editor "vim"
    echo "GitHub global git config has been set."
fi
