<#
.SYNOPSIS
Parsing a Smart Game Format string.

.DESCRIPTION
The exercise will have you parse an SGF string and return a tree structure of properties.

.EXAMPLE
Invoke-Parser -Data "(;E[xercism])"

Returns:
[SgfTree]::new(
    @{
        "E" = @("exercism")
    },
    @()
)
#>

Class SgfTree {
    <#
    .DESCRIPTION
    The SGF Tree class represent each node in the tree structure
    The Equals method is required to compare trees in test suite.
    #>
    [hashtable] $Properties
    [SgfTree[]]  $Children

    SgfTree() {
        $this.Properties = @{}
        $this.Children   = @()
    }

    SgfTree($properties, $children) {
        $this.Properties = $properties
        $this.Children   = $children
    }

    [bool] Equals($other) {
        #Two trees are equal when their properties and children are equal
        Throw "Please implement this function"
    }
}

function Invoke-Parser {
    param (
        [string]$Data
    )
    Throw "Please implement this function"
}
