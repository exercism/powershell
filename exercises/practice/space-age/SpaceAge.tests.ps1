BeforeAll {
    . "./SpaceAge.ps1"
}

Describe "Space Age test cases" {
    Context "passing tests" {
        It "age on Earth" {
            $got  = Get-SpaceAge -Seconds 1000000000 -Planet Earth
            $want = 31.69
    
            $got | Should -Be $want
        }
    
        It "no planet provided should default to Earth" {
            $got  = Get-SpaceAge -Seconds 1000000000
            $want = 31.69
    
            $got | Should -Be $want
        }
    
        It "age on Mercury" {
            $got  = Get-SpaceAge -Seconds 2134835688 -Planet Mercury
            $want = 280.88
    
            $got | Should -Be $want
        }
    
        It "age on Venus" {
            $got  = Get-SpaceAge -Seconds 189839836 -Planet Venus
            $want = 9.78
    
            $got | Should -Be $want
        }
    
        It "age on Mars" {
            $got  = Get-SpaceAge -Seconds 2129871239 -Planet Mars
            $want = 35.88
    
            $got | Should -Be $want
        }
    
        It "age on Jupiter" {
            $got  = Get-SpaceAge -Seconds 901876382 -Planet Jupiter
            $want = 2.41
    
            $got | Should -Be $want
        }
    
        It "age on Saturn" {
            $got  = Get-SpaceAge -Seconds 2000000000 -Planet Saturn
            $want = 2.15
    
            $got | Should -Be $want
        }
    
        It "age on Uranus" {
            $got  = Get-SpaceAge -Seconds 1210123456 -Planet Uranus
            $want = 0.46
    
            $got | Should -Be $want
        }
    
        It "age on Neptune" {
            $got  = Get-SpaceAge -Seconds 1821023456 -Planet Neptune
            $want = 0.35
    
            $got | Should -Be $want
        }
    }
    
    Context "invalid input" {
        It "invalid planet give error" {
            { Get-SpaceAge -Seconds 1000000000 -Planet Pluto } | Should -Throw "Cannot validate argument on parameter 'Planet'. Invalid planet"
        }
    }
}