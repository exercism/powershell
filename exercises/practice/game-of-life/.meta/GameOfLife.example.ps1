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
    if ($Matrix.Count -eq 0) {
        return @()
    }

    $mapValues = @{}
    for ($r = 0; $r -lt $Matrix.Count; $r++) {
        for ($c = 0; $c -lt $Matrix[$r].Count; $c++) {
            $cell = [Cell]::new($r,$c)
            Update-Cell $cell $mapValues $Matrix
            
            $neighbors = $Cell.GetNeighbors($Matrix.Count)
            foreach ($n in $neighbors) {
                Update-Cell $n $mapValues $Matrix
            }
            $isAlive = $Matrix[$r][$c] -eq 1
            $liveNeighbors = ($neighbors | Where-Object {$mapValues[$_.ToString()] -eq 1}).Count
            if ($isAlive -and ($liveNeighbors -eq 2 -or $liveNeighbors -eq 3) -or (-not $isAlive -and $liveNeighbors -eq 3))  {
                $Matrix[$r][$c] = 1
            }else {
                $Matrix[$r][$c] = 0
            }
        }
    }
    $Matrix
}
class Cell {
    [int]$Row
    [int]$Column

    Cell([int]$row, [int]$col) {
        $this.Row = $row
        $this.Column = $col
    }

    [System.Collections.Generic.List[Cell]] GetNeighbors([int]$Limit) {
        $neighbors = [System.Collections.Generic.List[Cell]]::new()
        foreach ($i in -1..1) {
            foreach ($j in -1..1) {
                if ($i -eq 0 -and $j -eq 0) {
                    continue
                }
                $newR = $this.Row + $i
                $newC = $this.Column + $j
                if ($newR -ge 0 -and $newR -lt $Limit -and $newC -ge 0 -and $newC -lt $Limit) {
                    $neighbors.Add([Cell]::new($newR, $newC))
                }
            }
        }
        return $neighbors
    }

    [string]ToString() {
        return "$($this.Row):$($this.Column)"
    }
}

function Update-Cell {
    param (
        [Cell]$Cell,
        [hashtable]$Map,
        [int[][]] $Matrix
    )
    if (-not $Map.ContainsKey($Cell.ToString())) {
        $Map[$Cell.ToString()] = $Matrix[$Cell.Row][$Cell.Column]
    }
}
