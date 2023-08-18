Function Get-PascalsTriangleRows() {
    <#
    .SYNOPSIS
    Returns the first n rows of Pascal's triangle.
    
    .DESCRIPTION
    Given a count, returns the first n rows of Pascal's triangle.
    
    .PARAMETER Count
    The number of rows to return.
    
    .EXAMPLE
    Get-PascalsTriangleRows -Count 1
    
    Returns: @(
        @(1)
    )
    #>
    [CmdletBinding()]
    Param(
        [string]$Count
    )

    $rows = @()

    for ($i = 0; $i -lt $Count; $i++) {
        $row = @()

        for ($j = 0; $j -le $i; $j++) {
            if ($j -eq 0 -or $j -eq $i) {
                $row += 1
            } else {
                $row += $rows[$i - 1][$j - 1] + $rows[$i - 1][$j]
            }
        }

        $rows += ,$row
    }

    return $rows
}
