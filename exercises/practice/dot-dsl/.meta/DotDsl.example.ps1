<#
.SYNOPSIS
    Write a Domain Specific Language similar to the Graphviz dot language.

.DESCRIPTION
    Implement the classes to stimulate a DSL similar to the Graphviz dot language.

    Node class : represent the nodes inside the graph.
    Edge class : represent the relationship between two nodes.
    Attr class : represent the attributes of other objects (node, edge or graph).
    Graph class: represent the graph, contains info about nodes, edges and attributes.

    Node, Edge and Attr should have the 'Equals' method implemented for the purpose of comparison in the test suite.
#>

Class Node {
    [string] $Name
    [Attr] $Attrs

    Node([string] $name){
        $this.Name = $name
        $this.Attrs = [Attr]::new()
    }

    Node([string] $name, [hashtable] $attrs){
        $this.Name = $name
        $this.Attrs = [Attr]::new($attrs)
    }

    [bool] Equals([object] $other) {
        return $this.Name -eq $other.Name -and $this.Attrs -eq $other.Attrs
    }
}

Class Edge {
    [string] $Source
    [string] $Target
    [Attr] $Attrs

    Edge([string] $from, [string] $to){
        $this.Source = $from
        $this.Target = $to
        $this.Attrs  = [Attr]::new()
    }

    Edge([string] $from, [string] $to, [hashtable] $attr){
        $this.Source = $from
        $this.Target = $to
        $this.Attrs  = [Attr]::new($attr)
    }

    [bool] Equals([object] $other) {
        return $this.Source -eq $other.Source 
        -and $this.Target -eq $other.Target 
        -and $this.Attrs -eq $other.Attrs
    }
}

Class Attr {
    [hashtable] hidden $Data

    Attr() {
        $this.Data = @{}
    }

    Attr([hashtable] $attr){
        $this.Data = @{}
        $this.Data += $attr
    }

    [bool] Equals( $other) {
        $equalsKey = Compare-Object $this.Data.Keys $other.Data.Keys
        $equalsVal = Compare-Object $this.Data.Values $other.Data.Values
        return -not ($equalsKey -or $equalsVal)
    }
}

Class Graph {
    [Node[]] $Nodes
    [Edge[]] $Edges
    [Attr[]] $Attrs

    Graph(){
        $this.Nodes = @()
        $this.Edges = @()
        $this.Attrs = @()
    }

    Graph([object[]] $Data){
        switch ($Data) {
            {$_ -is [Node]} { $this.Nodes += $_ }
            {$_ -is [Edge]} { $this.Edges += $_ }
            {$_ -is [Attr]} { $this.Attrs += $_ }
            Default { Throw "Graph can only contain node, egde or attribute"}
        }
    }
}