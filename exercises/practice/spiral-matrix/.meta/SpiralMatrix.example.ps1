Function Get-SpiralMatrix() {
    <#
    .SYNOPSIS
    Implement a function to generate a spiral matrix.

    .DESCRIPTION
    Given the size, return a square matrix of numbers in spiral order.
    The matrix should be filled with natural numbers, starting from 1 in the top-left corner, increasing in an inward, clockwise spiral order

    .PARAMETER Size
    Size of the matrix.

    .EXAMPLE
    Get-SpiralMatrix -Size 2
    Return: @(
        @(1,2),
        @(4,3)
    )
    #>
    [CmdletBinding()]
    Param(
        [int]$Size
    )

    enum Dir {
        RIGHT
        DOWN
        LEFT
        UP
    }
    
    $matrix = @()
    for ($i = 0; $i -lt $Size; $i++) {
        $matrix += ,(@($null) * $Size)
    }

    $top    = $left = 0
    $bottom = $right = $Size - 1
    $dir    = [Dir]::RIGHT
    $value  = 1

    while (($bottom -ge $top) -and ($right -ge $left)) {
        switch ($dir) {
            RIGHT   {
                $left..$right | ForEach-Object { $matrix[$top][$_] = $value; $value++ }
                $top++
            }
            DOWN    { 
                $top..$bottom | ForEach-Object { $matrix[$_][$right] = $value; $value++ }
                $right--
            }
            LEFT    {  
                $right..$left | ForEach-Object { $matrix[$bottom][$_] = $value; $value++ }
                $bottom--
            }
            default {  
                $bottom..$top | ForEach-Object { $matrix[$_][$left] = $value; $value++ }
                $left++
            }
        }
        $dir = ($dir + 1) % 4
    }
    $matrix
}