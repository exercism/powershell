BeforeAll {
    . ".\LargestSeriesProduct.ps1"
}

Describe "Test LargestSeriesProduct Cases" {
    Context "Passing tests" {
        It "finds the largest product if span equals length" {
            Get-LargestSeriesProduct -Digits "29" -Span 2 | Should -Be 18
        }
    
        It "can find the largest product of 2 with numbers in order" {
            Get-LargestSeriesProduct -Digits "0123456789" -Span 2 | Should -Be 72
        }
    
        It "can find the largest product of 2" {
            Get-LargestSeriesProduct -Digits "578092124" -Span 2 | Should -Be 56
        }
    
        It "can find the largest product of 3 with numbers in order" {
            Get-LargestSeriesProduct -Digits "0123456789" -Span 3 | Should -Be 504
        }
    
        It "can find the largest product of 3" {
            Get-LargestSeriesProduct -Digits "1975034682" -Span 3 | Should -Be 315
        }
    
        It "can find the largest product of 5 with numbers in order" {
            Get-LargestSeriesProduct -Digits "0123456789" -Span 5 | Should -Be 15120
        }
    
        It "can get the largest product of a big number" {
            Get-LargestSeriesProduct -Digits "73167176531330624919225119674426574742355349194934" -Span 6 | Should -Be 23520
        }
    
        It "reports zero if the only digits are zero" {
            Get-LargestSeriesProduct -Digits "000000" -Span 3 | Should -Be 0
        }
    
        It "reports zero if all spans include zero" {
            Get-LargestSeriesProduct -Digits "0550880" -Span 3 | Should -Be 0
        }
    }
    
    Context "Invalid Inputs" {
        It "rejects span longer than string length" {
            { Get-LargestSeriesProduct -Digits "123" -Span 4 } | Should -Throw "*span must be smaller than string length*"
        }
    
        It "rejects empty string and nonzero span" {
            { Get-LargestSeriesProduct -Digits "" -Span 2 } | Should -Throw "*span must be smaller than string length*"
        }
    
        It "rejects invalid character in digits" {
            { Get-LargestSeriesProduct -Digits "12e456T" -Span 3 } | Should -Throw "*digits input must only contain digits*"
        }
    
        It "rejects negative span" {
            { Get-LargestSeriesProduct -Digits "1234" -Span -2 } | Should -Throw "*span must not be negative*"
        }
    }
}