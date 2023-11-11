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

    You also need to implement the Equals methods so the test can run correctly while comparing objects.

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
    [int] $Value
    [Tree] $Left
    [Tree] $Right

    Tree([int] $data, [Tree] $left, [Tree] $right) {
        Throw "Please implement this class"
    }
}

Class Zipper {
    Zipper() {
        Throw "Please implement this class"
    }

    [int] GetValue() {
        Throw "Please implement this function"
    }

    [Zipper] SetValue([int] $data) {
        Throw "Please implement this function"
    }

    [Zipper] GoLeft() {
        Throw "Please implement this function"
    }

    [Zipper] SetLeft([Tree] $tree) {
        Throw "Please implement this function"
    }

    [Zipper] GoRight() {
        Throw "Please implement this function"
    }

    [Zipper] SetRight([Tree] $tree) {
        Throw "Please implement this function"
    }

    [Zipper] GoUp() {
        Throw "Please implement this function"
    }

    [Tree] ToTree() {
        Throw "Please implement this function"
    }

    static [Zipper] FromTree([Tree] $tree) {
        Throw "Please implement this function"
    }
}