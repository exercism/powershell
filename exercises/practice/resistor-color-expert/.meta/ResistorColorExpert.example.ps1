Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor from its color-coded bands.

    .DESCRIPTION
    Given an array of 1, 4 or 5 colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array represent the colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "black", "green", "red")
    Return: "2 megaohms ±2%"

    Get-ResistorLabel -Colors @("blue", "blue", "blue", "blue", "blue")
    Return: "666 megaohms ±0.25%"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )

    if ($Colors.Count -eq 1) {
        return "0 ohms"
    }

    $colorsCode = @{
        "black"  = 0
        "brown"  = 1
        "red"    = 2
        "orange" = 3
        "yellow" = 4
        "green"  = 5
        "blue"   = 6
        "violet" = 7
        "grey"   = 8
        "white"  = 9
    }

    $units = [ordered]@{
        1e9 = "gigaohms"
        1e6 = "megaohms"
        1e3 = "kiloohms"
    }

    $toleranceCode = @{
        "grey"   = 0.05
        "violet" = 0.1
        "blue"   = 0.25
        "green"  = 0.5
        "brown"  = 1
        "red"    = 2
        "gold"   = 5
        "silver" = 10
    }

    if ($Colors.Count -eq 4) {
        $v1, $v2, $multiplier = $Colors[0..2] | ForEach-Object {$colorsCode[$_]}
        $totalValue = ($v1 * 10 + $v2) * [Math]::Pow(10, $multiplier)
    } elseif ($Colors.Count -eq 5) {
        $v1, $v2, $v3, $multiplier, $tolerance = $Colors[0..3] | ForEach-Object {$colorsCode[$_]}
        $totalValue = ($v1 * 100 + $v2 * 10 + $v3) * [Math]::Pow(10, $multiplier)
    }
    $tolerance  = $toleranceCode[$Colors[-1]]

    foreach ($key in $units.Keys) {
        if ($totalValue -gt $key) {
            return "$($totalValue / $key) $($units[$key]) ±$tolerance%"
        }
    }
    return "$totalValue ohms ±$tolerance%"
}