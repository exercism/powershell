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
        if ($other -isnot [SgfTree]) {
            return $false
        }
        foreach ($key in $this.Properties.Keys) {
            if (-not $other.Properties.ContainsKey($key)){
                return $false
            }
            $arrayComparison = Compare-Object $this.Properties[$key] $other.Properties[$key]
            if ($arrayComparison.Count -ne 0) {
                return $false
            }
        }
        foreach ($key in $other.Properties.Keys) {
            if (-not $this.Properties.ContainsKey($key)) {
                return $false
            }
        }
        if ($this.Children.Count -ne $other.Children.Count) {
            return $false
        }
        return $true
    }
}

function Validation($string) {
    <#
    .DESCRIPTION
    Helper function to validate the string
    #>
    if ($string -notlike "(*)") {Throw "Tree missing"}

    if ($string -notmatch ";") {Throw "Tree with no nodes"}

    $string -cmatch ";([a-zA-Z]+)(\[.*\])*" | Out-Null

    if ($Matches[1] -cmatch "[a-z]") {Throw "Property must be in uppercase"}

    if ($Matches[1] -and -not $Matches[2]) {Throw "Properties without delimiter"}
}

function ParseTree {
    <#
    .DESCRIPTION
    Helper function to parse a node
    #>
    param (
        [string]$Data
    )
    $properties = @{}
    $i = 0

    while ($i -lt $Data.Length) {
        if ($Data[$i] -cmatch "[A-Z]") { #property phase
            $property = ""
            while ($Data[$i] -ne "[") {
                $property += $Data[$i]
                $i++
            }
            $properties[$property] = @()
        }
    
        if ($Data[$i] -eq "[") { #value phase
            $value = ""
            $i++
            while ($Data[$i] -ne "]") {
                if ($Data[$i] -eq "\") { #escaping phase
                    switch ($Data[$i+1]) {
                        "t" {$value += " "; $i+=2}
                        "n" {$value += "\n"; $i+=2}
                        "\" {
                            $chars = -join $Data[($i+2)..($i+3)]
                            switch ($chars) {
                                "\\" {$value += "\\";  $i+=4}
                                "\t" {$value += " ";  $i+=4}
                                "\n" {$i+=4}
                                Default {$value += $Data[$i+2]; $i+=3}
                            }
                        }
                    }
                    continue
                }
                $value += $Data[$i]
                $i++
            }
            $properties[$property] += $value
        }
        $i++
    }
    
    [SgfTree]::new($properties, @())
}


function Invoke-Parser {
    param (
        [string]$Data
    )
    Validation $Data

    $str = $Data.Trim("()")
    $nodes = $str -csplit '(;)(?=[A-Z])' | Where-Object {$_ -ne "" -and $_ -ne ";"}
    if ($nodes.Count -eq 0) { return [SgfTree]::new() }
    if ($nodes.Count -eq 1) { return ParseTree $nodes }

    for ($i = 0; $i -lt $nodes.Count; $i++) {
        if ($i -eq 0) {
            $tree = ParseTree $nodes[$i]
        }else {
            $tree.Children += ParseTree $nodes[$i]
        }
    }
    $tree
}