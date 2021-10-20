$ComputerName = "DC2"

 Invoke-Command -ComputerName $ComputerName -ScriptBlock {  # Invoke-Command is used on DC1 to input commands on the MS without connecting to it
             $profilesFolder = "c:\profiles" # var
             Write-Host "Creating Home Folder"
             New-Item -Path $profilesFolder -type directory -Force # Creating the folder

             Write-Host "Making home folder a share"
             New-SmbShare -Name 'profiles$' -Path $profilesFolder -FullAccess "Everyone" # Sharing the folder

             Write-Host "Folder creation complete"

             # Changing the Permissions NTFS
             Write-Host "ACL"
             $acl = Get-Acl $profilesFolder
             $acl.SetAccessRuleProtection($True, $False)
             $acl.Access | % { $acl.RemoveAccessRule($_) } # I remove all security
             $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('administrators', 'FullControl', "ContainerInherit, objectInherit", "None", 'Allow') # I set my admin account as also having access
             $acl.AddAccessRule($rule)
             $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('Authenticated Users', 'Modify', "None", "None", "Allow")
             $acl.AddAccessRule($rule)
             (Get-Item $profilesFolder).SetAccessControl($acl)
         }
