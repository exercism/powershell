BeforeAll {
    . "./FlattenArray.ps1"
}

Describe "flatten array test cases" {
    It "empty" {
        $got  = Invoke-FlattenArray -Array @()
        $want = @()

        $got | Should -BeExactly $want
    }
    
    It "no nesting" {
        $got  = Invoke-FlattenArray -Array @(1, 2, 3)
        $want = @(1, 2, 3)

        $got | Should -BeExactly $want
    }
    
    It "flattens a nested array" {
        $got  = Invoke-FlattenArray -Array @(@(@()))
        $want = @()

        $got | Should -BeExactly $want
    }
    
    It "flattens array with just integers present" {
        $got  = Invoke-FlattenArray -Array @(1, @(2, 3, 4, 5, 6, 7), 8)
        $want = @(1, 2, 3, 4, 5, 6, 7, 8)

        $got | Should -BeExactly $want
    }
    
    It "5 level nesting" {
        $got  = Invoke-FlattenArray -Array @(0, 2, @(@(2, 3), 8, 100, 4, @(@(@(50)))), -2)
        $want = @(0, 2, 2, 3, 8, 100, 4, 50, -2)

        $got | Should -BeExactly $want
    }
    
    It "6 level nesting" {
        $got  = Invoke-FlattenArray -Array @(1, @(2, 3, 4, 5, 6, 7), 8)
        $want = @(1, 2, 3, 4, 5, 6, 7, 8)

        $got | Should -BeExactly $want
    }
    
    It "null values are omitted from the final result" {
        $got  = Invoke-FlattenArray -Array @(1, 2, $null)
        $want = @(1, 2)

        $got | Should -BeExactly $want
    }
    
    It "consecutive null values at the front of the list are omitted from the final result" {
        $got  = Invoke-FlattenArray -Array @($null, $null, 5)
        $want = @(5)

        $got | Should -BeExactly $want
    }
    
    It "consecutive null values in the middle of the list are omitted from the final result" {
        $got  = Invoke-FlattenArray -Array @(1, $null, $null, 4)
        $want = @(1, 4)

        $got | Should -BeExactly $want
    }
    
    It "6 level nest list with null values" {
        $got  = Invoke-FlattenArray -Array @(0, 2, @(@(2, 3), 8, @(@(100)), $null, @(@($null))), -2)
        $want = @(0, 2, 2, 3, 8, 100, -2)

        $got | Should -BeExactly $want
    }
    
    It "all values in nested list are null" {
        $got  = Invoke-FlattenArray -Array @($null, @(@(@($null))), $null, $null, @(@($null, $null), $null), $null)
        $want = @()

        $got | Should -BeExactly $want
    }
}