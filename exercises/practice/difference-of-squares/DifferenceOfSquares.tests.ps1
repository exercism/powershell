BeforeAll {
    . "./DifferenceOfSquares.ps1"
}

Describe "Test difference-of-squares" {
    Context "Get-SquareOfSum" {

        It "square of sum 1" {
            $got =  Get-SquareOfSum -Number 1
            $want = 1
    
            $got | Should -BeExactly $want
        }

        It "square of sum 5" {
            $got =  Get-SquareOfSum -Number 5
            $want = 225
    
            $got | Should -BeExactly $want
        }

        It "square of sum 100" {
            $got =  Get-SquareOfSum -Number 100
            $want = 25502500
    
            $got | Should -BeExactly $want
        }
    }

    Context "Get-SumOfSquares"{
        It "sum of squares 1" {
            $got =  Get-SumOfSquares -Number 1
            $want = 1
    
            $got | Should -BeExactly $want
        }

        It "sum of squares 5" {
            $got =  Get-SumOfSquares -Number 5
            $want = 55
    
            $got | Should -BeExactly $want
        }

        It "sum of squares 100" {
            $got =  Get-SumOfSquares -Number 100
            $want = 338350
    
            $got | Should -BeExactly $want
        }
    }

    Context "Get-DifferenceOfSquares"{
        It "difference of squares 1" {
            $got =  Get-DifferenceOfSquares -Number 1
            $want = 0
    
            $got | Should -BeExactly $want
        }

        It "difference of squares 5" {
            $got =  Get-DifferenceOfSquares -Number 5
            $want = 170
    
            $got | Should -BeExactly $want
        }

        It "difference of squares 100" {
            $got =  Get-DifferenceOfSquares -Number 100
            $want = 25164150
    
            $got | Should -BeExactly $want
        }
    }
}
