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
    CustomSet() {
        Throw "Please implement this class"
    }

    [bool] IsEmpty() {
        Throw "Please implement this fucntion"
    }
    
    [bool] Contains($element) {
        Throw "Please implement this fucntion"
    }

    [bool] IsSubset($other) {
        Throw "Please implement this fucntion"
    }

    [bool] IsDisjoint($other) {
        Throw "Please implement this fucntion"
    }

    [CustomSet] Add($element) {
        Throw "Please implement this fucntion"
    }

    [CustomSet] Union($other) {
        Throw "Please implement this fucntion"
    }
    
    [CustomSet] Difference($other) {
        Throw "Please implement this fucntion"
    }

    [CustomSet] Intersection($other) {
        Throw "Please implement this fucntion"
    }

    [bool] Equals($other) {
        Throw "Please implement this fucntion"
    }
}