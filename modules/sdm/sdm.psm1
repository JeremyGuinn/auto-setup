<#
.SYNOPSIS
    Manages the Docker application stack.

.DESCRIPTION
    The Invoke-SDMCommand function provides a simplified interface for managing Docker Compose stacks, including starting, stopping, and viewing the status of services.

.PARAMETER Command
    The Docker Compose command to execute. Valid commands include 'start', 'stop', and 'status'.

.PARAMETER ComposeArgs
    Additional arguments or options to pass through to the docker-compose command.

.EXAMPLE
    Invoke-SDMCommand -Command start -- -d --build
    Starts the Docker Compose stack in detached mode and forces a build of the images.

.EXAMPLE
    Invoke-SDMCommand -Command stop
    Stops the Docker Compose stack and removes the containers.

.EXAMPLE
    Invoke-SDMCommand -Command status
    Displays the status of the Docker Compose stack's services.

.NOTES
    For more information on Docker Compose commands and options, refer to the Docker Compose documentation.

.LINK
    https://docs.docker.com/compose/

#>
function Invoke-SDMCommand {
    param (
        [Parameter(Position=0, Mandatory=$false)]
        [string]$Command,

        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$ComposeArgs
    )

    function Show-Help {
        Get-Help Invoke-SDMCommand -Detailed
    }

    function Start-AppStack {
        param (
            [string]$ComposeFile = "$PSScriptRoot\..\..\docker\merged-docker-compose.yml"
        )
        docker-compose -f $ComposeFile up $ComposeArgs
    }
    
    function Stop-AppStack {
        param (
            [string]$ComposeFile = "$PSScriptRoot\..\..\docker\merged-docker-compose.yml"
        )
        docker-compose -f $ComposeFile down $ComposeArgs
    }
    
    function Status-AppStack {
        param (
            [string]$ComposeFile = "$PSScriptRoot\..\..\docker\merged-docker-compose.yml"
        )
        docker-compose -f $ComposeFile ps $ComposeArgs
    }

    switch ($Command) {
        "start" { Start-AppStack }
        "stop" { Stop-AppStack }
        "status" { Status-AppStack }
        "help" { Show-Help }
        default { Show-Help }
    }
}

New-Alias -Name sdm -Value Invoke-SDMCommand
Export-ModuleMember -Alias sdm -Function Invoke-SDMCommand