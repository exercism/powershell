<#
.SYNOPSIS
    Count territories of each player in a Go game

.DESCRIPTION
    Implement a class that take in an array of string to represent a two-dimensoinal Go board.

    Territory method: Take in a two integers array @(column, row) represent a coordinate on the board.
    It should return an object with Owner and Coordinates properties (representing the owner's territories)

    Territories method: Find the owners and the territories of the whole board
    It should return an object with ALL Owners and their properties.

    Owner is of Enum value, e.g., [Owner]::NONE
    Coordinates is of SORTED collection of arrays, e.g., @( @(0,0), @(0,1), @(0,2) )

.EXAMPLE
    The board below has 3 spaces to count for territories.
    Black surrounded (0,0) so it owns that, (0,2) and (1,1) is undisputed so None owns those.

    $input = @(
        " B "
        "B W"
    )
    $board = [Board]::new($input)

    $board.Territory(@(1,1))
    Return: @{
                Owner = [Owner]::BLACK
                Coordinates = @()
            }

    $board.Territories()
    Returns: @{
                [Owner]::BLACK = @(@(0,0))
                [Owner]::WHITE = @()
                [Owner]::NONE  = @(@(0,2), @(1,1))
            }
#>

Class Board {
    Board([string[]]$board) {
        Throw "Please implement this class"
    }

    [object] Territory([int[]]$coor) {
        Throw "Please implement this function"
    }

    [object] Territories() {
        Throw "Please implement this function"
    }
}