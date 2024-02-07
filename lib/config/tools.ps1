$requiredTools = @(
    @{ Name = "Windows Terminal"; WingetId = "Microsoft.WindowsTerminal"; }
    @{ Name = "Microsoft Powershell"; WingetId = "Microsoft.PowerShell"; }
    @{ Name = "GitHub CLI"; WingetId = "GitHub.cli"; }
    @{ Name = "AWS CLI"; WingetId = "Amazon.AWSCLI"; }
    @{ Name = "AWS Session Manager Plugin"; WingetId = "mazon.SessionManagerPlugin"; }
    @{ Name = "Rancher Desktop"; WingetId = "suse.RancherDesktop"; }
    @{ Name = "Fast Node Manager (FNM)"; WingetId = "Schniz.fnm"; }
    @{ Name = ".NET 6"; WingetId = "Microsoft.DotNet.SDK.6"; }
    @{ Name = ".NET 7"; WingetId = "Microsoft.DotNet.SDK.7"; }
    @{ Name = ".NET 8"; WingetId = "Microsoft.DotNet.SDK.8"; }
)

$optionalTools = @(
    @{ Name = "Visual Studio Code"; WingetId = "Microsoft.VisualStudioCode"; }
    @{ Name = "Visual Studio Enterprise"; WingetId = "Microsoft.VisualStudio.Enterprise"; }
    @{ Name = "GitHub Desktop"; WingetId = "GitHub.GitHubDesktop"; }
    @{ Name = "Google Chrome"; WingetId = "Google.Chrome"; }
    @{ Name = "Mozilla Firefox"; WingetId = "Mozilla.Firefox"; }
    @{ Name = "JDK 11"; WingetId = "ojdkbuild.openjdk.11.jdk"; }
)