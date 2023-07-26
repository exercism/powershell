Function Test-Luhn() {
    <#
    .SYNOPSIS
    Determine if a number is valid per the Luhn formula.
    
    .DESCRIPTION
    The Luhn formula is a simple checksum formula used to validate a variety of identification numbers,
    such as credit card numbers and Canadian Social Insurance Numbers.
    
    .PARAMETER Value
    The number to validate
    
    .EXAMPLE
    Test-Luhn -Value "59"
    
    Retuns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Value
    )

    Throw "Please implement this function"
}
