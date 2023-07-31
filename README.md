# UbuntuServerSetup

This script helps set up an Ubuntu Server instance by doing the following things:

1. Configure unattended upgrades
2. Configure automatic removal of unused dependencies to prevent the disk slowly filling up with unused kernels and other packages
3. Configure the DHCP client identifier to be the MAC address of the network interface.

## Usage

Run these commands on a new Ubuntu Server instance:

```
wget https://raw.githubusercontent.com/bp2008/UbuntuServerSetup/main/initialsetup.sh
chmod u+x initialsetup.sh
sudo ./initialsetup.sh
```
