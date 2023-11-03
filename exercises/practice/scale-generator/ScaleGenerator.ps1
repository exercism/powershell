<#
.SYNOPSIS
    Implement a program to generate different scales of music based on a tonic.

.DESCRIPTION
    Please read the instructions for the rules and further details of music related terms.

    This exercise require you to create a class Scale, which take in a starting tonic.
    The class required two methods to be implemented:
    - Chromatic : which will return a 12-note scale depend on whether the starting tonic is flat or sharp.
    - Interval(string) : method take in a string represent the intervals and return a diatonic scales.

.EXAMPLE
    $scale = [Scale]::new("C")
    $scale.Chromatic()
    Returns: @("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B")
    
    $scale.Interval("MMmMMMm")
    Returns: @("C", "D", "E", "F", "G", "A", "B", "C")
#>

Class Scale {
    Scale([string] $tonic) {
        Throw "Please implement this class"
    }

    [string[]] Chromatic() {
        Throw "Please implement this function"
    }

    [string[]] Interval([string] $intervals) {
        Throw "Please implement this function"
    }
}