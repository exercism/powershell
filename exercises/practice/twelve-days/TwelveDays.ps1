Function Invoke-TwelveDays() {
    <#
    .SYNOPSIS
    Recite the lyrics of the song: "The Twelve Days of Christmas" based on given verses.

    .DESCRIPTION
    Given a start verse and an end verse, return the string lyric of the English Christmas carol "The Twelve Days of Christmas".
    Each subsequent verse of the song builds on the previous verse.

    .PARAMETER Start
    The starting verse.

    .PARAMETER End
    The ending verse.

    .EXAMPLE
    Invoke-TwelveDays -Start 1 -End 1
    Return: "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
    #>
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )
    Throw "Please implement this function"
}