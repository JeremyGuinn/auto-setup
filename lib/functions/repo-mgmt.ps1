function Check-GitHubAuthentication {
    try {
        $authStatus = gh auth status
        if ($authStatus -like "*Logged in*") {
            Write-Host "GitHub CLI authentication confirmed."
        }
    }
    catch {
        Write-Host "You are not logged in to GitHub CLI. Please log in to continue."
        gh auth login
        if ($LASTEXITCODE -ne 0) {
            Write-Host "GitHub CLI login failed. Please check your credentials and try again."
            exit
        }
    }
}

function ForkOrCloneProject {
    param (
        [Parameter(Mandatory=$true)] [System.Collections.Hashtable] $project
    )
    $projectPath = Join-Path -Path $SourceDir -ChildPath $project.Name
    # Early return if the project is already cloned
    if (Test-Path -Path $projectPath) {
        Write-Host "The project `"$($project.Name)`" is already cloned to $projectPath."
        return
    }

    $defaultChoice = if ($project.RecommendFork) { "Y/n" } else { "y/N" }
    $forkResponse = Read-Host "Do you want to fork `"$($project.Name)`"? [$defaultChoice]"
    
    if ($forkResponse -eq '') {
        $forkResponse = if ($project.RecommendFork) { 'Y' } else { 'N' }
    }

    if ($forkResponse -ieq 'Y') {
        Write-Host "Forking and cloning `"$($project.Name)`" to $SourceDir..."
        gh repo fork $($project.Url) --clone=true --target-directory=$SourceDir
    } else {
        Write-Host "Cloning `"$($project.Name)`" to $SourceDir..."
        gh repo clone $($project.Url) $projectPath
    }
}