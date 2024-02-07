function Create-Networks {
    param (
        [string[]] $networks
    )
    
    foreach ($network in $networks) {
        Create-Network -network $network    
    }
}

function Create-Network {
    param (
        [string] $network
    )

    if (-not (docker network ls --format "{{.Name}}" | Select-String -Pattern "^$network$")) {
        Write-Host "Creating Docker network: $network"
        docker network create $network
    } else {
        Write-Host "Docker network $network already exists."
    }
}

function Create-Volumes {
    param (
        [string[]] $volumes
    )
    
    foreach ($volume in $volumes) {
        Create-Volume -volume $volume    
    }
}

function Create-Volume {
    param (
        [string] $volume
    )

    if (-not (docker volume ls --format "{{.Name}}" | Select-String -Pattern "^$volume$")) {
        Write-Host "Creating Docker volume: $volume"
        docker volume create $volume
    } else {
        Write-Host "Docker volume $volume already exists."
    }
}

function Merge-ComposeFiles {
    param (
        [Parameter(Mandatory=$true)][string[]]$ComposeFiles,
        [Parameter(Mandatory=$true)][string]$OutputFile
    )
    # Construct the docker-compose command to merge files
    $composeCommand = "docker-compose"
    foreach ($file in $ComposeFiles) {
        $composeCommand += " -f `"$file`""
    }
    $composeCommand += " config > `"$OutputFile`""

    # Execute the command
    Invoke-Expression $composeCommand
}