#!/bin/bash

set -euo pipefail
sudo -v

if [[ $(uname) == "Darwin" ]]; then
    if ! command -v brew; then
        echo "brew not installed - https://brew.sh/"
        exit 1
    brew install tmux
    fi

elif command -v apt &>/dev/null; then
    sudo apt install -y tmux

elif command -v pacman &>/dev/null; then
    sudo pacman -S --needed --noconfirm tmux
fi

# save previous tmux config if it exists 
[ -f "$HOME/.tmux.conf" ] && cp ~/.tmux.conf ~/.tmux.conf.bak
echo "Backup of original config is saved to $HOME/.tmux.conf.bak"

cp ./config/tmux ~/.tmux.conf
echo "Copied tmux config to $HOME/.tmux.conf"

# check if shell is bash/fish
if [[ $(basename $SHELL) == "bash" ]]; then
    # check if ssh_tmux entry already exists in bashrc 
    if [[ -z $(cat ~/.bashrc | grep ssh_tmux) ]]; then
        echo "Adding entry to .bashrc to automatically tmux on ssh"
cat >> ~/.bashrc <<'EOF'
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
EOF
    fi    

elif [[ $(basename $SHELL) == "fish" ]]; then
    # check if ssh_tmux entry already exists in bashrc 
    if [[ -z $(cat ~/.config/fish/config.fish | grep ssh_tmux) ]]; then
        echo "Adding entry to .config.fish to automatically tmux on ssh"
cat >> ~/.config/fish/config.fish <<'EOF'
if status is-interactive; and not set -q TMUX; and test -n "$SSH_TTY"
    tmux attach-session -t ssh_tmux; or tmux new-session -s ssh_tmux
end
EOF
    fi
fi    
