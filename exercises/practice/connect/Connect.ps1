<#
.SYNOPSIS
    Compute the result for a game of Hex / Polygon.

.DESCRIPTION
    Your goal is to build a program that given a simple representation of a board computes the winner (or lack thereof).
    Note that all games need not be "fair".
    Player 'O' plays from top to bottom, and player 'X' plays from left to right.
    
.EXAMPLE
    $board = @(
        "O O X",
        " X O X",
        "  X X O"
    )

    $game = [Connect]::new($board)
    $game.GetWinner()
    Returns: [Winner]::X
#>

Enum Winner {
    X
    O
    NONE
}

Class Connect {
    Connect() {
        Throw "Please implement this class"
    }   

    [Winner] GetWinner() {
        Throw "Please implement this function"
    }
}

