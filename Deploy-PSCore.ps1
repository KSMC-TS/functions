function Deploy-PSCore {
    <#

    .DESCRIPTION
    Deploy PowerShell Core:latest from Microsoft

    .PARAMETER listpath
    Required; Accepts Value from Pipline;
    List of computers to deploy to

    .EXAMPLE
    Deploy-PSCore -listpath "c:\servers.txt"

    .NOTES
    https://docs.microsoft.com/en-us/powershell/scripting/install/migrating-from-windows-powershell-51-to-powershell-7?view=powershell-7


    Version:        1.0
    Last Updated:   07/02/2020
    Creation Date:  07/02/2020
    Author:         Fred Gottman

    #>

    param (
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        [String[]] $listpath = ""
        )
    $computers = Get-Content $listpath
    ForEach ($computer in $computers) {
        Write-Output "Deploying PowerShellCore:Latest on $computer"
        Invoke-Command -ComputerName $computer {iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"}
    }
}
