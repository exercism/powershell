BeforeAll {
    . "./DotDsl.ps1"
}

Describe "DotDsl test cases" {
    It "empty graph" {
        $graph = [Graph]::new()
        
        $graph.Nodes | Should -BeNullOrEmpty
        $graph.Edges | Should -BeNullOrEmpty
        $graph.Attrs | Should -BeNullOrEmpty
    }

    It "graph with one node" {
        $graph = [Graph]::new( 
            @(
                [Node]::new("a")   
            )
        )

        $graph.Nodes | Should -BeExactly @([Node]::new("a"))
        $graph.Edges | Should -BeNullOrEmpty
        $graph.Attrs | Should -BeNullOrEmpty
    }

    It "graph with one node with keywords" {
        $graph = [Graph]::new( 
            @(
                [Node]::new("a", @{Color = "green"})   
            )
        )
        
        $graph.Nodes | Should -BeExactly @([Node]::new("a", @{Color = "green"}))
        $graph.Edges | Should -BeNullOrEmpty
        $graph.Attrs | Should -BeNullOrEmpty
    }

    It "graph with one edge" {
        $graph = [Graph]::new( 
            @(
                [Edge]::new("a", "b")   
            )
        )
        
        $graph.Nodes | Should -BeNullOrEmpty
        $graph.Edges | Should -BeExactly @([Edge]::new("a", "b"))
        $graph.Attrs | Should -BeNullOrEmpty
    }

    It "graph with one edge with attribute" {
        $graph = [Graph]::new( 
            @(
                [Edge]::new("a", "b", @{Style = "dotted"})   
            )
        )
        
        $graph.Nodes | Should -BeNullOrEmpty
        $graph.Edges | Should -BeExactly @([Edge]::new("a", "b", @{Style = "dotted"}))
        $graph.Attrs | Should -BeNullOrEmpty
    }

    It "graph with one attribute" {
        $graph = [Graph]::new( 
            @(
                [Attr]::new(@{Title = "mygraph"})   
            )
        )
        
        $graph.Nodes | Should -BeNullOrEmpty
        $graph.Edges | Should -BeNullOrEmpty
        $graph.Attrs | Should -BeExactly @([Attr]::new(@{Title = "mygraph"}))
    }

    It "graph with attributes" {
        $graph = [Graph]::new( 
            @(
                [Attr]::new(@{Title = "mygraph"}),
                [Attr]::new(@{Author = "exercism"}),
                [Node]::new("a", @{Color = "green"}),
                [Node]::new("c"),
                [Node]::new("b", @{Label = "beta"}),
                [Edge]::new("b", "c"),
                [Edge]::new("a", "b", @{Style = "solid"; Color = "yellow"}),
                [Attr]::new(@{Version = 1.0})
            )
        )
        
        $nodes = @(
                [Node]::new("a", @{Color = "green"}), 
                [Node]::new("c"), 
                [Node]::new("b", @{Label = "beta"})
            )
        $edges = @(
                [Edge]::new("b", "c"), 
                [Edge]::new("a", "b", @{Style = "solid"; Color = "yellow"})
            )
        $attrs = @(
                [Attr]::new(@{Title = "mygraph"}), 
                [Attr]::new(@{Author = "exercism"}), 
                [Attr]::new(@{Version = 1.0})
            )
        
        $graph.Nodes | Should -BeExactly $nodes
        $graph.Edges | Should -BeExactly $edges
        $graph.Attrs | Should -BeExactly $attrs
    }

    It "unknown item in graph throw error" {
        {[Graph]::new("hello")} | Should -Throw "*Graph can only contain node, egde or attribute*"
    }
}
