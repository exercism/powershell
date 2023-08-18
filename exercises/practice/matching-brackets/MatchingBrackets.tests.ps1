BeforeAll {
    . ".\MatchingBrackets.ps1"
}

Describe "Matching brackets test cases" {
    It "paired square brackets" {
        $got  = Test-MatchingBrackets("[]")

        $got | Should -Be $true
    }
    
    It "empty string" {
        $got  = Test-MatchingBrackets("")

        $got | Should -Be $true
    }
    
    It "unpaired brackets" {
        $got  = Test-MatchingBrackets("[[")

        $got | Should -Be $false
    }
    
    It "wrong ordered brackets" {
        $got  = Test-MatchingBrackets("}{")

        $got | Should -Be $false
    }
    
    It "wrong closing bracket" {
        $got  = Test-MatchingBrackets("{]")

        $got | Should -Be $false
    }
    
    It "paired with whitespace" {
        $got  = Test-MatchingBrackets("{  }")

        $got | Should -Be $true
    }
    
    It "partially paired brackets" {
        $got  = Test-MatchingBrackets("{[])")

        $got | Should -Be $false
    }
    
    It "simple nested brackets" {
        $got  = Test-MatchingBrackets("{[]}")

        $got | Should -Be $true
    }
    
    It "several paired brackets" {
        $got  = Test-MatchingBrackets("{}[]")

        $got | Should -Be $true
    }
    
    It "paired and nested brackets" {
        $got  = Test-MatchingBrackets("([{}({}[])])")

        $got | Should -Be $true
    }
    
    It "unopened closing brackets" {
        $got  = Test-MatchingBrackets("{[)][]}")

        $got | Should -Be $false
    }
    
    It "unpaired and nested brackets" {
        $got  = Test-MatchingBrackets("([{])")

        $got | Should -Be $false
    }
    
    It "paired and wrong nested brackets" {
        $got  = Test-MatchingBrackets("[({]})")

        $got | Should -Be $false
    }
    
    It "paired and wrong nested brackets but innermost are correct" {
        $got  = Test-MatchingBrackets("[({}])")

        $got | Should -Be $false
    }
    
    It "paired and incomplete brackets" {
        $got  = Test-MatchingBrackets("{}[")

        $got | Should -Be $false
    }
    
    It "too many closing brackets" {
        $got  = Test-MatchingBrackets("[]]")

        $got | Should -Be $false
    }
    
    It "early unexpected brackets" {
        $got  = Test-MatchingBrackets(")()")

        $got | Should -Be $false
    }
    
    It "early mismatched brackets" {
        $got  = Test-MatchingBrackets("{)()")

        $got | Should -Be $false
    }
    
    It "math expression" {
        $got  = Test-MatchingBrackets("(((185 + 223.85) * 15) - 543)/2")

        $got | Should -Be $true
    }
    
    It "complex latex expression" {
        $complexString = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"
        $got  = Test-MatchingBrackets($complexString)

        $got | Should -Be $true
    }
}