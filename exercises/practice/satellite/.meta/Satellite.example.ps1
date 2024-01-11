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
    Validator $Preorder $Inorder

    $root = $Preorder[0]
    if ($Preorder.Count -le 1 -or $Inorder.Count -le 1) {
        return [Node]::new($root)
    }

    $mid = $Inorder.IndexOf($root)
    #Recursive call to keep building the inner tree
    [Node]::new(
        $root,
        (Get-TreeFromTraversals $Preorder[1..$mid] $Inorder[0..($mid-1)]),
        (Get-TreeFromTraversals $Preorder[($mid+1)..($Preorder.Count)] $Inorder[($mid+1)..($Preorder.Count)])
    )
}

function Validator($preorder, $inorder) {
    <#
    .DESCRIPTION
    Validator for the preorder and inorder inputs before attempting to rebuild the tree
    #>
    if ($preorder.Count -ne $inorder.Count) {
        Write-Error -Exception ([ArgumentException]::new("Traversals must have the same length")) -ErrorAction Stop
    }

    if ((($preorder | Get-Unique).Count + ($inorder | Get-Unique).Count) -ne ($preorder.Count + $inorder.Count)) {
        Write-Error -Exception ([ArgumentException]::new("Traversals must contain unique items")) -ErrorAction Stop
    }

    if ((Compare-Object $preorder $inorder -ExcludeDifferent).Count -ne $preorder.Count) {
        Write-Error -Exception ([ArgumentException]::new("Traversals must have the same elements")) -ErrorAction Stop
    }
}

Class Node {
    [object] $Value = $null
    [Node]   $Left  = $null
    [Node]   $Right = $null

    Node() {}

    Node($value) {
        $this.Value = $value
    }
    
    Node($value, $left, $right) {
        $this.Value = $value
        $this.Left  = $left
        $this.Right = $right
    }

    [bool] Equals($other) {
        $difference = Compare-Object $this $other -Property Value, Left, Right
        return -not $difference
    }
}