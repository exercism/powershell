BeforeAll {
    . "./Zipper.ps1"
}

Describe "Zipper test cases" {
    BeforeEach {
        # Creating a tree and a zipper object from that tree for each test case
        $tree   = [Tree]::new(1, [Tree]::new(2, $null, [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))
        $zipper = [Zipper]::FromTree($tree)
    }

    It "data is retained" {
        $got  = $zipper.ToTree()
        $want = [Tree]::new(1, [Tree]::new(2, $null, [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))

        $got | Should -BeExactly $want
    }

    It "left, right and value" {
        $got  = $zipper.GoLeft().GoRight().GetValue()
        $want = 3

        $got | Should -BeExactly $want
    }

    It "dead end" {
        $got = $zipper.GoLeft().GoLeft()
        $got | Should -BeNullOrEmpty
    }

    It "tree from deep focus" {
        $got  = $zipper.GoLeft().GoRight().ToTree()
        $want = [Tree]::new(1, [Tree]::new(2, $null, [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))

        $got | Should -BeExactly $want
    }

    It "traversing GoUp from top" {
        $got = $zipper.GoUp()
        $got | Should -BeNullOrEmpty
    }

    It "left, right, and up" {
        $got  = $zipper.GoLeft().GoUp().GoRight().GoUp().GoLeft().GoRight().GetValue()
        $want = 3
        
        $got | Should -BeExactly $want
    }

    It "test ability to descend multiple levels and return" {
        $got  = $zipper.GoLeft().GoRight().GoUp().GoUp().GetValue()
        $want = 1
        
        $got | Should -BeExactly $want
    }

    It "set_value" {
        $got  = $zipper.GoLeft().SetValue(5).ToTree()
        $want = [Tree]::new(1, [Tree]::new(5, $null, [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))
        
        $got | Should -BeExactly $want
    }

    It "set_value after traversing up" {
        $got  = $zipper.GoLeft().GoRight().GoUp().SetValue(5).ToTree()
        $want = [Tree]::new(1, [Tree]::new(5, $null, [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))
    
        $got | Should -BeExactly $want
    }

    It "set_left with leaf" {
        $got  = $zipper.GoLeft().SetLeft([Tree]::new(5, $null, $null)).ToTree()
        $want = [Tree]::new(1, [Tree]::new(2, [Tree]::new(5, $null, $null), [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))
    
        $got | Should -BeExactly $want
    }

    It "set_right with null" {
        $got  = $zipper.GoLeft().SetRight($null).ToTree()
        $want = [Tree]::new(1, [Tree]::new(2, $null, $null), [Tree]::new(4, $null, $null))

        $got | Should -BeExactly $want
    }

    It "set_right with subtree" {
        $got  = $zipper.SetRight([Tree]::new(6, [Tree]::new(7, $null, $null), [Tree]::new(8, $null, $null))).ToTree()
        $want = [Tree]::new(1, [Tree]::new(2, $null, [Tree]::new(3, $null, $null)), [Tree]::new(6, [Tree]::new(7, $null, $null), [Tree]::new(8, $null, $null)))
    
        $got | Should -BeExactly $want
    }

    It "set_value on deep focus" {
        $got  = $zipper.GoLeft().GoRight().SetValue(5).ToTree()
        $want = [Tree]::new(1, [Tree]::new(2, $null, [Tree]::new(5, $null, $null)), [Tree]::new(4, $null, $null))

        $got | Should -BeExactly $want
    }

    It "different paths to same zipper" {
        $got  = $zipper.GoLeft().GoUp().GoRight()
        $want = [Zipper]::FromTree([Tree]::new(1, [Tree]::new(2, $null, [Tree]::new(3, $null, $null)), [Tree]::new(4, $null, $null))).GoRight()

        $got | Should -BeExactly $want
    }
}
