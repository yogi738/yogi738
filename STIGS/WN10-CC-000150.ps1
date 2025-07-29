<#
.SYNOPSIS
    Remediate STIG finding for voice activation above lock screen. 
.NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000150

.TESTED ON
    Date(s) Tested  : 2025-07-29
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000150.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valueName = "ACSettingIndex"
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the desired registry value
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the result
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName
Write-Output "Policy applied: $valueName = $($currentValue.$valueName)"
