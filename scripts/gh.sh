#!/bin/bash

sudo apt install -y gh git
gh auth login

echo "Setting global git config"
git config --global user.email "collinz888z@yahoo.com"
git config --global user.name "Collin"
git config --global core.editor "vim"
