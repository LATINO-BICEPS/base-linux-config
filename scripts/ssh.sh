#!/bin/bash
# add my ssh pub keys and only allow pubkey auth

mkdir ~/.ssh
curl https://github.com/LATINO-BICEPS.keys > ~/.ssh/authorized_keys

sudo cp ../config/sshd_config /etc/ssh/sshd_config.d/
sudo systemctl restart ssh
