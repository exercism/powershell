$LINES = @{
    1 = @('fly'   , "I don't know why she swallowed the fly. Perhaps she'll die.")
    2 = @('spider', "It wriggled and jiggled and tickled inside her.")
    3 = @('bird'  , "How absurd to swallow a bird!")
    4 = @('cat'   , "Imagine that, to swallow a cat!")
    5 = @('dog'   , "What a hog, to swallow a dog!")
    6 = @('goat'  , "Just opened her throat and swallowed a goat!")
    7 = @('cow'   , "I don't know how she swallowed a cow!")
    8 = @('horse' , "She's dead, of course!")
}

Function Invoke-FoodChain() {
    <#
    .SYNOPSIS
    Generate the lyrics of the song 'I Know an Old Lady Who Swallowed a Fly'.

    .DESCRIPTION
    Given a start verse and an end verse, generate a string lyric from the song 'I Know an Old Lady Who Swallowed a Fly'.

    .PARAMETER Start
    The starting verse. This parameter is mandatory.

    .PARAMETER End
    The ending verse. This parameter is optional.
    If not provided, it should be the same as starting verse.

    .EXAMPLE
    Invoke-FoodChain -Start 2
    Return:
    @"
    I know an old lady who swallowed a spider.
    It wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    "@
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1,8)]
        [int]$Start,
        [ValidateRange(1,8)]
        [int]$End = $Start
    )
    $lyrics = $Start..$End | ForEach-Object {Get-Verse $_}
    (-join $lyrics).TrimEnd()
}

Function Get-Verse($number) {
    $verse = [System.Text.StringBuilder]::new()
    [void]$verse.Append("I know an old lady who swallowed a $($LINES[$number][0]).`n")
    
    if ($number -eq 8 -or $number -eq 1) {
        [void]$verse.Append($LINES[$number][1] + "`n`n")
        return $verse.ToString()
    }
    [void]$verse.Append($LINES[$number][1] + "`n")

    for ($i = $number; $i -gt 1; $i--) {
        $eater, $eaten = $LINES[$i][0], $LINES[$i-1][0]
        if ($eaten -eq "spider") {
            $eaten = "spider that wriggled and jiggled and tickled inside her"
        }
        [void]$verse.Append("She swallowed the $eater to catch the $eaten.`n")
    }
    [void]$verse.Append($LINES[1][1] + "`n`n")
    $verse.ToString()
}