$ComputerName = "MS"

 Invoke-Command -ComputerName $ComputerName -ScriptBlock {  # Invoke-Command is used on DC1 to input commands on the MS without connecting to it
             $publicFolder = "c:\public" # var
             Write-Host "Creating Public Folder" -ForegroundColor DarkBlue
             New-Item -Path $publicFolder -type directory -Force # Creating the folder

             Write-Host "Making public folder a share" -ForegroundColor Blue
             New-SmbShare -Name "public" -Path $publicFolder -FullAccess "Everyone" # Sharing the folder

             Write-Host "Folder creation complete" -ForegroundColor DarkCyan

             # Changing the Permissions NTFS
             Write-Host "ACL" -ForegroundColor Cyan
             $acl = Get-Acl $publicFolder
             $acl.SetAccessRuleProtection($True, $False)
             $acl.Access | % { $acl.RemoveAccessRule($_) } # I remove all security
             $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('administrators', 'FullControl', "ContainerInherit, objectInherit", "None", 'Allow') # I set my admin account as also having access
             $acl.AddAccessRule($rule)
             $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('Authenticated Users', 'Modify', "ContainerInherit, objectInherit", "None", "Allow")
             $acl.AddAccessRule($rule)
             (Get-Item $publicFolder).SetAccessControl($acl)
         }
