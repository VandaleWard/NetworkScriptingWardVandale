$fileexists = Test-Path -Path E:\reports\first-file.txt

If (Test-Path -Path C:\Users\vanda\Desktop\Network Scripting\NetworkScriptingWardVandale\Examen-WardVandale\firstrun.sh) {
Write-Host "FILE EXISTS"
}
Else {
Write-Host "file does not exist, please make sure the file is in the same directory"
}