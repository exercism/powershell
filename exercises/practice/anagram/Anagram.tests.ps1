BeforeAll {
    . "./Anagram.ps1"
}

Describe "Test Invoke-Anagram.ps1" {
    It "no matches" {
        $got = Invoke-Anagram -Subject "diaper" -Candidates @("hello", "world", "zombies", "pants")
        $want = @()

        $got | Should -Be $want
    }

    It "detects two anagrams" {
        $got = Invoke-Anagram -Subject "solemn" -Candidates @("lemons", "cherry", "melons")
        $want = @("lemons", "melons")

        $got | Should -Be $want
    }

    It "does not detect anagram subsets" {
        $got = Invoke-Anagram -Subject "good" -Candidates @("dog", "goody")
        $want = @()

        $got | Should -Be $want
    }

    It "detects anagram" {
        $got = Invoke-Anagram -Subject "listen" -Candidates @("enlists", "google", "inlets", "banana")
        $want = @("inlets")

        $got | Should -Be $want
    }

    It "detects three anagrams" {
        $got = Invoke-Anagram -Subject "allergy" -Candidates @("gallery", "ballerina", "regally", "clergy", "largely", "leading")
        $want = @("gallery", "regally", "largely")

        $got | Should -Be $want
    }

    It "detects multiple anagrams with different case" {
        $got = Invoke-Anagram -Subject "nose" -Candidates @("Eons", "ONES")
        $want = @("Eons", "ONES")

        $got | Should -Be $want
    }

    It "does not detect non-anagrams with identical checksum" {
        $got = Invoke-Anagram -Subject "mass" -Candidates @("last")
        $want = @()

        $got | Should -Be $want
    }

    It "detects anagrams case-insensitively" {
        $got = Invoke-Anagram -Subject "Orchestra" -Candidates @("cashregister", "Carthorse", "radishes")
        $want = @("Carthorse")

        $got | Should -Be $want
    }

    It "detects anagrams using case-insensitive subject" {
        $got = Invoke-Anagram -Subject "Orchestra" -Candidates @("cashregister", "carthorse", "radishes")
        $want = @("carthorse")

        $got | Should -Be $want
    }

    It "detects anagrams using case-insensitive possible matches" {
        $got = Invoke-Anagram -Subject "orchestra" -Candidates @("cashregister", "Carthorse", "radishes")
        $want = @("Carthorse")

        $got | Should -Be $want
    }

    It "does not detect a anagram if the original word is repeated" {
        $got = Invoke-Anagram -Subject "go" -Candidates @("go Go GO")
        $want = @()

        $got | Should -Be $want
    }

    It "anagrams must use all letters exactly once" {
        $got = Invoke-Anagram -Subject "tapper" -Candidates @("patter")
        $want = @()

        $got | Should -Be $want
    }

    It "words are not anagrams of themselves" {
        $got = Invoke-Anagram -Subject "BANANA" -Candidates @("BANANA")
        $want = @()

        $got | Should -Be $want
    }

    It "words are not anagrams of themselves even if letter case is partially different" {
        $got = Invoke-Anagram -Subject "BANANA" -Candidates @("Banana")
        $want = @()

        $got | Should -Be $want
    }

    It "words are not anagrams of themselves even if letter case is completely different" {
        $got = Invoke-Anagram -Subject "BANANA" -Candidates @("banana")
        $want = @()

        $got | Should -Be $want
    }

    It "words other than themselves can be anagrams" {
        $got = Invoke-Anagram -Subject "LISTEN" -Candidates @("Listen", "Silent")
        $want = @("Silent")

        $got | Should -Be $want
    }
}
