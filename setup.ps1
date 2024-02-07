param (
    [string]$SourceDir = "C:\source",
    [bool]$SkipOptionalTools = $false
)

$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path

. "$ScriptDir\lib\config\tools.ps1"
. "$ScriptDir\lib\scripts\install-tools.ps1" -Required $requiredTools -Optional $optionalTools -SkipOptionalTools:$SkipOptionalTools

. "$ScriptDir\lib\config\projects.ps1"
. "$ScriptDir\lib\scripts\pull-repos.ps1" -SourceDir $SourceDir -Projects $projects

. "$ScriptDir\lib\scripts\init-docker.ps1" -SourceDir $SourceDir -Projects $projects

. "$ScriptDir\lib\scripts\profile-setup.ps1"