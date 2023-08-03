Function Get-RomanNumerals() {
    <#
    .SYNOPSIS
    Given a number, convert it into a roman numeral.

    .DESCRIPTION
    Convert a positive integer into a string representation of that integer in roman numeral form.
    
    .PARAMETER Number
    The number to turn into roman numeral.

    .EXAMPLE
    Get-RomanNumerals -Number 1
    return: 'I'
    Get-RomanNumerals -Number 3999
    return: 'MMMCMXCIX'
    #>
    [CmdletBinding()]
    Param(
        [int]$Number
    )
    if ($Number -lt 1 -or $Number -gt 3999) {
        Throw 'Number has to be positive integer in range of 1-3999.'
    }
    $Roman = @()
    $romanNumerals = [ordered]@{
        1000 = 'M'; 900  = 'CM'; 500  = 'D'; 400  = 'CD';
        100  = 'C'; 90   = 'XC'; 50   = 'L'; 40   = 'XL';
        10   = 'X'; 9    = 'IX'; 5    = 'V'; 4    = 'IV';
        1    = 'I'
    }
    foreach ($key in $romanNumerals.Keys) {
        $Multi   = [Math]::Floor($Number / $key)
        $Roman  += $RomanNumerals.$key * $Multi
        $Number -= $multi * $key
    }
    return -join $Roman
}