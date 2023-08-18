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
    [hashtable]$myGarden

    Garden([string]$diagram) {
        $students  = @('Alice','Bob','Charlie','David','Eve','Fred','Ginny',
                            'Harriet','Ileana','Joseph','Kincaid','Larry')
        $this.myGarden = $this.MakeGarden($diagram, $students)
    }

    Garden([string]$diagram, [string[]]$students) {
        $sortedStudents = $students | Sort-Object
        $this.myGarden = $this.MakeGarden($diagram, $sortedStudents)
    }

    [hashtable] MakeGarden([string]$diagram, [string[]]$students) {
        $tempGarden = @{}
        $topRow, $botRow = $diagram -split "`n"

        for ($i = 0; $i -lt $students.Count; $i++) {
            $plantsArray = $topRow[($i*2)..($i*2+1)] + $botRow[($i*2)..($i*2+1)]
            $tempGarden.Add($students[$i], $plantsArray)
        }
        return $tempGarden
    }

    [string[]] GetPlants([string]$student) {
        $plants = $this.myGarden.$student | ForEach-Object {
            switch ($_) {
                'C' { 'Clover' }
                'G' { 'Grass' }
                'V' { 'Violets' }
                'R' { 'Radishes' }
            }
        }
        return $plants
    }
}