Class Record {
    $RecordId
    $ParentId

    Record($RecordId, $parentId) {
        $this.RecordId = $RecordId
        $this.ParentId = $parentId
    }

    [void] Validate($upperBound){
        if ($this.RecordId -ge $upperBound) {
            Throw "Record id is invalid or out of order."
        }
        if ($this.RecordId -eq $this.ParentId -and $this.RecordId -ne 0) {
            Throw "Only root should have equal record and parent id (0)."
        }
        if ($this.RecordId -lt $this.ParentId) {
            Throw "Node record ID should be greater than parent id."
        }
    }
}

Class Node {
    [int] $NodeID
    [int] $ParentID
    [Node[]] $Children

    Node([Record] $record) {
        $this.NodeID     = $record.RecordId
        $this.ParentID   = $record.ParentId
        $this.Children   = @()
    }

    [bool] IsLeaf() {
        return $this.Children.Count -eq 0
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
    $upperBound = $Records.Count

    $Records 
    | Sort-Object RecordId 
    | ForEach-Object {$nodes = @{}} {
        $_.Validate($upperBound)
        $nodes[$_.RecordId] = [Node]::new($_)
    }

    foreach ($id in $nodes.Keys) {
        if ($id -ne 0) {
            $parent = $nodes[$id].ParentId
            $nodes[$parent].Children = @($nodes[$id]) + $nodes[$parent].Children
        }
    }
    $nodes[0]
}