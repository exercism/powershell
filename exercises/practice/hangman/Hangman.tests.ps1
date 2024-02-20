BeforeAll {
    . "./Hangman.ps1"
}

#This test suite is mostly adapted from the python track
Describe "Hangman test cases" {
    It "test initially 9 failures are allowed" {
        $game = [Hangman]::new("test")

        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 9
    }

    It "test initially no letters are guessed" {
        $game = [Hangman]::new("test")

        $game.Display() | Should -BeExactly "____"
    }

    It "test after 10 failures the game is over" {
        $game = [Hangman]::new("test")

        for ($i = 0; $i -lt 10; $i++) {
            $game.Guess("x")
        }
        $game.GetStatus() | Should -BeExactly LOSE
        {$game.Guess("x")} | Should -Throw "*The game has already ended.*"
    }

    It "test feeding a correct letter removes underscores" {
        $game = [Hangman]::new("exercism")

        $game.Guess("e")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 9
        $game.Display() | Should -BeExactly "e_e_____"

        $game.Guess("i")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 9
        $game.Display() | Should -BeExactly "e_e__i__"
    }

    It "test feeding a correct letter twice counts as a failure" {
        $game = [Hangman]::new("test")

        $game.Guess("e")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 9
        $game.Display() | Should -BeExactly "_e__"

        $game.Guess("e")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 8
        $game.Display() | Should -BeExactly "_e__"
    }

    It "test getting all the letter right makes for a win" {
        $game = [Hangman]::new("hello")

        $game.Guess("a")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 8
        $game.Display() | Should -BeExactly "_____"

        $game.Guess("e")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 8
        $game.Display() | Should -BeExactly "_e___"

        $game.Guess("o")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 8
        $game.Display() | Should -BeExactly "_e__o"

        $game.Guess("l")
        $game.GetStatus() | Should -BeExactly ONGOING
        $game.RemainingGuesses | Should -Be 8
        $game.Display() | Should -BeExactly "_ello"

        $game.Guess("h")
        $game.GetStatus() | Should -BeExactly WIN
        $game.Display() | Should -BeExactly "hello"
        
        {$game.Guess("x")} | Should -Throw "*The game has already ended.*"
    }

    It "test winning on last guess still counts as a win" {
        $game = [Hangman]::new("zzzzz")
        foreach ($char in "abcdefghi".ToCharArray()) {
            $game.Guess($char)
        }
        $game.Guess("z")
        $game.RemainingGuesses | Should -BeExactly 0
        $game.GetStatus() | Should -BeExactly WIN
        $game.Display()   | Should -BeExactly "zzzzz"
    }
}
