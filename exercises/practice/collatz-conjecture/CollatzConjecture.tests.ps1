BeforeAll {
    . "./CollatzConjecture.ps1"
}

Describe "Test Invoke-CollatzConjecture.ps1" {
    Context "Passing Tests" {

        It "zero steps for one" {
            $got = Invoke-CollatzConjecture -Number 1
            $want = 0
    
            $got | Should -BeExactly $want
        }
    
        It "divide if even" {
            $got = Invoke-CollatzConjecture -Number 16
            $want = 4
    
            $got | Should -BeExactly $want
        }
    
        It "even and odd steps" {
            $got = Invoke-CollatzConjecture -Number 12
            $want = 9
    
            $got | Should -BeExactly $want
        }
        
        It "large number of even and odd steps" {
            $got = Invoke-CollatzConjecture -Number 1000000
            $want = 152
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "Invalid Inputs" {
        It "zero is an error" {
            { Invoke-CollatzConjecture -Number 0 } | Should -Throw "*error: Only positive numbers are allowed*"
        }
    
        It "negative value is an error" {
            { Invoke-CollatzConjecture -Number -15 } | Should -Throw "*error: Only positive numbers are allowed*"
        }
    }
}
