Function Invoke-ArmstrongNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is an Armstrong number.

    .DESCRIPTION
    An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.

    .PARAMETER Number
    The number to check.

    .EXAMPLE
    Invoke-ArmstrongNumbers -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $numberString = $number.ToString()
    $length = $numberString.Length
    $sum = 0
    foreach ($digit in $numberString.ToCharArray()) {
        $num = [Int64]::Parse($digit)
        $sum += [Math]::Pow($num, $length)
    }
    return $sum -eq $Number
}
