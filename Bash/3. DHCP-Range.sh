#!/bin/bash

# See if script is running as root
if [ "$(id -u)" -ne 0 ]; then

echo 'This script must be run by root' >&2
echo ""
echo "Stopping the script ..."

exit 1

fi

sudo apt install isc-dhcp-server -y
path2conf='/etc/dhcp/dhcpd.conf'

# Create the conf
echo "Creating backup of $path2conf..."
if [ -d "/etc/dhcp/dhcp.conf.backup" ]
then
    echo "    -> Already exists"
else
    mv /etc/dhcp/dhcpd.conf{,.backup}
    touch $path2conf
    echo "    -> Done!"
fi


    echo "    -> OK! $path2conf exists."

    echo "# a simple /etc/dhcp/dhcp.conf" > $path2conf

    echo "subnet 192.168.1.0 netmask 255.255.255.0 {" >> $path2conf
    echo "    range 192.168.1.1 192.168.1.254;" >> $path2conf
    echo "    default-lease-time 3600;" >> $path2conf
    echo "    max-lease-time 3600;" >> $path2conf
    echo "    option subnet-mask 255.255.255.0;" >> $path2conf
    echo "    option broadcast-address 192.168.1.255;" >> $path2conf
    echo "    option routers 192.168.1.1; " >> $path2conf
    echo "    option domain-name-servers 172.20.0.2, 172.20.0.3;" >> $path2conf
    echo "}" >> $path2conf

    echo "INTERFACESv4='ens192'" > /etc/default/isc-dhcp-server


systemctl restart isc-dhcp-server.service
systemctl status isc-dhcp-server.service