BeforeAll {
    . "./IntergalacticTransmission.ps1"
}

Describe "IntergalacticTransmission test cases" {
    Context "Calculate transmit sequences" {
        It "empty message" {
            $got = Invoke-Transmitter -Sequence @()
            $expected = @()

            $got | Should -Be $expected
        }

        It "0x00 is transmitted as 0x0000" {
            $got = Invoke-Transmitter -Sequence @(0x00)
            $expected = @(0x00, 0x00)

            $got | Should -Be $expected
        }

        It "0x02 is transmitted as 0x0300" {
            $got = Invoke-Transmitter -Sequence @(0x02)
            $expected = @(0x03, 0x00)

            $got | Should -Be $expected
        }

        It "0x06 is transmitted as 0x0600" {
            $got = Invoke-Transmitter -Sequence @(0x06)
            $expected = @(0x06, 0x00)

            $got | Should -Be $expected
        }

        It "0x05 is transmitted as 0x0581" {
            $got = Invoke-Transmitter -Sequence @(0x05)
            $expected = @(0x05, 0x81)

            $got | Should -Be $expected
        }

        It "0x29 is transmitted as 0x2881" {
            $got = Invoke-Transmitter -Sequence @(0x29)
            $expected = @(0x28, 0x81)

            $got | Should -Be $expected
        }

        It "0xc001c0de is transmitted as 0xc000711be1" {
            $got = Invoke-Transmitter -Sequence @(0xc0, 0x01, 0xc0, 0xde)
            $expected = @(0xc0, 0x00, 0x71, 0x1b, 0xe1)

            $got | Should -Be $expected
        }

        It "six byte message" {
            $got = Invoke-Transmitter -Sequence @(0x47, 0x72, 0x65, 0x61, 0x74, 0x21)
            $expected = @(0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0x84)

            $got | Should -Be $expected
        }

        It "seven byte message" {
            $got = Invoke-Transmitter -Sequence @(0x47, 0x72, 0x65, 0x61, 0x74, 0x31, 0x21)
            $expected = @(0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x42)

            $got | Should -Be $expected
        }

        It "eight byte message" {
            $got = Invoke-Transmitter -Sequence @(0xc0, 0x01, 0x13, 0x37, 0xc0, 0xde, 0x21, 0x21)
            $expected = @(0xc0, 0x00, 0x44, 0x66, 0x7d, 0x06, 0x78, 0x42, 0x21, 0x81)

            $got | Should -Be $expected
        }

        It "twenty byte message" {
            $got = Invoke-Transmitter -Sequence @(
                0x45, 0x78, 0x65, 0x72, 0x63, 0x69, 0x73, 0x6d, 0x20, 0x69,
                0x73, 0x20, 0x61, 0x77, 0x65, 0x73, 0x6f, 0x6d, 0x65, 0x21
            )
            $expected = @(
                0x44, 0xbd, 0x18, 0xaf, 0x27, 0x1b, 0xa5, 0xe7, 0x6c, 0x90,
                0x1b, 0x2e, 0x33, 0x03, 0x84, 0xee, 0x65, 0xb8, 0xdb, 0xed, 
                0xd7, 0x28, 0x84
            )

            $got | Should -Be $expected
        }
    }

    Context "Decode received messages" {
        It "empty message" {
            $got = Invoke-Receiver -Sequence @()
            $expected = @()

            $got | Should -Be $expected
        }

        It "zero message" {
            $got = Invoke-Receiver -Sequence @(0x00, 0x00)
            $expected = @(0x00)

            $got | Should -Be $expected
        }

        It "0x0300 is decoded to 0x02" {
            $got = Invoke-Receiver -Sequence @(0x03, 0x00)
            $expected = @(0x02)

            $got | Should -Be $expected
        }

        It "0x0581 is decoded to 0x05" {
            $got = Invoke-Receiver -Sequence @(0x05, 0x81)
            $expected = @(0x05)

            $got | Should -Be $expected
        }

        It "0x2881 is decoded to 0x29" {
            $got = Invoke-Receiver -Sequence @(0x28, 0x81)
            $expected = @(0x29)

            $got | Should -Be $expected
        }

        It "first byte has wrong parity" {
            { Invoke-Receiver -Sequence @(0x07, 0x00) } | Should -Throw "*wrong parity*"
        }

        It "second byte has wrong parity" {
            { Invoke-Receiver -Sequence @(0x03, 0x68) } | Should -Throw "*wrong parity*"
        }

        It "0xcf4b00 is decoded to 0xce94" {
            $got = Invoke-Receiver -Sequence @(0xcf, 0x4b, 0x00)
            $expected = @(0xce, 0x94)

            $got | Should -Be $expected
        }

        It "0xe2566500 is decoded to 0xe2ad90" {
            $got = Invoke-Receiver -Sequence @(0xe2, 0x56, 0x65, 0x00)
            $expected = @(0xe2, 0xad, 0x90)

            $got | Should -Be $expected
        }

        It "six byte message" {
            $got = Invoke-Receiver -Sequence @(0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0x84)
            $expected = @(0x47, 0x72, 0x65, 0x61, 0x74, 0x21)

            $got | Should -Be $expected
        }

        It "seven byte message" {
            $got = Invoke-Receiver -Sequence @(0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x42)
            $expected = @(0x47, 0x72, 0x65, 0x61, 0x74, 0x31, 0x21)

            $got | Should -Be $expected
        }

        It "last byte has wrong parity" {
            { Invoke-Receiver -Sequence @(0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x43) } | Should -Throw "*wrong parity*"
        }

        It "eight byte message" {
            $got = Invoke-Receiver -Sequence @(0xc0, 0x00, 0x44, 0x66, 0x7d, 0x06, 0x78, 0x42, 0x21, 0x81)
            $expected = @(0xc0, 0x01, 0x13, 0x37, 0xc0, 0xde, 0x21, 0x21)

            $got | Should -Be $expected
        }

        It "twenty byte message" {
            $got = Invoke-Receiver -Sequence @(
                0x44, 0xbd, 0x18, 0xaf, 0x27, 0x1b, 0xa5, 0xe7, 0x6c, 0x90,
                0x1b, 0x2e, 0x33, 0x03, 0x84, 0xee, 0x65, 0xb8, 0xdb, 0xed,
                0xd7, 0x28, 0x84
            )
            $expected = @(
                0x45, 0x78, 0x65, 0x72, 0x63, 0x69, 0x73, 0x6d, 0x20, 0x69,
                0x73, 0x20, 0x61, 0x77, 0x65, 0x73, 0x6f, 0x6d, 0x65, 0x21
            )

            $got | Should -Be $expected
        }

        It "wrong parity on 16th byte" {
            { Invoke-Receiver -Sequence @(
                0x44, 0xbd, 0x18, 0xaf, 0x27, 0x1b, 0xa5, 0xe7, 0x6c, 0x90,
                0x1b, 0x2e, 0x33, 0x03, 0x84, 0xef, 0x65, 0xb8, 0xdb, 0xed,
                0xd7, 0x28, 0x84
            ) } | Should -Throw "*wrong parity*"
        }
    }
}
