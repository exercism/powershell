$Alphabet = 'a'..'z'
$ReversedAlphabet = $Alphabet[25..0]

Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Encode a string using the Atbash cipher.

    .DESCRIPTION
    The Atbash cipher is a simple substitution cipher that relies on transposing all the letters in the 
    alphabet such that the resulting alphabet is backwards. 
    The first letter is replaced with the last letter, the second with the second-last, and so on.

    .PARAMETER Phrase
    The string to encode.

    .EXAMPLE
    Invoke-Encode -Phrase "yes"
    #>
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )
    $Phrase = $Phrase.ToLower()
    $Output = ''
    $Counter = 0

    foreach ($Letter in $Phrase.ToCharArray()) {
        $Index = $Alphabet.IndexOf($Letter)
        if ($Index -ne -1) {
            $Letter = $ReversedAlphabet[$Index]
        }elseif (-not ($Letter -match "[0-9]")) {
            continue
        }
        $Counter++
        $Output += $Letter

        if ($Counter % 5 -eq 0) {
            $Output += ' '
        }
    }

    return $Output.Trim()
}

Function Invoke-Decode(){
    <#
    .SYNOPSIS
    Decode a string using the Atbash cipher.

    .DESCRIPTION
    The Atbash cipher is a simple substitution cipher that relies on transposing all the letters in the 
    alphabet such that the resulting alphabet is backwards. 
    The first letter is replaced with the last letter, the second with the second-last, and so on.

    .PARAMETER Phrase
    The string to decode.

    .EXAMPLE
    Invoke-Decode -Phrase "yes"
    #>
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )

    $Output = ''

    foreach ($Letter in $Phrase.ToCharArray()) {
        $Index = $ReversedAlphabet.IndexOf($Letter)
        if ($Index -ne -1) {
            $Letter = $Alphabet[$Index]
        }elseif (-not ($Letter -match "[0-9]")) {
            continue
        }

        $Output += $Letter
    }

    return $Output
}
