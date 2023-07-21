BeforeAll {
    . "./Grains.ps1"
}

Describe "Test Grains.ps1" {
    Context "Passing Tests" {
        It "grains on square 1" {
            $got = Get-GrainSquare -Number 1
            $want = 1
    
            $got | Should -BeExactly $want
        }

        It "grains on square 2" {
            $got = Get-GrainSquare -Number 2
            $want = 2
    
            $got | Should -BeExactly $want
        }

        It "grains on square 3" {
            $got = Get-GrainSquare -Number 3
            $want = 4
    
            $got | Should -BeExactly $want
        }

        It "grains on square 4" {
            $got = Get-GrainSquare -Number 4
            $want = 8
    
            $got | Should -BeExactly $want
        }

        It "grains on square 16" {
            $got = Get-GrainSquare -Number 16
            $want = 32768
    
            $got | Should -BeExactly $want
        }

        It "grains on square 32" {
            $got = Get-GrainSquare -Number 32
            $want = 2147483648
    
            $got | Should -BeExactly $want
        }

        It "grains on square 64" {
            $got = Get-GrainSquare -Number 64
            $want = 9223372036854775808
    
            $got | Should -BeExactly $want
        }

        It "returns the total number of grains on the board" {
            $got = Get-GrainTotal
            $want = 18446744073709551615
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "Invalid Inputs" {
        It "zero is an error" {
            { Get-GrainSquare -Number 0 } | Should -Throw "square must be between 1 and 64"
        }
    
        It "negative value is an error" {
            { Get-GrainSquare -Number -1 } | Should -Throw "square must be between 1 and 64"
        }

        It "exceeds maximum square" {
            { Get-GrainSquare -Number 65 } | Should -Throw "square must be between 1 and 64"
        }
    }
}
