<#
.SYNOPSIS
    Given two buckets of different size and which bucket to fill first, determine how many actions are required to measure an exact number of liters by strategically transferring fluid between the buckets.

.DESCRIPTION
    Please read the rules of how to implement the solution in instructions.
    
    Your task here is to implement a class to solve for the solution.
    The class should take in : size of bucket 1, size of bucket 2, and which bucket to start with "one" or "two"
    The class should have the Measure method that take in the target, and if possible return an object for the result.

    If it is not possible to reach the target, please throw an error.
    
.EXAMPLE
    $buckets = [TwoBucket]::new(6, 7, "one")
    $buckets.Measure(5) | Format-List

    Returns:
    Moves       : 4
    GoalBucket  : one
    OtherBucket : 7
#>

Class TwoBucket {
    TwoBucket([int] $size1, [int] $size2, [string] $start) {
        Throw "Please implement this class"
    }

    [object] Measure([int] $target) {
        Throw "Please implement this function"
    }
}