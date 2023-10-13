BeforeAll {
    . "./PigLatin.ps1"
}

Describe "PigLatin test cases" {
    Context "ay is added to words that start with vowels" {
        It "word beginning with <Desc>" -ForEach @(
            @{Text = "apple"  ; want = "appleay"  ; Desc = "a"}
            @{Text = "ear"    ; want = "earay"    ; Desc = "e"}
            @{Text = "igloo"  ; want = "iglooay"  ; Desc = "i"}
            @{Text = "object" ; want = "objectay" ; Desc = "o"}
            @{Text = "under"  ; want = "underay"  ; Desc = "u"}
            @{Text = "equal"  ; want = "equalay"  ; Desc = "a vowel and followed by a qu"}
        ) {
            param($Text, $want)
            $got = Invoke-PigLatin -Text $Text

            $got | Should -BeExactly $want
        }
    }

    Context "first letter and ay are moved to the end of words that start with consonants" {
        It "word beginning with <Desc>" -ForEach @(
            @{Text = "pig"   ; want = "igpay"   ; Desc = "p"}
            @{Text = "koala" ; want = "oalakay" ; Desc = "k"}
            @{Text = "xenon" ; want = "enonxay" ; Desc = "x"}
            @{Text = "qat"   ; want = "atqay"   ; Desc = "q without a following u"}
        ) {
            param($Text, $want)
            $got = Invoke-PigLatin -Text $Text

            $got | Should -BeExactly $want
        }
    }

    Context "some letter clusters are treated like a single consonant/vowel" {
        It "word beginning with <Desc>" -ForEach @(
            @{Text = "chair"   ; want = "airchay"   ; Desc = "ch"}
            @{Text = "queen"   ; want = "eenquay"   ; Desc = "qu"}
            @{Text = "square"  ; want = "aresquay"  ; Desc = "qu and a preceding consonant"}
            @{Text = "therapy" ; want = "erapythay" ; Desc = "th"}
            @{Text = "thrush"  ; want = "ushthray"  ; Desc = "thr"}
            @{Text = "school"  ; want = "oolschay"  ; Desc = "sch"}
            @{Text = "yttria"  ; want = "yttriaay"  ; Desc = "yt"}
            @{Text = "xray"    ; want = "xrayay"    ; Desc = "xr"}
        ) {
            param($Text, $want)
            $got = Invoke-PigLatin -Text $Text

            $got | Should -BeExactly $want
        }
    }
    
    Context "position of y in a word determines if it is a consonant or a vowel" {
        It "y is treated like a consonant at the beginning of a word" {
            $got  = Invoke-PigLatin -Text "yellow"
            $want = "ellowyay"
        
            $got | Should -BeExactly $want
        }
        
        It "y is treated like a vowel at the end of a consonant cluster" {
            $got  = Invoke-PigLatin -Text "rhythm"
            $want = "ythmrhay"
        
            $got | Should -BeExactly $want
        }
        
        It "y as the second letter in a two-letter word" {
            $got  = Invoke-PigLatin -Text "my"
            $want = "ymay"
        
            $got | Should -BeExactly $want
        }
    }

    Context "phrases are translated" {
        It "a whole phrase" {
            $got  = Invoke-PigLatin -Text "quick fast run"
            $want = "ickquay astfay unray"
        
            $got | Should -BeExactly $want
        }
    }
}
