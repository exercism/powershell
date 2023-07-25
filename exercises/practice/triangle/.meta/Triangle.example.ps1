Enum Triangle {
    EQUILATERAL
    ISOSCELES
    SCALENE
}

Function Get-Triangle() {
    <#
    .SYNOPSIS
    Determine if a triangle is EQUILATERAL, ISOSCELES, or SCALENE.

    .DESCRIPTION
    Given 3 sides of a triangle, return the type of that triangle if it is a valid triangle.
    
    .PARAMETER Sides
    The lengths of a triangle's sides.

    .EXAMPLE
    Get-Triangle -Sides @(1,2,3)
    #>
    
    [CmdletBinding()]
    Param (
        [double[]]$Sides
    )
    Test-Validity $Sides
    switch (($Sides | Select-Object -Unique).Count) {
        1       { return [Triangle]::EQUILATERAL }
        2       { return [Triangle]::ISOSCELES }
        default { return [Triangle]::SCALENE }
    }
}

Function Test-Validity() {
    [CmdletBinding()]
    Param (
        [double[]]$Sides
    )
    if ($Sides | Where-Object {$_ -le 0}) {
        Throw "All side lengths must be positive."
    }
    $sortedSides = $Sides | Sort-Object
    if ($sortedSides[0] + $sortedSides[1] -lt $sortedSides[2]) {
        Throw "Side lengths violate triangle inequality."
    }
}