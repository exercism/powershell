Function Invoke-FlattenArray() {
    <#
    .SYNOPSIS
    Given an array, flatten it and keep all values execept null.

    .DESCRIPTION
    Take a nested array and return a single flattened array with all values except null.

    .PARAMETER Array
    The nested array to be flatten.

    .EXAMPLE
    Invoke-FlattenArray -Array @(1, @(2, 3, $null, 4), @($null), 5)
    Return: @(1, 2, 3, 4, 5)
    #>
    [CmdletBinding()]
    Param(
        [System.Object[]]$Array
    )

    $Array | ForEach-Object {
        if ($_ -is [Array]) {
            Invoke-FlattenArray $_
        } elseif ($null -ne $_) {
            $_
        } 
    }
}