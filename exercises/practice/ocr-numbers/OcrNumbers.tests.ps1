BeforeAll {
    . "./OcrNumbers.ps1"
}

Describe "OcrNumbers test cases" {
    Context "valid input" {
        It "Recognizes 0" {
            $lines = (
                " _ ",
                "| |",
                "|_|",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "0"
            
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 1" {
            $lines = (
                "   ",
                "  |",
                "  |",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "1"
            
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 2" {
            $lines = (
                " _ ",
                " _|",
                "|_ ",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "2"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 3" {
            $lines = (
                " _ ",
                " _|",
                " _|",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "3"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 4" {
            $lines = (
                "   ",
                "|_|",
                "  |",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "4"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 5" {
            $lines = (
                " _ ",
                "|_ ",
                " _|",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "5"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 6" {
            $lines = (
                " _ ",
                "|_ ",
                "|_|",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "6"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 7" {
            $lines = (
                " _ ",
                "  |",
                "  |",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "7"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 8" {
            $lines = (
                " _ ",
                "|_|",
                "|_|",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "8"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 9" {
            $lines = (
                " _ ",
                "|_|",
                " _|",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "9"
    
            $got | Should -BeExactly $want
        }
    
        It "Unreadable but correctly sized inputs return ?" {
            $lines = (
                "   ",
                "  _",
                "  |",
                "   "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "?"
            
            $got | Should -BeExactly $want
        }
    
        It "Recognizes 110101100" {
            $lines = (  
                "       _     _        _  _ ",
                "  |  || |  || |  |  || || |",
                "  |  ||_|  ||_|  |  ||_||_|",
                "                           "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "110101100"
            
            $got | Should -BeExactly $want
        }
    
        It "Garbled numbers in a string are replaced with ?" {
            $lines = (  
                "       _     _           _ ",
                "  |  || |  || |     || || |",
                "  |  | _|  ||_|  |  ||_||_|",
                "                           "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "11?10?1?0"
    
            $got | Should -BeExactly $want
        }
    
        It "Recognizes string of decimal numbers" {
            $lines = (
                "    _  _     _  _  _  _  _  _ ",
                "  | _| _||_||_ |_   ||_||_|| |",
                "  ||_  _|  | _||_|  ||_| _||_|",
                "                              "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "1234567890"
    
            $got | Should -BeExactly $want
        }
    
        It "Numbers separated by empty lines are recognized. Lines are joined by commas." {
            $lines = (
                "    _  _ ",
                "  | _| _|",
                "  ||_  _|",
                "         ",
                "    _  _ ",
                "|_||_ |_ ",
                "  | _||_|",
                "         ",
                " _  _  _ ",
                "  ||_||_|",
                "  ||_| _|",
                "         "
                )
            $got  = Invoke-OCR -Grid $lines
            $want = "123,456,789"
    
            $got | Should -BeExactly $want
        }
    }

    Context "invalud input" {
        It "Input with a number of lines that is not a multiple of four raises an error" {
            $lines = (
                " _ ",
                "| |",
                "   "
                )
            { Invoke-OCR -Grid $lines } | Should -Throw "*Number of input lines is not a multiple of four*"
        }
    
        It "Input with a number of columns that is not a multiple of three raises an error" {
            $lines = (
                "    ",
                "   |",
                "   |",
                "    "
                )
            { Invoke-OCR -Grid $lines } | Should -Throw "*Number of input columns is not a multiple of three*"
        }
    }

}
