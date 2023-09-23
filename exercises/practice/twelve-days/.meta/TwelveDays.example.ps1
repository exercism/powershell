$VERSES = @{
    1  = @("first", "and a Partridge in a Pear Tree.", "a Partridge in a Pear Tree.")
    2  = @("second", "two Turtle Doves")
    3  = @("third", "three French Hens")
    4  = @("fourth", "four Calling Birds")
    5  = @("fifth", "five Gold Rings")
    6  = @("sixth", "six Geese-a-Laying")
    7  = @("seventh", "seven Swans-a-Swimming")
    8  = @("eighth", "eight Maids-a-Milking")
    9  = @("ninth", "nine Ladies Dancing")
    10 = @("tenth", "ten Lords-a-Leaping")
    11 = @("eleventh", "eleven Pipers Piping")
    12 = @("twelfth", "twelve Drummers Drumming")
}
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
        [ValidateRange(1,12)]
        [int]$Start,
        [ValidateRange(1,12)]
        [int]$End
    )
    ($Start..$End | ForEach-Object {Get-Verse $_}) -join "`n"
}

Function Get-Verse($number) {
    $day = $VERSES[$number][0]
    $items = $number..1 | ForEach-Object {
        $number -ne 1 ? $VERSES[$_][1] : $VERSES[$_][2]
    }

    "On the $day day of Christmas my true love gave to me: $($items -join ", ")"
}