BeforeAll {
    . ".\RotationalCipher.ps1"
}

Describe "RotationalCipherTests" {
	It "rotate a by 0, same output as input" {
        $got = Invoke-RotationalCipher -Text "a" -Shift 0
        $want = "a"

        $got | Should -Be $want
	}

    It "rotate a by 1"{
        $got = Invoke-RotationalCipher -Text "a" -Shift 1
        $want = "b"

        $got | Should -Be $want
    }

    It "rotate a by 26, same output as input" {
        $got = Invoke-RotationalCipher -Text "a" -Shift 26
        $want = "a"

        $got | Should -Be $want
    }

    It "rotate m by 13" {
        $got = Invoke-RotationalCipher -Text "m" -Shift 13
        $want = "z"

        $got | Should -Be $want
    }

    It "rotate n by 13 with wrap around alphabet" {
        $got = Invoke-RotationalCipher -Text "n" -Shift 13
        $want = "a"

        $got | Should -Be $want
    }

    It "rotate capital letters" {
        $got = Invoke-RotationalCipher -Text "OMG" -Shift 5
        $want = "TRL"

        $got | Should -Be $want
    }

    It "rotate spaces" {
        $got = Invoke-RotationalCipher -Text "O M G" -Shift 5
        $want = "T R L"

        $got | Should -Be $want
    }

    It "rotate numbers" {
        $got = Invoke-RotationalCipher -Text "Testing 1 2 3 testing" -Shift 4
        $want = "Xiwxmrk 1 2 3 xiwxmrk"

        $got | Should -Be $want
    }

    It "rotate punctuation" {
        $got = Invoke-RotationalCipher -Text "Let's eat, Grandma!" -Shift 21
        $want = "Gzo'n zvo, Bmviyhv!"

        $got | Should -Be $want
    }

    It "rotate all letters" {
        $got = Invoke-RotationalCipher -Text "The quick brown fox jumps over the lazy dog." -Shift 13
        $want = "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."

        $got | Should -Be $want
    }
}
