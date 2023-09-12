Function Get-Lyric() {
    <#
    .SYNOPSIS
    Recite the lyrics to that popular children's repetitive song: Ten Green Bottles.

    .DESCRIPTION
    Given a start bottles and a number of bottles to be taken away, return a string made of lyric from the song Ten Green Bottles.
    Note that not all verses are identical.

    .PARAMETER Start
    Number of bottles to start with, in range 1-10

    .PARAMETER Take
    Number of bottles to be taken away, in range 1-10
    Taken bottles can't be larger than starting bottles.

    .EXAMPLE
    Get-Lyric -Start 7
    Return:
    @"
    Seven green bottles hanging on the wall,
    Seven green bottles hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be six green bottles hanging on the wall.
    "@"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateRange(1, 10)]
        [int]$Start,
        [ValidateRange(1, 10)]
        [ValidateScript({$_ -le $Start}, ErrorMessage = "You can't take more bottle than what you started with.")]
        [int]$Take = 1
    )

    $lyric = $Start..($Start - $Take + 1) | ForEach-Object {Get-Verse $_}
    ($lyric -join "`n").TrimEnd()
}

Function Get-Verse($count) {
    $numWords = @{
        0  = "no"
        1  = "One"
        2  = "Two"
        3  = "Three"
        4  = "Four"
        5  = "Five"
        6  = "Six"
        7  = "Seven"
        8  = "Eight"
        9  = "Nine"
        10 = "Ten"
    }

    $pluralCheck = {param($bottle) $bottle -eq 1 ? "bottle" : "bottles"}

    $curCount  = $numWords[$count]
    $curBottle = & $pluralCheck $count

    $remainCount  = ($numWords[$($count - 1)]).ToLower()
    $remainBottle = & $pluralCheck ($count - 1)

    @(
    "$curCount green $curBottle hanging on the wall,",
    "$curCount green $curBottle hanging on the wall,",
    "And if one green bottle should accidentally fall,",
    "There'll be $remainCount green $remainBottle hanging on the wall.",
    ""
    ) 
}