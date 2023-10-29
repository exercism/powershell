BeforeAll {
    . "./Grep.ps1"
    
    $Global:FILES = @{
        'iliad.txt' = @(
            "Achilles sing, O Goddess! Peleus' son;",
            "His wrath pernicious, who ten thousand woes",
            "Caused to Achaia's host, sent many a soul",
            "Illustrious into Ades premature,",
            "And Heroes gave (so stood the will of Jove)",
            "To dogs and to all ravening fowls a prey,",
            "When fierce dispute had separated once",
            "The noble Chief Achilles from the son",
            "Of Atreus, Agamemnon, King of men."
        )
    
        'midsummer-night.txt' = @(
            "I do entreat your grace to pardon me.",
            "I know not by what power I am made bold,",
            "Nor how it may concern my modesty,",
            "In such a presence here to plead my thoughts;",
            "But I beseech your grace that I may know",
            "The worst that may befall me in this case,",
            "If I refuse to wed Demetrius."
        )
    
        'paradise-lost.txt' = @(
            "Of Mans First Disobedience, and the Fruit",
            "Of that Forbidden Tree, whose mortal tast",
            "Brought Death into the World, and all our woe,",
            "With loss of Eden, till one greater Man",
            "Restore us, and regain the blissful Seat,",
            "Sing Heav'nly Muse, that on the secret top",
            "Of Oreb, or of Sinai, didst inspire",
            "That Shepherd, who first taught the chosen Seed"
        )
    }
}

