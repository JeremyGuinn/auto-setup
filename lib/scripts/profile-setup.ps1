$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path
$sdmModulePath = "$ScriptDir\..\modules\sdm"

function Append-ToProfile {
    param (
        [string]$ProfilePath,
        [string]$Command
    )
    if (-not (Test-Path $ProfilePath)) {
        New-Item -Type File -Path $ProfilePath -Force | Out-Null
    }
    Add-Content -Path $ProfilePath -Value $Command
}

$profileCommand = @"
`n# This line was added by the setup script from $ScriptDir at $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))
Import-Module '$sdmModulePath'
"@


$windowsPowerShellProfile = & powershell -Command { Write-Output $PROFILE.CurrentUserCurrentHost }
if ($null -eq $windowsPowerShellProfile) {
    $windowsPowerShellProfile = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}
if (-not (Get-Content -Path $windowsPowerShellProfile | Select-String -Pattern "Import-Module '$sdmModulePath'")) {
    Append-ToProfile -ProfilePath $windowsPowerShellProfile -Command $profileCommand
}

$powerShell7Profile = & pwsh -Command { Write-Output $PROFILE.CurrentUserCurrentHost }
if ($null -eq $powerShell7Profile) {
    $powerShell7Profile = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
}
if (-not (Get-Content -Path $powerShell7Profile | Select-String -Pattern "Import-Module '$sdmModulePath'")) {
    Append-ToProfile -ProfilePath $powerShell7Profile -Command $profileCommand
}