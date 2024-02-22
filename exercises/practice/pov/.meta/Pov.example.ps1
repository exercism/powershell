<#
.SYNOPSIS
    Given a tree, reorientate it based on a selected node.

.DESCRIPTION
    A tree is a special type of graph where all nodes are connected but there are no cycles.
    That means, there is exactly one path to get from one node to another for any pair of nodes.

    Implement a class to represent the Tree along with these methods:
    - FromPov: accept a value of a node, return a new Tree object orientated based on that node.
        Throw error if the value/node does't exist in the tree.
    - Path: accept the source and destination values of two nodes, return an array of string represent the path from source to destination.
        Throw error if the path doesn't exist.
    - Equals: equality method to compare trees for the test suite.

.EXAMPLE
    Read instructions for visual example.
#>

Class Tree {
    [string] $Value
    [Tree[]] $Children
    [hashtable] hidden $Graph = @{}

    Tree([string] $value) {
        $this.Value = $value
        $this.Children = @()
    }

    Tree([string] $value, [Tree[]] $Children) {
        $this.Value = $value
        $this.Children = $Children
    }

    [void] hidden CreateGraph($tree, $parent) {
        <#
        .DESCRIPTION
        Helper function, creating a hashtable representing the graph for the original tree.
        #>
        $this.Graph[$tree.Value] = @{
            Parent = $parent
            Children = @($tree.Children | ForEach-Object {$_.Value})
        }
        foreach ($child in $tree.Children) {
            $this.CreateGraph($child, $tree.Value)
        }
    }

    [void] hidden PovGraph([string]$root) {
        <#
        .DESCRIPTION
        Helper function, representing the graph for the tree with a new root.
        #>
        if ($this.Graph.Count -eq 0) {$this.CreateGraph($this, $null)}
        if (-not $this.Graph.ContainsKey($root)) {Throw "Tree could not be reoriented"}
        if ($null -eq $this.Graph[$root].Parent) {return}

        $curParent = $this.Graph[$root].Parent
        $this.Graph[$root].Parent = $null
        $this.Graph[$root].Children += @($curParent)
        
        while ($null -ne $curParent) {
            $tempParent = $this.Graph[$curParent].Parent
            $this.Graph[$curParent].Parent = $root
            $this.Graph[$curParent].Children = ($this.Graph[$curParent].Children -ne $root) + ($null -eq $tempParent ? @() : @($tempParent) )
            $root = $curParent
            $curParent = $tempParent
        }
    }

    [Tree] FromPov([string] $node) {
        if ($this.Graph.Count -eq 0) {$this.PovGraph($node)}
        
        return [Tree]::new(
            $node, 
            @( $this.Graph[$node].Children | ForEach-Object {$this.FromPov($_)})
        )
    }

    [string[]] Path([string] $from, [string] $to) {
        if ($this.Graph.Count -eq 0) {$this.CreateGraph($this, $null)}
        if (-not $this.Graph.ContainsKey($from) -or -not $this.Graph.ContainsKey($to)) {
            Throw "No path found"
        }
        $this.PovGraph($from)
        $path = @()
        $parent = $to
        while ($parent) {
            $path+= $parent
            $parent = $this.Graph[$parent].Parent
        }
        [array]::Reverse($path)
        return $path
    }

    [bool] Equals($other) {
        if($this.Value -ne $other.Value) {
            return $false
        }

        if($this.Children.Count -ne $other.Children.Count) {
            return $false
        }

        $sortedOwnChildren = $this.Children | Sort-Object { $_.Value }
        $sortedTheirChildren = $other.Children | Sort-Object { $_.Value }
    
        for ($i = 0; $i -lt $sortedOwnChildren.Count; $i++) {
            if ($sortedOwnChildren[$i] -ne $sortedTheirChildren[$i]) {
                return $false
            }
        }
        return $true
    }
}