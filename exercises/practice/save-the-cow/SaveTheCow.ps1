<#
.SYNOPSIS
    Implement the logic for a word-guessing game.
.DESCRIPTION
    Implement the logic and functionalities of a word-guessing game.
    The game has 3 states: WIN, LOSE and ONGOING.
    You are allowed to fail 9 times.
    Incorrect guess and repeating guess will decrease the remaining failures by 1.
    You win when you correctly guess the word.
#>

Enum Status {
    WIN
    LOSE
    ONGOING
}

Class WordGame {
    [int] $RemainingFailures
    [Status] $State

    WordGame([string] $word) {
        Throw "Please implement this class"
    }

    [void] Guess([char]$letter) {
        Throw "Please implement this function"
    }

    [string] Display() {
        Throw "Please implement this function"
    }
}
