#!/bin/bash

set -euo pipefail
sudo -v

# https://askubuntu.com/questions/551378/is-there-any-default-function-utility-to-prompt-the-user-for-yes-no-in-a-bash-sc
check_yes_no(){
    while true; do
        read -p "$1" yn
        if [ "$yn" = "" ]; then
            yn='Y'
        fi
        case "$yn" in
            [Yy])
                break;;
            [Nn])
                echo "Aborting..."
                exit 1;;
            *)
                echo "Please answer y or n for yes or no.";;
        esac
    done;
}

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

NEW="./config/tmux"
OLD="$HOME/.tmux.conf"

if [[ -e "$OLD" ]]; then
  if diff --color "$OLD" "$NEW"; then
    echo "There are no differences in your tmux config."
    exit 0
  fi
  check_yes_no "Do you want to replace your current config with the following? [Y/n] "
  cp "$NEW" "$OLD" 
  echo "Copied tmux.conf to $OLD"
fi

# automatically tmux on SSH
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
