#!/bin/bash

# Making variable filename 
filename="firstrun.sh"

# check if script is running as sudo
if [ "$(id -u)" -ne 0 ]; then
  printf "Script must be executed with sudo!\n\n"
  exit 1
fi

# Checking if the script firstrun.sh already exists
if [ -f $filename ]
then
    printf "$filename exists"
else
    printf "    -> ERROR! $filename does not exist or is not in the same directory."
    exit 3
fi

#creating backup of the firstrun file
backupFile="cp firstrun.sh firstrun.sh.backup"
eval "$backupFile"

#edit the file
sed -i '/firstrun.sh/ i # start fallback preconfig \
profile static_eth0 \
static ip_address=192.168.168.168/24 \
\
# The primary network interface \
interface eth0 \
arping 192.168.66.6 \
fallback static_eth0 \
DHCPCDEOF' $FILENAME