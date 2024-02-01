Function Get-TreeFromTraversals() {
    <#
    .SYNOPSIS
    Write the software for the satellite to rebuild the tree from the traversals.

    .DESCRIPTION
    GIven the preorder and inorder traverse of a tree, rebuild the tree.
    Read the instructions for more information of preorder, inorder and example.

    The rebuilt tree should be represent by the Node class template below.
    Implement the Equals class method in the Node class for comparison.

    .PARAMETER Preorder
    An array represent the preorder traverse of the original tree.

    .PARAMETER Inorder
    An array represent the inorder traverse of the original tree.

    .EXAMPLE
    Get-TreeFromTraversals -Preorder @("a", "b") -Inorder @("b", "a")
    Return: [Node]::new(
                "a",
                [Node]::new("b"),
                [Node]::new()
            )
    #>
    [CmdletBinding()]
    Param(
        [object[]]$Preorder,
        [object[]]$Inorder
    )
    Throw "Please implement this function"
}


Class Node {
    $Value 
    $Left
    $Right

    Node() {
        Throw "Please implement this class"
    }

    [bool] Equals($other) {
        Throw "Please implement this function"
    }
}