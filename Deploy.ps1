# Script to simplify setup and deployment as files are changed.

$ErrorActionPreference = 'SilentlyContinue'

$moduleName = 'PSSlack'
$sourcePath = "c:\PowerShell-Implementing-Jea\$moduleName"
$destinationPath = "C:\Program Files\WindowsPowerShell\Modules\$moduleName"
$adminAccounts = ('jea-admin')

$transcriptPath = "C:\temp\Logs\$moduleName\JeaTranscripts"
Move-Item -Path "$transcriptPath\*.txt" -Destination ".\Archive\"

if ( -not (Test-ModuleManifest (Join-Path $sourcePath -ChildPath "$moduleName.psd1"))) {
    Write-Error 'Module manifest not valid'
    exit 1
}

if ( -not (Test-PSSessionConfigurationFile (Join-Path $sourcePath -ChildPath 'PSSlackJEA.pssc'))) {
    write-Error 'Session configuration not valid'
    exit 1
}

# Check for Transcripts directory, create if not exist, archive old

if (-not (Get-LocalUser -Name 'jea-admin')) {
    New-LocalUser -Name $adminAccounts -Description 'Demo account for JEA'
}

if (-not (Get-LocalGroup -Name 'JeaUsers')) {
    New-LocalGroup -Name 'JeaUsers' -Description 'Test group for JEA'
}
if ( -not (Get-LocalGroupMember -Group 'JeaUsers' -Member $env:USERNAME)) {
    Add-LocalGroupMember -Group 'JeaUsers' -Member $env:USERNAME
}

if (-not (Get-LocalGroup -Name 'JeaAdmins')) {
    New-LocalGroup -Name 'JeaAdmins' -Description 'Test group for JEA'
}
if ( -not (Get-LocalGroupMember -Group 'JeaAdmins' -Member $adminAccounts)) {
    Add-LocalGroupMember -Group 'JeaAdmins' -Member $adminAccounts
}
Write-Output 'Copying files'
Copy-Item "$sourcePath\*" "$destinationPath" -Recurse -Force
Write-Output "Unregistering previous instances of $moduleName"
Get-PSSessionConfiguration -Name $moduleName | Unregister-PSSessionConfiguration
Write-Output "Registering $moduleName"
Register-PSSessionConfiguration -Name $moduleName -Path (Join-Path $destinationPath -ChildPath 'PSSlackJEA.pssc')
Write-Output 'Restarting WinRM'
Get-Service WinRM | Restart-Service