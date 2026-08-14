BeforeAll {
    . "./SaveTheCow.ps1"
}

Describe "SaveTheCow test cases" {
    It "Initially 9 failures are allowed and no letters are guessed" {
        $game = [WordGame]::new("loot")

        $game.State | Should -BeExactly ONGOING
        $game.RemainingFailures | Should -Be 9
    }

    It "After 10 failures the game is over" {
        $game = [WordGame]::new("loot")
        $guesses = @("a","b","c","d","e","f","g","h","i","j")
        foreach ($letter in $guesses) {
            $game.Guess($letter)
        }

        $game.State | Should -BeExactly LOSE
        $game.Display() | Should -BeExactly "____"
        $game.RemainingFailures | Should -Be 0
    }

    It "Losing with several correct guesses" {
        $game = [WordGame]::new("loot")
        $guesses = @("t","o","a","b","c","d","e","f","g","h","i","j")
        foreach ($letter in $guesses) {
            $game.Guess($letter)
        }

        $game.State | Should -BeExactly LOSE
        $game.Display() | Should -BeExactly "_oot"
        $game.RemainingFailures | Should -Be 0
    }

    It "Feeding a correct letter removes underscores" {
        $game = [WordGame]::new("loot")
        $game.Guess("t")

        $game.State | Should -BeExactly ONGOING
        $game.Display() | Should -BeExactly "___t"
        $game.RemainingFailures | Should -Be 9
    }

    It "Feeding a correct letter twice counts as a failure" {
        $game = [WordGame]::new("loot")
        $game.Guess("t")
        $game.Guess("t")

        $game.State | Should -BeExactly ONGOING
        $game.Display() | Should -BeExactly "___t"
        $game.RemainingFailures | Should -Be 8
    }

    It "Guessing a repeated letter reveals all instances" {
        $game = [WordGame]::new("loot")
        $game.Guess("t")
        $game.Guess("t")
        $game.Guess("o")

        $game.State | Should -BeExactly ONGOING
        $game.Display() | Should -BeExactly "_oot"
        $game.RemainingFailures | Should -Be 8
    }

    It "Getting all the letters right makes for a win" {
        $game = [WordGame]::new("loot")
        $game.Guess("t")
        $game.Guess("t")
        $game.Guess("o")
        $game.Guess("l")

        $game.State | Should -BeExactly WIN
        $game.Display() | Should -BeExactly "loot"
        $game.RemainingFailures | Should -Be 8
    }

    It "Winning on the last guess is still a win" {
        $game = [WordGame]::new("loot")
        $guesses = @("a","b","c","d","e","f","g","h","i","t","o","l")
        foreach ($letter in $guesses) {
            $game.Guess($letter)
        }

        $game.State | Should -BeExactly WIN
        $game.Display() | Should -BeExactly "loot"
        $game.RemainingFailures | Should -Be 0
    }

    It "Guessing after a lose is error" {
        $game = [WordGame]::new("loot")
        $guesses = @("a","b","c","d","e","f","g","h","i","j")
        foreach ($letter in $guesses) {
            $game.Guess($letter)
        }
        {$game.Guess("k")} | Should -Throw "*Can't make further guess. Game is already finished : You LOSE*"
    }

    It "Guessing after a win is error" {
        $game = [WordGame]::new("loot")
        $game.Guess("t")
        $game.Guess("o")
        $game.Guess("l")
        {$game.Guess("l")} | Should -Throw "*Can't make further guess. Game is already finished : You WIN*"
    }
}
