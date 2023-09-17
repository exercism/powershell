# Score categories. Change the values as you see fit.
Enum Category {
    YACHT           = $null
    ONES            = $null
    TWOS            = $null
    THREES          = $null
    FOURS           = $null
    FIVES           = $null
    SIXES           = $null
    FULL_HOUSE      = $null
    FOUR_OF_A_KIND  = $null
    LITTLE_STRAIGHT = $null
    BIG_STRAIGHT    = $null
    CHOICE          = $null
}

Function Get-Score() {
    <#
    .SYNOPSIS
    Implement a function to get the score of a yacht game.

    .DESCRIPTION
    Given a list of values for five dice and a category, your solution should return the score of the dice for that category.
    If the dice do not satisfy the requirements of the category your solution should return 0.
    You can assume that five values will always be presented, and the value of each will be between one and six inclusively.
    You should not assume that the dice are ordered.

    .PARAMETER Dice
    An array of 5 integer, each represent a dice value.

    .PARAMETER Category
    An Enum value represent a category in the game of yacht.

    .EXAMPLE
    Get-Score -Dice @(1,2,3,4,5) -Category CHOICE
    Return: 15
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Dice,
        [Category]$Category
    )
    Throw 'Please implement this function'
}