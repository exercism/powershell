Enum Sublist {
    EQUAL
    UNEQUAL
    SUBLIST
    SUPERLIST
}
Function Invoke-Sublist() {
    <#
    .SYNOPSIS
    Determine the relationship of two arrays.

    .DESCRIPTION
    Given two arrays, determine the relationship of the first array relating to the second array.
    There are four possible categories: EQUAL, UNEQUAL, SUBLIST and SUPERLIST.
    Note: This exercise use Enum values for return.
    
    .PARAMETER Data1
    The first array

    .PARAMETER Data2
    The second array

    .EXAMPLE
    Invoke-Sublist -Data1 @(1,2,3) -Data2 @(1,2,3)
    Return: [Sublist]::EQUAL

    Invoke-Sublist -Data1 @(1,2) -Data2 @(1,2,3)
    Return: [Sublist]::SUBLIST
    #>
    [CmdletBinding()]
    Param (
        [object[]]$Data1,
        [object[]]$Data2
    )
    if ($Data1.Count -eq $Data2.Count -and (Test-Equal $Data1 $Data2)) {
        return [Sublist]::EQUAL
    }elseif ($Data1.Count -eq 0 -or (Test-SubList $Data1 $Data2)) {
        return [Sublist]::SUBLIST
    }elseif ($Data2.Count -eq 0 -or (Test-SubList $Data2 $Data1)) {
        return [Sublist]::SUPERLIST
    }
    return [Sublist]::UNEQUAL
}

Function Test-Equal($ar1, $ar2) {
    return (-join $ar1) -eq (-join $ar2)
}

Function Test-SubList($ar1, $ar2) {
    if ($ar1.Count -ge $ar2.Count) {
        return $false
    }
    for ($i = 0; $i -lt ($ar2.Count + 1 - $ar1.Count) ; $i++) {
        if (Test-Equal $ar1 $ar2[$i..($i+$ar1.Count-1)]) {
            return $true
        }
    }
    return $false
}