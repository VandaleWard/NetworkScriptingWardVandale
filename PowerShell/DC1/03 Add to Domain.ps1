$DomainName= "intranet.mijnschool.be" # Variable that has the domainname

Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools # Installing the Active Directory Domain Services and the management tools

Install-ADDSForest -DomainName $DomainName -InstallDNS # After installing our AD, we're creating the domain "forest"

Restart-Computer # Powershell command to restart the computer