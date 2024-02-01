BeforeAll {
    . "./AffineCipher.ps1"
}

Describe "AffineCipher test cases" {
    Context "encode tests" {
        It "encode yes" {
            $got  = Invoke-Encode -Plaintext "yes" -Keys @{a = 5; b = 7}
            $want = "xbt"
    
            $got | Should -BeExactly $want
        }
    
        It "encode no" {
            $got  = Invoke-Encode -Plaintext "no" -Keys @{a = 15; b = 18}
            $want = "fu"
    
            $got | Should -BeExactly $want
        }
    
        It "encode OMG" {
            $got  = Invoke-Encode -Plaintext "OMG" -Keys @{a = 21; b = 3}
            $want = "lvz"
    
            $got | Should -BeExactly $want
        }
    
        It "encode O M G" {
            $got  = Invoke-Encode -Plaintext "O M G" -Keys @{a = 25; b = 47}
            $want = "hjp"
    
            $got | Should -BeExactly $want
        }
    
        It "encode mindblowingly" {
            $got  = Invoke-Encode -Plaintext "mindblowingly" -Keys @{a = 11; b = 15}
            $want = "rzcwa gnxzc dgt"
    
            $got | Should -BeExactly $want
        }
    
        It "encode numbers" {
            $got  = Invoke-Encode -Plaintext "Testing,1 2 3, testing." -Keys @{a = 3; b = 4}
            $want = "jqgjc rw123 jqgjc rw"
    
            $got | Should -BeExactly $want
        }
    
        It "encode deep thought" {
            $got  = Invoke-Encode -Plaintext "Truth is fiction." -Keys @{a = 5; b = 17}
            $want = "iynia fdqfb ifje"
            
            $got | Should -BeExactly $want
        }
    
        It "encode all the letters" {
            $got  = Invoke-Encode -Plaintext "The quick brown fox jumps over the lazy dog." -Keys @{a = 17; b = 33}
            $want = "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
            
            $got | Should -BeExactly $want
        }
    }
    
    Context "decode tests" {
        It "decode exercism" {
            $got  = Invoke-Decode -Ciphertext "tytgn fjr" -Keys @{a = 3; b = 7}
            $want = "exercism"
            
            $got | Should -BeExactly $want
        }
    
        It "decode a sentence" {
            $got  = Invoke-Decode -Ciphertext "qdwju nqcro muwhn odqun oppmd aunwd o" -Keys @{a = 19; b = 16}
            $want = "anobstacleisoftenasteppingstone"
            
            $got | Should -BeExactly $want
        }
    
        It "decode numbers" {
            $got  = Invoke-Decode -Ciphertext "odpoz ub123 odpoz ub" -Keys @{a = 25; b = 7}
            $want = "testing123testing"
            
            $got | Should -BeExactly $want
        }
    
        It "decode all the letters" {
            $got  = Invoke-Decode -Ciphertext "swxtj npvyk lruol iejdc blaxk swxmh qzglf" -Keys @{a = 17; b = 33}
            $want = "thequickbrownfoxjumpsoverthelazydog"
            
            $got | Should -BeExactly $want
        }
    
        It "decode with no spaces in input" {
            $got  = Invoke-Decode -Ciphertext "swxtjnpvyklruoliejdcblaxkswxmhqzglf" -Keys @{a = 17; b = 33}
            $want = "thequickbrownfoxjumpsoverthelazydog"
            
            $got | Should -BeExactly $want
        }
    
        It "decode with too many spaces" {
            $got  = Invoke-Decode -Ciphertext "vszzm    cly   yd cg    qdp" -Keys @{a = 15; b = 16}
            $want = "jollygreengiant"
            
            $got | Should -BeExactly $want
        }
    }

    Context "invalid inputs" {
        It "decode with a not coprime to m" {
            { Invoke-Encode -Plaintext "This is a test." -Keys @{a = 6; b = 17} } | Should -Throw "*a and m must be coprime*"
        }
    
        It "encode with a not coprime to m" {
            { Invoke-Decode -Ciphertext "Decode test." -Keys @{a = 13; b = 5} } | Should -Throw "*a and m must be coprime*"
        }
    }
}