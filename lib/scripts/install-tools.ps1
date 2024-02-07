param (
    [switch]$SkipOptionalTools = $false
    [System.Collections.Hashtable[]]$requiredTools
    [System.Collections.Hashtable[]]$optionalTools
)

$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path
. "$ScriptDir\..\functions\tool-mgmt.ps1"


# Install required tools
foreach ($tool in $requiredTools) {
    Install-Tool -tool $tool
}

if (-not $SkipOptionalTools) {
    foreach ($tool in $optionalTools) {
        $install = Read-Host "Do you want to install $($tool.Name)? (Y/N)"
        if ($install -eq 'Y') {
            Install-Tool -tool $tool
        }
    }
}