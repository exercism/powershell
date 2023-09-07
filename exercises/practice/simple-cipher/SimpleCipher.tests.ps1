BeforeAll {
    . "./SimpleCipher.ps1"
}

Describe "SimpleCipher test cases" {
    Context "random cipher" {
        It "Can encode" {
            $text   = "aaaaaaaaaa"
            $cipher = [SimpleCipher]::new()
            $got    = $cipher.Encode($text)
            $want   = $cipher._key.Substring(0, $text.Length)
    
            $got | Should -BeExactly $want
        }
    
        It "Can decode" {
            $text   = "aaaaaaaaaa"
            $cipher = [SimpleCipher]::new()
            $got    = $cipher.Decode($cipher._key.Substring(0, $text.Length))
    
            $got | Should -BeExactly $text
        }
    
        It "Is reversible" {
            $text   = "abcdefghij"
            $cipher = [SimpleCipher]::new()
            $got    = $cipher.Decode($cipher.Encode($text))
    
            $got | Should -BeExactly $text
        }

        It "random key is made of only lowercase letters" {
            $cipher = [SimpleCipher]::new()
            $got    = $cipher._key -cmatch "^[a-z]+$"

            $got | Should -BeTrue
        }

        It "random key at minimum 100 letters" {
            $cipher = [SimpleCipher]::new()
            $got    = $cipher._key.Length -ge 100

            $got | Should -BeTrue
        }

        It "a really long text work with random key shorter than the text" {
            $text   = "loremipsumdolorsitametconsecteturadipiscingelitseddoeiusmodtemporincididuntutlaboreetdoloremagnaaliquaexercitationullamcolaborisnisiutaliquipexeacommodoconsequatduisauteiruredolorinreprehenderitinvoluptatevelitesseculpadoloreeufugiatnullapariaturexcepteursintoccaecatcupidatatnonproidentsuntinculpaquiofficiadeseruntmollitanimidestlaborum"
            $cipher = [SimpleCipher]::new()
            $got    = $cipher.Decode($cipher.Encode($text))

            $got | Should -BeExactly $text
        }
    }
    
    Context "Substitution cipher" {
        It "Can encode" {
            $text   = "aaaaaaaaaa"
            $cipher = [SimpleCipher]::new("abcdefghij")
            $got    = $cipher.Encode($text)
            $want   = $cipher._key.Substring(0, $text.Length)

            $got | Should -BeExactly $want
        }

        It "Can decode" {
            $cipher = [SimpleCipher]::new("practice")
            $got    = $cipher.Decode("toetvquq")
            $want   = "exercism"
    
            $got | Should -BeExactly $want
        }

        It "Is reversible" {
            $text   = "abcdefghij"
            $cipher = [SimpleCipher]::new("abcdefghij")
            $got    = $cipher.Decode($cipher.Encode($text))

            $got | Should -BeExactly $text
        }

        It "Can double shift encode" {
            $text   = "iamapandabear"
            $cipher = [SimpleCipher]::new("iamapandabear")
            $got    = $cipher.Encode($text)
            $want   = "qayaeaagaciai"

            $got | Should -BeExactly $want
        }

        It "Can wrap on encode" {
            $text   = "zzzzzzzzzz"
            $cipher = [SimpleCipher]::new("abcdefghij")
            $got    = $cipher.Encode($text)
            $want   = "zabcdefghi"

            $got | Should -BeExactly $want
        }

        It "Can wrap on decode" {
            $cipher = [SimpleCipher]::new("abcdefghij")
            $got    = $cipher.Decode("zabcdefghi")
            $want   = "zzzzzzzzzz"

            $got | Should -BeExactly $want
        }

        It "Can encode messages longer than the key" {
            $text   = "iamapandabear"
            $cipher = [SimpleCipher]::new("abc")
            $got    = $cipher.Encode($text)
            $want   = "iboaqcnecbfcr"

            $got | Should -BeExactly $want
        }

        It "Can decode messages longer than the key" {
            $cipher = [SimpleCipher]::new("abc")
            $got    = $cipher.Decode("iboaqcnecbfcr")
            $want   = "iamapandabear"

            $got | Should -BeExactly $want
        }
    }
}
