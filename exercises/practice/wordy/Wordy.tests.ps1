BeforeAll {
    . "./Wordy.ps1"
}

Describe "Wordy test cases" {
    Context "valid prompt" {
        It "just a number" {
            $got  = Get-Answer -Question "What is 5?"
            $want = 5
    
            $got | Should -BeExactly $want
        }
    
        It "addition" {
            $got  = Get-Answer -Question "What is 1 plus 1?"
            $want = 2
    
            $got | Should -BeExactly $want
        }
    
        It "more addition" {
            $got  = Get-Answer -Question "What is 53 plus 2?"
            $want = 55
    
            $got | Should -BeExactly $want
        }
    
        It "addition with negative numbers" {
            $got  = Get-Answer -Question "What is -1 plus -10?"
            $want = -11
    
            $got | Should -BeExactly $want
        }
    
        It "large addition" {
            $got  = Get-Answer -Question "What is 123 plus 45678?"
            $want = 45801
    
            $got | Should -BeExactly $want
        }
    
        It "subtraction" {
            $got  = Get-Answer -Question "What is 4 minus -12?"
            $want = 16
    
            $got | Should -BeExactly $want
        }
    
        It "multiplication" {
            $got  = Get-Answer -Question "What is -3 multiplied by 25?"
            $want = -75
    
            $got | Should -BeExactly $want
        }
    
        It "division" {
            $got  = Get-Answer -Question "What is 33 divided by -3?"
            $want = -11
    
            $got | Should -BeExactly $want
        }
    
        It "multiple additions" {
            $got  = Get-Answer -Question "What is 1 plus 1 plus 1?"
            $want = 3
    
            $got | Should -BeExactly $want
        }
    
        It "addition and subtraction" {
            $got  = Get-Answer -Question "What is 1 plus 5 minus -2?"
            $want = 8
    
            $got | Should -BeExactly $want
        }
    
        It "multiple subtraction" {
            $got  = Get-Answer -Question "What is 20 minus 4 minus 13?"
            $want = 3
    
            $got | Should -BeExactly $want
        }
    
        It "subtraction then addition" {
            $got  = Get-Answer -Question "What is 17 minus 6 plus 3?"
            $want = 14
    
            $got | Should -BeExactly $want
        }
    
        It "multiple multiplication" {
            $got  = Get-Answer -Question "What is 2 multiplied by -2 multiplied by 3?"
            $want = -12
    
            $got | Should -BeExactly $want
        }
    
        It "addition and multiplication" {
            $got  = Get-Answer -Question "What is -3 plus 7 multiplied by -2?"
            $want = -8
    
            $got | Should -BeExactly $want
        }
    
        It "multiple division" {
            $got  = Get-Answer -Question "What is -12 divided by 2 divided by -3?"
            $want = 2
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "invalid question" {
        It "unknown operation" {
            {Get-Answer -Question "What is 52 cubed?"} | Should -Throw "*Unknown operation*"
        }
    
        It "Non math question" {
            {Get-Answer -Question "Who is the President of the United States?"} | Should -Throw "*Unknown operation*"
        }

        It "reject problem missing an operand" {
            {Get-Answer -Question "What is 1 plus?"} | Should -Throw "*Syntax Error*"
        }
    
        It "reject problem with no operands or operators" {
            {Get-Answer -Question "What is?"} | Should -Throw "*Syntax Error*"
        }
    
        It "reject two operations in a row" {
            {Get-Answer -Question "What is 1 plus plus 2?"} | Should -Throw "*Syntax Error*"
        }
    
        It "reject two numbers in a row" {
            {Get-Answer -Question "What is 1 plus 2 1?"} | Should -Throw "*Syntax Error*"
        }
    
        It "reject postfix notation" {
            {Get-Answer -Question "What is 1 2 plus?"} | Should -Throw "*Syntax Error*"
        }
    
        It "reject prefix notation" {
            {Get-Answer -Question "What is plus 1 2?"} | Should -Throw "*Syntax Error*"
        }

        It "reject missing operation" {
            {Get-Answer -Question "What is 2 2 minus 3?"} | Should -Throw "*Syntax Error*"
        }

        It "reject missing number" {
            {Get-Answer -Question "What is 7 plus multiplied by -2?"} | Should -Throw "*Syntax Error*"
        }
    }
}
