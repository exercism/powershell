Function Get-MaximumValue() {
    <#
    .SYNOPSIS
    Implement a function to solve the classic knapsack problem.

    .DESCRIPTION
    Given a knapsack with a specific carrying capacity (W), determine the maximum value we can get from the list of items.
    Note that each item can only be taken once.

    All values given will be strictly positive.

    .PARAMETER MaxWeight
    An integer represent the maximum weight to be carried.

    .PARAMETER Items
    An array of object represent the items, each object will have a Weight and a Value property.

    .EXAMPLE
    $items = @(
        [PSCustomObject]@{Weight = 1; Value = 3}
        [PSCustomObject]@{Weight = 2; Value = 5}
        [PSCustomObject]@{Weight = 3; Value = 7}
        [PSCustomObject]@{Weight = 4; Value = 8}
    )

    Get-MaximumValue -MaxWeight 5 -Items $items
    Returns: 12
    #>
    [CmdletBinding()]
    Param(
        [int]$MaxWeight,
        [object[]]$Items
    )
    Throw "Please implement this function"
}