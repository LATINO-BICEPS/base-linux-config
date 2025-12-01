#!/bin/bash

if [[ $(uname) == "Darwin" ]]; then
    cp ./config/bashrc.macos ~/.bashrc
    echo "Copied .bashrc_macos to home dir"
    BASH_PROFILE_EXISTS=$(cat ~/.bash_profile | grep "source ~/.bashrc") 
    if [[ -z $BASH_PROFILE_EXISTS ]]; then
        cat >> ~/.bash_profile <<'EOF'
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
EOF
        echo "added entry to .bash_profile"
        source ~/.bashrc
        echo ".bashrc updated" 
    fi
else
    cp ./config/bashrc ~/.bashrc
    echo "Copied .bashrc to home dir"
    source ~/.bashrc
fi
