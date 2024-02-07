param (
    [string]$SourceDir = "C:\source"
    [System.Collections.Hashtable[]]$Projects
)

$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path
. "$ScriptDir\..\functions\repo-mgmt.ps1"

# Ensure the source directory exists
if (-not (Test-Path -Path $SourceDir)) {
    Write-Host "Creating source directory at $SourceDir"
    New-Item -ItemType Directory -Path $SourceDir | Out-Null
}

foreach ($project in $Projects) {
    ForkOrCloneProject -project $project
}

Write-Host "All specified projects have been processed."