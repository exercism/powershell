Function Get-Change() {
    <#
    .SYNOPSIS
    Determine the fewest number of coins to be given to a customer such that the sum of the coins' value would equal the correct amount of change.
    
    .DESCRIPTION
    Given a change target and an array of coins with different values, find the fewest number of coins can to be used to make the change.
    Return the array of coins (if possible) in ascending order.
    
    .PARAMETER Coins
    The array of coin values.

    .PARAMETER Target
    The amount of change needed to be made.
    
    .EXAMPLE
    Get-Change -Coins @(1, 2, 5, 10, 25) -Target 55
    Return: @(5, 25, 25)
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Coins,
        [int]$Target
    )
    Throw "Please implement this function"
}