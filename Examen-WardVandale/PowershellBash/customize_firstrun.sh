#!/bin/bash

# Vars
currFile="firstrun.sh"

# Check if script is running in sudo
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run the script as a root! Using sudo ./customize_firstrun.sh"
  exit 1

fi

# Checking if the file exists
if [ -f $currFile ]
then
    echo "firstrun.sh exists"
else
    echo "!!!!!!!!!!!!!!!!!!!!!!"
    echo "firstrun.sh seems nowhere to be found!"
    echo "run this script in the same directory as firstrun.sh"
    echo "Stopping the script, bye bye"
    exit 3
fi

# Creatin Backup of file
echo "Creating a backup from the file, please wait"
backupFile="cp firstrun.sh firstrun.sh.bak"
eval "$backupFile"
echo "Backup complete\n\n"


sed -i '/firstrun.sh/ i # start fallback preconfig  \
profile static_eth0 \
static ip_address=192.168.168.168/24 \
\
# The primary network interface \
interface eth0 \
arping 192.168.66.6 \
fallback static_eth0 \
DHCPCDEOF' $currFile