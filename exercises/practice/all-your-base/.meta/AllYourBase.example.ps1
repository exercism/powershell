Function Invoke-Rebase() {
    <#
    .SYNOPSIS
    Convert a number, represented as a sequence of digits in one base, to any other base.

    .DESCRIPTION
    Implement general base conversion of a number.
    Given an array of digits represent a number in base "a", convert it and return an array of digits represent the same number in base "b".

    .PARAMETER Digits
    Array of digits represent the number to be converted.

    .PARAMETER InputBase
    The original base of the number.

    .PARAMETER OutputBase
    The base to be converted to.

    .EXAMPLE
    Invoke-Rebase -Digits @(1, 0, 1 , 0 ,1 ) -InputBase 2 -OutputBase 10
    return : @(2, 1)
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Digits,
        [int]$InputBase,
        [int]$OutputBase
    )
    ErrorHandling $Digits $InputBase $OutputBase

    $result = @()
    $decimal = ConvertToDecimal $Digits $InputBase

    while ($decimal -ge $OutputBase) {
        $result += $decimal % $OutputBase
        $decimal = [Math]::Floor($decimal / $OutputBase)
    }
    if ($decimal -lt $OutputBase) {
        $result += $decimal
    }
    [array]::Reverse($result)
    return  $result
}

Function ConvertToDecimal($Digits, $Base) {
    $DecimalValue = 0
    for ($i = $Digits.Count-1; $i -ge 0; $i--) {
        $DecimalValue += $Digits[$i] * [Math]::Pow($Base, ($Digits.Count - 1) - $i)
    }
    return $DecimalValue
}

Function ErrorHandling($Digits, $InputBase, $OutputBase) {
    if ($InputBase -lt 2) {
        Throw "input base must be >= 2"
    }
    if ($OutputBase -lt 2) {
        Throw "output base must be >= 2"
    }
    if (($Digits | Where-Object { $_ -lt 0 -or $_ -ge $InputBase}).Count ) {
        Throw "all digits must satisfy 0 <= digit < input base"
    }
}