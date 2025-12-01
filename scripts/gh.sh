#!/bin/bash

if [[ $(uname) == "Darwin" ]]; then
    if ! command -v brew; then
        echo "brew not installed - https://brew.sh/"
        exit 1
    brew install gh git 
    fi
else
    sudo apt install -y gh git
fi

if ! gh auth status; then 
    gh auth login
    echo
    echo "############################"
    echo "Setting global git config"
    echo "############################"
    echo
    git config --global user.email "collinz888z@yahoo.com"
    git config --global user.name "Collin"
    git config --global core.editor "vim"
fi
