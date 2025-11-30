#!/bin/bash

sudo apt install -y tmux

echo "######################################################"
echo "Copying tmux config files to the home dir."
echo -e "######################################################\n"
cat > ~/.tmux.conf <<'EOF'
# rebind ctrl b to ctrl space
unbind-key C-b
set -g prefix C-Space
bind C-Space send-prefix

# vim keybindings
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
setw -g mode-key vi

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# enable mouse
set -g mouse on
EOF

# checks if .bashrc entry already exists
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
