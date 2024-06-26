# WSL2 Fedora (SystemD)

This Docker Image is used to build WSL2 Image for Fedora 40, that is using SystemD.

## Features
The resulting WSL2 Fedora Image has the following features:

1. SystemD is enabled.
2. Sudo priviliged user is created and configured as default WSL2 user. UserName: wsl01, Pwd: wsl01.
3. Sudo permissions modified to never ask password for user wsl01.
4. "nano" Editor is installed.
5. "ps" is installed.
6. "xclock" X-Window sample app is installed.

To View XWindows application 'xclock' host Windows 10/11 computer should be running a X-Window-Server. One such Open Source one is linked below. Make sure that its runtime configuration allows unauthenticated connections from X-Clients:
[https://github.com/marchaesen/vcxsrv/releases/download/21.1.10/vcxsrv-64.21.1.10.0.installer.exe](https://github.com/marchaesen/vcxsrv/releases/download/21.1.10/vcxsrv-64.21.1.10.0.installer.exe)

## Steps
First switch to a Linux environment, possibly a standard WSL2 Ubuntu.
  
Launch WSL
```
C:\Users\XYZ>wsl -d Ubuntu-22.04
```
OR if this is your first time using WSL then
```
C:\Users\XYZ>wsl --install Ubuntu-22.04
```
Then follow WSL prompts to create a sudo user. Then continue with following steps.

### Steps to do in WSL2:
```
sudo apt install -y nano podman git
#mkdir wsl2-fedora-systemd
git clone https://github.com/hammadrauf/wsl2-fedora-systemd.git .
cd wsl2-fedora-systemd
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
podman export $podmanContainerID > /mnt/c/temp/fedora_systemd.tar
```
Then in the Host Windows System, import the tar file generated above, as follows:
```
C:\Users\XYZ>wsl -d Ubuntu-22.04 --shutdown
C:\Users\XYZ>wsl --unregister fedora40       (If exists previuosly)

C:\Users\XYZ>wsl --import fedora40 "C:\Users\XYZ\VirtualBox VMs\wsls-custom\fedora40" "C:\temp\fedora_systemd.tar"
Import in progress, this may take a few minutes.
The operation completed successfully.

C:\Users\XYZ>
```

## To Run WSL2

```
wsl -l -v
wsl -d fedora40
wsl -d fedora40 --shutdown
```

## Steps for 2nd Ubuntu WSL2 Instance - from official Ubuntu tar ball
Get tar.gz wsl Image from Ubuntu Sites.  
- [https://cloud-images.ubuntu.com/wsl/](https://cloud-images.ubuntu.com/wsl/)
- [https://cloud-images.ubuntu.com/wsl/noble/current/](https://cloud-images.ubuntu.com/wsl/noble/current/)
- [https://cloud-images.ubuntu.com/releases/](https://cloud-images.ubuntu.com/releases/)

Make sure the file name has amd64-wsl and the file type is .tar.gz (GZIP tarball).

Then use the following command:
```
wsl.exe --import <Distribution Name> <Install Folder> <.TAR.GZ File Path>
```

## Steps for 2nd Ubuntu WSL2 Instance - from MS Windows Store
Assuming, you already have atleast 1 installation called "Ubuntu".  
Use the following commands:
```
wsl --export Ubuntu "C:\Users\XYZ\VirtualBox VMs\wsls-custom\ubuntu-first\ubuntu-first.tar"   # Backup of first instance
wsl --unregister Ubuntu   # Deletes the old instance
wsl --install Ubuntu    # Creates a fresh Install
wsl --import ubuntu-first "C:\Users\XYZ\VirtualBox VMs\wsls-custom\ubuntu-first" "C:\Users\XYZ\VirtualBox VMs\wsls-custom\ubuntu-first\ubuntu-first.tar"
wsl -l -v
wsl --set-default ubuntu-first
```
You can compress the tar file backup to .tar.gz using software like 7Zip.

## Default VHDX file location
```
%LocalAppData%\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState
```
