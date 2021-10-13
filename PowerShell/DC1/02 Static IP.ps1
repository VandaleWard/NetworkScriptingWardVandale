$IP = "192.168.1.2" # Desired IP Address on the Server
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "192.168.1.1" # IP of PfSense
$Dns1 = "172.20.0.2" # First DNS of Howest
$Dns2 = "172.20.0.3" # Second DNS of Howest
$IPType = "IPv4" # We're using IPv4, not IPv6
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter -Physical | Where-Object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}
 # Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses ($Dns1, $Dns2)