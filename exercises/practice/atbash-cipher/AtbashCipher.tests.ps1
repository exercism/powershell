BeforeAll {
    . "./AtbashCipher.ps1"
}

Describe "Test Invoke-AtbashCipher.ps1" {
    Context "Encoding" {
        It "encode yes" {
            $got = Invoke-Encode -Phrase "yes"
            $want = "bvh"	

            $got | Should -BeExactly $want
        }

        It "encode no" {
            $got = Invoke-Encode -Phrase "no"
            $want = "ml"	

            $got | Should -BeExactly $want
        }

        It "encode OMG" {
            $got = Invoke-Encode -Phrase "OMG"
            $want = "lnt"	

            $got | Should -BeExactly $want
        }

        It "encode spaces" {
            $got = Invoke-Encode -Phrase "O M G"
            $want = "lnt"	

            $got | Should -BeExactly $want
        }

        It "encode mindblowingly" {
            $got = Invoke-Encode -Phrase "mindblowingly"
            $want = "nrmwy oldrm tob"	

            $got | Should -BeExactly $want
        }

        It "encode numbers" {
            $got = Invoke-Encode -Phrase "Testing,1 2 3, testing."
            $want = "gvhgr mt123 gvhgr mt"	

            $got | Should -BeExactly $want
        }

        It "encode deep thought" {
            $got = Invoke-Encode -Phrase "Truth is fiction."
            $want = "gifgs rhurx grlm"	

            $got | Should -BeExactly $want
        }

        It "encode all the letters" {
            $got = Invoke-Encode -Phrase "The quick brown fox jumps over the lazy dog."
            $want = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"	

            $got | Should -BeExactly $want
        }
    }

    Context "Decoding" {
        It "decode exercism" {
            $got = Invoke-Decode -Phrase "vcvix rhn"
            $want = "exercism"	

            $got | Should -BeExactly $want
        }

        It "decode a sentence" {
            $got = Invoke-Decode -Phrase "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
            $want = "anobstacleisoftenasteppingstone"	

            $got | Should -BeExactly $want
        }

        It "decode numbers" {
            $got = Invoke-Decode -Phrase "gvhgr mt123 gvhgr mt"
            $want = "testing123testing"	

            $got | Should -BeExactly $want
        }

        It "decode all the letters" {
            $got = Invoke-Decode -Phrase "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
            $want = "thequickbrownfoxjumpsoverthelazydog"	

            $got | Should -BeExactly $want
        }

        It "decode with too many spaces" {
            $got = Invoke-Decode -Phrase "vc vix    r hn"
            $want = "exercism"	

            $got | Should -BeExactly $want
        }

        It "decode with no spaces" {
            $got = Invoke-Decode -Phrase "zmlyhgzxovrhlugvmzhgvkkrmthglmv"
            $want = "anobstacleisoftenasteppingstone"	

            $got | Should -BeExactly $want
        }
    }
}
