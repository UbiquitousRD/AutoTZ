Set-WindowsTimeZone -Force
Get-ScheduledTask -TaskName "Set-WindowsTimeZone" -ErrorAction SilentlyContinue -OutVariable tasktest2
if($tasktest2){
Unregister-ScheduledTask 'Set-WindowsTimeZone' -Confirm:$false
}
if(Test-Path -Path "C:\ProgramData\PSscripts\Run_Set-WindowsTimeZone.ps1") {
Remove-Item -path "C:\ProgramData\PSscripts\Run_Set-WindowsTimeZone.ps1" -Recurse -Force
}