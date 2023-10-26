BeforeAll {
    . "./ScaleGenerator.ps1"
}

Describe "ScaleGenerator test cases" {
    Context "Chromatic scales" {
        It "Chromatic scale with sharps" {
            $got  = [Scale]::new("C").Chromatic()
            $want = @("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B")
    
            $got | Should -BeExactly $want
        }
    
        It "Chromatic scale with flats" {
            $got  = [Scale]::new("F").Chromatic()
            $want = @("F", "Gb", "G", "Ab", "A", "Bb", "B", "C", "Db", "D", "Eb", "E")
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "Scales with specified intervals" {
        It "Simple major scale" {
            $got  = [Scale]::new("C").Interval("MMmMMMm")
            $want = @("C", "D", "E", "F", "G", "A", "B", "C")
    
            $got | Should -BeExactly $want
        }
    
        It "Major scale with sharps" {
            $got  = [Scale]::new("G").Interval("MMmMMMm")
            $want = @("G", "A", "B", "C", "D", "E", "F#", "G")
    
            $got | Should -BeExactly $want
        }
    
        It "Major scale with flats" {
            $got  = [Scale]::new("F").Interval("MMmMMMm")
            $want = @("F", "G", "A", "Bb", "C", "D", "E", "F")
    
            $got | Should -BeExactly $want
        }
    
        It "Minor scale with sharps" {
            $got  = [Scale]::new("f#").Interval("MmMMmMM")
            $want = @("F#", "G#", "A", "B", "C#", "D", "E", "F#")
    
            $got | Should -BeExactly $want
        }
    
        It "Minor scale with flats" {
            $got  = [Scale]::new("bb").Interval("MmMMmMM")
            $want = @("Bb", "C", "Db", "Eb", "F", "Gb", "Ab", "Bb")
    
            $got | Should -BeExactly $want
        }
    
        It "Dorian mode" {
            $got  = [Scale]::new("d").Interval("MmMMMmM")
            $want = @("D", "E", "F", "G", "A", "B", "C", "D")
    
            $got | Should -BeExactly $want
        }
    
        It "Mixolydian mode" {
            $got  = [Scale]::new("Eb").Interval("MMmMMmM")
            $want = @("Eb", "F", "G", "Ab", "Bb", "C", "Db", "Eb")
    
            $got | Should -BeExactly $want
        }
    
        It "Lydian mode" {
            $got  = [Scale]::new("a").Interval("MMMmMMm")
            $want = @("A", "B", "C#", "D#", "E", "F#", "G#", "A")
    
            $got | Should -BeExactly $want
        }
    
        It "Phrygian mode" {
            $got  = [Scale]::new("e").Interval("mMMMmMM")
            $want = @("E", "F", "G", "A", "B", "C", "D", "E")
    
            $got | Should -BeExactly $want
        }
    
        It "Locrian mode" {
            $got  = [Scale]::new("g").Interval("mMMmMMM")
            $want = @("G", "Ab", "Bb", "C", "Db", "Eb", "F", "G")
    
            $got | Should -BeExactly $want
        }
    
        It "Harmonic minor" {
            $got  = [Scale]::new("d").Interval("MmMMmAm")
            $want = @("D", "E", "F", "G", "A", "Bb", "Db", "D")
    
            $got | Should -BeExactly $want
        }
    
        It "Octatonic" {
            $got  = [Scale]::new("C").Interval("MmMmMmMm")
            $want = @("C", "D", "D#", "F", "F#", "G#", "A", "B", "C")
    
            $got | Should -BeExactly $want
        }
    
        It "Hexatonic" {
            $got  = [Scale]::new("Db").Interval("MMMMMM")
            $want = @("Db", "Eb", "F", "G", "A", "B", "Db")
    
            $got | Should -BeExactly $want
        }
    
        It "Pentatonic" {
            $got  = [Scale]::new("A").Interval("MMAMA")
            $want = @("A", "B", "C#", "E", "F#", "A")
    
            $got | Should -BeExactly $want
        }
    
        It "Enigmatic" {
            $got  = [Scale]::new("G").Interval("mAMMMmm")
            $want = @("G", "G#", "B", "C#", "D#", "F", "F#", "G")
    
            $got | Should -BeExactly $want
        }
    }
}
