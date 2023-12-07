<#
.SYNOPSIS
    Write a robot simulator that take in instructions of how to move.
    
.DESCRIPTION
    A robot factory's test facility needs a program to verify robot movements.
    The robots have three possible movements:
    - turn right
    - turn left
    - advance

    Robots are placed on a hypothetical infinite grid, facing a particular direction (north, east, south, or west) at a set of {x,y} coordinates,
    e.g., {3,8}, with coordinates increasing to the north and east.

    A robot instance without any input should be at the default location : facing North at (0, 0)
    
.EXAMPLE
    $robot = [Robot]::new('NORTH', 7, 3)
    $robot.Move("RAALAL")

    $robot.Direction
    Returns: WEST

    $robot.GetPosition()
    Returns: @(9, 4)
#>

Enum Direction {
    NORTH
    EAST
    SOUTH
    WEST
}

Class Robot {
    [Direction]$Direction
    hidden [int]$_x
    hidden [int]$_y

    Robot() {
        $this.Direction = [Direction]::NORTH
        $this._x = 0
        $this._y = 0
    }

    Robot($Dir, $X, $Y) {
        $this.InputValidator($Dir, $X, $Y)
        $this.Direction = $Dir
        $this._x = $X
        $this._y = $Y
    }

    [void] Move([string]$Instruction) {
        $moves = $Instruction.ToCharArray()
        switch -Regex ($moves) {
            'R' {$this.Direction = ($this.Direction + 1) % 4}
            'L' {$this.Direction = ($this.Direction + 3) % 4}
            'A' {$this.Advance()}
            Default {Throw "Error: Invalid instruction"}
        }
    }

    [void] hidden Advance() {
        switch ($this.Direction) {
            'NORTH' { $this._y++ }
            'EAST'  { $this._x++ }
            'SOUTH' { $this._y-- }
            'WEST'  { $this._x-- }
        }
    }

    [void] hidden InputValidator($Dir, $X, $Y) {
        if (-not [Enum]::IsDefined([Direction], $Dir)) {
            Throw "Error: Invalid direction"
        }

        if ($x -isnot [int]) {
            Throw "Error: Invalid X position"
        }

        if ($y -isnot [int]) {
            Throw "Error: Invalid Y position"
        }
    }

    [int[]] GetPosition() {
        return @($this._x, $this._y)
    }
}