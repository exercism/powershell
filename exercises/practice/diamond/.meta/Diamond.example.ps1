Function Invoke-Diamond() {
    <#
    .SYNOPSIS
    Given a letter, output a diamond shape.

    .DESCRIPTION
    Take a letter of the alphabet, return a string in a diamond shape starting with 'A', with the supplied letter at the widest point.
    The output should use only capitalized letters, however the input should be case-insensitive.

    .PARAMETER Letter
    The letter used to decide the shape of the diamond.

    .EXAMPLE
    Invoke-Diamond -Letter D
    Return:
    @"
       A   
      B B  
     C   C 
    D     D
     C   C 
      B B  
       A   
    "@ 
    #>
    [CmdletBinding()]
    Param(
        [char]$Letter
    )
    $Letter = $Letter.ToString().ToUpper()

    if ($Letter -eq 'A') {
        return "A`n"
    }

    $MakeLine = { param($l) 
        $space = ' ' * ([char]$Letter - [char]$l)
        if ($l -eq 'A') {
            return "${space}${l}${space}"
        } else {
            $mid = ' ' * (([char]$l - [char]'A') * 2 - 1)
            return "${space}${l}${mid}${l}${space}"
        }
    }

    $Diamond  = [char]'A'..[char]$Letter + [char]($Letter-1)..[char]'A' | ForEach-Object {& $MakeLine $_}
    return $Diamond -join "`r`n"
}