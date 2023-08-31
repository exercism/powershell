BeforeAll {
    . "./SecretHandshake.ps1"
}

Describe "SecretHandshake test cases" {
    It "wink for 1" {
        $got  =  Invoke-SecretHandshake -Number 1
        $want =  @("wink")

        $got | Should -BeExactly $want
    }

    It "double blink for 10" {
        $got  =  Invoke-SecretHandshake -Number 2
        $want =  @("double blink")

        $got | Should -BeExactly $want
    }

    It "close your eyes for 100" {
        $got  =  Invoke-SecretHandshake -Number 4
        $want =  @("close your eyes")

        $got | Should -BeExactly $want
    }

    It "jump for 1000" {
        $got  =  Invoke-SecretHandshake -Number 8
        $want =  @("jump")

        $got | Should -BeExactly $want
    }

    It "combine two actions" {
        $got  =  Invoke-SecretHandshake -Number 3
        $want =  @("wink", "double blink")

        $got | Should -BeExactly $want
    }

    It "reverse two actions" {
        $got  =  Invoke-SecretHandshake -Number 19
        $want =  @("double blink", "wink")

        $got | Should -BeExactly $want
    }

    It "reversing one action gives the same action" {
        $got  =  Invoke-SecretHandshake -Number 24
        $want =  @("jump")

        $got | Should -BeExactly $want
    }

    It "reversing no actions still gives no actions" {
        $got  =  Invoke-SecretHandshake -Number 16
        $want =  @()

        $got | Should -BeExactly $want
    }

    It "all possible actions" {
        $got  =  Invoke-SecretHandshake -Number 15
        $want =  @("wink", "double blink", "close your eyes", "jump")

        $got | Should -BeExactly $want
    }

    It "reverse all possible actions" {
        $got  =  Invoke-SecretHandshake -Number 31
        $want =  @("jump", "close your eyes", "double blink", "wink")

        $got | Should -BeExactly $want
    }

    It "do nothing for zero" {
        $got  =  Invoke-SecretHandshake -Number 0
        $want =  @()

        $got | Should -BeExactly $want
    }

}
