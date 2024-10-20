<#
.SYNOPSIS
    Implement a custom set data type.

.DESCRIPTION
    Implement a class CustomSet to represent the set data structure with its typical behaviors and methods.
    Set behavior: elements inside a set are unique. 
    Set methods: IsEmpty, Contains, IsSubset, IsDisjoint, Add, Union, Difference and Intersection.

    How it being contructed internally doesn't matter, but the class also need an 'Equals' method to compare with other set.

.EXAMPLE
    $set  = [CustomSet]::new(@(3, 4, 5))
    $set2 = [CustomSet]::new(@(3, 2, 4, 5, 1))

    $set.IsEmpty()
    Returns: $false

    $set.Contains(3)
    Returns: $true

    $set.IsSubset($set2)
    Returns: $true
#>
Class CustomSet {
    [Object[]] $Set

    CustomSet() {
        $this.Set = @()
    }

    CustomSet([Object[]]$values) {
        $this.Set = @()
        foreach ($val in $values) {
            if ($val -notin $this.Set) {
                $this.Set += $val
            }
        }
    }

    [bool] IsEmpty() {
        return $this.Set.Count -eq 0
    }
    
    [bool] Contains([object]$element) {
        return $this.Set -contains $element
    }

    [bool] IsSubset([CustomSet]$other) {
        if ($this.IsEmpty()) {
            return $true
        }
        foreach ($element in $this.Set) {
            if (-not $other.Contains($element)) {
                return $false
            }
        }
        return $true
    }

    [bool] IsDisjoint([CustomSet]$otherSet) {
        $overlap = Compare-Object $this.Set $otherSet.Set -IncludeEqual -ExcludeDifferent
        return -not $overlap
    }

    [CustomSet] Add([Object]$element) {
        $this.Set += $element | Where-Object { $element -notin $this.Set }
        return $this
    }

    [CustomSet] Union([CustomSet]$otherSet) {
        $overlap = Compare-Object $this.Set $otherSet.Set -IncludeEqual -PassThru
        return [CustomSet]::new(@($overlap))
    }
    
    [CustomSet] Difference([CustomSet]$otherSet) {
        if ($otherSet.IsEmpty()) {
            return [CustomSet]::new($this.Set)
        }
        $difA = $this.Set | Where-Object {$_ -notin $otherSet.Set}
        if ($this.IsEmpty() -or $difA.Count -eq 0) {
            return [CustomSet]::new()
        }
        return [CustomSet]::new(@($difA))
    }

    [CustomSet] Intersection([CustomSet]$otherSet) {
        $overlap = Compare-Object $this.Set $otherSet.Set -IncludeEqual -ExcludeDifferent -PassThru
        return [CustomSet]::new(@($overlap))
    }

    [bool] Equals($other) {
        if ($this.IsEmpty() -and $other.IsEmpty()) {
            return $true
        }
        foreach ($element in $this.Set) {
            if (-not $other.Contains($element)) {
                return $false
            }
        }
        return $this.Set.Count -eq $other.Set.Count
    }
}
