Function Invoke-PerfectNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is perfect, abundant, or deficient based on Nicomachus' (60 - 120 CE) classification scheme for natural numbers.

    .DESCRIPTION
    Calculate the aliquot sum of a number: the sum of its positive divisors not including the number itself.
    Compare the sum to the original number.
    Determine the classification: perfect, abundant, or deficient.

    .PARAMETER Number
    The number to perform the classification on.

    .EXAMPLE
    Invoke-PerfectNumbers -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )
    if ($Number -le 0) {
        Throw "error: Classification is only possible for positive integers."
    }
    
    $sum = 0

    for ($i = 1; $i -lt $number; $i++) {
        if ($Number % $i -eq 0) {
            $sum += $i
        }
    }
    switch ($sum) {
        {$sum -eq $Number} {return "perfect"}
        {$sum -gt $Number} {return "abundant"}
        {$sum -lt $Number} {return "deficient"}
    }
}
