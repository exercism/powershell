<#
.SYNOPSIS
Implement two classes, one for tree node and one for binary search tree.

.DESCRIPTION
Create a binary search tree made by many different tree node.
Each tree node instance contain the value for the node and its children if exist.
The binary search tree should have these methods:
- Insert    : take in an array of number, create node and insert them follow the property of the binary search tree.
- GetData   : return the root node that contain the entire tree's data
- Search    : take in a number to find in the binary tree, return a boolean value
- Inorder   : return an array of values in order of inorder travel
- Postorder : return an array of values in order of postorder travel
- Preorder  : return an array of values in order of preorder travel

.EXAMPLE
$tree = [BinarySearchTree]::new(@(3,4,2))

$tree.Search(3)
Return: true

$tree.Inorder()
Return: @(2, 3, 4)

$tree.PreOrder()
Return: @(3, 2, 4)

$tree.Postorder()
Return: @(2, 4, 3)
#>
Class TreeNode {
    hidden [int]$data
    hidden [TreeNode]$left 
    hidden [TreeNode]$right

    TreeNode([int]$Value) {
        $this.data  = $Value
        $this.left  = $null
        $this.right = $null
    }

    TreeNode([int]$Value, $leftchild, $rightchild) {
        $this.data  = $Value
        $this.left  = $leftchild
        $this.right = $rightchild
    }

    [string] ToString() {
        return "Node{data=$($this.data), L=$($this.left), R=$($this.right)}"
    }
}

Class BinarySearchTree {
    hidden [TreeNode]$root

    BinarySearchTree([int[]]$Data) {
        $this.root = $null
        $Data | ForEach-Object {$this.Insert($_)}
    }

    [void] Insert([int]$Value) {
        <#
        .DESCRIPTION
        Insertion method to add new node to the tree.
        #>
        $this.root = $this.Insert($this.root, $Value)
    }

    hidden [TreeNode] Insert([TreeNode]$node, [int]$Value) {
        if (-not $node) {
            $node = [TreeNode]::new($Value)
        }elseif ($Value -le $node.data) {
            $node.left  = $this.Insert($node.left,$Value)
        }elseif ($Value -gt $node.data) {
            $node.right = $this.Insert($node.right,$Value)
        }
        return $node
    }

    [TreeNode] GetData() {
        return $this.root
    }

    [bool] Search([int]$Value) {
        <#
        .DESCRIPTION
        Search function to Search a value inside the tree.
        Return true if exist, otherwise return false.
        #>
        return $this.Search($this.root, $Value)
    }

    hidden [bool] Search($root, [int]$Value) {
        if (-not $root) {
            return $false
        }
        $currentVal = $root.data
        if ($Value -eq $currentVal) {
            return $true
        }elseif ($Value -le $currentVal){
            return $this.Search($root.left, $Value)
        }elseif ($Value -gt $currentVal){
            return $this.Search($root.right, $Value)
        }
        return $false
    }

    [void] Remove([int]$Value) {
        <#
        .DESCRIPTION
        Remove function to remove a node inside the tree, and reshape/update the tree.
        Does not return anything.
        #>
        $this.root = $this.Remove($this.root, $Value)
    }

    hidden [TreeNode] Remove($root, $Value) {
        # Base case: If the tree or subtree is empty, return null
        if (-not $root) {
            Write-Host "Element doesn't exist to be removed"
            return $null
        }
        # If the value to delete is smaller, move to the left subtree
        if ($Value -lt $root.data) {
            $root.left = $this.Remove($root.left, $Value)
        # If the value to delete is larger, move to the right subtree
        }elseif ($Value -gt $root.data) {
            $root.right = $this.Remove($root.right, $Value)
        }else {
            #Found the value to be deleted
            # Case 1&2: Node with one child or no child
            if (-not $root.left -or -not $root.right) {
                return $root.left ? $root.left : $root.right
            }
            # Case 3: Node with two children
            $replacementNode = $this.SearchMin($root.right)
            $root.data = $replacementNode.data
            $root.right = $this.Remove($root.right, $replacementNode.data)
        }
        return $root
    }

    hidden [TreeNode] SearchMin([TreeNode]$node) {
        <#
        .DESCRIPTION
        Helper function for removal, Search the successor to replace the removed node.
        #>
        while ($node.left) {
            $node = $node.left
        }
        return $node
    }

    [int[]] Inorder() {
        <#
        .DESCRIPTION
        Inorder traverse method.
        Return an array of value based on the traverse method.
        #>
        return $this.Inorder($this.root, @())
    }

    hidden [int[]] Inorder($root, [int[]]$result) {
        if ($root) {
            $result = $this.Inorder($root.left,$result)
            $result += @($root.data)
            $result = $this.Inorder($root.right,$result)
        }
        return $result
    }

    [int[]] PreOrder() {
        <#
        .DESCRIPTION
        Preorder traverse method.
        Return an array of value based on the traverse method.
        #>
        return $this.PreOrder($this.root, @())
    }
    
    hidden [int[]] PreOrder($root, [int[]]$result) {
        if ($root) {
            $result += @($root.data)
            $result = $this.PreOrder($root.left, $result)
            $result = $this.PreOrder($root.right, $result)
        }
        return $result
    }

    [int[]] Postorder() {
        <#
        .DESCRIPTION
        Postorder traverse method.
        Return an array of value based on the traverse method.
        #>
        return $this.Postorder($this.root, @())
    }
    
    hidden [int[]] Postorder($root, [int[]]$result) {
        if ($root) {
            $result = $this.Postorder($root.left, $result)
            $result = $this.Postorder($root.right, $result)
            $result += @($root.data)
        }
        return $result
    }

    [string] ToString() {
        <#
        .DESCRIPTION
        Tostring method to help print out the tree in a nice format for viewing
        Adapt from : https://stackoverflow.com/questions/4965335/how-to-print-binary-tree-diagram-in-java
        #>
        $textBuilder = [System.Text.StringBuilder]::new()
        $this.PrintBinaryTree($textBuilder, "", "", $this.root)
        return $textBuilder.ToString()
    }

    hidden [void] PrintBinaryTree ([System.Text.StringBuilder]$string, [string]$prefix, [string]$childrenPrefix, [TreeNode]$root) {
        $string.Append("$prefix$($root.data)`n")

        if ($root.left -and $root.right) { #draw left child
            $this.PrintBinaryTree($string, ($childrenPrefix + "├──L:"), ($childrenPrefix + "│   "), $root.left)
        }elseif ($root.left){
            $this.PrintBinaryTree($string, ($childrenPrefix + "└──L:"), ($childrenPrefix + "    "), $root.left)
        }
        
        if ($root.right) { #draw right child
            $this.PrintBinaryTree($string, ($childrenPrefix + "└──R:"), ($childrenPrefix + "    "), $root.right)
        }
    }
}