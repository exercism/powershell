<#
.SYNOPSIS
    Stimulate a game of hangman.
.DESCRIPTION
    Implement the logic and functionalities of a hangman game.
    The game started with 9 remaining guesses.
    Each incorrect guess will decrease the remaining guesses by 1.
    The game has 3 states: WIN, LOSE and ONGOING.
    You win when you correctly guess the word.
    You lose when you spent all of your guesses.
.EXAMPLE
    $game = [Hangman]::new("welcome")

    $game.RemainingGuesses
    Returns: 9
    $game.Display()
    Returns: "_______"

    $game.Guess("e")
    $game.Display()
    Returns: "_e____e"

    $game.Guess("z")
    $game.RemainingGuesses
    Returns: 8
#>


Enum Status {
    WIN
    LOSE
    ONGOING
}

Class Hangman {
    [int] $RemainingGuesses
    [Status] $Status
    [char[]] hidden $Masked
    [char[]] $Secret

    Hangman([string] $word) {
        $this.RemainingGuesses  = 9
        $this.Secret = $word
        $this.Masked = @("_") * $word.Length
        $this.Status = [Status]::ONGOING
    }

    [void] Guess($char) {
        if ($this.GetStatus() -ne [Status]::ONGOING) {
            Throw "The game has already ended."
        }
        if ($char -notin $this.Secret -or $char -in $this.Masked){
            $this.RemainingGuesses--
        }else{
            for ($i = 0; $i -lt $this.Secret.Count; $i++) {
                if($this.Secret[$i] -eq $char){
                    $this.Masked[$i] = $char
                }
            }
        }
    }

    [string] Display() {
        return -join $this.Masked
    }

    [Status] GetStatus() {
        if ($this.Masked -notcontains "_") {
            return [Status]::WIN
        }elseif ($this.RemainingGuesses -lt 0) {
            return [Status]::LOSE
        }
        return [Status]::ONGOING
    }
}