BeforeAll {
    . "./CryptoSquare.ps1"
}

Describe "CryptoSquare test cases" {
    It "empty plaintext results in an empty ciphertext" {
        $got  = Invoke-CryptoSquare -PlainText ""
        $want = ""

        $got | Should -BeExactly $want
    }

    It "normalization results in empty plaintext" {
        $got  = Invoke-CryptoSquare -PlainText "... --- ..."
        $want = ""

        $got | Should -BeExactly $want
    }

    It "Lowercase" {
        $got  = Invoke-CryptoSquare -PlainText "A"
        $want = "a"

        $got | Should -BeExactly $want
    }

    It "Remove spaces" {
        $got  = Invoke-CryptoSquare -PlainText "  b "
        $want = "b"

        $got | Should -BeExactly $want
    }

    It "Remove punctuation" {
        $got  = Invoke-CryptoSquare -PlainText "@1,%!"
        $want = "1"

        $got | Should -BeExactly $want
    }

    It "9 character plaintext results in 3 chunks of 3 characters" {
        $got  = Invoke-CryptoSquare -PlainText "This is fun!"
        $want = "tsf hiu isn"

        $got | Should -BeExactly $want
    }

    It "8 character plaintext results in 3 chunks, the last one with a trailing space" {
        $got  = Invoke-CryptoSquare -PlainText "Chill out."
        $want = "clu hlt io "

        $got | Should -BeExactly $want
    }

    It "54 character plaintext results in 7 chunks, the last two with trailing spaces" {
        $got  = Invoke-CryptoSquare -PlainText "If man was meant to stay on the ground, god would have given us roots."
        $want = "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "

        $got | Should -BeExactly $want
    }

}
