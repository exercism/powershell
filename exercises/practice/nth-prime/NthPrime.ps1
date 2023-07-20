Function Get-NthPrime() {
    <#
    .SYNOPSIS
    Given a number n, determine what the nth prime is.

    .DESCRIPTION
    By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

    .PARAMETER Number
    The number of the prime to return.

    .EXAMPLE
    Get-NthPrime -Number 5
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )
    
    throw "Please implement this function"
}
