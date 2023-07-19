Function Invoke-Panagram() {
    <#
    .SYNOPSIS
    Determine if a sentence is a pangram.
    
    .DESCRIPTION
    A pangram is a sentence using every letter of the alphabet at least once.
    
    .PARAMETER Sentence
    The sentence to check
    
    .EXAMPLE
    Invoke-Panagram -Sentence "The quick brown fox jumps over the lazy dog"
    
    Retuns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Sentence
    )

    $Sentence = $Sentence.ToLower()

    $FoundLetters = @()
    $Letters = $Sentence.ToCharArray()
    foreach ($item in $Letters) {
        if ($FoundLetters -notcontains $item -and $item -match "[a-z]") {
            $FoundLetters += $item
        }
    }

    if ($FoundLetters.Count -eq 26) {
        return $true
    }
    return $false
}
