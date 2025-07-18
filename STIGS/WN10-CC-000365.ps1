<#
.SYNOPSIS
    Remediate STIG finding for voice activation above lock screen. 
.NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-18
    Last Modified   : 2025-07-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000365

.TESTED ON
    Date(s) Tested  : 2025-07-18
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000365.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL RUN as ADMINISTRATOR

Write-Host "=== Remediating Voice Activation Above Lock Screen Setting ==="

# Run as Admin check
if (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning "This script must be run as Administrator!"
    exit 1
}

# Define registry path and names
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
$letAppsActivateWithVoice = "LetAppsActivateWithVoice"
$letAppsActivateWithVoiceAboveLock = "LetAppsActivateWithVoiceAboveLock"

# Ensure registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path not found. Creating: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Check LetAppsActivateWithVoice
$voiceSetting = Get-ItemProperty -Path $regPath -Name $letAppsActivateWithVoice -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $letAppsActivateWithVoice -ErrorAction SilentlyContinue

if ($voiceSetting -eq 2) {
    Write-Host "`n✅ LetAppsActivateWithVoice is already set to 2 (Force Deny). Requirement is Not Applicable."
} else {
    Write-Host "`nℹ️ LetAppsActivateWithVoice is not set to 2. Setting LetAppsActivateWithVoiceAboveLock to 2..."
    Set-ItemProperty -Path $regPath -Name $letAppsActivateWithVoiceAboveLock -Value 2 -Type DWord
    Write-Host "✅ LetAppsActivateWithVoiceAboveLock has been set to 2 (Force Deny)."
}

# Output final values
Write-Host "`n=== Final Registry Settings ==="
Get-ItemProperty -Path $regPath | Select-Object $letAppsActivateWithVoice, $letAppsActivateWithVoiceAboveLock | Format-List

Write-Host "`n=== Remediation Complete ==="
