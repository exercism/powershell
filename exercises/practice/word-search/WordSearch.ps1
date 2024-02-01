<#
.SYNOPSIS
    Implement a program to find word in a search puzzle.

.DESCRIPTION
    Given a grid of letters, find the targey word that hides inside it.
    Words can be hidden in all kinds of directions: left-to-right, right-to-left, vertical and diagonal.

    Implement a class that will take in an array of string(s) represent the grid.
    Inside the class, implement a Search method that will take in a string as the target word.
    If found, return the result in an object that contain the location of the first and last letter.
    If the word doesn't exist in the grid, return $null.

    The object return must have these properties and their value in this format:
    - Start: @(row value, column value)
    - End  : @(row value, column value)
    Value of row and column follow the standard of 0-based index.

.EXAMPLE
    $grid = @(
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    )
    $puzzle = [WordSearch]::new($grid)
    $puzzle.Search("clojure")

    Returns: [PsCustomObject]@{
        Start = @(9, 0)
        End   = @(9, 6)
    }
#>
Class WordSearch {
    WordSearch($grid) {
        Throw "Please implement this class"
    }

    Search ($word) {
        Throw "Please implement this function"
    }
}