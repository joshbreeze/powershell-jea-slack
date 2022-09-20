Get-LocalGroup Jea* | Remove-LocalGroup
Get-LocalUser Jea* | Remove-LocalUser
Get-PSSessionConfiguration PSSlack | Unregister-PSSessionConfiguration
Restart-Service WinRM