BeforeAll {
    . "./EliudsEggs.ps1"
}

Describe "PopCount test cases" {
    It "0 eggs" {
        $got  = Invoke-Counter -Value 0
        $want = 0

        $got | Should -BeExactly $want
    }

    It "1 egg" {
        $got  = Invoke-Counter -Value 16
        $want = 1

        $got | Should -BeExactly $want
    }

    It "4 eggs" {
        $got  = Invoke-Counter -Value 89
        $want = 4

        $got | Should -BeExactly $want
    }

    It "13 eggs" {
        $got  = Invoke-Counter -Value 2000000000
        $want = 13

        $got | Should -BeExactly $want
    }
}
