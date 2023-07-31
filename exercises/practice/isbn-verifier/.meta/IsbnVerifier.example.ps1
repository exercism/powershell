Function Test-Isbn() {
    <#
    .SYNOPSIS
    Determine if an ISBN is valid or not.
    
    .DESCRIPTION
    Given a string the function should check if the provided string is a valid ISBN-10.
    
    .PARAMETER Isbn
    The ISBN to check
    
    .EXAMPLE
    Test-Isbn -Isbn "3-598-21508-8"
    
    Retuns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Isbn
    )

    $isbn = $Isbn -replace "-", ""
    if ($isbn.Length -ne 10) {
        return $false
    }

    $sum = 0

    for ($i = 0; $i -lt 10; $i++) {
        $c = $isbn[$i]
        if ($c -eq "X" -and $i -eq 9) {
            $sum += 10
        } elseif ($c -ge "0" -and $c -le "9") {
            $sum += [int]::Parse($c) * (10 - $i)
        } else {
            return $false
        }
    }
    return $sum % 11 -eq 0
}
