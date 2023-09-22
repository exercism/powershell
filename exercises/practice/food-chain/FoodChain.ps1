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
        [int]$Start,
        [int]$End
    )
    Throw "Please implement this function"
}
