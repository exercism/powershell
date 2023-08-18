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
    
    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Value
    )

    $Value = $Value -replace ' ', ''
    if ($Value -match '[^\d]') {
        return $false
    }
    
    $sum = 0
    $i = 0
    $Value = $Value[($Value.length - 1)..0] -join ""
    $ValueArray = $Value.ToCharArray()
    foreach ($digit in $ValueArray) {
        $i++
        $digit = [int][string]$digit
        if ($i % 2 -eq 0) {
            $digit = $digit * 2
            if ($digit -gt 9) {
                $digit -= 9
            }
        }
        $sum += $digit
    }
    return $sum % 10 -eq 0 -and $Value.Length -ne 1
}