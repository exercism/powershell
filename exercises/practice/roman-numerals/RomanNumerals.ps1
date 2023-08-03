Function Get-RomanNumerals() {
    <#
    .SYNOPSIS
    Given a number, convert it into a roman numeral.

    .DESCRIPTION
    Convert a positive integer into a string representation of that integer in roman numeral form.
    
    .PARAMETER Number
    The number to turn into roman numeral.

    .EXAMPLE
    Get-RomanNumerals -Number 1
    return: 'I'
    Get-RomanNumerals -Number 3999
    return: 'MMMCMXCIX'
    #>
    [CmdletBinding()]
    Param(
        [int]$Number
    )
    Throw "Please implement this function."
}