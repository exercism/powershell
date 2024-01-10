<#
.SYNOPSIS
    Stimulate a game of hangman.
.DESCRIPTION
    Implement the logic and functionalities of a hangman game.
    The game started with 9 remaining guesses.
    Each incorrect guess will decrease the remaining guesses by 1.
    The game has 3 states: WIN, LOSE and ONGOING.
    You win when you correctly guess the word.
    You lose when you spent all of your guesses.
.EXAMPLE
    $game = [Hangman]::new("welcome")

    $game.RemainingGuesses
    Returns: 9
    $game.Display()
    Returns: "_______"

    $game.Guess("e")
    $game.Display()
    Returns: "_e____e"

    $game.Guess("z")
    $game.RemainingGuesses
    Returns: 8
#>


Enum Status {
    WIN
    LOSE
    ONGOING
}

Class Hangman {
    [int] $RemainingGuesses
    [Status] $Status

    Hangman([string] $word) {
        Throw "Please implement this class"
    }

    Guess($char) {
        Throw "Please implement this function"
    }

    [string] Display() {
        Throw "Please implement this function"
    }

    [Status] GetStatus() {
        Throw "Please implement this function"
    }
}