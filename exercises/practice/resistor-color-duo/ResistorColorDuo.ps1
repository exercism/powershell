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
    
    throw "Please implement this function"
}
