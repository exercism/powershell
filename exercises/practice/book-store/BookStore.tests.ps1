BeforeAll {
    . "./BookStore.ps1"
}

Describe "BookStore test cases" {
    It "Only a single book" {
        $got  = Get-Total -Books @(1)
        $want = 8

        $got | Should -BeLike $want
    }

    It "Two of the same book" {
        $got  = Get-Total -Books @(2, 2)
        $want = 16

        $got | Should -BeLike $want
    }

    It "Empty basket" {
        $got  = Get-Total -Books @()
        $want = 0

        $got | Should -BeLike $want
    }

    It "Two different books" {
        $got  = Get-Total -Books @(1, 2)
        $want = 15.2

        $got | Should -BeLike $want
    }

    It "Three different books" {
        $got  = Get-Total -Books @(1, 2, 3)
        $want = 21.6

        $got | Should -BeLike $want
    }

    It "Four different books" {
        $got  = Get-Total -Books @(1, 2, 3, 4)
        $want = 25.6

        $got | Should -BeLike $want
    }

    It "Five different books" {
        $got  = Get-Total -Books @(1, 2, 3, 4, 5)
        $want = 30

        $got | Should -BeLike $want
    }

    It "Two groups of four is cheaper than group of five plus group of three" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 3, 4, 5)
        $want = 51.2

        $got | Should -BeLike $want
    }

    It "Two groups of four is cheaper than groups of five and three" {
        $got  = Get-Total -Books @(1, 1, 2, 3, 4, 4, 5, 5)
        $want = 51.2

        $got | Should -BeLike $want
    }

    It "Group of four plus group of two is cheaper than two groups of three" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 4)
        $want = 40.8

        $got | Should -BeLike $want
    }

    It "Two each of first four books and one copy each of rest" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 3, 4, 4, 5)
        $want = 55.6

        $got | Should -BeLike $want
    }

    It "Two copies of each book" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 3, 4, 4, 5, 5)
        $want = 60

        $got | Should -BeLike $want
    }

    It "Three copies of first book and two each of remaining" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1)
        $want = 68

        $got | Should -BeLike $want
    }

    It "Three each of first two books and two each of remaining books" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 2)
        $want = 75.2

        $got | Should -BeLike $want
    }

    It "Four groups of four are cheaper than two groups each of five and three" {
        $got  = Get-Total -Books @(1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5)
        $want = 102.4

        $got | Should -BeLike $want
    }

    It "Check that groups of four are created properly even when there are more groups of three than groups of five" {
        $got  = Get-Total -Books @(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 5, 5)
        $want = 145.6

        $got | Should -BeLike $want
    }

    It "One group of one and four is cheaper than one group of two and three" {
        $got  = Get-Total -Books @(1, 1, 2, 3, 4)
        $want = 33.6

        $got | Should -BeLike $want
    }

    It "One group of one and two plus three groups of four is cheaper than one group of each size" {
        $got  = Get-Total -Books @(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5)
        $want = 100

        $got | Should -BeLike $want
    }

    # Extra tests from python track and parameter check for PowerShell
    It "two_groups_of_four_and_a_group_of_five" {
        $got  = Get-Total -Books @(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5)
        $want = 81.2

        $got | Should -BeLike $want
    }

    It "shuffled_book_order" {
        $got  = Get-Total -Books @(1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3)
        $want = 81.2

        $got | Should -BeLike $want
    }

    It "invalid book number for the series" {
        { Get-Total -Books @(0, 1, 2, 3, 4, 5, 6) } | Should -Throw "*Cannot validate argument on parameter 'Books'*"
    }

}