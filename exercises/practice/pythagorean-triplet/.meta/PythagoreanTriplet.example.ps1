Function Get-PythagoreanTriplet() {
    <#
    .SYNOPSIS
    Given input integer N, find all Pythagorean triplets for which 'a + b + c = N'.

    .DESCRIPTION
    Given an integer, find all the possible Pythagorean triplets whose sum is equal to that integer.
    Return the array of Pythagorean triplets in sorted ascending order.

    A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for which:
    a² + b² = c²
    a < b < c

    .PARAMETER Number
    The sum of a Pythagorean triplet

    .EXAMPLE
    Get-PythagoreanTriplet -Sum 12
    Return: @( ,@(3, 4, 5))
    #>
    [CmdletBinding()]
    Param(
        [int]$Sum
    )
    # Logic : If a is at maximum, it still less than b, and b less than c. So c at mimimum but be around N/3
    # For a + b + c = N and a² + b² = c² to be valid, c at maximum cant be larger than N/2
    $rangeOfc = [math]::Floor($Sum / 3)..[math]::Floor($Sum / 2)
    $triplets = @()

    foreach ($c in $rangeOfc) {
        $abSum = $Sum - $c
        $abProd =  [math]::Floor(($abSum * $abSum - $c * $c) / 2)
        if ($abProd -gt 0) {
            $a, $b = Get-AB $abSum $abProd
            $validTriple = ($a * $a + $b * $b) -eq ($c * $c)
            if ($a -and $b -and $validTriple) {
                $triplets += ,@($a, $b, $c)
            }
        }
    }
    $triplets | Sort-Object { $_[0] }
}

function Get-AB($abSum, $abProd) {
    <#
    .DESCRIPTION
    Helper function using the identity (x+y)2−4xy=(x−y)2 aka ab_sum*2−4*ab_prod = (x−y)^2
    to find a and b
    #>
    $abDifSqr = [math]::Pow($abSum, 2) - 4 * $abProd
    if ($abDifSqr -gt 0) {
        $abDif = [math]::Floor([math]::Sqrt($abDifSqr))
        $b, $a = [math]::Floor(($abSum + $abDif) / 2) , [math]::Floor(($abSum - $abDif) / 2)
        $a, $b
    }
}