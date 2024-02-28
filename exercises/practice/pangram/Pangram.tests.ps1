BeforeAll {
    . ".\Pangram.ps1"
}

Describe "PangramTests" {
	It "empty sentence" {
        $got = Invoke-Panagram -Sentence ""

        $got | Should -BeFalse
	}

    It "perfect lower case" {
        $got = Invoke-Panagram -Sentence "abcdefghijklmnopqrstuvwxyz"

        $got | Should -BeTrue
    }

    It "only lower case" {
        $got = Invoke-Panagram -Sentence "the quick brown fox jumps over the lazy dog"

        $got | Should -BeTrue
    }

    It "missing the letter 'x'" {
        $got = Invoke-Panagram -Sentence "a quick movement of the enemy will jeopardize five gunboats"

        $got | Should -BeFalse
    }

    It "missing the letter 'h'" {
        $got = Invoke-Panagram -Sentence "five boxing wizards jump quickly at it"

        $got | Should -BeFalse
    }

    It "with underscores" {
        $got = Invoke-Panagram -Sentence "the_quick_brown_fox_jumps_over_the_lazy_dog"

        $got | Should -BeTrue
    }

    It "with numbers" {
        $got = Invoke-Panagram -Sentence "the 1 quick brown fox jumps over the 2 lazy dogs"

        $got | Should -BeTrue
    }

    It "missing letters replaced by numbers" {
        $got = Invoke-Panagram -Sentence "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"

        $got | Should -BeFalse
    }

    It "mixed case and punctuation" {
        $got = Invoke-Panagram -Sentence "`"Five quacking Zephyrs jolt my wax bed.`""

        $got | Should -BeTrue
    }

    It "a-m and A-M are 26 different characters but not a pangram" {
        $got = Invoke-Panagram -Sentence "abcdefghijklm ABCDEFGHIJKLM"

        $got | Should -BeFalse
    }
}