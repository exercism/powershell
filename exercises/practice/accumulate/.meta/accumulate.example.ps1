Function Get-Accumulation() {
    <#
    .SYNOPSIS
    Accumulate a list of numbers based on the operation given.

    .DESCRIPTION
    Given the collection of numbers:

    - 1, 2, 3, 4, 5

    And the operation:

    - square a number `$x = $x * $x`

    Your code should be able to produce the collection of squares:

    - 1, 4, 9, 16, 25

    Check out the test suite to see the expected function signature.

    .PARAMETER List
    Collection of numbers to perform an operation on.

    .PARAMETER Func
    A scriptblock containing the operation to perform on the given $List

    .EXAMPLE
    Get-Accumulation -List 1,2,3,4,5 -Func { <some code here> }
    #>
    [CmdletBinding()]
    Param(
        [PSObject[]]$List,
        [scriptblock]$Func
    )


    Invoke-Command -Scriptblock $Func -ArgumentList @(,$List)
}
