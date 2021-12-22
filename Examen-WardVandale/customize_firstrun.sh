# Making variable to the script
$pathToFile = ".\firstrun.sh"

# Adding the content to the content variable to put it in the script
$content = "# start fallback preconfig"
$content = $content + 'file="/etc/dhcpcd.conf\"'
$content = $content + "sed -i 's/#profile static_eth0/profile static_eth0/' $file"
$content = $content + "sed -i 's/#static ip_address=192.168.1.23/static ip_address=192.168.168.168/' $file"
$content = $content + "line=`grep -n '# fallback to static profile' $file | awk -F: '{ print $1 }'`"
$content = $content + `sed -i '$line,$ s/#interface eth0/interface eth0/' $file`
$content = $content + 'sed -i 's/#fallback static_eth0/arping 192.168.66.6\nfallback static_eth0/' $file'
$content = $content + "# end fallback preconfig"

# Output the content to the host
Write-Host $content

# Input the content in to the firstrun.sh script
Out-File -FilePath $pathToFile -InputObject $content 