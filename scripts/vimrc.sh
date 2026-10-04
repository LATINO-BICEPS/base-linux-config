#!/bin/bash

set -euo pipefail

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

if [[ -e "$HOME/.vimrc" ]]; then
  if diff --color ~/.vimrc ./config/vimrc; then
    echo "There are no differences in your vim config."
    exit 0
  fi
  check_yes_no "Do you want to replace your current config with the following? [Y/n] "
  cp ./config/vimrc ~/.vimrc
  echo "Copied vimrc to $HOME/.vimrc"
fi
