Function Invoke-KillerSudokuHelper() {
    <#
    .SYNOPSIS
    Implement a function to help solve killer sudoku.

    .DESCRIPTION
    Given a cage of certain size, a sum and an array of excluded number, follow the rules and find all possible combinations to fill the cage.
    To make the output of your program easy to read, the combinations it returns must be sorted.

    For example:
    7, [][][], No exclusion => Only possible solution is [1][2][4]
    [1][1][5], [1][3][3], [2][2][3] are all in violation of the "A digit may only occur once in a cage" rule.

    .PARAMETER Sum
    The target sum: total of all number in a cage.

    .PARAMETER Size
    The size of the cage: total cells available for the sum.

    .PARAMETER Exlude
    An array of number that should be excluded from consideration for the sum.

    .EXAMPLE
    Invoke-KillerSudokuHelper -Sum 5 -Size 2 -Exclude @(1)
    Return: @( ,@(2, 3))
    #>
    [CmdletBinding()]
    Param(
        [int]$Sum,
        [int]$Size,
        [int[]]$Exclude
    )
    $potential = 1..9 | Where-Object {$_ -le $sum -and $Exclude -notcontains $_}

    $combinations = Get-Combination -Target $Sum -Size $Size -Range $potential -Result @()
    $combinations
}

function Get-Combination {
    <#
    .DESCRIPTION
    Recursive function to help fincing all posible solutions.
    #>
    param (
        [int]$Target,
        [int]$Size,
        [int[]]$Range,
        [int[]]$Result
    )
    if ($Result.Count -eq $Size -and $Target -eq 0) {
        return (,$Result)
    }

    for ($i = 0; $i -lt $Range.Count; $i++) {
        $num = $Range[$i]
        if ($num -le $Target) {
            $newTarget = $Target - $num
            $newResult = $Result + $num
           
            $newRange = $Range[($i + 1)..($Range.Count - 1)]
            Get-Combination $newTarget $Size $newRange $newResult
        }
    }
}