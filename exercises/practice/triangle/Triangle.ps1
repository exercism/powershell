Function Get-Triangle() {
    <#
    .SYNOPSIS
    Determine if a triangle is equilateral, isosceles, or scalene.

    .DESCRIPTION
    Given 3 sides of a triangle, return the type of that triangle if it is a valid triangle.
    
    .PARAMETER Sides
    The lengths of a triangle's sides.

    .EXAMPLE
    Get-Triangle -Sides @(1,2,3)
    Return: [Triangle]::SCALENE
    #>
    
    [CmdletBinding()]
    Param (
        [double[]]$Sides
    )
    Throw "Please implement this function"
}