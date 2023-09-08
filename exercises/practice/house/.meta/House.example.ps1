$LIENS = @{
    1  = @('house', 'Jack built.')
    2  = @('malt', 'lay in')
    3  = @('rat', 'ate')
    4  = @('cat', 'killed')
    5  = @('dog', 'worried')
    6  = @('cow with the crumpled horn', 'tossed')
    7  = @('maiden all forlorn', 'milked')
    8  = @('man all tattered and torn', 'kissed')
    9  = @('priest all shaven and shorn', 'married')
    10 = @('rooster that crowed in the morn', 'woke')
    11 = @('farmer sowing his corn', 'kept')
    12 = @('horse and the hound and the horn', 'belonged to')
    }

Function Get-Rhyme() {
    <#
    .SYNOPSIS
    Recite the nursery rhyme 'This is the House that Jack Built'.

    .DESCRIPTION
    Given the start verse and the end verse, return a string reciting the rhyme from that range.

    .PARAMETER Start
    The start verse.

    .PARAMETER End
    The end verse.

    .EXAMPLE
    Get-Rhyme -Start 1 -End 2
    Return:
    @"
    This is the house that Jack built.
    This is the malt that lay in the house that Jack built.
    "@
     #>
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )
    $LIENS = $Start..$End | ForEach-Object {
        Get-Verse $_
    }
    $LIENS -join "`n"
}

Function Get-Verse($Number) {
    $text = ($Number..1 | ForEach-Object {
        "the $($LIENS[$_][0]) that $($LIENS[$_][1])"
    }) -join " "

    "This is $text"
}