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
    [string []]  hidden $_grid
    [hashtable]  hidden $_indicesTable

    WordSearch([string[]]$grid) {
        $this._grid = $grid
        $this._indicesTable = $this.GetIndices($this._grid)
    }

    [hashtable] hidden GetIndices([string []]$grid) {
        <#
        .DESCRIPTION
        Helper function for constructor, build a hashmap of all the letters in the grid and their indices.
        #>
        $table = @{}
        for ($row = 0; $row -lt $grid.Count; $row++) {
            for ($col = 0; $col -lt $grid[0].Length; $col++) {
                $letter = $grid[$row][$col]
                $table[$letter] += ,@($row, $col)
            }
        }
        return $table
    }

    [object]Search ([string]$word) {
        <#
        .DESCRIPTION
        Main function of the class.
        #>
        if (-not $this.IsInGrid($word)) {return $null}

        $startIndices = $this._indicesTable[$word[0]]
        $endIndices   = $this._indicesTable[$word[-1]]

        foreach ($start in $startIndices) {
            foreach ($end in $endIndices) {
                $match =  $this.TestMatching($start, $end, $word.Length -1)
                if ($match.IsMatch) {
                    $wordToCompare = $this.ExtractWord($start,$end, $match.Direction, $word.Length-1)
                    if ($wordToCompare -eq $word) {
                        return [PSCustomObject]@{
                            Start = $start
                            End   = $end
                        }
                    }
                }
            }
        }
        return $null
    }

    [bool] hidden IsInGrid([string]$word) {
        <#
        .DESCRIPTION
        Helper function to check if all letters of the word appear in the grid, via the hashtable.
        A quick check to make sure a word is viable before searching.
        #>
        $present = $word.ToCharArray() | Where-Object {$this._indicesTable.ContainsKey($_)}
        return $present.Count -eq $word.Length
    }

    [PSObject] hidden TestMatching($start, $end, $lenght) {
        <#
        .DESCRIPTION
        A helper function to check if a possible start and end match a potential word, and which direction it is matching to.
        #>
        $horizontalMatch = ($start[0] -eq $end[0]) -and ([Math]::Abs($start[1] - $end[1]) -eq $lenght)
        $verticalMatch   = ($start[1] -eq $end[1]) -and ([Math]::Abs($start[0] - $end[0]) -eq $lenght)
        $dexDiagMatch    = ($start[0] - $end[0] -eq $start[1] - $end[1]) -and ([Math]::Abs($start[0] - $end[0]) -eq $lenght)
        $sinDiagMatch    = ($start[0] + $start[1] -eq $end[0] + $end[1]) -and ([Math]::Abs($start[0] - $end[0]) -eq $lenght)

        $match = switch ($true) {
            $horizontalMatch {@{IsMatch=$true ; Direction="horizontal"}}
            $verticalMatch   {@{IsMatch=$true ; Direction="vertical"}}
            $dexDiagMatch    {@{IsMatch=$true ; Direction="dexter diagonal"}}
            $sinDiagMatch    {@{IsMatch=$true ; Direction="sinister diagonal"}}
            Default          {@{IsMatch=$false; Direction=$null}}
        }
        return $match
    }

    [string] hidden ExtractWord($start, $end, $direction, $length) {
        <#
        .DESCRIPTION
        Helper function to extract a word from start-end indices, and which direction of the word in the grid.
        ALso account for the word being read in reverse (bottom up)
        #>
        $reverse = $false
        $word = switch ($direction) {
            "horizontal" {
                $reverse = $start[1] -gt $end[1]
                if ($reverse) {$start, $end = $end, $start}
                0..$length | ForEach-Object {$this._grid[$start[0]][$start[1] + $_]}
            }
            "vertical" {
                $reverse = $start[0] -gt $end[0]
                if ($reverse) {$start, $end = $end, $start}
                0..$length | ForEach-Object { $this._grid[$start[0] + $_][$start[1]]}
            }
            "dexter diagonal" {
                $reverse = $start[1] -gt $end[1]
                if ($reverse) {$start, $end = $end, $start}
                0..$length | ForEach-Object { $this._grid[$start[0] + $_][$start[1] + $_] }
            }
            "sinister diagonal" {
                $reverse = $start[1] -gt $end[1]
                if ($reverse) {$start, $end = $end, $start}
                0..$length | ForEach-Object { $this._grid[$start[0] - $_][$start[1] + $_] }
            }
        }

        $word = $reverse ? -join ($word[-1..-($word.Length)]) : -join $word
        return $word
    }
}