# UbuntuServerSetup

This script helps set up an Ubuntu Server instance by doing the following things (permission will be asked to perform each step):

1. Configure unattended upgrades and automatic removal of unused dependencies to prevent the disk slowly filling up with unused kernels and other packages
2. Configure the DHCP client identifier to be the MAC address of the network interface.
3. Set the time zone to Mountain Time (`America/Denver`).

## Usage

Run these commands on a new Ubuntu Server instance:

```
wget https://raw.githubusercontent.com/bp2008/UbuntuServerSetup/main/initialsetup.sh
chmod u+x initialsetup.sh
sudo ./initialsetup.sh
```
