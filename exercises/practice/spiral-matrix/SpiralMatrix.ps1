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
    Throw "Please implement this function"
}