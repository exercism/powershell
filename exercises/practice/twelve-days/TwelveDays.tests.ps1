BeforeAll {
    . "./TwelveDays.ps1"
}

Describe "TwelveDays test cases" {
    Context "single verse" {
        It "first day a partridge in a pear tree" {
            $got  = Invoke-TwelveDays -Start 1 -End 1
            $want = "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "second day two turtle doves" {
            $got  = Invoke-TwelveDays -Start 2 -End 2
            $want = "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "third day three french hens" {
            $got  = Invoke-TwelveDays -Start 3 -End 3
            $want = "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "fourth day four calling birds" {
            $got  = Invoke-TwelveDays -Start 4 -End 4
            $want = "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "fifth day five gold rings" {
            $got  = Invoke-TwelveDays -Start 5 -End 5
            $want = "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "sixth day six geese-a-laying" {
            $got  = Invoke-TwelveDays -Start 6 -End 6
            $want = "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "seventh day seven swans-a-swimming" {
            $got  = Invoke-TwelveDays -Start 7 -End 7
            $want = "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "eighth day eight maids-a-milking" {
            $got  = Invoke-TwelveDays -Start 8 -End 8
            $want = "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "ninth day nine ladies dancing" {
            $got  = Invoke-TwelveDays -Start 9 -End 9
            $want = "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "tenth day ten lords-a-leaping" {
            $got  = Invoke-TwelveDays -Start 10 -End 10
            $want = "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "eleventh day eleven pipers piping" {
            $got  = Invoke-TwelveDays -Start 11 -End 11
            $want = "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    
        It "twelfth day twelve drummers drumming" {
            $got  = Invoke-TwelveDays -Start 12 -End 12
            $want = "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "multi verses lyrics" {
        It "recites first three verses of the song" {
            $got  = Invoke-TwelveDays -Start 1 -End 3
            $want = (
                "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.",
                "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
            ) -join "`n"
    
            $got | Should -BeExactly $want
        }
    
        It "recites three verses from the middle of the song" {
            $got  = Invoke-TwelveDays -Start 4 -End 6
            $want = (
                "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
            ) -join "`n"
    
            $got | Should -BeExactly $want
        }
    
        It "recites the whole song" {
            $got  = Invoke-TwelveDays -Start 1 -End 12
            $want = (
                "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.",
                "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
                "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
            ) -join "`n"
    
            $got | Should -BeExactly $want
        }
    }
    
}
