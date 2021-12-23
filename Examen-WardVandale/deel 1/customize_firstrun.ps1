# Saving the contents of firstrun.sh in a var
$currFile = Get-ChildItem "C:\Users\vanda\Desktop\Network Scripting\NetworkScriptingWardVandale\Examen-WardVandale\firstrun.sh" | Get-Content

# Making a var to save the new file content
$newFile = @()
 
# Watching if the current firstrun.sh has already been modified 
if ($currFile -like "*#Start fallback preconfig*"){
        Write-Host "The script firstrun.sh has already been modified"
}
else{
    for ($i = 0; $i -lt $currFile.Length; $i++) {
        # Search the line rm -f /boot/firstrun.sh
        if ($currFile[$i] -like "*rm -f /boot/firstrun.sh*") {
            # Add the following commands to the new NetFileContent var
            $newFile += "#Start fallback preconfig
                                file=`"/etc/dhcpcd.conf`"
                                sed -i 's/#profile static_eth0/profile static/' `$file
                                sed -i 's/#static ip_address=192.168.1.23/static ip_address=192.168.168.168/' `$file
                                line=``grep -n ' # fallback to static profile' `$file | awk -F: '{ print `$1}'``
                                sed -i `"`$line,`$ s/#interface eth0/interface eth0/`" `$file
                                sed -i 's/#fallback static_eth0/arping 192.168.66.6\nfallback static_eth0/' `$file
                                #end fallback preconf"
        }
    # Add the new lines in front onf the rm -f /boot/firstrun.sh line
    $newFile += $currFile[$i]
    # Save the NewFileContent to the current file
    $newFile | Out-File "C:\Users\vanda\Desktop\Network Scripting\NetworkScriptingWardVandale\Examen-WardVandale\firstrun.sh" }
    
 }

# Source used: https://stackoverflow.com/questions/46582073/powershell-append-text-before-specific-line-instead-of-after
