BeforeAll {
    . "./Dominoes.ps1"
}

Describe "Dominoes test cases" {
    It "empty input = empty output" {
        $got = Test-DominoesChain -Dominoes @( )

        $got | Should -BeTrue
    }

    It "singleton input = singleton output" {
        $got = Test-DominoesChain -Dominoes @( ,@(1, 1) )
        
        $got | Should -BeTrue
    }

    It "singleton that can't be chained" {
        $got = Test-DominoesChain -Dominoes @( ,@(1, 2) )
        
        $got | Should -BeFalse
    }

    It "three elements" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(3, 1), @(2, 3) )
        
        $got | Should -BeTrue
    }

    It "can reverse dominoes" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(1, 3), @(2, 3) )
        
        $got | Should -BeTrue
    }

    It "can't be chained" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(4, 1), @(2, 3) )
        
        $got | Should -BeFalse
    }

    It "disconnected - simple" {
        $got = Test-DominoesChain -Dominoes @( @(1, 1), @(2, 2) )
        
        $got | Should -BeFalse
    }

    It "disconnected - double loop" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(2, 1), @(3, 4), @(4, 3) )
        
        $got | Should -BeFalse
    }

    It "disconnected - single isolated" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(2, 3), @(3, 1), @(4, 4) )
        
        $got | Should -BeFalse
    }

    It "need backtrack" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(2, 3), @(3, 1), @(2, 4), @(2, 4) )
        
        $got | Should -BeTrue
    }

    It "separate loops" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(2, 3), @(3, 1), @(1, 1), @(2, 2), @(3, 3) )
        
        $got | Should -BeTrue
    }

    It "nine elements" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(5, 3), @(3, 1), @(1, 2), @(2, 4), @(1, 6), @(2,3), @(3, 4), @(5, 6) )
        
        $got | Should -BeTrue
    }

    It "separate three-domino loops" {
        $got = Test-DominoesChain -Dominoes @( @(1, 2), @(2, 3), @(3, 1), @(4, 5), @(5, 6), @(6, 4) )
        
        $got | Should -BeFalse
    }
}
