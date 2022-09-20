# Implementing JEA: PSSlack

Demo code from a talk I gave at Jane Street: [Thursday, September 8, 2022:
Implementing JEA & Harness your PowerShell Pipeline @ Jane Street (in-person)](https://www.meetup.com/powershell-london-uk/events/287695895/) showing connecting to the Slack API and permissioning different user groups using role capabilities and a ValidateSet.

## Covered in the demo
Converting an existing PowerShell module to a JEA module:

* Creating a Session Configuration (`*.pssc` - created with `New-PSSessionConfigurationFile`)
* Adding Role Capabilities (`*.psrc` - created with `New-PSRoleCapabilityFile`)
* Registering the Configuration (`Register-PSSessionConfiguration`)
* Restricting access to functions with `Parameters` and `ValidateSet`

The scripts here are are as they were when used in the demo. I plan to make improvements and add additional comments.

## Getting Started
> Note: This is not intended to be used in production, but a minimum viable product. Keys should be stored more securely.

* Obtain an API key for Slack and place this in `C:\temp\really_important_token.txt`
* Set the ACL for that file to be Administrators only with `SetACL.ps1`
* Once you've made any tweaks, run `Deploy.ps1` to create any requried users/groups, copy the files to the correct location and register the configuration.

`Deploy.ps1` can be re-run when changes have been made.

If you are running the scripts without any changes, you can use `Decom.ps1` to cleanup any users, groups and configurations created. Note this won't remove any files copied.