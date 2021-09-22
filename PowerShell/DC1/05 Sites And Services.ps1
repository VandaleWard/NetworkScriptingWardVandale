$first_site_name = "Kortrijk"
$second_site_name = "Brugge"

$subnet_first_site_name = "192.168.1.0/24"
$subnet_second_site_name = "192.168.2.0/24"

Get-ADReplicationSite "Default-First-Site-Name" | Rename-ADObject -NewName $first_site_name
Get-ADReplicationSite $first_site_name | Set-ADReplicationSite -Description $first_site_name
New-ADReplicationSubnet -Name $subnet_first_site_name -Site $first_site_name -Description $first_site_name -location $first_site_name

New-ADReplicationSite $second_site_name
Get-ADReplicationsite $second_site_name | Set-ADReplicationSite -Description $second_site_name
New-ADReplicationSubnet -Name $subnet_second_site_name -Site $second_site_name -Description $second_site_name -location $second_site_name