BeforeAll {
    . "./BinarySearch.ps1"
}

Describe "Test Invoke-BinarySearch.ps1" {
    Context "Passing Tests" {
        It "finds a value in an array with one element" {
            $got = Invoke-BinarySearch -Array @(6) -Value 6
            $want = 0
    
            $got | Should -BeExactly $want
        }
    
        It "finds a value in the middle of an array" {
            $got = Invoke-BinarySearch -Array @(1, 3, 4, 6, 8, 9, 11) -Value 6
            $want = 3
    
            $got | Should -BeExactly $want
        }

        It "finds a value at the beginning of an array" {
            $got = Invoke-BinarySearch -Array @(1, 3, 4, 6, 8, 9, 11) -Value 1
            $want = 0
    
            $got | Should -BeExactly $want
        }

        It "finds a value at the end of an array" {
            $got = Invoke-BinarySearch -Array @(1, 3, 4, 6, 8, 9, 11) -Value 11
            $want = 6
    
            $got | Should -BeExactly $want
        }

        It "finds a value in an array of odd length" {
            $got = Invoke-BinarySearch -Array @(1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634) -Value 144
            $want = 9
    
            $got | Should -BeExactly $want
        }

        It "finds a value in an array of even length" {
            $got = Invoke-BinarySearch -Array @(1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377) -Value 21
            $want = 5
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "Invalid Inputs" {
        It "identifies that a value is not included in the array" {
            { Invoke-BinarySearch -Array @(1, 3, 4, 6, 8, 9, 11) -Value 7  } | Should -Throw "error: value not in array"
        }

        It "identifies that a value smaller than the array's smallest value is not included in the array" {
            { Invoke-BinarySearch -Array @(1, 3, 4, 6, 8, 9, 11) -Value 0  } | Should -Throw "error: value not in array"
        }

        It "identifies that a value larger than the array's largest value is not included in the array" {
            { Invoke-BinarySearch -Array @(1, 3, 4, 6, 8, 9, 11) -Value 13  } | Should -Throw "error: value not in array"
        }

        It "nothing is found in an empty array" {
            { Invoke-BinarySearch -Array @() -Value 1  } | Should -Throw "error: value not in array"
        }

        It "nothing is found when the left and right bounds cross" {
            { Invoke-BinarySearch -Array @(1, 2) -Value 0  } | Should -Throw "error: value not in array"
        }
    }
}
