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
    [Object[]] hidden $Set

    CustomSet() {
        $this.Set = @()
    }

    CustomSet([Object[]]$values) {
        if ($values.Count -eq 0) {
            $this.Set = @()
        }else {
            $this.Set += $values | Where-Object { $this.Set -notcontains $_ }
        }
    }

    [bool] IsEmpty() {
        return $this.Set.Count -eq 0
    }
    
    [bool] Contains([Object]$element) {
        return $this.Set -contains $element
    }

    [bool] IsSubset([CustomSet]$otherSet) {
        $overlap = Compare-Object $this.Set $otherSet.Set -IncludeEqual -ExcludeDifferent
        return $overlap.Count -eq $this.Set.Count
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
        if ($otherSet.Set.Count -eq 0) {
            return [CustomSet]::new($this.Set)
        }
        $difA = $this.Set | Where-Object {$_ -notin $otherSet.Set}
        if ($this.Set.Count -eq 0 -or $difA.Count -eq 0) {
            return [CustomSet]::new()
        }
        return [CustomSet]::new(@($difA))
    }

    [CustomSet] Intersection([CustomSet]$otherSet) {
        $overlap = Compare-Object $this.Set $otherSet.Set -IncludeEqual -ExcludeDifferent -PassThru
        return [CustomSet]::new(@($overlap))
    }

    [bool] Equals([Object]$otherSet) {
        if ($otherSet -is [CustomSet]) {
            return -not (Compare-Object $this.Set $otherSet.Set)
        }
        return $false
    }
}
