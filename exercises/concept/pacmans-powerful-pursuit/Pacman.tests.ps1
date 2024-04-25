BeforeAll {
    . "./Pacman.ps1"
}

Describe "Test Pac-Man Game Rules" {
    Context "Task 0" {
        It "the power is on" {
            (Get-Variable -Name "PowerOn").Value | Should -BeTrue
        }
    }

    Context "Task 1" {
        It "ghost got eaten" {
            $got = EatGhost -ActivePower $true -TouchingGhost $true
            $got | Should -BeTrue
        }

        It "ghost does not get eaten because no power pellet active" {
            $got = EatGhost -ActivePower $false -TouchingGhost $true
            $got | Should -BeFalse
        }

        It "ghost does not get eaten because not touching ghost" {
            $got = EatGhost -ActivePower $true -TouchingGhost $false
            $got | Should -BeFalse
        }

        It "ghost does not get eaten because not touching ghost and not having pellet" {
            $got = EatGhost -ActivePower $false -TouchingGhost $false
            $got | Should -BeFalse
        }
    }

    Context "Task 2" {
        It "score when eating dot" {
            $got = Score -TouchPowerPellet $false -TouchDot $true
            $got | Should -BeTrue
        }

        It "score when eating power pellet" {
            $got = Score -TouchPowerPellet $true -TouchDot $false
            $got | Should -BeTrue
        }

        It "no score when nothing eaten" {
            $got = Score -TouchPowerPellet $false -TouchDot $false
            $got | Should -BeFalse
        }
    }

    Context "Task 3" {
        It "lose if touching a ghost without a power pellet active" {
            $got = Lose -ActivePower $false -TouchingGhost $true
            $got | Should -BeTrue
        }

        It "dont lose if touching a ghost with a power pellet active" {
            $got = Lose -ActivePower $true -TouchingGhost $true
            $got | Should -BeFalse
        }

        It "dont lose if not touching a ghost" {
            $got = Lose -ActivePower $true -TouchingGhost $false
            $got | Should -BeFalse
        }
    }

    Context "Task 4" {
        It "win if all dots eaten" {
            $got = Win -EatenAllDots $true -ActivePower $false -TouchingGhost $false
            $got | Should -BeTrue
        }

        It "win if all dots eaten and touching a ghost with a power pellet active" {
            $got = Win -EatenAllDots $true -ActivePower $true -TouchingGhost $true
            $got | Should -BeTrue
        }

        It "dont win if not all dots eaten" {
            $got = Win -EatenAllDots $false -ActivePower $true -TouchingGhost $true
            $got | Should -BeFalse
        }

        It "dont win if all dots eaten but touching a ghost" {
            $got = Win -EatenAllDots $true -ActivePower $false -TouchingGhost $true
            $got | Should -BeFalse
        }
    }

    Context "Task 5" {
        It "function has Synopsis for comment-base help with minimum len of 10" {
            $got = (Get-Help -Name "Win").Synopsis
            $got.Length | Should -BeGreaterOrEqual 10 -Because "Synopsis need to be at minimum 10 chars"
        }
    }
}
