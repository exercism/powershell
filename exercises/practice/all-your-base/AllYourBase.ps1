Function Invoke-Rebase() {
    <#
    .SYNOPSIS
    Convert a number, represented as a sequence of digits in one base, to any other base.

    .DESCRIPTION
    Implement general base conversion of a number.
    Given an array of digits represent a number in base "a", convert it and return an array of digits represent the same number in base "b".

    .PARAMETER Digits
    Array of digits represent the number to be converted.

    .PARAMETER InputBase
    The original base of the number.

    .PARAMETER OutputBase
    The base to be converted to.

    .EXAMPLE
    Invoke-Rebase -Digits @(1, 0, 1 , 0 ,1 ) -InputBase 2 -OutputBase 10
    return : @(2, 1)
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Digits,
        [int]$InputBase,
        [int]$OutputBase
    )
    Throw "Please implement this function"
}