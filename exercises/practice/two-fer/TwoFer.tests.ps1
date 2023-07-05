BeforeAll {
    . ".\TwoFer.ps1"
}

Describe "Get-TwoFer Tests" {
    It "no name given"{
        Get-TwoFer | Should -BeExactly "One for you, one for me"
    }

    It "a name given"{
        Get-TwoFer -Name "Alice" | Should -BeExactly "One for Alice, one for me"
    }

    It "another name given"{
        Get-TwoFer -Name "Bob" | Should -BeExactly "One for Bob, one for me"
    }
}
