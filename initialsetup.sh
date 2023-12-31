#!/bin/bash

# Check if the user has run the script as superuser
if [[ $EUID -ne 0 ]];
then
    echo "This script must be run as superuser (using sudo)"
    exit 1
fi

read -p "Do you want to install upgrades automatically and autoremove unused dependencies? (y/n) " answer
if [[ $answer == "y" ]]
then
    echo ""
    echo "Configuring unattended upgrades"
    echo ""
    # Configure unattended upgrades
    dpkg-reconfigure --priority=low unattended-upgrades
    
    echo ""
    echo "Configuring automatic removal of unused dependencies"
    echo ""
    # Enable the setting Unattended-Upgrade::Remove-Unused-Dependencies
    sed -i 's|//Unattended-Upgrade::Remove-Unused-Dependencies "false";|Unattended-Upgrade::Remove-Unused-Dependencies "true";|' /etc/apt/apt.conf.d/50unattended-upgrades
fi

read -p "Do you want configure the DHCP client identifier to be the MAC address? (y/n) " answer
if [[ $answer == "y" ]]
then
    echo ""
    echo "Configuring DHCP client identifier to be MAC address"
    echo ""
    # Configure ubuntu to use the MAC address as its client identifier for DHCP
    # Find the first file in the /etc/netplan/ directory
    NETPLAN_FILE=$(find /etc/netplan -type f | head -n 1)
    
    # Check if a file was found
    if [ -z "$NETPLAN_FILE" ];
    then
        echo "Unable to configure DHCP because no netplan file was found in /etc/netplan/"
        exit 1
    fi
    
    # Check if the changes have already been made
    if ! grep -q "dhcp-identifier: mac" "$NETPLAN_FILE";
    then
        echo "DHCP settings are about to change."
        echo "This machine may get a different IP address and you may lose connection."
    
        # Make a backup of the original file
        cp "$NETPLAN_FILE" "$NETPLAN_FILE.bak"
    
        # Add the dhcp-identifier: mac setting
        sed -i '/dhcp4: true/a \ \ \ \ \ \ dhcp-identifier: mac' "$NETPLAN_FILE"
    
        # Apply the new settings
        netplan apply
    fi
fi

read -p "Do you want to set the time zone to America/Denver? (y/n) " answer
if [[ $answer == "y" ]]
then
    timedatectl set-timezone America/Denver
    echo "Time zone set to America/Denver"
fi

echo ""
echo "Setup Script Completed"
echo ""
