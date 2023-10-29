Function Invoke-Say() {
    <#
    .SYNOPSIS
    Given a number from 0 to 999,999,999,999, spell out that number in English.

    .DESCRIPTION
    Implement a program to convert a number in a specific range to a string of that number in English.

    .PARAMETER Number
    An int in the range of 0 - 999,999,999,999 to be converted into english words.

    .EXAMPLE
    Invoke-Say -Number 12345
    Returns: "twelve thousand three hundred forty-five"
    #>
    [CmdletBinding()]
    Param(
        [ValidateRange(0,999999999999)]
        [int64]$Number
    )

    $ONES = @(
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
    )

    $TENS = @("", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")
    
    $BASES = [ordered]@{
        'billion'  = 1e9
        'million'  = 1e6
        'thousand' = 1e3
        'hundred'  = 1e2
    }

    if ($Number -lt 20) {
        return $ONES[$Number]
    }

    $result = @()
    foreach ($pair in $BASES.GetEnumerator()) {
        if ($Number -ge $pair.Value) {
            $result += Invoke-Say -Number ([math]::Floor($Number / $pair.Value))
            $result += $pair.Name
            $Number = $Number % $pair.Value
        }
    }

    if ($Number -gt 0 -and $Number -lt 20) {
        $result += $ONES[$Number]
    }else {
        $tensPlace = [Math]::Floor($Number/10)
        $word = $Number % 10  ?  "$($TENS[$tensPlace])-$($ONES[$Number%10])" : $TENS[$tensPlace]
        $result += $word
    }
    $result -ne "" -join " "
}