<#
.SYNOPSIS
    Given a tree, reorientate it based on a selected node.

.DESCRIPTION
    A tree is a special type of graph where all nodes are connected but there are no cycles.
    That means, there is exactly one path to get from one node to another for any pair of nodes.

    Implement a class to represent the Tree along with these methods:
    - FromPov: accept a value of a node, return a new Tree object orientated based on that node.
        Throw error if the value/node does't exist in the tree.
    - Path: accept the source and destination values of two nodes, return an array of string represent the path from source to destination.
        Throw error if the path doesn't exist.
    - Equals: equality method to compare trees for the test suite.

.EXAMPLE
    Read instructions for visual example.
#>

Class Tree {
    Tree([string] $value, [Tree[]] $Children) {
        Throw "Please implement this class"
    }

    [Tree] FromPov([string] $node) {
        Throw "Please implement this function"
    }

    [string[]] Path([string] $from, [string] $to) {
        Throw "Please implement this function"
    }

    [bool] Equals($other) {
        Throw "Please implement this function"
    }
}