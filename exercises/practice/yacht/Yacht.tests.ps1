BeforeAll {
    . "./Yacht.ps1"
}

Describe "Yacht test cases" {
    It "Yacht" {
        $got  = Get-Score -Dice @(5, 5, 5, 5, 5) -Category YACHT
        $want = 50

        $got | Should -BeExactly $want
    }

    It "Not Yacht" {
        $got  = Get-Score -Dice @(1, 3, 3, 2, 5) -Category YACHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Ones" {
        $got  = Get-Score -Dice @(1, 1, 1, 3, 5) -Category ONES
        $want = 3

        $got | Should -BeExactly $want
    }

    It "Ones, out of order" {
        $got  = Get-Score -Dice @(3, 1, 1, 5, 1) -Category ONES
        $want = 3

        $got | Should -BeExactly $want
    }

    It "No ones" {
        $got  = Get-Score -Dice @(2, 3, 4, 5, 4) -Category ONES
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Twos" {
        $got  = Get-Score -Dice @(2, 3, 4, 5, 4) -Category TWOS
        $want = 2

        $got | Should -BeExactly $want
    }

    It "Fours" {
        $got  = Get-Score -Dice @(2, 3, 4, 5, 4) -Category FOURS
        $want = 8

        $got | Should -BeExactly $want
    }

    It "Yacht counted as threes" {
        $got  = Get-Score -Dice @(3, 3, 3, 3, 3) -Category THREES
        $want = 15

        $got | Should -BeExactly $want
    }

    It "Yacht of 3s counted as fives" {
        $got  = Get-Score -Dice @(3, 3, 3, 3, 3) -Category FIVES
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Fives" {
        $got  = Get-Score -Dice @(1, 3, 5, 6, 5) -Category FIVES
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Sixes" {
        $got  = Get-Score -Dice @(2, 6, 6, 6, 1) -Category SIXES
        $want = 18

        $got | Should -BeExactly $want
    }

    It "Full house two small, three big" {
        $got  = Get-Score -Dice @(2, 2, 4, 4, 4) -Category FULL_HOUSE
        $want = 16

        $got | Should -BeExactly $want
    }

    It "Full house three small, two big" {
        $got  = Get-Score -Dice @(5, 3, 3, 5, 3) -Category FULL_HOUSE
        $want = 19

        $got | Should -BeExactly $want
    }

    It "Two pair is not a full house" {
        $got  = Get-Score -Dice @(2, 2, 5, 5, 6) -Category FULL_HOUSE
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Four of a kind is not a full house" {
        $got  = Get-Score -Dice @(1, 4, 4, 4, 4) -Category FULL_HOUSE
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Yacht is not a full house" {
        $got  = Get-Score -Dice @(6, 6, 6, 6, 6) -Category FULL_HOUSE
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Four of a Kind" {
        $got  = Get-Score -Dice @(5, 5, 2, 5, 5) -Category FOUR_OF_A_KIND
        $want = 20

        $got | Should -BeExactly $want
    }

    It "Yacht can be scored as Four of a Kind" {
        $got  = Get-Score -Dice @(4, 4, 4, 4, 4) -Category FOUR_OF_A_KIND
        $want = 16

        $got | Should -BeExactly $want
    }

    It "Full house is not Four of a Kind" {
        $got  = Get-Score -Dice @(1, 2, 1, 2, 2) -Category FOUR_OF_A_KIND
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Little Straight" {
        $got  = Get-Score -Dice @(3, 2, 4, 1, 5) -Category LITTLE_STRAIGHT
        $want = 30

        $got | Should -BeExactly $want
    }

    It "Little Straight as Big Straight" {
        $got  = Get-Score -Dice @(1, 2, 3, 4, 5) -Category BIG_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Four in order but not a little straight" {
        $got  = Get-Score -Dice @(1, 1, 2, 3, 4) -Category LITTLE_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "No pairs but not a little straight" {
        $got  = Get-Score -Dice @(1, 2, 3, 4, 6) -Category LITTLE_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Minimum is 1, maximum is 5, but not a little straight" {
        $got  = Get-Score -Dice @(1, 1, 3, 4, 5) -Category LITTLE_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Big Straight" {
        $got  = Get-Score -Dice @(1, 2, 3, 4, 6) -Category BIG_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Big Straight as little straight" {
        $got  = Get-Score -Dice @(2, 3, 4, 5, 6) -Category LITTLE_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "No pairs but not a big straight" {
        $got  = Get-Score -Dice @(6, 3, 4, 5, 1) -Category BIG_STRAIGHT
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Choice" {
        $got  = Get-Score -Dice @(3, 3, 5, 6, 6) -Category CHOICE
        $want = 23

        $got | Should -BeExactly $want
    }

    It "Yacht as choice" {
        $got  = Get-Score -Dice @(4, 4, 4, 4, 4) -Category CHOICE
        $want = 20

        $got | Should -BeExactly $want
    }
}
