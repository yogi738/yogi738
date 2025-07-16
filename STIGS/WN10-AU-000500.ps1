<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Atmuri Yogeswar
    LinkedIn        : linkedin.com/in/atmuriyogeswar/
    GitHub          : github.com/yogi738
    Date Created    : 2025-07-16
    Last Modified   : 2025-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-07-16
    Tested By       : atmuri yogeswar
    Systems Tested  : windows 10pro
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

#  CODE  FOR  IMPLEMENTING STIG ON POWERSHELL

# Define the registry path and value
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$valueName = 'MaxSize'
$minValue = 32768

# Check if the key exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path not found. Creating path: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Host "MaxSize not set. Setting it to $minValue KB."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $minValue -Type DWord
}
elseif ($currentValue -lt $minValue) {
    Write-Host "Current MaxSize ($currentValue KB) is less than required ($minValue KB). Updating..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $minValue -Type DWord
}
else {
    Write-Host "MaxSize is already set to $currentValue KB, which meets or exceeds the requirement."
}

# Output final value
(Get-ItemProperty -Path $regPath -Name $valueName).$valueName
