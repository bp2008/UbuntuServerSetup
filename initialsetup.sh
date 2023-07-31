#!/bin/bash

# Check if the user has run the script as superuser
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as superuser (using sudo)"
    exit 1
fi

echo ""
echo "This script will configure:"
echo "  1. unattended upgrades"
echo "  2. Automatic removal of unused dependencies"
echo "     to prevent the disk from slowly filling "
echo "     up over time."
echo "  3. DHCP client identifier should be the "
echo "     network interface's MAC address"
echo ""

# Configure unattended upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# Enable the setting Unattended-Upgrade::Remove-Unused-Dependencies
sed -i 's|//Unattended-Upgrade::Remove-Unused-Dependencies "false";|Unattended-Upgrade::Remove-Unused-Dependencies "true";|' /etc/apt/apt.conf.d/50unattended-upgrades

# Configure ubuntu to use the MAC address as its client identifier for DHCP
if ! grep -q "send dhcp-client-identifier = hardware;" /etc/dhcp/dhclient.conf; then
    echo "send dhcp-client-identifier = hardware;" >>/etc/dhcp/dhclient.conf
#    rm /var/lib/dhcp/*
#    systemctl restart systemd-networkd
fi

echo ""
echo "Setup Script Completed"
echo ""
