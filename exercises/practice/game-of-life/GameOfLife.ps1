Function Invoke-GameOfLife() {
    <#
    .SYNOPSIS
    Compute the next generation of cells for Conway's Game of Life.

    .DESCRIPTION
    Given a matrix of integer acting as cells in Conway's Game of Life, compute the next generation.
    Each cell has two states : alive (1) or dead (0).
    Each cell have eight neighbors, and the following rules are applied to each cell:
    - Any live cell with two or three live neighbors lives on.
    - Any dead cell with exactly three live neighbors becomes a live cell.
    - All other cells die or stay dead.

    .PARAMETER Matrix
    A matrix represent the current state of the game.

    .EXAMPLE
    $matrix = @(
        @(1, 1),
        @(1, 0)
    )
    
    Invok-GameOfLife -Matrix $matrix
    Returns:
    @(
        @(1, 1),
        @(1, 1)
    )
    #Bottom right cell come alive and the other three cells stay alive follow the logic of the rules.
    #>
    [CmdletBinding()]
    Param(
        [int[][]] $Matrix
    )
    Throw "Please implement this function"
}
