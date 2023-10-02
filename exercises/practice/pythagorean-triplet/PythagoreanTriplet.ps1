Function Get-PythagoreanTriplet() {
    <#
    .SYNOPSIS
    Given input integer N, find all Pythagorean triplets for which 'a + b + c = N'.

    .DESCRIPTION
    Given an integer, find all the possible Pythagorean triplets whose sum is equal to that integer.
    Return the array of Pythagorean triplets in sorted ascending order.

    A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for which:
    a² + b² = c²
    a < b < c

    .PARAMETER Number
    The sum of a Pythagorean triplet

    .EXAMPLE
    Get-PythagoreanTriplet -Sum 12
    Return: @( ,@(3, 4, 5))
    #>
    [CmdletBinding()]
    Param(
        [int]$Sum
    )
    Throw "Please implement this function"
}