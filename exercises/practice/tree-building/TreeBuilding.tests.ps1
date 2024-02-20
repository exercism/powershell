BeforeAll {
    . "./TreeBuilding.ps1"

    # Utility functions
    function NodeIsBranch() {
        [CmdletBinding()]
        Param(
            [Node] $Node, 
            [int]  $NodeId, 
            [int]  $ChildrenCount
        )

        $Node.NodeId | Should -Be $NodeId
        $Node.IsLeaf() | Should -BeFalse
        $Node.Children.Count | Should -BeExactly $ChildrenCount
    }

    function NodeIsLeaf($Node, $NodeId) {
        $Node.NodeId | Should -Be $NodeId
        $Node.IsLeaf() | Should -BeTrue
    }
}

Describe "TreeBuilding test cases" {
    Context "Valid records input" {
        It "empty list input" {
            $records = @()
            $tree = Build-Tree -Records $records
    
            $tree | Should -BeNullOrEmpty
        }
    
        It "one Node" {
            $records = @(
                [Record]::new(0, 0)
            )
            $tree = Build-Tree -Records $records
    
            NodeIsLeaf -Node $tree -NodeID 0
        }
    
        It "three Nodes in order" {
            $records = @(
                [Record]::new(0, 0)
                [Record]::new(1, 0)
                [Record]::new(2, 0)
            )
            $tree = Build-Tree -Records $records
    
            NodeIsBranch -Node $tree -NodeID 0 -ChildrenCount 2
            NodeIsLeaf -Node $tree.Children[0] -NodeID 1
            NodeIsLeaf -Node $tree.Children[1] -NodeID 2
        }
    
        It "three Nodes in reverse order" {
            $records = @(
                [Record]::new(2, 0)
                [Record]::new(1, 0)
                [Record]::new(0, 0)
            )
            $tree = Build-Tree -Records $records
    
            NodeIsBranch -Node $tree -NodeID 0 -ChildrenCount 2
            NodeIsLeaf -Node $tree.Children[0] -NodeID 1
            NodeIsLeaf -Node $tree.Children[1] -NodeID 2
        }
    
        It "more than two children" {
            $records = @(
                [Record]::new(0, 0)
                [Record]::new(1, 0)
                [Record]::new(2, 0)
                [Record]::new(3, 0)
            )
            $tree = Build-Tree -Records $records
    
            NodeIsBranch -Node $tree -NodeID 0 -ChildrenCount 3
            NodeIsLeaf -Node $tree.Children[0] -NodeID 1
            NodeIsLeaf -Node $tree.Children[1] -NodeID 2
            NodeIsLeaf -Node $tree.Children[2] -NodeID 3
        }
        
        It "binary tree" {
            $records = @(
                [Record]::new(6, 2)
                [Record]::new(0, 0)
                [Record]::new(3, 1)
                [Record]::new(2, 0)
                [Record]::new(4, 1)
                [Record]::new(5, 2)
                [Record]::new(1, 0)
            )
            $tree = Build-Tree -Records $records
    
            NodeIsBranch -Node $tree -NodeID 0 -ChildrenCount 2
            NodeIsBranch -Node $tree.Children[0] -NodeID 1 -ChildrenCount 2
            NodeIsBranch -Node $tree.Children[1] -NodeID 2 -ChildrenCount 2
            NodeIsLeaf -Node $tree.Children[0].Children[0] -NodeID 3
            NodeIsLeaf -Node $tree.Children[0].Children[1] -NodeID 4
            NodeIsLeaf -Node $tree.Children[1].Children[0] -NodeID 5
            NodeIsLeaf -Node $tree.Children[1].Children[1] -NodeID 6
        }
    
        It "unbalanced treed" {
            $records = @(
                [Record]::new(5, 2)
                [Record]::new(2, 0)
                [Record]::new(3, 2)
                [Record]::new(1, 0)
                [Record]::new(4, 1)
                [Record]::new(0, 0)
                [Record]::new(6, 2)
            )
            $tree = Build-Tree -Records $records
    
            NodeIsBranch -Node $tree -NodeID 0 -ChildrenCount 2
            NodeIsBranch -Node $tree.Children[0] -NodeID 1 -ChildrenCount 1
            NodeIsBranch -Node $tree.Children[1] -NodeID 2 -ChildrenCount 3
            NodeIsLeaf -Node $tree.Children[0].Children[0] -NodeID 4
            NodeIsLeaf -Node $tree.Children[1].Children[0] -NodeID 3
            NodeIsLeaf -Node $tree.Children[1].Children[1] -NodeID 5
            NodeIsLeaf -Node $tree.Children[1].Children[2] -NodeID 6
        }
    }
    
    Context "Invalid records input" {
        It "root Node has parent" {
            $records = @(
                [Record]::new(0, 1)
                [Record]::new(1, 0)
            )
    
            {Build-Tree -Records $records} | Should -Throw "*Node record id should be greater than parent id.*"
        }
    
        It "no root Node" {
            $records = @(
                [Record]::new(1, 0)
                [Record]::new(2, 0)
            )
    
            {Build-Tree -Records $records} | Should -Throw "*Record id is invalid or out of order.*"
        }
    
        It "non continuous" {
            $records = @(
                [Record]::new(2, 0)
                [Record]::new(4, 2)
                [Record]::new(1, 0)
                [Record]::new(0, 0)
            )
    
            {Build-Tree -Records $records} | Should -Throw "*Record id is invalid or out of order.*"
        }
    
        It "cycle directly" {
            $records = @(
                [Record]::new(5, 2)
                [Record]::new(3, 2)
                [Record]::new(2, 2)
                [Record]::new(4, 1)
                [Record]::new(1, 0)
                [Record]::new(0, 0)
                [Record]::new(6, 3)
            )
    
            {Build-Tree -Records $records} | Should -Throw "*Only root should have equal record and parent id (0).*"
        }
        
        It "cycle indirectly" {
            $records = @(
                [Record]::new(5, 2)
                [Record]::new(3, 2)
                [Record]::new(2, 6)
                [Record]::new(4, 1)
                [Record]::new(1, 0)
                [Record]::new(0, 0)
                [Record]::new(6, 3)
            )
    
            {Build-Tree -Records $records} | Should -Throw "*Node record id should be greater than parent id.*"
        }
    
        It "higher id parent of lower id" {
            $records = @(
                [Record]::new(0, 0)
                [Record]::new(2, 0)
                [Record]::new(1, 2)
            )
    
            {Build-Tree -Records $records} | Should -Throw "*Node record id should be greater than parent id.*"
        }
    }
}