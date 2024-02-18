BeforeAll {
    . "./SaddlePoints.ps1"
}

Describe "SaddlePoints test cases" {
    Context "Can identify saddle" {
        It "single saddle point" {
            $got  = Get-SaddlePoints -Matrix @( 
                @(9, 8, 7), 
                @(5, 3, 2), 
                @(6, 6, 7)
            )
            $want = @([SaddlePoint]::new(2, 1))
    
            $got | Should -BeExactly $want
        }
    
        It "empty matrix has no saddle points" {
            $got  = Get-SaddlePoints -Matrix @()
    
            $got | Should -BeNullOrEmpty
        }
    
        It "lack of saddle points when there are none" {
            $got  = Get-SaddlePoints -Matrix @(
                @(1, 2, 3), 
                @(3, 1, 2), 
                @(2, 3, 1)
            )
    
            $got | Should -BeNullOrEmpty
        }
    
        It "multiple saddle points in a column" {
            $got  = Get-SaddlePoints -Matrix @(
                @(4, 5, 4), 
                @(3, 5, 5), 
                @(1, 5, 4)
            )
            $want = @(
                [SaddlePoint]::new(1, 2),
                [SaddlePoint]::new(2, 2),
                [SaddlePoint]::new(3, 2)
            )
    
            $got | Should -BeExactly $want
        }
    
        It "multiple saddle points in a row" {
            $got  = Get-SaddlePoints -Matrix @(
                @(6, 7, 8), 
                @(5, 5, 5), 
                @(7, 5, 6)
            )
            $want = @(
                [SaddlePoint]::new(2, 1),
                [SaddlePoint]::new(2, 2),
                [SaddlePoint]::new(2, 3)
            )
    
            $got | Should -BeExactly $want
        }
    
        It "saddle point in bottom right corner" {
            $got  = Get-SaddlePoints -Matrix @(
                @(8, 7, 9), 
                @(6, 7, 6), 
                @(3, 2, 5)
            )
            $want = @([SaddlePoint]::new(3, 3))
    
            $got | Should -BeExactly $want
        }
    
        It "saddle points in a non square matrix" {
            $got  = Get-SaddlePoints -Matrix @(
                @(3, 1, 3), 
                @(3, 2, 4)
            )
            $want = @([SaddlePoint]::new(1, 1), [SaddlePoint]::new(1, 3))
    
            $got | Should -BeExactly $want
        }
    
        It "saddle points in a single column matrix are those with the minimum value" {
            $got  = Get-SaddlePoints -Matrix @(
                @(2), 
                @(1),
                @(4),
                @(1)
            )
            $want = @([SaddlePoint]::new(2, 1), [SaddlePoint]::new(4, 1))
    
            $got | Should -BeExactly $want
        }
    
        It "saddle points in a single row matrix are those with the maximum value" {
            $got  = Get-SaddlePoints -Matrix @( ,@(2, 5, 3, 5))
            $want = @([SaddlePoint]::new(1, 2), [SaddlePoint]::new(1, 4))
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "invalid input" {
        It "irregular_matrix" {
            {Get-SaddlePoints -Matrix @( 
                @(3, 2, 1),
                @(0, 1),
                @(2, 1, 0)
            )} | Should -Throw "*Irregular matrix*"
        }
    }
}
