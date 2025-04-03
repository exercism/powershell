using namespace System.Collections.Generic

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
    
    $graph = @{}
    foreach ($parent in $FamilyTree.GetEnumerator()) {
        $graph[$parent.Key] = $graph[$parent.Key] ?? [HashSet[string]]::new()
        foreach ($child in $parent.Value) {
            [void]$graph[$parent.Key].Add($child)
            $graph[$child] = $graph[$child] ?? [HashSet[string]]::new()
            [void]$graph[$child].Add($parent.Key)
        }
        
        $children = $parent.Value
        for ($i = 0; $i -lt $children.Count; $i++) {
            for ($j = $i + 1; $j -lt $children.Count; $j++) {
                [void]$graph[$children[$i]].Add($children[$j])
                [void]$graph[$children[$j]].Add($children[$i])
            }
        }
    }
    Get-RelativeDistance $graph $PersonA $PersonB
}

function Get-RelativeDistance($Graph, $From, $To) {
    $visited = [HashSet[string]]::new()
    $queue = [Queue[object]]::new()
    $queue.Enqueue([PSCustomObject]@{Name = $From;Dist = 0})

    while ($queue.Count -gt 0) {
        $item = $queue.Dequeue()
        [void]$visited.Add($item.Name)
        if ($item.Name -eq $To) {
            return $item.Dist
        }
        foreach ($relation in $graph[$item.Name]) {
            if (-not $visited.Contains($relation))  {
                $queue.Enqueue([PSCustomObject]@{Name = $relation; Dist = $item.Dist + 1})
            }
        }
    }
}
