Function Invoke-RotationalCipher() {
    <#
    .SYNOPSIS
    Rotate a string by a given number of places.

    .DESCRIPTION
    Create an implementation of the rotational cipher, also sometimes called the Caesar cipher.
    
    .PARAMETER Text
    The text to rotate    

    .PARAMETER Shift
    The number of places to shift the text

    .EXAMPLE
    Invoke-RotationalCipher -Text "A" -Shift 1
    #>
    [CmdletBinding()]
    Param(
        [string]$Strand
    )
    
    $result = ""
    $cipher = @{}
    $alphabet = "abcdefghijklmnopqrstuvwxyz"
    $alphabet.ToCharArray() | ForEach-Object -Begin { $i = 0 } -Process { $cipher[$_] = $alphabet[($i + 13) % 26]; $i++ }

    foreach ($letter in $Strand.ToCharArray()) {
        $result += $cipher[$letter]
    }

    return $result
}
