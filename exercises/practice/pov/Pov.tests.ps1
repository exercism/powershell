BeforeAll {
    . "./Pov.ps1"
}

Describe "Pov test cases" {
    Context "Reroot a tree so that its root is the specified node." {
        It "Results in the same tree if the input tree is a singleton" {
            $tree = [Tree]::new("x")
            $got  = $tree.FromPov("x")
            $want = [Tree]::new("x")

            $got | Should -BeExactly $want
        }
    
        It "Can reroot a tree with a parent and one sibling" {
            $tree = [Tree]::new("parent", 
                @([Tree]::new("x"), [Tree]::new("sibling"))
            )
            $got  = $tree.FromPov("x")
            $want = [Tree]::new("x", 
                @([Tree]::new("parent", @([Tree]::new("sibling"))))
            )

            $got | Should -BeExactly $want
        }
    
        It "Can reroot a tree with a parent and many siblings" {
            $tree = [Tree]::new("parent", 
                @([Tree]::new("a"), [Tree]::new("x"), [Tree]::new("b"), [Tree]::new("c"))
            )
            $got  = $tree.FromPov("x")
            $want = [Tree]::new("x", 
                @([Tree]::new("parent", @([Tree]::new("a"), [Tree]::new("b"), [Tree]::new("c"))))
            )

            $got | Should -BeExactly $want
        }
    
        It "Can reroot a tree with new root deeply nested in tree" {
            $tree = [Tree]::new("level-0", 
                @([Tree]::new("level-1", @([Tree]::new("level-2", @([Tree]::new("level-3", @([Tree]::new("x"))))))))
            )
            $got  = $tree.FromPov("x")
            $want = [Tree]::new("x", 
            @([Tree]::new("level-3", @([Tree]::new("level-2", @([Tree]::new("level-1", @([Tree]::new("level-0"))))))))
        )

            $got | Should -BeExactly $want
        }
    
        It "Moves children of the new root to same level as former parent" {
            $tree = [Tree]::new("parent", 
                @([Tree]::new("x", @([Tree]::new("kid-0"), [Tree]::new("kid-1"))))
            )
            $got  = $tree.FromPov("x")
            $want = [Tree]::new("x", 
                @([Tree]::new("kid-0"), [Tree]::new("kid-1"), [Tree]::new("parent"))
            )

            $got | Should -BeExactly $want
        }
    
        It "Can reroot a complex tree with cousins" {
            $tree = [Tree]::new("grandparent",
                @(
                    [Tree]::new("parent",
                        @(
                            [Tree]::new("x", @([Tree]::new("kid-0"), [Tree]::new("kid-1")))
                            [Tree]::new("sibling-0")
                            [Tree]::new("sibling-1")
                        )
                    ),
                    [Tree]::new("uncle", @([Tree]::new("cousin-0"), [Tree]::new("cousin-1")))
                )
            )

            $got  = $tree.FromPov("x")
            $want = [Tree]::new("x",
                @(
                    [Tree]::new("kid-0"),
                    [Tree]::new("kid-1"),
                    [Tree]::new("parent",
                        @(
                            [Tree]::new("sibling-0"),
                            [Tree]::new("sibling-1"),
                            [Tree]::new("grandparent", 
                                @([Tree]::new("uncle", @([Tree]::new("cousin-0"), [Tree]::new("cousin-1"))))
                            )
                        )
                    )
                )
            )

            $got | Should -BeExactly $want
        }

        # Additional test
        It "Can reroot a rerooted tree back to the original tree" {
            $tree = [Tree]::new("0",
                @(
                    [Tree]::new("1", @([Tree]::new("4"), [Tree]::new("5")))
                    [Tree]::new("2", @([Tree]::new("6"), [Tree]::new("7")))
                    [Tree]::new("3", @([Tree]::new("8"), [Tree]::new("9")))
                )
            )

            $reroot1  = $tree.FromPov("6")
            $reroot2  = $reroot1.FromPov("0")

            $tree | Should -BeExactly $reroot2
        }
    }

    Context "Given two nodes, find the path between them" {
        It "Can find path to parent" {
            $tree = $tree = [Tree]::new("parent", 
                @([Tree]::new("x"), [Tree]::new("sibling"))
            )
            $got  = $tree.Path("x", "parent")
            $want = @("x", "parent")

            $got | Should -BeExactly $want
        }
    
        It "Can find path to sibling" {
            $tree = $tree = [Tree]::new("parent", 
                @([Tree]::new("a"), [Tree]::new("x"), [Tree]::new("b"), [Tree]::new("c"))
            )
            $got  = $tree.Path("x", "b")
            $want = @("x", "parent", "b")

            $got | Should -BeExactly $want
        }
    
        It "Can find path to cousin" {
            $tree = [Tree]::new("grandparent",
                @(
                    [Tree]::new("parent",
                        @(
                            [Tree]::new("x", @([Tree]::new("kid-0"), [Tree]::new("kid-1")))
                            [Tree]::new("sibling-0")
                            [Tree]::new("sibling-1")
                        )
                    ),
                    [Tree]::new("uncle", @([Tree]::new("cousin-0"), [Tree]::new("cousin-1")))
                )
            )

            $got  = $tree.Path("x", "cousin-1")
            $want = @("x", "parent", "grandparent", "uncle", "cousin-1")

            $got | Should -BeExactly $want
        }
    
        It "Can find path not involving root" {
            $tree = [Tree]::new("grandparent", 
                @([Tree]::new("parent", @([Tree]::new("x"), [Tree]::new("sibling-0"), [Tree]::new("sibling-1"))))
            )
            $got  = $tree.Path("x", "sibling-1")
            $want = @("x", "parent", "sibling-1")

            $got | Should -BeExactly $want
        }
    
        It "Can find path from nodes other than x" {
            $tree = [Tree]::new("parent", 
                @([Tree]::new("a"), [Tree]::new("x"), [Tree]::new("b"), [Tree]::new("c"))
            )
            $got  = $tree.Path("a", "c")
            $want = @("a", "parent", "c")

            $got | Should -BeExactly $want
        }
    }

    Context "invalid input" {
        It "Errors if target does not exist in a singleton tree" {
            $tree = [Tree]::new("x")
            {$tree.FromPov("nonexistent")} | Should -Throw "*Tree could not be reoriented*"
        }

        BeforeEach {
            $tree = [Tree]::new("parent",
                @(  
                    [Tree]::new("x", @([Tree]::new("kid-0"), [Tree]::new("kid-1"))),
                    [Tree]::new("sibling-0"),
                    [Tree]::new("sibling-1")
                )
            )
        }

        It "Errors if target does not exist in a large tree" {
            {$tree.FromPov("nonexistent")} | Should -Throw "*Tree could not be reoriented*"
        }

        It "Errors if destination does not exist" {
            {$tree.Path("x", "nonexistent")} | Should -Throw "*No path found*"
        }
    
        It "Errors if source does not exist" {
            {$tree.Path("nonexistent", "x")} | Should -Throw "*No path found*"
        }
    }
}
