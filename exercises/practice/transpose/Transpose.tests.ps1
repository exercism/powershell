BeforeAll {
    . "./Transpose.ps1"
}
Describe "Transpose test cases" {
    It "empty string" {
        $got  = Invoke-Transpose -Text ""

        $got | Should -BeNullOrEmpty
    }

    It "two characters in a row" {
        $got  = Invoke-Transpose -Text "A1"
        $want = "A`n1"

        $got | Should -BeExactly $want
    }

    It "two characters in a column" {
        $got  = Invoke-Transpose -Text "A`n1"
        $want = "A1"

        $got | Should -BeExactly $want
    }

    It "simple" {
        $got  = Invoke-Transpose -Text "ABC`n123"
        $want = "A1`nB2`nC3"

        $got | Should -BeExactly $want
    }

    It "single line" {
        $got  = Invoke-Transpose -Text "Single line."
        $want = @("S", "i", "n", "g", "l", "e", " ", "l", "i", "n", "e", ".") -join "`n"

        $got | Should -BeExactly $want
    }

    It "first line longer than second line" {
        $got  = Invoke-Transpose -Text "The fourth line.`nThe fifth line."
        $want = @(
            "TT",
            "hh",
            "ee",
            "  ",
            "ff",
            "oi",
            "uf",
            "rt",
            "th",
            "h ",
            " l",
            "li",
            "in",
            "ne",
            "e.",
            "."
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "second line longer than first line" {
        $got  = Invoke-Transpose -Text "The first line.`nThe second line."
        $want = @(
            "TT",
            "hh",
            "ee",
            "  ",
            "fs",
            "ie",
            "rc",
            "so",
            "tn",
            " d",
            "l ",
            "il",
            "ni",
            "en",
            ".e",
            " ."
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "mixed line length" {
        $got  = Invoke-Transpose -Text "The longest line.`nA long line.`nA longer line.`nA line."
        $want = @(
            "TAAA",
            "h   ",
            "elll",
            " ooi",
            "lnnn",
            "ogge",
            "n e.",
            "glr",
            "ei ",
            "snl",
            "tei",
            " .n",
            "l e",
            "i .",
            "n",
            "e",
            "."
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "square" {
        $got  = Invoke-Transpose -Text "HEART`nEMBER`nABUSE`nRESIN`nTREND"
        $want = @(
            "HEART", 
            "EMBER", 
            "ABUSE", 
            "RESIN", 
            "TREND"
            ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "rectangle" {
        $got  = Invoke-Transpose -Text "FRACTURE`nOUTLINED`nBLOOMING`nSEPTETTE"
        $want = @(
            "FOBS",
            "RULE",
            "ATOP",
            "CLOT",
            "TIME",
            "UNIT",
            "RENT",
            "EDGE"
            ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "triangle" {
        $got  = Invoke-Transpose -Text "T`nEE`nAAA`nSSSS`nEEEEE`nRRRRRR"
        $want = @(
            "TEASER",
            " EASER",
            "  ASER",
            "   SER",
            "    ER",
            "     R"
            ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "jagged triangle" {
        $got  = Invoke-Transpose -Text "11`n2`n3333`n444`n555555`n66666"
        $want = @(
            "123456",
            "1 3456",
            "  3456",
            "  3 56",
            "    56",
            "    5"
            ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "many Text" {
        $plainText = @(
            "Chor. Two households, both alike in dignity,",
            "In fair Verona, where we lay our scene,",
            "From ancient grudge break to new mutiny,",
            "Where civil blood makes civil hands unclean.",
            "From forth the fatal loins of these two foes",
            "A pair of star-cross'd lovers take their life;",
            "Whose misadventur'd piteous overthrows",
            "Doth with their death bury their parents' strife.",
            "The fearful passage of their death-mark'd love,",
            "And the continuance of their parents' rage,",
            "Which, but their children's end, naught could remove,",
            "Is now the two hours' traffic of our stage;",
            "The which if you with patient ears attend,",
            "What here shall miss, our toil shall strive to mend."
        ) -join "`n"

        $got  = Invoke-Transpose -Text $plainText
        $want = @(
            "CIFWFAWDTAWITW"
            "hnrhr hohnhshh"
            "o oeopotedi ea"
            "rfmrmash  cn t"
            ".a e ie fthow "
            " ia fr weh,whh"
            "Trnco miae  ie"
            "w ciroitr btcr"
            "oVivtfshfcuhhe"
            " eeih a uote  "
            "hrnl sdtln  is"
            "oot ttvh tttfh"
            "un bhaeepihw a"
            "saglernianeoyl"
            "e,ro -trsui ol"
            "h uofcu sarhu "
            "owddarrdan o m"
            "lhg to'egccuwi"
            "deemasdaeehris"
            "sr als t  ists"
            ",ebk 'phool'h,"
            "  reldi ffd   "
            "bweso tb  rtpo"
            "oea ileutterau"
            "t kcnoorhhnatr"
            "hl isvuyee'fi "
            " atv es iisfet"
            "ayoior trr ino"
            "l  lfsoh  ecti"
            "ion   vedpn  l"
            "kuehtteieadoe "
            "erwaharrar,fas"
            "   nekt te  rh"
            "ismdsehphnnosa"
            "ncuse ra-tau l"
            " et  tormsural"
            "dniuthwea'g t "
            "iennwesnr hsts"
            "g,ycoi tkrttet"
            "n ,l r s'a anr"
            "i  ef  'dgcgdi"
            "t  aol   eoe,v"
            "y  nei sl,u; e"
            ",  .sf to l   "
            "     e rv d  t"
            "     ; ie    o"
            "       f, r   "
            "       e  e  m"
            "       .  m  e"
            "          o  n"
            "          v  d"
            "          e  ."
            "          ,"
            ) -join "`n"

        $got | Should -BeExactly $want
    }
}
