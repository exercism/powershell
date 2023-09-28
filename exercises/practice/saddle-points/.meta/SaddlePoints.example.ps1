<#
.DESCRIPTION
    A helper class act as a data structure for the saddle point.
    It has a two properties: Row and Column, their indexes should be offset by 1 to reflect normal counting.
    It also has an Equals method for comparison in tests.
    Please don't delete or change this class.
#>
Class SaddlePoint {
    [int]$Row
    [int]$Column

    SaddlePoint($row, $col) {
        $this.Row = $row
        $this.Column = $col
    }

    [bool] Equals($other) {
        return $this.Row -eq $other.Row -and $this.Column -eq $other.Column
    }
}

Function Get-SaddlePoints() {
    <#
    .SYNOPSIS
    Find all the available saddle points in a given matrix.

    .DESCRIPTION
    Given a matrix (jagged arrays), return all the available saddle points found.
    The matrix can have a different number of rows and columns (non square), and it may have zero or more saddle points.

    It's called a "saddle point" because it is greater than or equal to every element in its row and less than or equal to every element in its column.

    Your code should be able to provide the (possibly empty) list of all the saddle points for any given matrix.

    .PARAMETER Matrix
    An array of arrays, each inner array contains number that could be a saddle point.

    .EXAMPLE
    Get-SaddlePoints -Matrix @( ,@(1, 2, 3))
    Returns: [SaddlePoint]::new(1, 3)
    #>
    [CmdletBinding()]
    Param(
        [int[][]]$Matrix
    )
    #check for valid matrix
    $lenCount = ($Matrix | Select-Object {$_.Count} -Unique).Count
    if ($lenCount -gt 1) { Throw "Irregular matrix"}

    #got total rows and column
    $rows = $Matrix.Count
    $columns = $Matrix[0].Count

    $maxValues, $minValues = Get-MaxMinValues $Matrix $rows $columns

    #saddle found when max of row is the same as min of column
    $saddlePoints = @()
    for ($row = 0; $row -lt $rows; $row++) {
        for ($col = 0; $col -lt $columns; $col++) {
            $value =  $Matrix[$row][$col]
            if ($maxValues[$row] -eq $value -and $minValues[$col] -eq $value) {
                $saddlePoints += [SaddlePoint]::new($row+1, $col+1)
            }
            
        }
    }
    $saddlePoints
}

function Get-MaxMinValues($matrix, $rows, $columns) {
    <#
    .DESCRIPTION
    Helper function to find max value for each row and min value for each col
    #>
    $maxValues = @([int]::MinValue) * $rows  
    $minValues = @([int]::MaxValue) * $columns

    for ($row = 0; $row -lt $rows; $row++) {
        for ($col = 0; $col -lt $columns; $col++) {
            $value =  $Matrix[$row][$col]
            if ($value -ge $maxValues[$row]) {
                $maxValues[$row] = $value
            }

            if ($value -le $minValues[$col]) {
                $minValues[$col] = $value
            }
        }
    }
    $maxValues, $minValues
}