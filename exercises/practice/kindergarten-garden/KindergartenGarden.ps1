<#
.SYNOPSIS
    Given a diagram, determine which plants each child in the kindergarten class is responsible for.

.DESCRIPTION
    There are 12 children in the class:
    - Alice, Bob, Charlie, David,
    - Eve, Fred, Ginny, Harriet,
    - Ileana, Joseph, Kincaid, and Larry.
    Each child take care of 4 plants, two on each row.
    The children are being seated alphabetically from left to right.

    Note: the class constructor should accept an optional list of differnt students if provided.

.EXAMPLE
    $garden = [Garden]::new("VCCCGG`nVGCCGG")
    $garden.GetPlants("Alice")
    Return : @("Violets", "Clover", "Violets", "Grass")
#>
Class Garden {
    Garden() {
        Throw "Please implement this class"
    }
}