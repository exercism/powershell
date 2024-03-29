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
        [string]$Text, 
        [int]$Shift
    )
    
    $result = ""
    $Text.ToCharArray() | ForEach-Object {
        $char = $_
        if ($char -cmatch '^[a-z]$') {
            $result += [char]((([int]$char) + $Shift - 97) % 26 + 97)
        } elseif ($char -match "[A-Z]") {
            $result += [char]((([int]$char) + $Shift - 65) % 26 + 65)
        } else {
            $result += $char
        }
    }

    return $result
}
