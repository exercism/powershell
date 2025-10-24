using namespace System.Collections.Generic

function Get-NewState([int]$col, [int]$carry, [int[]]$assignments, [int]$used) {
    [PSCustomObject]@{
        ColIdx     = $col
        Carry      = $carry
        Assignment = $assignments
        Used       = $used
    }
}

function Invoke-Alphametics {
    <#
    .SYNOPSIS
    Implement a solver for alphametic puzzles.

    .PARAMETER Puzzle
    The string represent the puzzle.

    .NOTES
    This solution is not optimized enough for the biggest test.
    #>
    [CmdletBinding()]
    Param(
        [string] $Puzzle
    )
    #Parse the puzzle: addens and sum
    $Words = -split $Puzzle -match "\w"
    $addens, $sum = $Words[0..($Words.Count-2)], $Words[-1]
    $maxLen = $sum.Length
    
    if ($addens | Where-Object { $_.Length -gt $maxLen }) { return $null }
    # Extract unique letters and index them
    $Letters =  $Puzzle -split "" -match "[A-Z]" | Select-Object -Unique
    
    # getting leading letter and they cant be zero
    $isLeading = [bool[]]::new($Letters.Count)
    foreach ($word in $Words) {
        $index = $Letters.IndexOf($word[0])
        $isLeading[$index] = $true
    }
    # build the grid or array of column
    $paddedWords = $Words | ForEach-Object {$_.PadLeft($maxLen, ' ')}
    $paddedaddens = $paddedWords | Select-Object -First ($Words.Count - 1)
    $paddedsum = $paddedWords | Select-Object -Last 1

    $columns = @()
    for ($c = 0; $c -lt $maxLen; $c++) {
        $newColumn = [PSCustomObject]@{
            Addens = @()
            Result = -1
        }
        foreach ($word in $paddedaddens) {
            $letter = $word[$maxLen - 1 - $c]
            $newColumn.Addens += $letter -ne ' ' ? $Letters.IndexOf($letter) : @()
        }
        $newColumn.Result = $Letters.IndexOf($paddedsum[$maxLen - 1 - $c])
        $columns+= $newColumn
    }

    $Letters | ForEach-Object {$allowed = [ordered]@{}} {$allowed[$_] = $isLeading[$Letters.IndexOf($_)] ? (1..9) : (0..9)}
    ### SOLVING
    [int[]]$assignments = @(1..$Letters.Count).ForEach({-1})
    $usedBit = 0x400
    $stack = [Stack[PSCustomObject]]::new()
    $state = Get-NewState 0 0 $assignments $usedBit
    $stack.Push($state)

    while ($stack.Count -gt 0) {
        $state = $stack.Pop()
        # Base case: past last column return result
        if ($state.ColIdx -ge $maxLen) {
            return 0..($state.Assignment.Count - 1) | ForEach-Object -Begin {$result = [ordered]@{}} -Process {
                $result[$Letters[$_]] = $state.Assignment[$_] } -End {$result}
        }
        $col = $columns[$state.ColIdx]
        # Find the first unassigned letter in this column
        $unassigned = $col.Addens | Where-Object { $state.Assignment[$_] -eq -1 }

        if ($unassigned.Count -eq 0) {
            # All addens letters in this column are assigned → calculate sum
            $totalSum = ($col.Addens | ForEach-Object {$state.Assignment[$_]} | Measure-Object -Sum).Sum
            $resultDigit = ($totalSum + $state.Carry) % 10
            $newCarry = [math]::Floor(($totalSum + $state.Carry) / 10)

            if ($state.Assignment[$col.Result] -eq -1) { #Sum digit not assigned yet. assign and move to new col
                if ( (($state.Used -band (1 -shl $resultDigit)) -ne 0) -or $resultDigit -notin $allowed[$col.Result]) { continue }
                $newState = Get-NewState ($state.ColIdx + 1) $newCarry $state.Assignment.Clone() ($state.Used -bor (1 -shl $resultDigit))
                $newState.Assignment[$col.Result] = $resultDigit
                $stack.Push($newState)
            } else { # Sum digit already assigned → check consistency 
                if ($state.Assignment[$col.Result] -eq $resultDigit) {
                    $newState = Get-NewState ($state.ColIdx + 1) $newCarry $state.Assignment.Clone() ($state.Used -bor (1 -shl $resultDigit))
                    $stack.Push($newState)
                }
            }
        } else { #still unassigned letter(s)
            $firstUnassigned = $unassigned[0]
            $possibleValues = $allowed[$Letters[$firstUnassigned]] | Where-Object {($state.Used -band (1 -shl $_)) -eq 0 }
            foreach ($value in $possibleValues) {
                $newState = Get-NewState $state.ColIdx $state.Carry $state.Assignment.Clone() ($state.Used -bor (1 -shl $value))
                $newState.Assignment[$firstUnassigned] = $value
                $stack.Push($newState)
            }
        }
    }
}
