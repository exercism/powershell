BeforeAll {
    . ".\Acronym.ps1"
}

Describe "AcronymTests" {
    It "basic" {
        $got = Get-Acronym -Phrase "Portable Networks Graphic"
        $want = "PNG"
        $got | Should -Be $want
    }

    It "lowercase words" {
        $got = Get-Acronym -Phrase "Ruby on Rails"
        $want = "ROR"
        $got | Should -Be $want
    }

    It "punctuation" {
        $got = Get-Acronym -Phrase "First in, First out"
        $want = "FIFO"
        $got | Should -Be $want
    }

    It "all caps word" {
        $got = Get-Acronym -Phrase "GNU Image Manipulation Program"
        $want = "GIMP"
        $got | Should -Be $want
    }

    It "punctuation without whitespace" {
        $got = Get-Acronym -Phrase "Complementary Metal-Oxide semiconductor"
        $want = "CMOS"
        $got | Should -Be $want
    }

    It "very long abbreviation" {
        $got = Get-Acronym -Phrase "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"
        $want = "ROTFLSHTMDCOALM"
        $got | Should -Be $want
    }

    It "consecutive delimiters" {
        $got = Get-Acronym -Phrase "Something - I made up from thin air"
        $want = "SIMUFTA"
        $got | Should -Be $want
    }

    It "apostrophes" {
        $got = Get-Acronym -Phrase "Halley's Comet"
        $want = "HC"
        $got | Should -Be $want
    }

    It "underscore emphasis" {
        $got = Get-Acronym -Phrase "The Road _Not_ Taken"
        $want = "TRNT"
        $got | Should -Be $want
    }
}