#!/bin/bash
# add my ssh pub keys and only allow pubkey auth

set -euo pipefail
sudo -v

mkdir -p ~/.ssh
curl https://github.com/LATINO-BICEPS.keys 2>/dev/null > ~/.ssh/authorized_keys
echo "Copied GitHub public SSH keys to $HOME/.ssh/authorized_keys"
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

echo "Copied SSHd config to /etc/ssh/sshd_config.d/sshd_config"
unit=$(systemctl list-unit-files --type=service "ssh*" --legend=false --no-pager  | awk '{print $1}' | grep -xF -e "ssh.service" -e "sshd.service")
sudo systemctl reload $unit
echo "$unit has been reloaded."