Describe "Grep tests" {
    BeforeAll {
        #utility function
        Mock Get-Content {param($Path) return $Global:FILES[$Path]}
    }

    Context "Test grepping a single file" {
        It "One file, one match, no flags" {
            $got  = Invoke-Grep -Pattern "Agamemnon" -Files @("iliad.txt")
            $want = @("Of Atreus, Agamemnon, King of men.")

            $got | Should -BeExactly $want
        }
    
        It "One file, one match, print line numbers flag" {
            $got  = Invoke-Grep -Pattern "Forbidden" -Files @("paradise-lost.txt") -Number
            $want = @("2:Of that Forbidden Tree, whose mortal tast")

            $got | Should -BeExactly $want
        }
    
        It "One file, one match, case-insensitive flag" {
            $got  = Invoke-Grep -Pattern "FORBIDDEN" -Files @("paradise-lost.txt") -Insensitive
            $want = @("Of that Forbidden Tree, whose mortal tast")

            $got | Should -BeExactly $want
        }
    
        It "One file, one match, print file names flag" {
            $got  = Invoke-Grep -Pattern "Forbidden" -Files @("paradise-lost.txt") -List
            $want = @("paradise-lost.txt")

            $got | Should -BeExactly $want
        }
    
        It "One file, one match, match entire lines flag" {
            $got  = Invoke-Grep -Pattern "With loss of Eden, till one greater Man" -Files @("paradise-lost.txt") -Whole
            $want = @("With loss of Eden, till one greater Man")

            $got | Should -BeExactly $want
        }
    
        It "One file, one match, multiple flags" {
            $got  = Invoke-Grep -Pattern "OF ATREUS, Agamemnon, KIng of MEN." -Files @("iliad.txt") -Number -Insensitive -Whole
            $want = @("9:Of Atreus, Agamemnon, King of men.")

            $got | Should -BeExactly $want
        }
    
        It "One file, several matches, no flags" {
            $got  = Invoke-Grep -Pattern "may" -Files @("midsummer-night.txt") 
            $want = @(
                "Nor how it may concern my modesty,",
                "But I beseech your grace that I may know",
                "The worst that may befall me in this case,"
                )

            $got | Should -BeExactly $want
        }
    
        It "One file, several matches, print line numbers flag" {
            $got  = Invoke-Grep -Pattern "may" -Files @("midsummer-night.txt") -Number
            $want = @(
                "3:Nor how it may concern my modesty,",
                "5:But I beseech your grace that I may know",
                "6:The worst that may befall me in this case,"
                )

            $got | Should -BeExactly $want
        }
    
        It "One file, several matches, match entire lines flag" {
            $got  = Invoke-Grep -Pattern "may" -Files @("midsummer-night.txt") -Whole

            $got | Should -BeNullOrEmpty
        }
    
        It "One file, several matches, case-insensitive flag" {
            $got  = Invoke-Grep -Pattern "ACHILLES" -Files @("iliad.txt") -Insensitive
            $want = @(
                "Achilles sing, O Goddess! Peleus' son;",
                "The noble Chief Achilles from the son"
                )

            $got | Should -BeExactly $want
        }
    
        It "One file, several matches, inverted flag" {
            $got  = Invoke-Grep -Pattern "Of" -Files @("paradise-lost.txt") -Invert
            $want = @(
                "Brought Death into the World, and all our woe,",
                "With loss of Eden, till one greater Man",
                "Restore us, and regain the blissful Seat,",
                "Sing Heav'nly Muse, that on the secret top",
                "That Shepherd, who first taught the chosen Seed"
                )

            $got | Should -BeExactly $want
        }
    
        It "One file, no matches, various flags" {
            $got  = Invoke-Grep -Pattern "Gandalf" -Files @("iliad.txt") -Number -List -Whole -Insensitive

            $got | Should -BeNullOrEmpty
        }
    
        It "One file, one match, file flag takes precedence over line flag" {
            $got  = Invoke-Grep -Pattern "ten" -Files @("iliad.txt") -Number -List
            $want = @("iliad.txt")

            $got | Should -BeExactly $want
        }
    
        It "One file, several matches, inverted and match entire lines flags" {
            $got  = Invoke-Grep -Pattern "Illustrious into Ades premature," -Files @("iliad.txt") -Whole -Invert
            $want = @(
                "Achilles sing, O Goddess! Peleus' son;",
                "His wrath pernicious, who ten thousand woes",
                "Caused to Achaia's host, sent many a soul",
                "And Heroes gave (so stood the will of Jove)",
                "To dogs and to all ravening fowls a prey,",
                "When fierce dispute had separated once",
                "The noble Chief Achilles from the son",
                "Of Atreus, Agamemnon, King of men."
            )

            $got | Should -BeExactly $want
        }
    }
    
    Context "Test grepping multiples files at once" {
        BeforeEach {
            $files = @("iliad.txt", "midsummer-night.txt", "paradise-lost.txt")
        }

        It "Multiple files, one match, no flags" {
            $got  = Invoke-Grep -Pattern "Agamemnon" -Files $files
            $want = @("iliad.txt:Of Atreus, Agamemnon, King of men.")

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, several matches, no flags" {
            $got  = Invoke-Grep -Pattern "may" -Files $files
            $want = @(
                "midsummer-night.txt:Nor how it may concern my modesty,",
                "midsummer-night.txt:But I beseech your grace that I may know",
                "midsummer-night.txt:The worst that may befall me in this case,"
            )

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, several matches, print line numbers flag" {
            $got  = Invoke-Grep -Pattern "that" -Files $files -Number
            $want = @(
                "midsummer-night.txt:5:But I beseech your grace that I may know",
                "midsummer-night.txt:6:The worst that may befall me in this case,",
                "paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast",
                "paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top"
            )

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, one match, print file names flag" {
            $got  = Invoke-Grep -Pattern "who" -Files $files -List
            $want = @(
                "iliad.txt",
                "paradise-lost.txt"
            )

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, several matches, case-insensitive flag" {
            $got  = Invoke-Grep -Pattern "TO" -Files $files -Insensitive
            $want = @(
                "iliad.txt:Caused to Achaia's host, sent many a soul",
                "iliad.txt:Illustrious into Ades premature,",
                "iliad.txt:And Heroes gave (so stood the will of Jove)",
                "iliad.txt:To dogs and to all ravening fowls a prey,",
                "midsummer-night.txt:I do entreat your grace to pardon me.",
                "midsummer-night.txt:In such a presence here to plead my thoughts;",
                "midsummer-night.txt:If I refuse to wed Demetrius.",
                "paradise-lost.txt:Brought Death into the World, and all our woe,",
                "paradise-lost.txt:Restore us, and regain the blissful Seat,",
                "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"
            )

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, several matches, inverted flag" {
            $got  = Invoke-Grep -Pattern "a" -Files $files -Invert
            $want = @(
                "iliad.txt:Achilles sing, O Goddess! Peleus' son;",
                "iliad.txt:The noble Chief Achilles from the son",
                "midsummer-night.txt:If I refuse to wed Demetrius."
            )

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, one match, match entire lines flag" {
            $got  = Invoke-Grep -Pattern "But I beseech your grace that I may know" -Files $files -Whole
            $want = @("midsummer-night.txt:But I beseech your grace that I may know")

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, one match, multiple flags" {
            $got  = Invoke-Grep -Pattern "WITH LOSS OF EDEN, TILL ONE GREATER MAN" -Files $files -Number -Insensitive -Whole
            $want = @("paradise-lost.txt:4:With loss of Eden, till one greater Man")

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, no matches, various flags" {
            $got  = Invoke-Grep -Pattern "Frodo" -Files $files -Number -List -Whole -Insensitive

            $got | Should -BeNullOrEmpty
        }
    
        It "Multiple files, several matches, file flag takes precedence over line number flag" {
            $got  = Invoke-Grep -Pattern "who" -Files $files -Number -List
            $want = @(
                "iliad.txt",
                "paradise-lost.txt"
            )

            $got | Should -BeExactly $want
        }
    
        It "Multiple files, several matches, inverted and match entire lines flags" {
            $got  = Invoke-Grep -Pattern "Illustrious into Ades premature," -Files $files -Whole -Invert
            $want = @(
                "iliad.txt:Achilles sing, O Goddess! Peleus' son;",
                "iliad.txt:His wrath pernicious, who ten thousand woes",
                "iliad.txt:Caused to Achaia's host, sent many a soul",
                "iliad.txt:And Heroes gave (so stood the will of Jove)",
                "iliad.txt:To dogs and to all ravening fowls a prey,",
                "iliad.txt:When fierce dispute had separated once",
                "iliad.txt:The noble Chief Achilles from the son",
                "iliad.txt:Of Atreus, Agamemnon, King of men.",
                "midsummer-night.txt:I do entreat your grace to pardon me.",
                "midsummer-night.txt:I know not by what power I am made bold,",
                "midsummer-night.txt:Nor how it may concern my modesty,",
                "midsummer-night.txt:In such a presence here to plead my thoughts;",
                "midsummer-night.txt:But I beseech your grace that I may know",
                "midsummer-night.txt:The worst that may befall me in this case,",
                "midsummer-night.txt:If I refuse to wed Demetrius.",
                "paradise-lost.txt:Of Mans First Disobedience, and the Fruit",
                "paradise-lost.txt:Of that Forbidden Tree, whose mortal tast",
                "paradise-lost.txt:Brought Death into the World, and all our woe,",
                "paradise-lost.txt:With loss of Eden, till one greater Man",
                "paradise-lost.txt:Restore us, and regain the blissful Seat,",
                "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top",
                "paradise-lost.txt:Of Oreb, or of Sinai, didst inspire",
                "paradise-lost.txt:That Shepherd, who first taught the chosen Seed"
            )

            $got | Should -BeExactly $want
        }
    }
}