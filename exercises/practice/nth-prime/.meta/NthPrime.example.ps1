Function Get-NthPrime() {
    <#
    .SYNOPSIS
    Given a number n, determine what the nth prime is.

    .DESCRIPTION
    By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

    .PARAMETER Number
    The number of the prime to return.

    .EXAMPLE
    Get-NthPrime -Number 5
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -eq 0) {
        throw "error: there is no zeroth prime"
    }
    
    $primes = @()
    $i = 2

    while ($primes.Count -lt $Number) {
        $isPrime = $true

        for ($j = 2; $j -lt $i; $j++) {
            if ($i % $j -eq 0) {
                $isPrime = $false
                break
            }
        }

        if ($isPrime) {
            $primes += $i
        }

        $i++
    }

    return $primes[-1]
}