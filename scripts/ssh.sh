#!/bin/bash
# add my ssh pub keys and only allow pubkey auth

echo "Copying your GitHub public keys to .ssh"
mkdir ~/.ssh
curl https://github.com/LATINO-BICEPS.keys > ~/.ssh/authorized_keys

echo "Copying sshd config"
sudo cp config/sshd_config /etc/ssh/sshd_config.d/
sudo systemctl restart ssh
