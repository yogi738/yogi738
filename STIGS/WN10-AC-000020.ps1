<#
.SYNOPSIS
   The password history must be configured to 24 passwords remembered . 
.NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-19
    Last Modified   : 2025-07-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 2025-07-19
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000020.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL RUN as ADMINISTRATOR

Write-Host "=== Setting Enforce Password History to 24 ==="

# Run as Admin check
if (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning "This script must be run as Administrator!"
    exit 1
}

# Set value using 'net accounts'
Write-Host "Configuring password history to remember last 24 passwords..."
net accounts /uniquepw:24

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Successfully set Enforce password history to 24."
} else {
    Write-Warning "⚠️ Failed to set Enforce password history. Please check permissions and try again."
}

# Display current settings
Write-Host "`n=== Current Account Policy Settings ==="
net accounts
