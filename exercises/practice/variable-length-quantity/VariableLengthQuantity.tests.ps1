BeforeAll {
    . "./VariableLengthQuantity.ps1"
}

Describe "VariableLengthQuantity test cases" {
    Context "Encode a series of integers, producing a series of bytes." {
        It "zero" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x0)
            $want = @(0x0)

            $got | Should -BeExactly $want
        }
    
        It "arbitrary single byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x40)
            $want = @(0x40)

            $got | Should -BeExactly $want
        }
    
        It "largest single byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x7F)
            $want = @(0x7F)

            $got | Should -BeExactly $want
        }
    
        It "smallest double byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x80)
            $want = @(0x81, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "arbitrary double byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x2000)
            $want = @(0xC0, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "largest double byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x3FFF)
            $want = @(0xFF, 0x7F)

            $got | Should -BeExactly $want
        }
    
        It "smallest triple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x4000)
            $want = @(0x81, 0x80, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "arbitrary triple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x100000)
            $want = @(0xC0, 0x80, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "largest triple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x1FFFFF)
            $want = @(0xFF, 0xFF, 0x7F)

            $got | Should -BeExactly $want
        }
    
        It "smallest quadruple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x200000)
            $want = @(0x81, 0x80, 0x80, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "arbitrary quadruple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x8000000)
            $want = @(0xC0, 0x80, 0x80, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "largest quadruple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0xFFFFFFF)
            $want = @(0xFF, 0xFF, 0xFF, 0x7F)

            $got | Should -BeExactly $want
        }
    
        It "smallest quintuple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x10000000)
            $want = @(0x81, 0x80, 0x80, 0x80, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "arbitrary quintuple byte" {
            $got  = Invoke-EncodeVLQ -Bytes @([UInt32]"0xFF000000")
            $want = @(0x8F, 0xF8, 0x80, 0x80, 0x0)

            $got | Should -BeExactly $want
        }
    
        It "maximum 32-bit integer input" {
            $got  = Invoke-EncodeVLQ -Bytes @([UInt32]::MaxValue)
            $want = @(0x8F, 0xFF, 0xFF, 0xFF, 0x7F)

            $got | Should -BeExactly $want
        }
    
        It "two single-byte values" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x40, 0x7F)
            $want = @(0x40, 0x7F)

            $got | Should -BeExactly $want
        }
    
        It "two multi-byte values" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x4000, 0x123456)
            $want = @(0x81, 0x80, 0x0, 0xC8, 0xE8, 0x56)

            $got | Should -BeExactly $want
        }
    
        It "many multi-byte values" {
            $got  = Invoke-EncodeVLQ -Bytes @(0x2000, 0x123456, 0xFFFFFFF, 0x0, 0x3FFF, 0x4000)
            $want = @(
                0xC0,
                0x0,
                0xC8,
                0xE8,
                0x56,
                0xFF,
                0xFF,
                0xFF,
                0x7F,
                0x0,
                0xFF,
                0x7F,
                0x81,
                0x80,
                0x0
            )

            $got | Should -BeExactly $want
        }
    }
    
    Context "Decode a series of bytes, producing a series of integers." {
        It "one byte" {
            $got  = Invoke-DecodeVLQ -Bytes @(0x7F)
            $want = @(0x7F)

            $got | Should -BeExactly $want
        }
    
        It "two bytes" {
            $got  = Invoke-DecodeVLQ -Bytes @(0xC0, 0x0)
            $want = @(0x2000)

            $got | Should -BeExactly $want
        }
    
        It "three bytes" {
            $got  = Invoke-DecodeVLQ -Bytes @(0xFF, 0xFF, 0x7F)
            $want = @(0x1FFFFF)

            $got | Should -BeExactly $want
        }
    
        It "four bytes" {
            $got  = Invoke-DecodeVLQ -Bytes @(0x81, 0x80, 0x80, 0x0)
            $want = @(0x200000)

            $got | Should -BeExactly $want
        }
    
        It "maximum 32-bit integer" {
            $got  = Invoke-DecodeVLQ -Bytes @(0x8F, 0xFF, 0xFF, 0xFF, 0x7F)
            $want = @([UInt32]::MaxValue)

            $got | Should -BeExactly $want
        }
    
        It "multiple values" {
            $got  = Invoke-DecodeVLQ -Bytes @(
                0xC0,
                0x0,
                0xC8,
                0xE8,
                0x56,
                0xFF,
                0xFF,
                0xFF,
                0x7F,
                0x0,
                0xFF,
                0x7F,
                0x81,
                0x80,
                0x0
            )
            $want = @(0x2000, 0x123456, 0xFFFFFFF, 0x0, 0x3FFF, 0x4000)

            $got | Should -BeExactly $want
        }
    }

    Context "invalid input" {
        It "incomplete sequence causes error" {
            { Invoke-DecodeVLQ -Bytes @(0xFF) } | Should -Throw "*Incomplete sequence*"
        }
    
        It "incomplete sequence causes error, even if value is zero" {
            { Invoke-DecodeVLQ -Bytes @(0x80) } | Should -Throw "*Incomplete sequence*"
        }
    }
}
