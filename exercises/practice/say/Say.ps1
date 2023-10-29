Function Invoke-Say() {
    <#
    .SYNOPSIS
    Given a number from 0 to 999,999,999,999, spell out that number in English.

    .DESCRIPTION
    Implement a program to convert a number in a specific range to a string of that number in English.

    .PARAMETER Number
    An int in the range of 0 - 999,999,999,999 to be converted into english words.

    .EXAMPLE
    Invoke-Say -Number 12345
    Returns: "twelve thousand three hundred forty-five"
    #>
    [CmdletBinding()]
    Param(
        [int64]$Number
    )
    Throw "Please implement this function"
}