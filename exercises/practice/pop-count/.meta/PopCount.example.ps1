Function Invoke-PopCount() {
    <#
    .SYNOPSIS
    Count the number of '1' bit in the binary representation of a decimal number.

    .DESCRIPTION
    Given an integer, count all the '1' bit from the binary representation of that integer.
    Example: 25 is '11001' in binary form, and has 3 bits which are '1'.

    .PARAMETER Value
    Integer represent the decimal value being displayed.

    .EXAMPLE
    Invoke-PopCount -Value 12345
    Returns: 6
    #>
    [CmdletBinding()]
    Param(
        [int]$Value
    )
    $count = 0
    while ($Value -ge 1) {
        if ($Value -band 1 -eq 1 ) {
            $count++
        }
        $Value = $Value -shr 1
    }
    $count
}