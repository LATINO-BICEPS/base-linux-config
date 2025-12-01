#!/bin/bash

if [[ $(uname) == "Darwin" ]]; then
    if ! command -v brew; then
        echo "brew not installed - https://brew.sh/"
        exit 1
    brew install tmux
    fi
else
    sudo apt install -y tmux
fi

cp ./config/tmux ~/.tmux.conf
echo "copied tmux config"

# check if .bashrc entry already exists
if [[ -z $(cat ~/.bashrc | grep ssh_tmux) ]]; then
    echo "Adding entry to .bashrc to automatically tmux on ssh"
    cat >> ~/.bashrc <<'EOF'
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
EOF
fi    

echo "Killing all tmux sessions"
tmux kill-session
