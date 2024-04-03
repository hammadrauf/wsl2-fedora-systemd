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
echo "wsl01        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
cat >> /home/wsl01/.bashrc << EOF2

# set DISPLAY to use X terminal in WSL
# in WSL2 the localhost and network interfaces are not the same than windows
## In Windows Host XServer should be running and allowed to take unauthenticated client sessions.
## One free XServer - VcXsrv X Server - http://vcxsrv.sourceforge.net - Version 1.20.14.0
##                                    - https://github.com/marchaesen/vcxsrv - Repo new location
if grep -q WSL2 /proc/version; then
    # execute route.exe in the windows to determine its IP address
    DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
else
    # In WSL1 the DISPLAY can be the localhost address
    if grep -q icrosoft /proc/version; then
        DISPLAY=127.0.0.1:0.0
    fi
fi
EOF2
