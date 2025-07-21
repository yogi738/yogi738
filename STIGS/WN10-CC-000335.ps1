<#
.SYNOPSIS
   Disable unencrypted WinRM traffic (STIG compliance).
NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-21
    Last Modified   : 2025-07-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000335

.TESTED ON
    Date(s) Tested  : 2025-07-21
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000335.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL 
.DESCRIPTION
  Sets the registry value:
  HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client\AllowUnencryptedTraffic = 0

  Equivalent to GPO:
  Computer Configuration >> Administrative Templates >> Windows Components >> Windows Remote Management (WinRM) >> WinRM Client >> "Allow unencrypted traffic" = Disabled
#>

Write-Host "=== Enforcing WinRM to disallow unencrypted traffic ==="

# Check admin
if (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning "This script must be run as Administrator!"
    exit 1
}

# Define registry path & value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$valueName = "AllowUnencryptedTraffic"
$desiredValue = 0

# Ensure the key exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Set the value
Write-Host "Setting '$valueName' to $desiredValue under $regPath..."
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

Write-Host "✅ WinRM unencrypted traffic is now disallowed (value set to 0)."

# Verify
$current = Get-ItemProperty -Path $regPath -Name $valueName | Select-Object -ExpandProperty $valueName
Write-Host "`nCurrent setting of '$valueName': $current"
