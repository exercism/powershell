BeforeAll {
    . ".\WordCount.ps1"
}

Describe "Word Count Test Cases" {
    It "count one word" {
        $got = (Get-WordCount -Phrase "hello").GetEnumerator() | Sort-Object Name
        $want = @{ hello = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "count one of each word" {
        $got = (Get-WordCount -Phrase "welcome to exercism").GetEnumerator() | Sort-Object Name
        $want = @{ welcome = 1; to = 1; exercism = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "multiple occurrences of a word" {
        $got = (Get-WordCount -Phrase "one fish two fish red fish blue fish").GetEnumerator() | Sort-Object Name
        $want = @{ one = 1; fish = 4; two = 1; red = 1; blue = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -Be $want
    }

    It "handles cramped lists" {
        $got = (Get-WordCount -Phrase "one,two,three").GetEnumerator() | Sort-Object Name
        $want = @{ one = 1; two = 1; three = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "handles expanded lists" {
        $got = (Get-WordCount -Phrase "one,`ntwo,`nthree").GetEnumerator() | Sort-Object Name
        $want = @{ one = 1; two = 1; three = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "ignore punctuation" {
        $got = (Get-WordCount -Phrase "car: carpet as java: javascript!!&@$%^&").GetEnumerator() | Sort-Object Name
        $want = @{ car = 1; carpet = 1; as = 1; java = 1; javascript = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "include numbers" {
        $got = (Get-WordCount -Phrase "testing, 1, 2, 3 testing").GetEnumerator() | Sort-Object Name
        $want = @{ testing = 2; "1" = 1; "2" = 1; "3" = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "normalize case" {
        $got = (Get-WordCount -Phrase "go Go GO Stop stop").GetEnumerator() | Sort-Object Name
        $want = @{ go = 3; stop = 2 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "with quotations" {
        $got = (Get-WordCount -Phrase "Joe can't tell between 'large' and large.").GetEnumerator() | Sort-Object Name
        $want = @{ joe = 1; "can't" = 1; tell = 1; between = 1; large = 2; and = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "substrings from the beginning" {
        $got = (Get-WordCount -Phrase "Joe can't tell between app, apple and a.").GetEnumerator() | Sort-Object Name
        $want = @{ joe = 1; "can't" = 1; tell = 1; between = 1; app = 1; apple = 1; and = 1; a = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "multiple spaces not detected as a word" {
        $got = (Get-WordCount -Phrase " multiple   whitespaces  ").GetEnumerator() | Sort-Object Name
        $want = @{ multiple = 1; whitespaces = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "alternating word separators not detected as a word" {
        $got = (Get-WordCount -Phrase ",`n,one,`n ,two `n 'three'").GetEnumerator() | Sort-Object Name
        $want = @{ one = 1; two = 1; three = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "quotation for word with apostrophe" {
        $got = (Get-WordCount -Phrase "can, can't, 'can't'").GetEnumerator() | Sort-Object Name
        $want = @{ can = 1; "can't" = 2 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "with apostrophes" {
        $got = (Get-WordCount -Phrase "'First: don't laugh. Then: don't cry. You're getting it.'").GetEnumerator() | Sort-Object Name
        $want = @{  first = 1; "don't" = 2; laugh = 1; then = 1; cry= 1; "you're" = 1; getting = 1; it = 1}.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "non alphanumeric" {
        $got = (Get-WordCount -Phrase "hey,my_spacebar_is_broken").GetEnumerator() | Sort-Object Name
        $want = @{ hey = 1; my = 1; spacebar = 1; is = 1; broken = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }

    It "multiple apostrophes ignored" {
        $got = (Get-WordCount -Phrase "''hey''").GetEnumerator() | Sort-Object Name
        $want = @{ hey = 1 }.GetEnumerator() | Sort-Object Name

        $got | Should -BeExactly $want
    }
    
}