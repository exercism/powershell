BeforeAll {
    . "./RunLengthEncoding.ps1"
}

Describe "RunLengthEncoding test cases" {
    Context "run-length encode a string" {
        It "empty string" {
            $got = Invoke-Encode -Data ""
            
            $got | Should -BeNullOrEmpty
        }
    
        It "single characters only are encoded without count" {
            $got  = Invoke-Encode -Data "XYZ"
            $want = "XYZ"

            $got | Should -BeExactly $want
        }
    
        It "string with no single characters" {
            $got  = Invoke-Encode -Data "AABBBCCCC"
            $want = "2A3B4C"

            $got | Should -BeExactly $want
        }
    
        It "single characters mixed with repeated characters" {
            $got  = Invoke-Encode -Data "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
            $want = "12WB12W3B24WB"

            $got | Should -BeExactly $want
        }
    
        It "multiple whitespace mixed in string" {
            $got  = Invoke-Encode -Data "  hsqq qww  "
            $want = "2 hs2q q2w2 "

            $got | Should -BeExactly $want
        }
    
        It "lowercase characters" {
            $got  = Invoke-Encode -Data "aabbbcccc"
            $want = "2a3b4c"

            $got | Should -BeExactly $want
        }
    }
    
    Context "run-length decode a string" {
        It "empty string" {
            $got = Invoke-Decode -Data ""
            
            $got | Should -BeNullOrEmpty
        }
    
        It "single characters only" {
            $got  = Invoke-Decode -Data "XYZ"
            $want = "XYZ"

            $got | Should -BeExactly $want
        }
    
        It "string with no single characters" {
            $got  = Invoke-Decode -Data "2A3B4C"
            $want = "AABBBCCCC"

            $got | Should -BeExactly $want
        }
    
        It "single characters with repeated characters" {
            $got  = Invoke-Decode -Data "12WB12W3B24WB"
            $want = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"

            $got | Should -BeExactly $want
        }
    
        It "multiple whitespace mixed in string" {
            $got  = Invoke-Decode -Data "2 hs2q q2w2 "
            $want = "  hsqq qww  "

            $got | Should -BeExactly $want
        }
    
        It "lowercase string" {
            $got  = Invoke-Decode -Data "2a3b4c"
            $want = "aabbbcccc"

            $got | Should -BeExactly $want
        }
    }

    Context "reversible" {
        It "encode followed by decode gives original string" {
            $got  = Invoke-Encode -Data "zzz ZZ  zZ" | Invoke-Decode
            $want = "zzz ZZ  zZ"

            $got | Should -BeExactly $want
        }

        It "decode followed by encode gives original encoded string" {
            $got  = Invoke-Decode -Data "3z 2Z2 2Z" | Invoke-Encode
            $want = "3z 2Z2 2Z"

            $got | Should -BeExactly $want
        }
    }
}
