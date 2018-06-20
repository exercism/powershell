Function Get-Raindrops() {
    <#
    .SYNOPSIS
    Given a number convert it to Pling, Plang, Plong if it has factors of 3, 5 or 7.
    
    .DESCRIPTION
    Convert a number to a string, the contents of which depend on the number's factors.

    - If the number has 3 as a factor, output 'Pling'.
    - If the number has 5 as a factor, output 'Plang'.
    - If the number has 7 as a factor, output 'Plong'.
    - If the number does not have 3, 5, or 7 as a factor, just pass the number's digits straight through.
    
    .PARAMETER Rain
    The number to evaluate
    
    .EXAMPLE
    Get-Raindrops -Rain 35

    This will return PlangPlong as it has factors of 5 and 7

    .EXAMPLE
    Get-Raindrops -Rain 12121

    This will return 12121 as it does not contain factors of 3, 5 or 7 so the value is passed through.
    #>
    [CmdletBinding()]
    Param(
        [int]$Rain
    )

    Throw "Not implemented exception"
}