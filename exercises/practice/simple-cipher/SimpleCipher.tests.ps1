BeforeAll {
    . ".\SimpleCipher.ps1"
}

Describe "Simple cipher test cases" {
    Context "random key cipher" {
        It "can encode" {
            $text = "aaaaaaaaaa"
            $key  = GenerateKey

            $got  = Invoke-EncodeCipher -Plaintext $text -Key $key
            $want = $key.Substring(0,$text.Length)

            $got | Should -BeExactly $want
        }

        It "can encode even if forgot to provide key" {
            $text = "aaaaaaaaaa"
            $got  = Invoke-EncodeCipher -Plaintext $text

            $got.Length | Should -Be $text.Length
        }

        It "can decode" {
            $key  = GenerateKey
            $got  = Invoke-DecodeCipher -Ciphertext $key -Key $key
            $want = 'a' * $key.Length

            $got | Should -BeExactly $want
        }

        It "is reversible" {
            $text = 'abcdexyzw'
            $key  = GenerateKey
            $got  = $text | Invoke-EncodeCipher -Key $key | Invoke-DecodeCipher -Key $key

            $got | Should -BeExactly $text

        }

        It "random key is made of only lowercase letters" {
            $got = (GenerateKey) -cmatch "^[a-z]+$"

            $got | Should -Be $true
        }

        It "random key at minimum 100 letters" {
            $got = (GenerateKey).Length -ge 100

            $got | Should -Be $true
        }

        It "a really long text work with random key shorter than the text" {
            $text = "loremipsumdolorsitametconsecteturadipiscingelitseddoeiusmodtemporincididuntutlaboreetdoloremagnaaliquaexercitationullamcolaborisnisiutaliquipexeacommodoconsequatduisauteiruredolorinreprehenderitinvoluptatevelitesseculpadoloreeufugiatnullapariaturexcepteursintoccaecatcupidatatnonproidentsuntinculpaquiofficiadeseruntmollitanimidestlaborum"
            $key  = GenerateKey
            $got  = $text | Invoke-EncodeCipher -Key $key | Invoke-DecodeCipher -Key $key

            $got | Should -BeExactly $text
        }
    }

    Context "Substitution cipher" {
        It "can encode" {
            $key = "cipherxkey"
            $got = Invoke-EncodeCipher -Plaintext "aaaaaaaaaa" -Key $key

            $got | Should -BeExactly $key
        }

        It "can decode" {
            $key  = "cipherxkey"
            $got  = Invoke-DecodeCipher -Ciphertext $key -Key $key
            $want = "aaaaaaaaaa"
            
            $got | Should -BeExactly $want
        }

        It "is reversible" {
            $text = "abcdefghij"
            $got  = $text | Invoke-EncodeCipher -Key $text | Invoke-DecodeCipher -Key $text

            $got | Should -BeExactly $text
        }

        It "double shift encode" {
            $got  = Invoke-EncodeCipher -Plaintext "iamapandabear" -Key "iamapandabear"
            $want = "qayaeaagaciai"

            $got | Should -BeExactly $want
        }

        It "can wrap on encode" {
            $got  = Invoke-EncodeCipher -Plaintext "zzzzzzzzzz" -Key "abcdefghij"
            $want = "zabcdefghi"

            $got | Should -BeExactly $want
        }

        It "can wrap on decode" {
            $got  = Invoke-DecodeCipher -Ciphertext "zabcdefghi" -Key "abcdefghij"
            $want = "zzzzzzzzzz"

            $got | Should -BeExactly $want
        }

        It "can encode message longer than the key" {
            $got  = Invoke-EncodeCipher -Plaintext "iamapandabear" -Key "abc"
            $want = "iboaqcnecbfcr"

            $got | Should -BeExactly $want
        }

        It "can decode message longer than the key" {
            $got  = Invoke-DecodeCipher -Ciphertext "acedfhgik" -Key "abc"
            $want = "abcdefghi"

            $got | Should -BeExactly $want
        }

        It "can figure out key from encoded and decoded text" {
            $text = "simplexchange"
            $key  = "myxsecretxkey"
            $got  = $text | Invoke-EncodeCipher -Key $key | Invoke-DecodeCipher -Key $text

            $got | Should -BeExactly $key
        }
    }

    Context "invalid input" {
        It "decode need to be provided with a key" {
            { Invoke-DecodeCipher -Ciphertext "aaaaaaaaaa" } | Should -Throw "You need a key to decode ciphertext."
        }
    }

}