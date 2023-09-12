# Score categories.Change the values as you see fit.
Enum Category {
    YACHT           = 50
    ONES            = 1
    TWOS            = 2
    THREES          = 3
    FOURS           = 4
    FIVES           = 5
    SIXES           = 6
    FULL_HOUSE      
    FOUR_OF_A_KIND  
    LITTLE_STRAIGHT = 12345
    BIG_STRAIGHT    = 23456
    CHOICE          
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
        [ValidateCount(5,5)]
        [int[]]$Dice,
        [ValidateSet(
            'ONES','TWOS','THREES','FOURS','FIVES','SIXES','YACHT','CHOICE',
            'FULL_HOUSE','FOUR_OF_A_KIND','LITTLE_STRAIGHT','BIG_STRAIGHT')]
        [Category]$Category
    )

    $sortedDice = $Dice | Sort-Object
    switch ($Category) {
        {$_ -in 1..6}           { Singles $sortedDice $Category }
        {$_ -like "*STRAIGHT"}  { Straight $sortedDice $Category }
        FOUR_OF_A_KIND          { FourOfAKind $sortedDice $Category }
        FULL_HOUSE              { FullHouse $sortedDice $Category }
        YACHT                   { Yacht $sortedDice $Category }
        Default                 { Choice $sortedDice $Category }
    }
}

Function Singles([int[]]$Dice, [Category]$Category) {
    $count = ($Dice | Where-Object {$Category -eq $_}).Count
    return [int]$Category * $count
}

Function Straight([int[]]$Dice, [Category]$Category) {
    $diceAsInt = [int](-join $Dice)
    return [int]($diceAsInt -eq $Category) * 30
}

Function Yacht([int[]]$Dice, [Category]$Category) {
    $isYacht = $Dice[0] -eq $Dice[-1]
    return [int]$isYacht * 50
}

Function FullHouse([int[]]$Dice, [Category]$Category) {
    $twoUnique = ($Dice | Select-Object -Unique).Count -eq 2
    $twoSmallThreeLarge = ($Dice[0] -eq $Dice[1]) -and ($Dice[-1] -eq $Dice[2])
    $threeSmallTwoLarge = ($Dice[0] -eq $Dice[2]) -and ($Dice[-1] -eq $Dice[-2])
    $isFullhouse = ($twoSmallThreeLarge -or $threeSmallTwoLarge) -and $twoUnique
    return [int]$isFullhouse * ($Dice | Measure-Object -Sum).Sum
}
Function FourOfAKind([int[]]$Dice, [Category]$Category) {
    $diceValue = 0
    if ($Dice[0] -eq $Dice[3]) {
        $diceValue += $Dice[0]
    }elseif ($Dice[1] -eq $Dice[-1]) {
        $diceValue += $Dice[-1]
    }
    return $diceValue * 4
}

Function Choice([int[]]$Dice, [Category]$Category) {
    return ($Dice | Measure-Object -Sum).Sum
}

