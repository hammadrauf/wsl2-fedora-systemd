# Wsl2 Fedora Systemd
This Docker Image is used to build WSL2 Image for Fedora 40, that is using SystemD.

## Steps
First switch to a Linux environment, possibly a standard WSL2 Ubuntu.

Steps to do:
```
mkdir SystemFedora
cd SystemdFedora
ls -l
nano Dockerfile
nano create_user.sh
podman container ls -a
podman container rm -a
podman image rm -a
sudo service podman start
podman build -t fedora40 .
podman run --privileged --systemd=true -t fedora40 bash ls /
podmanContainerID=$(podman container ls -a | grep -i fedora40 | awk '{print $1}')
podman export $podmanContainerID > /mnt/c/hrauf1/fedora_systemd.tar
```
Then in the Host Windows System, import the tar file generated above, as follows:
```

```

## To Run WSL2

```
wsl -l -v
wsl -d fedora40
wsl -d fedora40 --shutdown
```

