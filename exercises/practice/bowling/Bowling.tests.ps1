BeforeAll {
    . "./Bowling.ps1"
    
    #utility function to start game
    Function Start-Bowling([int[]]$rolls) {
        $game = [BowlingGame]::new()
        foreach ($roll in $rolls) {
            $game.Roll($roll)
        }
        return $game
    }
}

Describe "Bowling test cases" {
    Context "can score valid games" {
        It "should be able to score a game with all zeros" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 0
        }
    
        It "should be able to score a game with no strikes or spares" {
            $rolls = @(3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 90
        }
    
        It "a spare followed by zeros is worth ten points" {
            $rolls = @(6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 10
        }
    
        It "points scored in the roll after a spare are counted twice" {
            $rolls = @(6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 16
        }
    
        It "consecutive spares each get a one roll bonus" {
            $rolls = @(5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 31
        }
    
        It "a spare in the last frame gets a one roll bonus that is counted once" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 17
        }
    
        It "a strike earns ten points in a frame with a single roll" {
            $rolls = @(10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 10
        }
    
        It "points scored in the two rolls after a strike are counted twice as a bonus" {
            $rolls = @(10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 26
        }
    
        It "consecutive strikes each get the two roll bonus" {
            $rolls = @(10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 81
        }
    
        It "a strike in the last frame gets a two roll bonus that is counted once" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 18
        }
    
        It "rolling a spare with the two roll bonus does not get a bonus roll" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 20
        }
    
        It "strikes with the two roll bonus do not get bonus rolls" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 30
        }
    
        It "last two strikes followed by only last bonus with non strike points" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 31
        }
    
        It "a strike with the one roll bonus after a spare in the last frame does not get a bonus" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 20
        }
    
        It "all strikes is a perfect game" {
            $rolls = @(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 300
        }
            
        It "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6)
            $got = Start-Bowling($rolls)
    
            $got.Score() | Should -BeExactly 26
        }
    }
    
    Context "invalid inputs" {
        It "rolls cannot score negative points" {
            $got = [BowlingGame]::new()
            {$got.Roll(-1)} | Should -Throw
        }

        It "a roll cannot score more than 10 points" {
            $got = [BowlingGame]::new()
            {$got.Roll(11)} | Should -Throw
        }
    
        It "two rolls in a frame cannot score more than 10 points" {
            $rolls = @(5)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(6)} | Should -Throw
        }
    
        It "bonus roll after a strike in the last frame cannot score more than 10 points" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(11)} | Should -Throw
        }
    
        It "two bonus rolls after a strike in the last frame cannot score more than 10 points" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(6)} | Should -Throw
        }

    
        It "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(10)} | Should -Throw
        }
    
        It "second bonus roll after a strike in the last frame cannot score more than 10 points" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(11)} | Should -Throw
        }
    
        It "an unstarted game cannot be scored" {
            $rolls = @()
            $got = Start-Bowling($rolls)
    
            {$got.Score()} | Should -Throw
        }
    
        It "an incomplete game cannot be scored" {
            $rolls = @(0, 0)
            $got = Start-Bowling($rolls)
    
            {$got.Score()} | Should -Throw
        }
    
        It "cannot roll if game already has ten frames" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(0)} | Should -Throw
        }
    
        It "bonus rolls for a strike in the last frame must be rolled before score can be calculated" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10)
            $got = Start-Bowling($rolls)
    
            {$got.Score()} | Should -Throw
        }
    
        It "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10)
            $got = Start-Bowling($rolls)
    
            {$got.Score()} | Should -Throw
        }
    
        It "bonus roll for a spare in the last frame must be rolled before score can be calculated" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3)
            $got = Start-Bowling($rolls)
    
            {$got.Score()} | Should -Throw
        }
    
        It "cannot roll after bonus roll for spare" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(2)} | Should -Throw
        }
    
        It "cannot roll after bonus rolls for strike" {
            $rolls = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2)
            $got = Start-Bowling($rolls)
    
            {$got.Roll(2)} | Should -Throw
        }
    }
}
