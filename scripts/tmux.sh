#!/bin/bash

sudo apt install -y tmux

echo "######################################################"
echo "Copying tmux config files to home dir"
echo -e "######################################################\n"
cp ./config/tmux.conf ~/.tmux.conf

# check if .bashrc entry already exists
BASHRC_MISSING=$(cat ~/.bashrc | grep ssh_tmux)
if [[ -z $BASHRC_MISSING ]]; then
    echo "######################################################"
    echo "Adding entry to .bashrc to automatically tmux on ssh"
    echo "######################################################"
    cat >> ~/.bashrc <<'EOF'
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
EOF
fi    

echo "######################################################"
echo "Killing all tmux sessions"
echo -e "######################################################\n"
tmux kill-session
