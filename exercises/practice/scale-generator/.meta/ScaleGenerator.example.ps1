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
    [string] hidden $tonic
    [string[]] hidden $pitches
    [int] hidden $NOTES

    Scale([string] $tonic) {
        $this.tonic = $tonic
        $this.pitches = $this.GetPitches($tonic)
        $this.NOTES = 12
    }

    [string[]] Chromatic() {
        $tonicTitle = (Get-Culture).TextInfo.ToTitleCase($this.tonic)
        $tonicIndex = $this.pitches.IndexOf($tonicTitle)
        if ($tonicIndex) {
            return $this.pitches[$tonicIndex..$this.pitches.Length] + $this.pitches[0..($tonicIndex - 1)]
        }
        return $this.pitches
    }

    [string[]] Interval([string] $intervals) {
        $chromatic = $this.Chromatic()
        $invervalsValues = $this.GetInterval($intervals)

        $result = @()
        for ($i = 0; $i -lt $invervalsValues.Count; $i++) {
            $noteIndex = ($i + $invervalsValues[$i]) % $this.NOTES
            $result += $chromatic[$noteIndex]
        }
        return $result
    }

    [int] hidden IsSharp([string] $tonic) {
        <#
        Determine if a tonic starting a flar or sharp scale
        #>
        return @('G', 'D', 'A', 'E', 'B', 'F#', 'e', 'b', 'f#', 'c#', 'g#', 'd#', 'C', 'a') -ccontains $tonic
    }

    [string[]] hidden GetPitches([string] $tonic) {
        <#
        Returns the flat or sharp pitches based on the tonic
        #>
        if ($this.IsSharp($tonic)) {
            return @('A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#')
        }
        return @('A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab')
    }

    [int[]] hidden GetInterval([string] $intervals) {
        <#
        Return the numerical values of the intervals for the Diatonic Scales
        #>
        $count = 0
        $values = switch -CaseSensitive ($intervals.ToCharArray()) {
            'M' {$count++; $count}
            'A' {$count+=2; $count}
            Default {$count}
        }
        return @(0) + $values
    }
}