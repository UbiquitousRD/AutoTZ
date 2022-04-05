Remove-Item -path "C:\Program Files\WindowsPowerShell\Modules\WinTZ\" -Recurse -Force
Remove-Item -path "C:\ProgramData\PSscripts\Run_Set-WindowsTimeZone.ps1" -Recurse -Force
Unregister-ScheduledTask -TaskName 'Set-WindowsTimeZone' -Confirm:$false