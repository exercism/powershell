<#
.SYNOPSIS
    Refactor a tree building algorithm.

.DESCRIPTION
    The code below are ugly, confusing and slow.
    Not to mention it also failed all the test that need to raise error.
    Feel free to rework it however you want to pass the test suite.
#>

# this stub is adapted from the python track
Class Record {
    $RecordId
    $ParentId

    Record($RecordId, $parentId) {
        $this.RecordId = $RecordId
        $this.ParentId = $parentId
    }
}

Class Node {
    [int] $NodeID
    [Node[]] $Children

    Node($id) {
        $this.NodeID     = $id
        $this.Children   = @()
    }

    [bool] IsLeaf() {
        if ($this.HasChildren()) {
            return $false
        }else {
            return $true
        }
    }

    [bool] HasChildren() {
        if ($this.Children.Count -gt 0) {
            return $true
        }else {
            return $false
        }
    }
}

Function Build-Tree() {
    <#
    .DESCRIPTION
    Building tree function

    .PARAMETER Records
    Records used to build tree
    #>
    [CmdletBinding()]
    Param(
        [Record[]] $Records
    )
    $root = $null

    $sortedRecords = $Records | Sort-Object RecordId

    $ordered_id = foreach ($r in $sortedRecords) {
        $r.RecordId
    }

    $trees = @()
    $parent = @{}

    foreach ($i in 0..($ordered_id.Count - 1)) {
        foreach ($j in $sortedRecords) {
            if ($ordered_id[$i] -eq $j.RecordId) {
                $trees += [Node]::new($ordered_id[$i])
            }
        }
    }

    foreach ($i in 0..($ordered_id.Length - 1)) {
        foreach ($j in $trees) {
            if ($i -eq $j.NodeID) {
                $parent = $j
            }
        }
        foreach ($j in $sortedRecords) {
            if ($j.ParentId -eq $i) {
                foreach ($k in $trees) {
                    if ($k.NodeID -eq 0) {
                        continue
                    }
                    if ($j.RecordId -eq $k.NodeID) {
                        $child = $k
                        $parent.Children += $child
                    }
                }
            }
        }
    }

    if ($trees.Count -gt 0) {
        $root = $trees[0]
    }
    return $root
}