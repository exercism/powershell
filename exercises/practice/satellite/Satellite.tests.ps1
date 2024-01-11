BeforeAll {
    . "./Satellite.ps1"
}

Describe "Satellite test cases" {
    Context "Valid tree traversals" {
        It "Empty tree" {
            $preoder = @()
            $inorder = @()
            $got  = Get-TreeFromTraversals -Preorder $preoder -Inorder $inorder
            $want = [Node]::new()
    
            $got | Should -BeExactly $want
        }
    
        It "Tree with one item" {
            $preoder = @("a")
            $inorder = @("a")
            $got = Get-TreeFromTraversals -Preorder $preoder -Inorder $inorder
            $want = [Node]::new("a")
    
            $got | Should -BeExactly $want
        }
    
        It "Tree with many items" {
            $preoder = @("a", "i", "x", "f", "r")
            $inorder = @("i", "a", "f", "x", "r")
            $got = Get-TreeFromTraversals -Preorder $preoder -Inorder $inorder
            $want = [Node]::new(
                        "a",
                        [Node]::new("i"),
                        [Node]::new(
                            "x",
                            [Node]::new("f"),    
                            [Node]::new("r")
                        )
            )
    
            $got | Should -BeExactly $want
        }
    }

    Context "Invalid tree traversals" {
        It "Reject traversals of different length" {
            $preoder = @("a", "b")
            $inorder = @("b", "a", "r")

            {Get-TreeFromTraversals -Preorder $preoder -Inorder $inorder} | Should -Throw "*Traversals must have the same length*"
        }
    
        It "Reject inconsistent traversals of same length" {
            $preoder = @("x", "y", "z")
            $inorder = @("a", "b", "c")

            {Get-TreeFromTraversals -Preorder $preoder -Inorder $inorder} | Should -Throw "*Traversals must have the same elements*"
        }
    
        It "Reject traversals with repeated items" {
            $preoder = @("a", "b", "a")
            $inorder = @("b", "a", "a")

            {Get-TreeFromTraversals -Preorder $preoder -Inorder $inorder} | Should -Throw "*Traversals must contain unique items*"
        }
    }
}
