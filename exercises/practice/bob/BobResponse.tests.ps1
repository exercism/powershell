BeforeAll {
    . ".\BobResponse.ps1"
}

Describe "Test Get-BobResponse" {

    It "stating something" {
        Get-BobResponse -HeyBob "Tom-ay-to, tom-aaaah-to." | Should -BeExactly "Whatever."
    }

    It "shouting" {
        Get-BobResponse -HeyBob "WATCH OUT!" | Should -BeExactly "Whoa, chill out!"
    }

    It "shouting gibberish" {
        Get-BobResponse -HeyBob "FCECDFCAAB" | Should -BeExactly "Whoa, chill out!"
    }

    It "asking a question" {
        Get-BobResponse -HeyBob "Does this cryogenic chamber make me look fat?" | Should -BeExactly "Sure."
    }

    It "asking a numeric question" {
        Get-BobResponse -HeyBob "You are, what, like 15?" | Should -BeExactly "Sure."
    }

    It "asking gibberish" {
        Get-BobResponse -HeyBob "fffbbcbeab?" | Should -BeExactly "Sure."
    }

    It "talking forcefully" {
        Get-BobResponse -HeyBob "Let's go make out behind the gym!" | Should -BeExactly "Whatever."
    }

    It "using acronyms in regular speech" {
        Get-BobResponse -HeyBob "It's OK if you don't want to go to the DMV." | Should -BeExactly "Whatever."
    }

    It "forceful question" {
        Get-BobResponse -HeyBob "WHAT THE HELL WERE YOU THINKING?" | Should -BeExactly "Calm down, I know what I'm doing!"
    }

    It "shouting numbers" {
        Get-BobResponse -HeyBob "1, 2, 3 GO!" | Should -BeExactly "Whoa, chill out!"
    }

    It "only numbers" {
        Get-BobResponse -HeyBob "1, 2, 3" | Should -BeExactly "Whatever."
    }

    It "question with only numbers" {
        Get-BobResponse -HeyBob "4?" | Should -BeExactly "Sure."
    }

    It "shouting with special characters" {
        Get-BobResponse -HeyBob "ZOMG THE %^*@#`$(*^ ZOMBIES ARE COMING!!11!!1!" | Should -BeExactly "Whoa, chill out!"
    }

    It "shouting with no exclamation mark" {
        Get-BobResponse -HeyBob "I HATE YOU" | Should -BeExactly "Whoa, chill out!"
    }

    It "statement containing question mark" {
        Get-BobResponse -HeyBob "Ending with ? means a question." | Should -BeExactly "Whatever."
    }

    It "non-letters with question" {
        Get-BobResponse -HeyBob ":) ?" | Should -BeExactly "Sure."
    }

    It "prattling on" {
        Get-BobResponse -HeyBob "Wait! Hang on. Are you going to be OK?" | Should -BeExactly "Sure."
    }

    It "silence" {
        Get-BobResponse -HeyBob "" | Should -BeExactly "Fine. Be that way!"
    }

    It "prolonged silence" {
        Get-BobResponse -HeyBob "          " | Should -BeExactly "Fine. Be that way!"
    }

    It "alternate silence" {
        Get-BobResponse -HeyBob "                                                                                " | Should -BeExactly "Fine. Be that way!"
    }

    It "multiple line question" {
        Get-BobResponse -HeyBob "
Does this cryogenic chamber make me look fat?
no" | Should -BeExactly "Whatever."
    }

    It "starting with whitespace" {
        Get-BobResponse -HeyBob "         hmmmmmmm..." | Should -BeExactly "Whatever."
    }

    It "ending with whitespace" {
        Get-BobResponse -HeyBob "Okay if like my  spacebar  quite a bit?   " | Should -BeExactly "Sure."
    }

    It "other whitespace" {
        Get-BobResponse -HeyBob "
        " | Should -BeExactly "Fine. Be that way!"
    }

    It "non-question ending with whitespace" {
        Get-BobResponse -HeyBob "This is a statement ending with whitespace      " | Should -BeExactly "Whatever."
    }
}