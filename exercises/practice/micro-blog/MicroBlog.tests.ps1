BeforeAll {
    . "./MicroBlog.ps1"
}

Describe "MicroBlog test cases" {
    It "English language short" {
        $got  = Invoke-MicroBlog -Post "Hi" 
        $want = "Hi"

        $got | Should -BeExactly $want
    }

    It "English language long" {
        $got  = Invoke-MicroBlog -Post "Hello there" 
        $want = "Hello"

        $got | Should -BeExactly $want
    }

    It "German language short  -Post broth " {
        $got  = Invoke-MicroBlog -Post "brühe" 
        $want = "brühe"

        $got | Should -BeExactly $want
    }

    It "German language long  -Post bear carpet → beards " {
        $got  = Invoke-MicroBlog -Post "Bärteppich" 
        $want = "Bärte"

        $got | Should -BeExactly $want
    }

    It "Bulgarian language short  -Post good " {
        $got  = Invoke-MicroBlog -Post "Добър" 
        $want = "Добър"

        $got | Should -BeExactly $want
    }

    It "Greek language short  -Post health " {
        $got  = Invoke-MicroBlog -Post "υγειά" 
        $want = "υγειά"

        $got | Should -BeExactly $want
    }

    It "Maths short" {
        $got  = Invoke-MicroBlog -Post "a=πr²" 
        $want = "a=πr²"

        $got | Should -BeExactly $want
    }

    It "Maths long" {
        $got  = Invoke-MicroBlog -Post "∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ" 
        $want = "∅⊊ℕ⊊ℤ"

        $got | Should -BeExactly $want
    }

    It "English and emoji short" {
        $got  = Invoke-MicroBlog -Post "Fly 🛫" 
        $want = "Fly 🛫"

        $got | Should -BeExactly $want
    }

    It "Emoji short" {
        $got  = Invoke-MicroBlog -Post "💇" 
        $want = "💇"

        $got | Should -BeExactly $want
    }

    It "Emoji long" {
        $got  = Invoke-MicroBlog -Post "❄🌡🤧🤒🏥🕰😀" 
        $want = "❄🌡🤧🤒🏥"

        $got | Should -BeExactly $want
    }

    It "Royal Flush?" {
        $got  = Invoke-MicroBlog -Post "🃎🂸🃅🃋🃍🃁🃊" 
        $want = "🃎🂸🃅🃋🃍"

        $got | Should -BeExactly $want
    }

    #Those below are extra tests for this track
    It "Chess pieces" {
        $got  = Invoke-MicroBlog -Post "♜♞♝♛♚♟︎" 
        $want = "♜♞♝♛♚"

        $got | Should -BeExactly $want
    }

    It "Zodiac signs" {
        $got  = Invoke-MicroBlog -Post "♈︎♉︎♊︎♋︎♌︎♍︎♎︎♏︎♐︎♑︎♒︎♓︎" 
        $want = "♈︎♉︎♊︎♋︎♌︎"

        $got | Should -BeExactly $want
    }

    It "Music notes" {
        $got  = Invoke-MicroBlog -Post "𝄠♭𝅘𝅥𝆕♫♬𝅘𝅥𝅯♯" 
        $want = "𝄠♭𝅘𝅥𝆕♫"

        $got | Should -BeExactly $want
    }

    It "Egyptian Hieroglyphs" {
        $got  = Invoke-MicroBlog -Post "𓂀𓅁𓅊𓁁☥𓁏" 
        $want = "𓂀𓅁𓅊𓁁☥"

        $got | Should -BeExactly $want
    }
}
