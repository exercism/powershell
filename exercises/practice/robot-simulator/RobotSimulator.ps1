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

    Robot() {
        Throw "Please implement this class"
    }

    Move([string]$Instruction) {
        Throw "Please implement this function"
    }

    GetPosition() {
        Throw "Please implement this function"
    }
}