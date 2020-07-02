function New-OptionList {

    <#

    .DESCRIPTION
        Use to create a Powershell option list and return the selected value.
    .PARAMETER title
        Title of the option list menu you'd like to specifiy.
    .PARAMETER optionsList
        Comma separated list of values to build your option menu from.
    .PARAMETER message
        Message to prepend before the option values and on the post selection page.
    .EXAMPLE
        $searchBy = New-OptionList -Title "Search for user by" -optionsList "displayname", "email", "userprincipalname" -message "to search by"
            This will create a menu with the options specified and return the $selectedValue to the $searchBy variable for use in the script.
    .NOTES
        Adapted from script on https://www.business.com/articles/powershell-interactive-menu/

        Version:        2.0
        Updated:        07/02/2020
        Created:        07/01/2020
        Author:         Zach Choate
        URL:            https://raw.githubusercontent.com/KSMC-TS/functions/master/New-OptionList.ps1

    #>

    param (
           [string]$title,
           [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
           [string[]]$optionsList=@(),
           [string]$message
    )

    Clear-Host
    Write-Host "================ $title ================"
    
    $n = 1
    ForEach($option in $optionsList) {

        Write-Host "$n`: Press `'$n`' $message $option."
        $n++

    }
    Write-Host "Q: Press 'Q' to quit."
    $validationSet = '^[1-{0}]$|^Q$' -f [regex]::escape($($n-1))
    while(($optionSelected = Read-Host "Please make a selection") -notmatch $validationSet){}
    If($optionSelected -eq "q") {
        Write-Host "Quiting..."
        Exit
    }
    $optionSelected = $optionSelected-1
    $selectedValue = $optionsList[$optionSelected]

    Write-Host "`nYou selected $message $selectedValue. `nMoving on..."
    Return $selectedValue

}
