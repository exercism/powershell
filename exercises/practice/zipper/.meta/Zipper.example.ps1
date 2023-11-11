<#
.SYNOPSIS
    Creating a zipper for a binary tree.

.DESCRIPTION
    Implement a class for a tree data structure with value, left child and right child as properties.

    Implement a zipper class data structure which support these operations:
    - 'FromTree' (get a zipper out of a binary tree, the focus is on the root node)
    - 'ToTree' (get the binary tree out of the zipper)
    - 'Value' (get the value of the focus node)
    - 'GoLeft' (move the focus to the left child node, returns a new zipper)
    - 'GoRight' (move the focus to the right child node, returns a new zipper)
    - 'GoUp' (move the focus to the parent, returns a new zipper)
    - 'SetValue' (set the value of the focus node, returns a new zipper)
    - 'SetLeft' (insert a new subtree before the focus node, it
    becomes the 'Left' of the focus node, returns a new zipper)
    - 'SetRight' (insert a new subtree after the focus node, it becomes
    the 'Right' of the focus node, returns a new zipper)
    - 'Delete' (removes the focus node and all subtrees, focus moves to the
    'Right' node if possible otherwise to the 'Left' node if possible,
    otherwise to the parent node, returns a new zipper) 
    
    *'Delete' operation is optional and there is no tests for it.

.EXAMPLE
    $tree = [Tree]::new(5, [Tree]::new(4, $null, $null), [Tree]::new(7, $null, $null))
    $zipper = [Zipper]::FromTree($tree)

    $zipper.GetValue()
    Returns: 5

    $zipper.GoLeft().GetValue()
    Returns: 4

    $zipper.GoRight().GoUp().GetValue()
    Returns: 5
#>
Class Tree {
    [int] hidden $Value
    [Tree] hidden $Left
    [Tree] hidden $Right

    Tree([int] $data, [Tree] $left, [Tree] $right) {
        $this.Value = $data
        $this.Left  = $left
        $this.Right  = $right
    }

    [bool] Equals( $other) {
        if ($null -eq $other) {
            return $false
        }
        if ($this.Value -ne $other.Value) {
            return $false
        }
        $leftEquals = if ($null -eq $this.Left) {
            $null -eq $other.Left
        } else {
            $this.Left.Equals($other.Left)
        }

        $rightEquals = if ($null -eq $this.Right) {
            $null -eq $other.Right
        } else {
            $this.Right.Equals($other.Right)
        }
        return $leftEquals -and $rightEquals
    }
}

Class Path {
    [string] $Direction
    [int] $Value
    [Tree] $Tree

    Path ([string] $dir,[int] $val,[Tree] $tree) {
        $this.Direction = $dir
        $this.Value = $val
        $this.Tree = $tree
    }
}

Class Zipper {
    [int]   hidden $Value
    [Tree]  hidden $Left
    [Tree]  hidden $Right
    [Path[]] hidden $Path

    Zipper([int] $data, [Tree] $left, [Tree] $right, [Path[]] $path) {
        $this.Value = $data
        $this.Left  = $left
        $this.Right = $right
        $this.Path  = $path
    }

    [Tree] ToTree() {
        $tree = [Tree]::new($this.Value, $this.Left, $this.Right)
        foreach ($trail in $this.Path) {
            if($trail.Direction -eq "left") {
                $tree = [Tree]::new($trail.Value, $tree, $trail.Tree)
            }elseif ($trail.Direction -eq "right") {
                $tree = [Tree]::new($trail.Value, $trail.Tree, $tree)
            }
        }
        return $tree
    }

    [int] GetValue() {
        return $this.Value
    }

    [Zipper] GoLeft() {
        if ($null -eq $this.Left) {
            return $null
        }
        $trail = @([Path]::new("left", $this.Value, $this.Right)) + $this.Path
        return [Zipper]::new($this.Left.Value, $this.Left.Left, $this.Left.Right, $trail)
    }

    [Zipper] GoRight() {
        if ($null -eq $this.Right) {
            return $null
        }
        $trail = @([Path]::new("right", $this.Value, $this.Left)) + $this.Path
        return [Zipper]::new($this.Right.Value, $this.Right.Left, $this.Right.Right, $trail)
    }

    [Zipper] SetValue([int] $data) {
        return [Zipper]::new($data, $this.Left, $this.Right, $this.Path)
    }

    [Zipper] SetLeft([Tree] $tree) {
        return [Zipper]::new($this.Value, $tree, $this.Right, $this.Path)
    }

    [Zipper] SetRight([Tree] $tree) {
        return [Zipper]::new($this.Value, $this.Left, $tree, $this.Path)
    }

    [Zipper] GoUp() {
        if ($this.Path.Count -eq 0) {
            return $null
        }
        $trail = $this.Path[0]
        $rest  = $this.Path | Select-Object -Skip 1

        $currentTree = [Tree]::new($this.Value, $this.Left, $this.Right)

        if ($trail.Direction -eq "left") {
            return  [Zipper]::new($trail.Value, $currentTree, $trail.Tree, $rest)
        }else {
            return  [Zipper]::new($trail.Value, $trail.Tree, $currentTree, $rest)
        }
    }

    [bool] Equals( $other) {
        return $this.ToTree() -eq $other.ToTree()
    }

    static [Zipper] FromTree([Tree] $tree) {
        return [Zipper]::new($tree.Value, $tree.Left, $tree.Right, @())
    }
}