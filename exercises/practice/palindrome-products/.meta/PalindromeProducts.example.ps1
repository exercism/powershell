Function Get-Products() {
    <#
    .SYNOPSIS
    Detect palindrome products in a given range.

    .DESCRIPTION
    A palindromic number is a number that remains the same when its digits are reversed.
    For example, `121` is a palindromic number but `112` is not.

    Given a range of numbers, find the largest and smallest palindromes which
    are products of two numbers within that range.

    Your solution should return the largest and smallest palindromes, along with the factors of each within the range.
    If the largest or smallest palindrome has more than one pair of factors within the range, then return all the pairs.

    .PARAMETER Min
    The minimum value of the range to find palindrome products.
    Min can't be larger than Max.
    
    .PARAMETER Max
    The maximum value of the range to find palindrome products.
    Max can't be smaller than Min. Parameter contrainst should be placed on this parameter.

    .PARAMETER Largest
    A switch parameter, present to return the largest palindrome.
    If not present then default behavior of the function should be return the smallest palindrome.

    .EXAMPLE
    Get-Products -Min 1 -Max 9
    Returns : @{ Value = 1; Products = @( @(1, 1)) }

    Get-Products -Min 1 -Max 9 -Largest
    Returns : @{ Value = 9; Products = @( @(1, 9), @(3, 3)) }
    #>
    [CmdletBinding()]
    Param(
        [int]$Min,
        [ValidateScript({$_ -ge $Min}, ErrorMessage="Min can't be larger than Max")]
        [int]$Max,
        [switch]$Largest
    )

    if ($Largest) {
        return FindLargest $Min $Max
    }else {
        return FindSmallest $Min $Max
    }
}

Function IsPalindrome([int64]$product) {
    $numStr  = $product.ToString()
    $reverse = -join ($numStr.ToCharArray()[($numStr.Length-1)..0])
    $numStr -eq $reverse
}


Function FindSmallest($min,$max) {
    $minPalindrome = $max * $max

    $factors = @()
    for ($i = $Min; $i -le $Max; $i++) {
        if ($i * $i -ge $minPalindrome) {
            break
        }
        for ($j = $Min; $j -le $Max; $j++) {
            $product = $i * $j
            if ($product -ge $minPalindrome) {
                break
            }
            if ((IsPalindrome $product) -and ($product -lt $minPalindrome)) {
                $minPalindrome = $product
                $factors = ,@($i,$j)
            }
        }
    }

    @{
        Value = $factors.Count ? $minPalindrome : $null
        Products = $factors
    }
}

Function FindLargest($min,$max) {
    $maxPalindrome = 0

    for ($i = $Max; $i -ge $Min; $i--) {
        if ($i * $i -le $maxPalindrome) {
            break
        }
        for ($j = $i; $j -ge $Min; $j--) {
            $product = $i * $j
            if ($product -le $maxPalindrome) {
                break
            }
            if (IsPalindrome $product) {
                $maxPalindrome = $product
            }
        }
    }

    $factors = @()
    for ($i = $min; $i -le [math]::Sqrt($maxPalindrome); $i++) {
        if ($maxPalindrome % $i -eq 0) {
            $remain = $maxPalindrome / $i
            if ($remain -le $max) {
                $factors += ,@($i,$remain)
            }
        }
    }

    @{
        Value = $factors.Count ? $maxPalindrome : $null
        Products = $factors
    }
}