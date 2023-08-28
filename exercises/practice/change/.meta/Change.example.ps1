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

    if ($Target -lt 0) {
        Throw "Target can't be negative"
    }

    if (-not $Target) {
        return @()
    }

    $table = @($null) * ($Target + 1)
    $table[0] = @()

    foreach ($amount in 1..$Target) {
        foreach ($coin in $Coins) {
            if ($amount -ge $coin -and $null -ne $table[$amount - $coin]) {
                $temp = $table[$amount - $coin] + @($coin)
                if ($null -eq $table[$amount]) {
                    $table[$amount] = $temp
                } else {
                    $table[$amount] = ($table[$amount].Count -lt $temp.Count) ? $table[$amount] : $temp
                }
            }
        }
    }

    if (-not $table[$Target]) {
        Throw "Can't make change with given coins"
    }
    $table[$Target]
}