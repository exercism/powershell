BeforeAll {
    . ".\AllYourBase.ps1"
}

Describe "All your base test cases" {
    Context "passing tests" {
        It "single bit one to decimal" {
            $got  = Invoke-Rebase -Digits @(1) -InputBase 2 -OutputBase 10
            $want = @(1)

            $got | Should -BeExactly $want
        }
        
        It "binary to single decimal" {
            $got  = (Invoke-Rebase -Digits @(1,0,1) -InputBase 2 -OutputBase 10)
            $want = @(5)

            $got | Should -BeExactly $want
        }
        
        It "single decimal to binary" {
            $got  = (Invoke-Rebase -Digits @(5) -InputBase 10 -OutputBase 2)
            $want = @(1,0,1)

            $got | Should -BeExactly $want
        }
        
        It "binary to multiple decimal" {
            $got  = (Invoke-Rebase -Digits @(1, 0, 1, 0, 1, 0) -InputBase 2 -OutputBase 10)
            $want = @(4,2)

            $got | Should -BeExactly $want
        }
        
        It "decimal to binary" {
            $got  = (Invoke-Rebase -Digits @(4, 2) -InputBase 10 -OutputBase 2)
            $want = @(1,0,1,0,1,0)

            $got | Should -BeExactly $want
        }
        
        It "trinary to hexadecimal" {
            $got  = (Invoke-Rebase -Digits @(1, 1, 2, 0) -InputBase 3 -OutputBase 16)
            $want = @(2,10)

            $got | Should -BeExactly $want
        }
        
        It "hexadecimal to trinary" {
            $got  = (Invoke-Rebase -Digits @(2, 10) -InputBase 16 -OutputBase 3)
            $want = @(1,1,2,0)

            $got | Should -BeExactly $want
        }
        
        It "15-bit integer" {
            $got  = (Invoke-Rebase -Digits @(3, 46, 60) -InputBase 97 -OutputBase 73)
            $want = @(6,10,45)

            $got | Should -BeExactly $want
        }
        
        It "empty list" {
            $got  = (Invoke-Rebase -Digits @() -InputBase 2 -OutputBase 10)
            $want = @(0)

            $got | Should -BeExactly $want
        }
        
        It "single zero" {
            $got  = (Invoke-Rebase -Digits @(0) -InputBase 10 -OutputBase 2)
            $want = @(0)

            $got | Should -BeExactly $want
        }
        
        It "multiple zeros" {
            $got  = (Invoke-Rebase -Digits @(0, 0, 0, 0) -InputBase 10 -OutputBase 2)
            $want = @(0)

            $got | Should -BeExactly $want
        }
        
        It "leading zeros" {
            $got  = (Invoke-Rebase -Digits @(0, 6, 0) -InputBase 7 -OutputBase 10)
            $want = @(4,2)

            $got | Should -BeExactly $want
        }
    }

    Context "invalid inputs" {
        It "input base is one" {
            {Invoke-Rebase -Digits @(0) -InputBase 1 -OutputBase 10} | Should -Throw "input base must be >= 2"
        }
        
        It "input base is zero" {
            {Invoke-Rebase -Digits @() -InputBase 0 -OutputBase 10} | Should -Throw "input base must be >= 2"
        }
        
        It "input base is negative" {
            {Invoke-Rebase -Digits @(1) -InputBase -3 -OutputBase 10} | Should -Throw "input base must be >= 2"
        }
        
        It "negative digit" {
            {Invoke-Rebase -Digits @(1, 0 ,-1 ,0 , 1) -InputBase 3 -OutputBase 10} | Should -Throw "all digits must satisfy 0 <= digit < input base"
        }
        
        It "invalid positive digit" {
            {Invoke-Rebase -Digits @(1, 0, 2 ,1 ,0 , 1) -InputBase 2 -OutputBase 10} | Should -Throw "all digits must satisfy 0 <= digit < input base"
        }
        
        It "output base is one" {
            {Invoke-Rebase -Digits @(1) -InputBase 4 -OutputBase 1} | Should -Throw "output base must be >= 2"
        }
        
        It "output base is zero" {
            {Invoke-Rebase -Digits @(1) -InputBase 5 -OutputBase 0} | Should -Throw "output base must be >= 2"
        }
        
        It "output base is negative" {
            {Invoke-Rebase -Digits @(1) -InputBase 3 -OutputBase -7} | Should -Throw "output base must be >= 2"
        }
        
        It "both bases are negative" {
            {Invoke-Rebase -Digits @(1) -InputBase -2 -OutputBase -5} | Should -Throw "input base must be >= 2"
        }
    }
}