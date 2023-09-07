Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor with three color-coded bands.

    .DESCRIPTION
    Given an array of colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array repesent the 3 colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "white", "blue")
    Return: "29 megaohms"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )
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

    $baseValue  = $colorsCode[$Colors[0]] * 10 + $colorsCode[$Colors[1]]
    $magnitute  = [Math]::Pow(10, $colorsCode[$Colors[2]])
    $total      = $baseValue * $magnitute

    foreach ($key in $units.Keys) {
        if ($total -gt $key) {
            return "$($total / $key) $($units[$key])"
        }
    }
    return "$total ohms"
}