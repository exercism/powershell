<#
.SYNOPSIS
    Implement a class to score a bowling game.

.DESCRIPTION
    For the detailed rules of the game, check instructions.

    Write code to keep track of the score of a game of bowling.
    It should support two operations:

    - roll(pins): is called each time the player rolls a ball.
    The argument is an integer represent the number of pins got knocked down (0 - 10)

    - score(): is called only at the very end of the game.
    It returns an integer represent the total score for that game.

    The class also should handle various cases of errors based on invalid or illegal inputs.
    You can decide what error message you want to throw.

.EXAMPLE
    $rolls = @(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
    $game = [BowlingGame]::new()

    foreach ($roll in $rolls) {
        $game.Roll($roll)
    }
    $game.Score()
    Returns: 300
#>
Class BowlingGame {
    BowlingGame() {
        Throw "Please implement this class"
    }

    Roll($pins) {
        Throw "Please implement this fucntion"
    }

    Score() {
        Throw "Please implement this fucntion"
    }
}