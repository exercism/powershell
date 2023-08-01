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
    
    Retuns: @(
        @(1)
    )
    #>
    [CmdletBinding()]
    Param(
        [string]$Count
    )

    Throw "Please implement this function"
}
