# Script to set file permissions for Administrators only

$File = 'C:\temp\really_important_token.txt'
$NewAcl = Get-Acl -Path $File
# Set properties
$identity = 'BUILTIN\Administrators'
$fileSystemRights = 'FullControl'
$type = 'Allow'
# Create new rule
$params = @{
    TypeName = 'System.Security.AccessControl.FileSystemAccessRule'
    ArgumentList = $identity, $fileSystemRights, $type
}
$fileSystemAccessRule = New-Object @params
# Apply new rule
$NewAcl.SetAccessRuleProtection($true, $false)
$NewAcl.SetAccessRule($fileSystemAccessRule)
Set-Acl -Path $File -AclObject $NewAcl