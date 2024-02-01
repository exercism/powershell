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
    if (-not $Items.Count) {return 0}
    $table = 0..$Items.Count | ForEach-Object { ,(@(0) * ($MaxWeight + 1)) }

    for ($i = 0; $i -le $Items.Count; $i++) {
        for ($j = 0; $j -le $MaxWeight; $j++) {
            if ($Items[$i].Weight -le $j) {
                $table[$i][$j] = [math]::Max($table[$i-1][$j], $table[$i-1][$j-$Items[$i].Weight] + $Items[$i].Value)
            }else{
                $table[$i][$j] = $table[$i-1][$j]
            }
        }
    }
    $table[$Items.Count - 1][$MaxWeight]
}