<#
.SYNOPSIS
    Implement a class to score a bowling game.

.DESCRIPTION
    For the detailed rules of the game, check instructions.

    Write code to keep track of the score of a game of bowling.
    It should support two operations:

    - roll(pins): is called each time the player rolls a ball.
    The argument is an integer represent the number of pins got knocked down (0 - 10)

    - score(): is called only at the very end of the game.
    It returns an integer represent the total score for that game.

    The class also should handle various cases of errors based on invalid or illegal inputs.
    You can decide what error message you want to throw.
    
.EXAMPLE
    $rolls = @(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
    $game = [BowlingGame]::new()

    foreach ($roll in $rolls) {
        $game.Roll($roll)
    }
    $game.Score()
    Returns: 300
#>
Class Frame {
    [int]   $Number
    [int[]] $Throws
    [int]   $Score
    [Frame] $Next

    Frame([int]$number) {
        $this.Number = $number
        $this.Throws = @()
        $this.Score  = 0
        $this.Next   = $null
    }

    [void] Update([int]$pins) {
        <#
        .DESCRIPTION
        Function to update the frame with new pins, and handle error if the pin invalid the frame
        #>
        $this.Throws += $pins
        $this.Score  += $pins

        if ($this.Throws.Count -eq 3) {
            $sum = $this.Throws[1] + $this.Throws[2]
            if ($this.Throws[0] -eq 10 -and $this.Throws[1] -lt 10 -and $sum -gt 10) {
                Throw "Two rolls in bonus spare can't be more than 10 points"
            }
        }else {
            if ($this.Score -gt 10 -and $this.Throws[0] -lt 10) {
                Throw "Two rolls in a spare can't be more than 10 points"
            }
        }
    }

    #boolean logic to handle frame
    [bool] IsStrike() {
        return $this.Score -eq 10 -and $this.Throws.Count -eq 1
    }

    [bool] IsSpare() {
        return $this.Score -eq 10 -and $this.Throws.Count -eq 2
    }

    [bool] IsComplete() {
        if ($this.Number -eq 10) {
            return ($this.Score -lt 10 -and $this.Throws.Count -eq 2) -or ($this.Throws.Count -eq 3)
        }
        return $this.IsStrike() -or $this.Throws.Count -eq 2
    }
}

Class BowlingGame {
    [Frame] hidden $Head
    [Frame] hidden $CurrentFrame

    BowlingGame() {
        $this.CurrentFrame = $null
        $this.Head = $null
    }

    [void] Roll([int]$pins) {
        if ($pins -lt 0 -or $pins -gt 10) {Throw "Invalid number of pin"}

        if ($null -eq $this.Head) {
            $this.CurrentFrame = [Frame]::new(1)
            $this.Head = $this.CurrentFrame
        }

        if ($this.CurrentFrame.IsComplete()) {
            if ($this.CurrentFrame.Number -eq 10) {Throw "Game's finished. Can't make any more roll"}
            $this.CurrentFrame.Next = [Frame]::new($this.CurrentFrame.Number + 1)
            $this.CurrentFrame = $this.CurrentFrame.Next
        }
        $this.CurrentFrame.Update($pins)
    }

    [int] Score() {
        if ($null -eq $this.Head) {
            Throw "Can't score game that hasn't started" 
        }

        if ($this.CurrentFrame.Number -lt 10 -or (-not $this.CurrentFrame.IsComplete())) {
            Throw "Can't score incomplete game" 
        }

        $total = 0
        while ($this.Head) {
            $total += $this.Head.Score
            $nextThrows = $this.Head.Next.Throws + $this.Head.Next.Next.Throws
            if ($this.Head.IsSpare()) {
                $total += $nextThrows[0]
            }elseif ($this.Head.IsStrike()) {
                $total += $nextThrows[0] + $nextThrows[1]
            }
            $this.Head = $this.Head.Next
        }
        return $total
    }
}