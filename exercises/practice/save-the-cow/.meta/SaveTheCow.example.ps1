<#
.SYNOPSIS
    Implement the logic for a word-guessing game.
.DESCRIPTION
    Implement the logic and functionalities of a word-guessing game.
    The game has 3 states: WIN, LOSE and ONGOING.
    You are allowed to fail 9 times.
    Incorrect guess and repeating guess will decrease the remaining failures by 1.
    You win when you correctly guess the word.
#>

Enum Status {
    WIN
    LOSE
    ONGOING
}

Class WordGame {
    [int] $RemainingFailures
    [Status] $State
    [char[]] hidden $Masked
    [char[]] $Secret

    WordGame([string] $word) {
        $this.RemainingFailures = 9
        $this.Secret = $word
        $this.Masked = @("_") * $word.Length
        $this.State = [Status]::ONGOING
    }

    [void] Guess([char]$letter) {
        if ($this.State -ne [Status]::ONGOING) {
            Throw "*Can't make further guess. Game is already finished : YOU $($this.State)*"
        }

        if ($this.Secret -contains $letter -and $this.Masked -notcontains $letter) {
            for ($i = 0; $i -lt $this.Secret.Count; $i++) {
                if($this.Secret[$i] -eq $letter){
                    $this.Masked[$i] = $letter
                }
            }
            if ($this.Masked -notcontains "_") {
                $this.State = [Status]::WIN
            }
        } else { #fail
            if ($this.RemainingFailures -eq 0) {
                $this.State = [Status]::LOSE
            }else {
                $this.RemainingFailures--
            }
        }
    }

    [string] Display() {
        return -join $this.Masked
    }
}
