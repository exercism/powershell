Function Get-SquareRoot() {
    <#
    .SYNOPSIS
    Given a natural radicand, return its square root.
    
    .DESCRIPTION
    The function takes a positive integer and return its square root value.

    .PARAMETER Radicand
    The number to get its square root.
    
    .EXAMPLE
    Get-SquareRoot -Radicand 25
    Retuns: 5
    #>
    [CmdletBinding()]
    Param(
        [int]$Radicand
    )
    $Guess = $Radicand
    $Divisor = 0
    $Term = 1 -shl 30
 
    while ($Term -gt $Radicand) {
        $Term = $Term -shr 2
    }
 
    while ($Term) {
        if ($Guess -ge ($Divisor + $Term)) {
            $Guess -= ($Divisor + $Term)
            $Divisor = ($Divisor -shr 1) + $Term
        }else {
             $Divisor = $Divisor -shr 1
        }
        $Term = $Term -shr 2
    }
    return $Divisor
}