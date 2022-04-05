$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$Source1 = “$PSScriptRoot\WinTZ\”       
$Source2 = “$PSScriptRoot\WinTZ\0.2.0\Run_Set-WindowsTimeZone.ps1” 
Copy-Item -path $source1 -Destination "C:\Program Files\WindowsPowerShell\Modules" -Recurse -Force
If(!(test-path "C:\ProgramData\PSscripts\"))                                                       
{
      New-Item -ItemType Directory -Force -Path "C:\ProgramData\PSscripts\"
      Copy-Item -path $source2 -Destination "C:\ProgramData\PSscripts\" -Recurse -Force
}else{
      Copy-Item -path $source2 -Destination "C:\ProgramData\PSscripts\" -Recurse -Force
}

Set-WindowsTimeZone -Force                                                                                                                                               
Get-ScheduledTask -TaskName "Set-WindowsTimeZone" -ErrorAction SilentlyContinue -OutVariable tasktest                                                                     
if (!$tasktest) {                                                                                                                                                         
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-executionpolicy bypass -noprofile -file C:\ProgramData\PSscripts\Run_Set-WindowsTimeZone.ps1" 
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
    Register-ScheduledTask -TaskName 'Set-WindowsTimeZone' -InputObject $task
}else{                                                                                                                                                                    
    Unregister-ScheduledTask -TaskName 'Set-WindowsTimeZone' -Confirm:$false
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-executionpolicy bypass -noprofile -file C:\ProgramData\PSscripts\Run_Set-WindowsTimeZone.ps1"
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
    Register-ScheduledTask -TaskName 'Set-WindowsTimeZone' -InputObject $task
}