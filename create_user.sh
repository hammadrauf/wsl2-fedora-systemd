#!/bin/bash
#myUsername=wsl01
#myUserpwd=wsl01
adduser -G wheel wsl01
echo 'wsl01:wsl01' | chpasswd
cat > /etc/wsl.conf << EOF
[boot]
systemd=true

[user]
default=wsl01
EOF