<#
.SYNOPSIS
    Manage a game player's High Score list.

.DESCRIPTION
    Your task is to build a high-score component of the classic Frogger game, one of the highest selling and most addictive games of all time, and a classic of the arcade era.
    Your task is to write methods that return the highest score from the list, the last added score and the three highest scores.

.EXAMPLE
    $roster = [HighScores]::new(@(30, 50, 40, 90, 80))
    $roster.GetTopThree()
    return : @(90, 80, 50)
#>
Class HighScores {
    HighScores([int[]]$list){
        Throw "Please implement this class."
    }
}