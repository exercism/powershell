BeforeAll {
    . ".\Sublist.ps1"
}

Describe "Sublist test cases" {
    It "empty lists" {
        $got = Invoke-Sublist -Data1 @() -Data2 @()
        $want = [Sublist]::EQUAL

        $got | Should -Be $want
    }

    It "empty list within non-empty list" {
        $got = Invoke-Sublist -Data1 @() -Data2 @(1, 2, 3)
        $want = [Sublist]::SUBLIST

        $got | Should -Be $want
    }

    It "non-empty list contains empty list" {
        $got = Invoke-Sublist -Data1 @(1, 2, 3) -Data2 @()
        $want = [Sublist]::SUPERLIST

        $got | Should -Be $want
    }

    It "list equals itself" {
        $got = Invoke-Sublist -Data1 @(1, 2, 3) -Data2 @(1, 2, 3)
        $want = [Sublist]::EQUAL

        $got | Should -Be $want
    }

    It "different lists" {
        $got = Invoke-Sublist -Data1 @(1, 2, 3) -Data2 @(2, 3, 4)
        $want = [Sublist]::UNEQUAL

        $got | Should -Be $want
    }

    It "false start" {
        $got = Invoke-Sublist -Data1 @(1, 2, 5) -Data2 @(0, 1, 2, 3, 1, 2, 5, 6)
        $want = [Sublist]::SUBLIST

        $got | Should -Be $want
    }

    It "consecutive" {
        $got = Invoke-Sublist -Data1 @(1, 1, 2) -Data2 @(0, 1, 1, 1, 2, 1, 2)
        $want = [Sublist]::SUBLIST

        $got | Should -Be $want
    }

    It "sublist at start" {
        $got = Invoke-Sublist -Data1 @(0, 1, 2) -Data2 @(0, 1, 2, 3, 4, 5)
        $want = [Sublist]::SUBLIST

        $got | Should -Be $want
    }

    It "sublist in middle" {
        $got = Invoke-Sublist -Data1 @(2, 3, 4) -Data2 @(0, 1, 2, 3, 4, 5)
        $want = [Sublist]::SUBLIST

        $got | Should -Be $want
    }

    It "sublist at end" {
        $got = Invoke-Sublist -Data1 @(3, 4, 5) -Data2 @(0, 1, 2, 3, 4, 5)
        $want = [Sublist]::SUBLIST

        $got | Should -Be $want
    }

    It "at start of superlist" {
        $got = Invoke-Sublist -Data1 @(0, 1, 2, 3, 4, 5) -Data2 @(0, 1, 2)
        $want = [Sublist]::SUPERLIST

        $got | Should -Be $want
    }

    It "in middle of superlist" {
        $got = Invoke-Sublist -Data1 @(0, 1, 2, 3, 4, 5) -Data2 @(2, 3)
        $want = [Sublist]::SUPERLIST

        $got | Should -Be $want
    }

    It "at end of superlist" {
        $got = Invoke-Sublist -Data1 @(0, 1, 2, 3, 4, 5) -Data2 @(3, 4, 5)
        $want = [Sublist]::SUPERLIST

        $got | Should -Be $want
    }

    It "first list missing element from second list" {
        $got = Invoke-Sublist -Data1 @(1, 3) -Data2 @(1, 2, 3)
        $want = [Sublist]::UNEQUAL

        $got | Should -Be $want
    }

    It "second list missing element from first list" {
        $got = Invoke-Sublist -Data1 @(1, 2, 3) -Data2 @(1, 3)
        $want = [Sublist]::UNEQUAL

        $got | Should -Be $want
    }

    It "first list missing additional digits from second list" {
        $got = Invoke-Sublist -Data1 @(1, 2) -Data2 @(1, 22)
        $want = [Sublist]::UNEQUAL

        $got | Should -Be $want
    }

    It "order matters to a list" {
        $got = Invoke-Sublist -Data1 @(1, 2, 3) -Data2 @(3, 2, 1)
        $want = [Sublist]::UNEQUAL

        $got | Should -Be $want
    }

    It "same digits but different numbers" {
        $got = Invoke-Sublist -Data1 @(1, 0, 1) -Data2 @(10, 1)
        $want = [Sublist]::UNEQUAL
        
        $got | Should -Be $want
    }

    It "work with letters" {
        $got = Invoke-Sublist -Data1 @('A'..'Z') -Data2 @('A'..'z')
        $want = [Sublist]::SUBLIST
        
        $got | Should -Be $want
    }

    It "string with inner space" {
        $got = Invoke-Sublist -Data1 @("a c") -Data2 @("a", "c")
        $want = [Sublist]::UNEQUAL
        
        $got | Should -Be $want
    }

    It "large list" {
        $got = Invoke-Sublist -Data1 @(1..10000) -Data2 @(10..5000)
        $want = [Sublist]::SUPERLIST
        
        $got | Should -Be $want
    }
}