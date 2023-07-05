Function Invoke-BinarySearch() {
    <#
    .SYNOPSIS
    Perform a binary search on a sorted array.

    .DESCRIPTION
    Take an array of integers and a search value and return the index of the value in the array.

    .PARAMETER Array
    The array to search.

    .PARAMETER Value
    The value to search for.

    .EXAMPLE
    Invoke-BinarySearch -Array @(1, 2, 3, 4, 5) -Value 3
    #>
    [CmdletBinding()]
    Param(
        [Int64[]]$Array,
        [Int64]$Value
    )
    $min = 0
    $max = $Array.Length - 1
    while ($min -le $max) {
        $mid = [Math]::Floor(($min + $max) / 2)
        if ($Array[$mid] -eq $Value) {
            return $mid
        } elseif ($Array[$mid] -lt $Value) {
            $min = $mid + 1
        } else {
            $max = $mid - 1
        }
    }
    throw "error: value not in array"
}
