BeforeAll {
    . "./Say.ps1"
}

Describe "Say test cases" {
    It "zero" {
        $got  =  Invoke-Say -Number 0
        $want =  "zero"

        $got | Should -BeExactly $want
    }

    It "one" {
        $got  =  Invoke-Say -Number 1
        $want =  "one"

        $got | Should -BeExactly $want
    }

    It "fourteen" {
        $got  =  Invoke-Say -Number 14
        $want =  "fourteen"
    
        $got | Should -BeExactly $want
    }
    
    It "twenty" {
        $got  =  Invoke-Say -Number 20
        $want =  "twenty"
    
        $got | Should -BeExactly $want
    }
    
    It "twenty-two" {
        $got  =  Invoke-Say -Number 22
        $want =  "twenty-two"
    
        $got | Should -BeExactly $want
    }
    
    It "thirty" {
        $got  =  Invoke-Say -Number 30
        $want =  "thirty"
    
        $got | Should -BeExactly $want
    }
    
    It "ninety-nine" {
        $got  =  Invoke-Say -Number 99
        $want =  "ninety-nine"
    
        $got | Should -BeExactly $want
    }
    
    It "one hundred" {
        $got  =  Invoke-Say -Number 100
        $want =  "one hundred"
    
        $got | Should -BeExactly $want
    }
    
    It "one hundred twenty-three" {
        $got  =  Invoke-Say -Number 123
        $want =  "one hundred twenty-three"
    
        $got | Should -BeExactly $want
    }
    
    It "two hundred" {
        $got  =  Invoke-Say -Number 200
        $want =  "two hundred"
    
        $got | Should -BeExactly $want
    }
    
    It "nine hundred ninety-nine" {
        $got  =  Invoke-Say -Number 999
        $want =  "nine hundred ninety-nine"
    
        $got | Should -BeExactly $want
    }
    
    It "one thousand" {
        $got  =  Invoke-Say -Number 1000
        $want =  "one thousand"
    
        $got | Should -BeExactly $want
    }

    It "one thousand two hundred thirty-four" {
        $got  =  Invoke-Say -Number 1234
        $want =  "one thousand two hundred thirty-four"
    
        $got | Should -BeExactly $want
    }
    
    It "one million" {
        $got  =  Invoke-Say -Number 1000000
        $want =  "one million"
    
        $got | Should -BeExactly $want
    }
    
    It "one million two thousand three hundred forty-five" {
        $got  =  Invoke-Say -Number 1002345
        $want =  "one million two thousand three hundred forty-five"
    
        $got | Should -BeExactly $want
    }
    
    It "one billion" {
        $got  =  Invoke-Say -Number 1000000000
        $want =  "one billion"
    
        $got | Should -BeExactly $want
    }

    It "a big number" {
        $got  =  Invoke-Say -Number 987654321123
        $want =  "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three"
    
        $got | Should -BeExactly $want
    }

    It "numbers below zero are out of range" {
        {Invoke-Say -Number -1} | Should -Throw "*Cannot validate argument on parameter 'Number'*"
    }

    It "numbers above 999,999,999,999 are out of range" {
        {Invoke-Say -Number 1000000000000} | Should -Throw "*Cannot validate argument on parameter 'Number'*"
    }
}
