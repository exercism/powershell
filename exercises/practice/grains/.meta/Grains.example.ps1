Function Get-GrainSquare() {
    <#
    .SYNOPSIS
    Get the number of grains on a square.

    .DESCRIPTION
    Given a number, return the number of grains on that square.
    
    .PARAMETER Number
    Which square to get the number of grains.
    
    .EXAMPLE
    Get-GrainSquare -Number 2
    #>
    [CmdletBinding()]
    Param(
        [BigInt]$Number
    )

    if ($Number -lt 1 -or $Number -gt 64) {
        throw "square must be between 1 and 64"
    }
    
    return [BigInt]::pow(2, ($Number - 1))
}

Function Get-GrainTotal() {
    <#
    .SYNOPSIS
    Get the total number of grains.

    .DESCRIPTION
    Return the total number of grains on the board.

    .EXAMPLE
    Get-GrainTotal
    #>
    
    $sum = 0
    for ($i = 1; $i -le 64; $i++) {
        $sum += Get-GrainSquare -Number $i
    }
    return $sum
}
