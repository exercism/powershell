Function Get-ColorsValue() {
    <#
    .SYNOPSIS
    Get the resistor value of 2 band colors.

    .DESCRIPTION
    Take the first 2 colors from the supplied colors and return the resistor value.
    

    .PARAMETER Colors
    The colors to translate to its corresponding resistor value.

    .EXAMPLE
    Get-ColorsValue -Colors @("brown", "black")
    #>
    [CmdletBinding()]
    Param(
        [string]$Colors
    )
    
    $Colors = @{
        "black" = 0
        "brown" = 1
        "red" = 2
        "orange" = 3
        "yellow" = 4
        "green" = 5
        "blue" = 6
        "violet" = 7
        "grey" = 8
        "white" = 9
    }
    return $Colors[$Colors[0]] * 10 + $Colors[$Colors[1]]
}
