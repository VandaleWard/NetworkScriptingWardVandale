 # Variables
    $Share_Name = "public"
    $Share_Path = "C:\$Share_Name"
    $File_Path = "\\DC1\netlogon\login.bat"

    # See if our login.bat exists
    if (Test-Path $File_Path){
        Write-Host "File exists, continuing ..."
    } 
    else {
        # when logon.bat does not exist stop the script
        Write-Host "login.bat not found"
        New-Item $File_Path -ItemType File -Value "@echo off"

    }

    # See if login.bat contains "net use P: \\MS\Public"
    $Text = "net use P: \\MS\Public"

    $SEL = Select-String -Path $File_Path -Pattern $Text

    if ($SEL -ne $null)
        {
            Write-Host "Login.bat contains '$Text'"
        }
    else
        {
            Write-Host "Adding '$Text' to login.bat ..."
            Add-Content $File_Path "`nnet use P: \\MS\Public"
        }