#!/bin/bash
# add my ssh pub keys and only allow pubkey auth

# prompt for sudo 
sudo -v

mkdir -p ~/.ssh
curl https://github.com/LATINO-BICEPS.keys > ~/.ssh/authorized_keys
echo "Copied GitHub public ssh keys"
cat << 'EOF' | sudo tee /etc/ssh/sshd_config.d/sshd_config > /dev/null
AcceptEnv LANG LC_*
UsePAM no
KbdInteractiveAuthentication no
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
X11Forwarding no
PrintMotd yes
EOF

echo "Copied sshd config"
sudo systemctl reload ssh
