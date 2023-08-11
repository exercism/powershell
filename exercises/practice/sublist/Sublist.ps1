Function Invoke-Sublist() {
    <#
    .SYNOPSIS
    Determine the relationship of two arrays.

    .DESCRIPTION
    Given two arrays, determine the relationship of the first array relating to the second array.
    There are four possible categories: EQUAL, UNEQUAL, SUBLIST and SUPERLIST.
    Note: This exercise use Enum values for return.
    
    .PARAMETER Arr1
    The first array

    .PARAMETER Arr2
    The second array

    .EXAMPLE
    Invoke-Sublist -Arr1 @(1,2,3) -Arr2 @(1,2,3)
    Return: [Sublist]::EQUAL

    Invoke-Sublist -Arr1 @(1,2) -Arr2 @(1,2,3)
    Return: [Sublist]::SUBLIST
    #>
    [CmdletBinding()]
    Param (
        [object[]]$Arr1,
        [object[]]$Arr2
    )
    Throw "Please implement this function"
}