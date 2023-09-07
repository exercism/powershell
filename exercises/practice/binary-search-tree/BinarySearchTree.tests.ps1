BeforeAll {
    . "./BinarySearchTree.ps1"

    #Utility function to compare nodes
    Function NodeComparison {
        param (
            [TreeNode]$Node1,
            [TreeNode]$Node2
        )
        if (-not $Node1 -and -not $Node2) {
            return $true
        }
    
        if (-not $Node1 -or -not $Node2) {
            return $false
        }
        $dataEqual  = $Node1.data -eq $Node2.data
        $leftEqual  = NodeComparison $Node1.left $Node2.left
        $rightEqual = NodeComparison $Node1.right $Node2.right
        return $dataEqual -and $leftEqual -and $rightEqual
    }
}

Describe "BinarySearchTree test cases" {
    Context "Treenode creation" {
        It "create a simple treenode without children" {
            $node = [TreeNode]::new(5)
    
            $node.data  | Should -BeExactly 5
            $node.left  | Should -BeNullOrEmpty
            $node.right | Should -BeNullOrEmpty
        }
    
        It "create a parent node with one child" {
            $rightchild = [TreeNode]::new(5)
            $node = [TreeNode]::new(3, $null, $rightchild)
    
            $node.data  | Should -BeExactly 3
            $node.left  | Should -BeNullOrEmpty
            {NodeComparison $node.right  $rightchild} | Should -BeTrue
        }
    
        It "create a parent node with both children" {
            $leftchild  = [TreeNode]::new(5)
            $rightchild = [TreeNode]::new(15)
            $node = [TreeNode]::new(10, $leftchild, $rightchild)
    
            $node.data  | Should -BeExactly 10
            {NodeComparison $node.left   $leftchild}  | Should -BeTrue
            {NodeComparison $node.right  $rightchild} | Should -BeTrue
        }
    }
    
    Context "BStree creation" {
        It "data is retained" {
            $node = [TreeNode]::new(4)
            $tree = [BinarySearchTree]::new(@(4))
            $got  = NodeComparison $node $tree.GetData()

            $got | Should -BeTrue
        }

        It "insert data at proper node -> smaller number at left node" {
            $node = [TreeNode]::new(4, [TreeNode]::new(2), $null)
            $tree = [BinarySearchTree]::new(@(4, 2))
            $got  = NodeComparison $node $tree.GetData()

            $got | Should -BeTrue
        }

        It "insert data at proper node -> same number at left node" {
            $node = [TreeNode]::new(5, [TreeNode]::new(5), $null)
            $tree = [BinarySearchTree]::new(@(5, 5))
            $got  = NodeComparison $node $tree.GetData()

            $got | Should -BeTrue
        }

        It "insert data at proper node -> greater number at right node" {
            $node = [TreeNode]::new(3, $null, [TreeNode]::new(7))
            $tree = [BinarySearchTree]::new(@(3, 7))
            $got  = NodeComparison $node $tree.GetData()

            $got | Should -BeTrue
        }

        It "can create complex tree" {
            $node = [TreeNode]::new(
               4,
            [TreeNode]::new(2, [TreeNode]::new(1), [TreeNode]::new(3)),
            [TreeNode]::new(6, [TreeNode]::new(5), [TreeNode]::new(7))
            )
            $tree = [BinarySearchTree]::new(@(4, 2, 6, 1, 3, 5, 7))
            $got  = NodeComparison $node $tree.GetData()

            $got | Should -BeTrue
        }

    }
    Context "Search for data in the binary search tree" {
        It "can Search an existing value in the tree" {
            $tree = [BinarySearchTree]::new(@(2, 3, 6))
            $got  = $tree.Search(3)

            $got | Should -BeTrue
        }

        It "cannot Search an existing value in the tree" {
            $tree = [BinarySearchTree]::new(@(2, 3, 6))
            $got  = $tree.Search(9)

            $got | Should -BeFalse
        }
    }

    Context "sorted data aka inorder traversal" {
        It "can sort single number" {
            $tree = [BinarySearchTree]::new(@(1))
            $got  = $tree.Inorder()
            $want = @(1)

            $got | Should -BeExactly $want
        }

        It "can sort if second number is smaller than first" {
            $tree = [BinarySearchTree]::new(@(2, 1))
            $got  = $tree.Inorder()
            $want = @(1, 2)

            $got | Should -BeExactly $want
        }

        It "can sort if second number is same as first" {
            $tree = [BinarySearchTree]::new(@(5, 5))
            $got  = $tree.Inorder()
            $want = @(5, 5)

            $got | Should -BeExactly $want
        }

        It "can sort if second number is greater than first" {
            $tree = [BinarySearchTree]::new(@(3, 4))
            $got  = $tree.Inorder()
            $want = @(3, 4)

            $got | Should -BeExactly $want
        }

        It "can sort complex tree" {
            $tree = [BinarySearchTree]::new(@(5, 8, 7, 4, 1, 6, 3, 9, 2))
            $got  = $tree.Inorder()
            $want = @(1, 2, 3, 4, 5, 6, 7, 8, 9)

            $got | Should -BeExactly $want
        }
    }

    Context "postorder traversal" {
        It "can travel complex tree" {
            $tree = [BinarySearchTree]::new(@(5, 8, 7, 4, 1, 6, 3, 9, 2))
            $got  = $tree.Postorder()
            $want = @(2, 3, 1, 4, 6, 7, 9, 8, 5)

            $got | Should -BeExactly $want
        }
    }

    Context "preorder traversal" {
        It "can travel complex tree" {
            $tree = [BinarySearchTree]::new(@(5, 8, 7, 4, 1, 6, 3, 9, 2))
            $got  = $tree.Preorder()
            $want = @(5, 4, 1, 3, 2, 8, 7, 6, 9)

            $got | Should -BeExactly $want
        }
    }

    Context "optional tests: removal operation" -Skip {
        It "remove a leaf" {
            $node = [TreeNode]::new(10,
            [TreeNode]::new(7,  [TreeNode]::new(4,  [TreeNode]::new(1), $null), $null),
            [TreeNode]::new(15, [TreeNode]::new(12),[TreeNode]::new(20)))

            $tree = [BinarySearchTree]::new(@(10, 7, 15, 9, 12, 4, 20, 1))
            $tree.Remove(9)

            $got  = NodeComparison $node $tree.GetData()
            $got | Should -BeTrue
        }

        It "remove a node that has one child" {
            $node = [TreeNode]::new(10,
            [TreeNode]::new(7,  [TreeNode]::new(1), [TreeNode]::new(9)),
            [TreeNode]::new(15, [TreeNode]::new(12),[TreeNode]::new(20)))

            $tree = [BinarySearchTree]::new(@(10, 7, 15, 9, 12, 4, 20, 1))
            $tree.Remove(4)

            $got  = NodeComparison $node $tree.GetData()
            $got | Should -BeTrue
        }

        It "remove a node that has both children" {
            $node = [TreeNode]::new(10,
            [TreeNode]::new(7,  [TreeNode]::new(4,   [TreeNode]::new(1), $null), [TreeNode]::new(9)),
            [TreeNode]::new(20, [TreeNode]::new(12), $null))
            
            $tree = [BinarySearchTree]::new(@(10, 7, 15, 9, 12, 4, 20, 1))
            $tree.Remove(15)

            $got  = NodeComparison $node $tree.GetData()
            $got | Should -BeTrue
        }

        It "remove node at the root" {
            $node = [TreeNode]::new(12,
            [TreeNode]::new(7, [TreeNode]::new(4, [TreeNode]::new(1), $null), [TreeNode]::new(9)),
            [TreeNode]::new(15, $null, [TreeNode]::new(20)))

            $tree = [BinarySearchTree]::new(@(10, 7, 15, 9, 12, 4, 20, 1))
            $tree.Remove(10)

            $got  = NodeComparison $node $tree.GetData()
            $got | Should -BeTrue
        }
    }
}
