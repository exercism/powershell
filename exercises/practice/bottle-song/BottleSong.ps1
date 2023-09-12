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
        [int]$Start,
        [int]$Take = 1
    )
    Throw "Please implement this function"
}
