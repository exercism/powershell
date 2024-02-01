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

Enum Owner {
    WHITE
    BLACK
    NONE
}

Class Board {
    [string[]] $_board
    [int] $_rows
    [int] $_cols

    Board([string[]]$board) {
        $this._board = $board
        $this._rows  = $board.Count
        $this._cols  = $board[0].Length
    }

    [object] Territory([int[]]$coor) {
        <#
        Utilize BDF and queue to find space and its surrounding
        #>
        $col, $row = $coor
        $this.ValidateCoor($col, $row)

        $result = [PSCustomObject]@{
            Owner = [Owner]::NONE
            Coordinates = [System.Collections.Generic.HashSet[int[]]]::new()
        }
        if ($this._board[$row][$col] -ne " ") {return $result}

        $owners = [System.Collections.Generic.HashSet[string]]::new()
        $visited = [System.Collections.Generic.HashSet[string]]::new()
        $queue = [System.Collections.Queue]::new()
        $queue.Enqueue($coor)
        
        while ($queue.Count) {
            $col, $row = $queue.Dequeue()
            $visited.Add("$col$row")

            if ($this._board[$row][$col] -eq " ") {
                $result.Coordinates.Add(@($col, $row))
            }

            $neighbors = $this.GetNeighbors($col, $row)
            foreach ($neighbor in $neighbors) {
                $n_col, $n_row = $neighbor
                if ($this._board[$n_row][$n_col] -eq " ") {
                    if(-not $visited.Contains("$n_col$n_row")) {
                        $queue.Enqueue($neighbor)
                    }
                }else {
                    $owners.Add($this._board[$n_row][$n_col])
                }
            }
        }

        if ($owners.Count -eq 1) {
            $result.Owner = [Owner]::($owners[0] -eq 'B' ? 'BLACK' : 'WHITE')
        }

        if ($result.Coordinates.Count -gt 1) {
            $result.Coordinates  = ($result.Coordinates | Sort-Object)
        }
        return $result
    }

    [object]  GetNeighbors($col, $row) {
        <#
        Get possible neighbors nodes
        #>
        $left   = ($col -ge 1) ? @(($col - 1), $row) : $null
        $right  = ($col + 1 -lt $this._cols) ? @(($col + 1), $row) : $null
        $top    = ($row -ge 1) ? @($col, ($row - 1)) : $null
        $bot    = ($row + 1 -lt $this._rows) ? @($col, ($row + 1)) : $null
        return ($left, $top, $right, $bot) -ne $null
    }

    [void] ValidateCoor([int] $col, [int] $row) {
        if ( $col -lt 0 -or $col -ge $this._cols -or $row -lt 0 -or $row -ge $this._rows) {
            Throw "Invalid coordinate"
        }
    }

    [object] Territories() {
        <#
        Find the owners and the territories of the whole board
        #>
        $result = [PSCustomObject]@{
            [Owner]::NONE  = [System.Collections.Generic.HashSet[object]]::new()
            [Owner]::WHITE = [System.Collections.Generic.HashSet[object]]::new()
            [Owner]::BLACK = [System.Collections.Generic.HashSet[object]]::new()
        }

        $visited = [System.Collections.Generic.HashSet[string]]::new()

        for ($row = 0; $row -lt $this._rows; $row++) {
            for ($col = 0; $col -lt $this._cols; $col++) {
                if (-not $visited.Contains("$col$row")) {
                    $current = $this.Territory(($col, $row))
                    foreach ($coor in $current.Coordinates) {
                        $result.$($current.Owner).Add($coor)
                        $visited.Add(-join $coor)
                    }
                }
            }
        }
        return $result
    }
}