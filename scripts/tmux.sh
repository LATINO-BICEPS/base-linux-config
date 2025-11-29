#!/bin/bash

sudo apt install -y tmux

echo "Copying tmux config files to the home dir."
cp config/tmux.conf ~/.tmux.conf

echo "Killing all tmux sessions"
tmux kill-session
