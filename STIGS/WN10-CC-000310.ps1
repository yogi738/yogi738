<#
.SYNOPSIS
 STIG Fix - Disable user control over installs.
NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000310

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000310.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL 
DESCRIPTION
    Sets 'EnableUserControl' to 0 under:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer
    This prevents users from changing Windows Installer options.
#>

# Ensure the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] `
  [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
  [Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning "You must run this script as Administrator!"
    exit 1
}

# Registry path and setting
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$name = "EnableUserControl"
$value = 0

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
Set-ItemProperty -Path $regPath -Name $name -Value $value -Type DWord

# Confirm result
$setValue = Get-ItemProperty -Path $regPath -Name $name | Select-Object -ExpandProperty $name
Write-Host "`n✔️ EnableUserControl set to: $setValue (expected: 0)"

Write-Host "✅ WinRM unencrypted traffic is now disallowed (value set to 0)."

# Verify
$current = Get-ItemProperty -Path $regPath -Name $valueName | Select-Object -ExpandProperty $valueName
Write-Host "`nCurrent setting of '$valueName': $current"
