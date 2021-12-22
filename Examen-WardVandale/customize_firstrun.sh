#!/bin/bash
FILE=/firstrun.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists."
fi


# #start fallback preconfig
# file="/etc/dhcpcd.conf"
# sed -i 's/#profile static_eth0/profile static_eth0/' $file
# sed -i 's/#static ip_address=192.168.1.23/static ip_address=192.168.168.168/' $file
# line=`grep -n '# fallback to static profile' $file | awk -F: '{ print $1 }'`
# sed -i "$line,$ s/#interface eth0/interface eth0/" $file
# sed -i 's/#fallback static_eth0/arping 192.168.66.6\nfallback static_eth0/' $file
# #end fallback preconfig