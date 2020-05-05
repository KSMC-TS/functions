function Get-CamelCaseStringSpaced {

    <#

    .DESCRIPTION
    Use to take a string that is camelCased to add spaces and capitalize first letter.

    .PARAMETER string
    String that you want to manipulate.

    .EXAMPLE
    Get-CamelCasedStringSpaced -string "thisIsMYFriend"
     - returns -
    This Is MY Friend

    .NOTES
    Referenced code found here: https://www.codeproject.com/Articles/108996/Splitting-Pascal-Camel-Case-with-RegEx-Enhancement
    and here: https://thedevopshub.com/powershell-converting-first-character-of-a-string-to-uppercase/

    Version:        1.0
    Last Updated:   04/21/2020
    Creation Date:  04/21/2020
    Author:         Zachary Choate

    #>

    param (
        [string]$string
    )

    $string = $string.substring(0,1).toupper()+$string.substring(1)
    ($string -creplace '(?<!^)([A-Z][a-z]|(?<=[a-z])[A-Z])',' $&').trim()

}
