<#
.SYNOPSIS
     Enable Success and Failure auditing for Process Creation.
  Passes STIG  WN10-AU-000585.
.NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-17
    Last Modified   : 2025-07-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000585

.TESTED ON
    Date(s) Tested  : 2025-07-17
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000585.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL RUN as ADMINISTRATOR

Write-Host "=== Enabling Audit Process Creation: Success and Failure ==="

# Verify running as admin
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltinRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator!"
    Exit 1
}

# Run auditpol command
$auditCommand = '/set /subcategory:"Process Creation" /success:enable /failure:enable'

Write-Host "Running command: auditpol $auditCommand"
$auditResult = & auditpol.exe $auditCommand

Write-Output $auditResult

# Verify setting
Write-Host "`n=== Verifying Current Setting ==="
$verifyResult = & auditpol.exe /get /subcategory:"Process Creation"

Write-Output $verifyResult

if ($verifyResult -match "Success and Failure") {
    Write-Host "`n✅ Audit Process Creation is now set to: Success and Failure."
} else {
    Write-Warning "`n⚠️ Audit Process Creation is NOT set correctly. Please check manually."
}

Write-Host "=== Script Complete ==="
