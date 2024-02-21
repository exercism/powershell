BeforeAll {
    . ".\PhoneNumber.ps1"
}

Describe "Phone Number Test Cases" {
    Context "Passing tests" {
        It "cleans the number" {
            $got = Get-PhoneNumber -Number '2234567890'
            $want = '2234567890'

            $got | Should -BeExactly $want
        }

        It "cleans numbers with dot" {
            $got = Get-PhoneNumber -Number '223.456.7890'
            $want = '2234567890'

            $got | Should -BeExactly $want
        }

        It "cleans numbers with multiple spaces" {
            $got = Get-PhoneNumber -Number ' 223 456   7890 '
            $want = '2234567890'

            $got | Should -BeExactly $want
        }

        It "cleans numbers with brackets and dash" {
            $got = Get-PhoneNumber -Number '(223)(456)-7890'
            $want = '2234567890'

            $got | Should -BeExactly $want
        }

        It "valid when 11 digits and starting with 1" {
            $got = Get-PhoneNumber -Number '12234567890'
            $want = '2234567890'

            $got | Should -BeExactly $want
        }

        It "valid when 11 digits and starting with 1 even with allowed punctuation" {
            $got = Get-PhoneNumber -Number '+1. (223) 456-7890'
            $want = '2234567890'

            $got | Should -BeExactly $want
        }

        It "clean number prettified" {
            $got = Get-PhoneNumber -Number '223-456-7890' -Pretty
            $want = '(223)-456-7890'

            $got | Should -BeExactly $want
        }

        It "valid 11 digits prettified" {
            $got = Get-PhoneNumber -Number '+1 (223) 456.7890' -Pretty
            $want = '(223)-456-7890'
            
            $got | Should -BeExactly $want
        }
    }

    Context "Invalid inputs" {
        It "invalid when 9 digits" {
            { Get-PhoneNumber -Number '223456789' } | Should -Throw "*Number can't be fewer than 10 digits*"
        }

        It "invalid when 11 digits does not start with a 1" {
            { Get-PhoneNumber -Number '+02234567890' } | Should -Throw "*11 digits must start with 1*"
        }

        It "invalid when more than 11 digits" {
            { Get-PhoneNumber -Number '123456789011' } | Should -Throw "*Number can't be more than 11 digits*"
        }

        It "invalid with letters" {
            { Get-PhoneNumber -Number 'tel-456-7890' } | Should -Throw "*Letters not permitted*"
        }

        It "invalid with punctuations" {
            { Get-PhoneNumber -Number '123-@:!-7890' } | Should -Throw "*Punctuations not permitted*"
        }

        It "invalid if area code starts with 0" {
            { Get-PhoneNumber -Number '(023) 456-7890' } | Should -Throw "*Area code can't start with 0*"
        }

        It "invalid if area code starts with 1" {
            { Get-PhoneNumber -Number '(123) 456-7890' } | Should -Throw "*Area code can't start with 1*"
        }

        It "invalid if exchange code starts with 0" {
            { Get-PhoneNumber -Number '223-056-7890' } | Should -Throw "*Exchange code can't start with 0*"
        }

        It "invalid if exchange code starts with 1" {
            {Get-PhoneNumber -Number '223-156-7890'} | Should -Throw "*Exchange code can't start with 1*"
        }

        It "invalid if area code starts with 0 on valid 11-digit number" {
            { Get-PhoneNumber -Number '+1 (023) 456-7890' } | Should -Throw "*Area code can't start with 0*"
        }

        It "invalid if area code starts with 1 on valid 11-digit number" {
            { Get-PhoneNumber -Number '+1 (123) 456-7890' } | Should -Throw "*Area code can't start with 1*"
        }

        It "invalid if exchange code starts with 0 on valid 11-digit number" {
            { Get-PhoneNumber -Number '+1 (223) 056-7890' } | Should -Throw "*Exchange code can't start with 0*"
        }

        It "invalid if exchange code starts with 1 on valid 11-digit number" {
            { Get-PhoneNumber -Number '+1 (223) 156-7890' } | Should -Throw "*Exchange code can't start with 1*"
        }
    }
}
