param (
    [string]$SourceDir = "C:\source"
    [System.Collections.Hashtable[]]$Projects
)

$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path
. "$ScriptDir\..\functions\docker-mgmt.ps1"

$volumesConfigPath = "$ScriptDir\..\config\docker\volumes.json"
$networksConfigPath = "$ScriptDir\..\config\docker\networks.json"

if (Test-Path $volumesConfigPath) {
    $volumes = Get-Content $volumesConfigPath | ConvertFrom-Json
    Create-Volumes -volumes $volumes
} else {
    Write-Host "Volumes configuration file not found at $volumesConfigPath"
}

if (Test-Path $networksConfigPath) {
    $networks = Get-Content $networksConfigPath | ConvertFrom-Json
    Create-Networks -networks $networks
} else {
    Write-Host "Networks configuration file not found at $networksConfigPath"
}

# Gather Docker Compose files from the projects
$composeFiles = $Projects | ForEach-Object {
    $projectPath = Join-Path -Path $SourceDir -ChildPath $_.Name
    $composeFilePath = Join-Path -Path $projectPath -ChildPath "docker-compose.yml"
    if (Test-Path $composeFilePath) {
        return $composeFilePath
    }
}

# Specify the output file for the merged Docker Compose configuration
$mergedComposeFile = "$ScriptDir\..\..\docker\merged-docker-compose.yml"

# Merge the Docker Compose files
if ($composeFiles.Count -gt 0) {
    Merge-ComposeFiles -ComposeFiles $composeFiles -OutputFile $mergedComposeFile
    Write-Host "Merged Docker Compose configuration saved to $mergedComposeFile"
} else {
    Write-Host "No Docker Compose files found in the specified projects."
}