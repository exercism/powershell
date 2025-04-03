Function Invoke-RelativeDistance() {
    <#
    .SYNOPSIS
    Determine the degree of separation between two individuals in a family tree

    .DESCRIPTION
    Given a family tree with all unique names, find the shortest number of connections from one person to another.

    .PARAMETER FamilyTree
    A PSObject represent the family tree.

    .PARAMETER PersonA
    Name of the first person.

    .PARAMETER PersonB
    Name of the second person.

    .EXAMPLE
    $tree = @{
        "Dalia" = @("Olga", "Yassin")
    }
    
    Invoke-RelativeDistance -FamilyTree $tree -PersonA "Olga" -PersonB "Yassin"
    Returns: 1
    #>
    [CmdletBinding()]
    Param(
        [object]$FamilyTree,
        [string]$PersonA,
        [string]$PersonB
    )
    
    Throw "Please implement this function"
}
