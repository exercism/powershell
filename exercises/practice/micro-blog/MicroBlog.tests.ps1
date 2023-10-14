BeforeAll {
    . "./MicroBlog.ps1"
}

Describe "MicroBlog test cases" {
    It "English language short" {
        $got  = Invoke-MicroBlog("Hi")
        $want = "Hi"

        $got | Should -BeExactly $want
    }

    It "English language long" {
        $got  = Invoke-MicroBlog("Hello there")
        $want = "Hello"

        $got | Should -BeExactly $want
    }

    It "German language short (broth)" {
        $got  = Invoke-MicroBlog("brühe")
        $want = "brühe"

        $got | Should -BeExactly $want
    }

    It "German language long (bear carpet → beards)" {
        $got  = Invoke-MicroBlog("Bärteppich")
        $want = "Bärte"

        $got | Should -BeExactly $want
    }

    It "Bulgarian language short (good)" {
        $got  = Invoke-MicroBlog("Добър")
        $want = "Добър"

        $got | Should -BeExactly $want
    }

    It "Greek language short (health)" {
        $got  = Invoke-MicroBlog("υγειά")
        $want = "υγειά"

        $got | Should -BeExactly $want
    }

    It "Maths short" {
        $got  = Invoke-MicroBlog("a=πr²")
        $want = "a=πr²"

        $got | Should -BeExactly $want
    }

    It "Maths long" {
        $got  = Invoke-MicroBlog("∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ")
        $want = "∅⊊ℕ⊊ℤ"

        $got | Should -BeExactly $want
    }

    It "English and emoji short" {
        $got  = Invoke-MicroBlog("Fly 🛫")
        $want = "Fly 🛫"

        $got | Should -BeExactly $want
    }

    It "Emoji short" {
        $got  = Invoke-MicroBlog("💇")
        $want = "💇"

        $got | Should -BeExactly $want
    }

    It "Emoji long" {
        $got  = Invoke-MicroBlog("❄🌡🤧🤒🏥🕰😀")
        $want = "❄🌡🤧🤒🏥"

        $got | Should -BeExactly $want
    }

    It "Royal Flush?" {
        $got  = Invoke-MicroBlog("🃎🂸🃅🃋🃍🃁🃊")
        $want = "🃎🂸🃅🃋🃍"

        $got | Should -BeExactly $want
    }

    #Those below are extra tests for this track
    It "Chess pieces" {
        $got  = Invoke-MicroBlog("♜♞♝♛♚♟︎")
        $want = "♜♞♝♛♚"

        $got | Should -BeExactly $want
    }

    It "Zodiac signs" {
        $got  = Invoke-MicroBlog("♈︎♉︎♊︎♋︎♌︎♍︎♎︎♏︎♐︎♑︎♒︎♓︎")
        $want = "♈︎♉︎♊︎♋︎♌︎"

        $got | Should -BeExactly $want
    }

    It "Music notes" {
        $got  = Invoke-MicroBlog("𝄠♭𝅘𝅥𝆕♫♬𝅘𝅥𝅯♯")
        $want = "𝄠♭𝅘𝅥𝆕♫"

        $got | Should -BeExactly $want
    }

    It "Egyptian Hieroglyphs" {
        $got  = Invoke-MicroBlog("𓂀𓅁𓅊𓁁☥𓁏")
        $want = "𓂀𓅁𓅊𓁁☥"

        $got | Should -BeExactly $want
    }
}
