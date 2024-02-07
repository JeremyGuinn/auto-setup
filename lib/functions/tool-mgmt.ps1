function Install-Tool {
    param (
        [Parameter(Mandatory = $true)] [System.Collections.Hashtable] $tool
    )

    Write-Host "Installing $($tool.Name)... "

    if ( Is-Installed -tool $tool ) {
        Write-Host "Skipping: $($tool.Name) (already installed)`n"
        return
    }

    winget install --id $tool.WingetId --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error installing $($tool.Name).`n" -ForegroundColor Red
        return
    }
    
    Update-Path

    Write-Host "$($tool.Name) installed successfully." -ForegroundColor Green
}

function Remove-Tool {
    param (
        [Parameter(Mandatory = $true)] [System.Collections.Hashtable] $tool
    )

    Write-Host "Removing $($tool.Name)... "

    if ( -not (Is-Installed -tool $tool) ) {
        Write-Host "Skipping: $($tool.Name) (not installed)`n"
        return
    }

    winget uninstall --id $tool.WingetId
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error uninstalling $($tool.Name).`n" -ForegroundColor Red
        return
    }

    Update-Path

    Write-Host "$($tool.Name) uninstalled successfully." -ForegroundColor Green
}

function Is-Installed {
    param (
        [Parameter(Mandatory = $true)] [System.Collections.Hashtable] $tool
    )

    $list = winget list --exact -q $tool.WingetId
    if ([String]::Join("", $list).Contains($tool.WingetId)) {
        return $true
    }

    return $false
}

function Update-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}
