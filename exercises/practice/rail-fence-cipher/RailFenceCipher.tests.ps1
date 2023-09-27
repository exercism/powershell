BeforeAll {
    . "./RailFenceCipher.ps1"
}

Describe "RailFenceCipher test cases" {
    Context "encoding" {
        It "encode with two rails" {
            $got  = Invoke-Encode -Message "XOXOXOXOXOXOXOXOXO" -Rails 2
            $want = "XXXXXXXXXOOOOOOOOO"

            $got | Should -BeExactly $want
        }
    
        It "encode with three rails" {
            $got  = Invoke-Encode -Message "WEAREDISCOVEREDFLEEATONCE" -Rails 3
            $want = "WECRLTEERDSOEEFEAOCAIVDEN"

            $got | Should -BeExactly $want
        }
    
        It "encode with ending in the middle" {
            $got  = Invoke-Encode -Message "EXERCISES" -Rails 4
            $want = "ESXIEECSR"

            $got | Should -BeExactly $want
        }
    }
    
    Context "decoding" {
        It "decode with three rails" {
            $got  = Invoke-Decode -Ciphertext "TEITELHDVLSNHDTISEIIEA" -Rails 3
            $want = "THEDEVILISINTHEDETAILS"

            $got | Should -BeExactly $want
        }
    
        It "decode with five rails" {
            $got  = Invoke-Decode -Ciphertext "EIEXMSMESAORIWSCE" -Rails 5
            $want = "EXERCISMISAWESOME"

            $got | Should -BeExactly $want
        }
    
        It "decode with six rails" {
            $got  = Invoke-Decode -Ciphertext "133714114238148966225439541018335470986172518171757571896261" -Rails 6
            $want = "112358132134558914423337761098715972584418167651094617711286"

            $got | Should -BeExactly $want
        }
    }
}
