BeforeAll {
    . "./CircularBuffer.ps1"
}

Describe "CircularBuffer test cases" {
    It "reading empty buffer should fail" {
        $buffer = [CircularBuffer]::new(1)
        { $buffer.Read() } | Should -Throw "*BufferError: Circular buffer is empty*"
    }

    It "can read an item just written" {
        $buffer = [CircularBuffer]::new(1)
        $buffer.Write(1)
        $buffer.Read() | Should -BeExactly 1
    }

    It "each item may only be read once" {
        $buffer = [CircularBuffer]::new(1)
        $buffer.Write(1)
        $buffer.Read() | Should -BeExactly 1
        { $buffer.Read() } | Should -Throw "*BufferError: Circular buffer is empty*"
    }

    It "items are read in the order they are written" {
        $buffer = [CircularBuffer]::new(2)
        $buffer.Write(1)
        $buffer.Write(2)
        $buffer.Read() | Should -BeExactly 1
        $buffer.Read() | Should -BeExactly 2
    }

    It "full buffer can't be written to" {
        $buffer = [CircularBuffer]::new(5)
        1..5 | ForEach-Object {$buffer.Write($_)}
        { $buffer.Write(6) } | Should -Throw "*BufferError: Circular buffer is full*"
    }

    It "a read frees up capacity for another write" {
        $buffer = [CircularBuffer]::new(1)
        $buffer.Write(1)
        $buffer.Read() | Should -BeExactly 1
        $buffer.Write(2)
        $buffer.Read() | Should -BeExactly 2
    }

    It "read position is maintained even across multiple writes" {
        $buffer = [CircularBuffer]::new(3)
        $buffer.Write(1)
        $buffer.Write(2)
        $buffer.Read() | Should -BeExactly 1
        $buffer.Write(3)
        $buffer.Read() | Should -BeExactly 2
        $buffer.Read() | Should -BeExactly 3
    }

    It "items cleared out of buffer can't be read" {
        $buffer = [CircularBuffer]::new(1)
        $buffer.Write(1)
        $buffer.Clear()
        { $buffer.Read() } | Should -Throw "*BufferError: Circular buffer is empty*"
    }

    It "clear frees up capacity for another write" {
        $buffer = [CircularBuffer]::new(1)
        $buffer.Write(1)
        $buffer.Clear()
        $buffer.Write(2)
        $buffer.Read() | Should -BeExactly 2
    }

    It "clear does nothing on empty buffer" {
        $buffer = [CircularBuffer]::new(1)
        $buffer.Clear()
        $buffer.Write(1)
        $buffer.Read() | Should -BeExactly 1
    }

    It "overwrite acts like write on non-full buffer" {
        $buffer = [CircularBuffer]::new(2)
        $buffer.Write(1)
        $buffer.Overwrite(2)
        $buffer.Read() | Should -BeExactly 1
        $buffer.Read() | Should -BeExactly 2
    }

    It "overwrite replaces the oldest item on full buffer" {
        $buffer = [CircularBuffer]::new(2)
        $buffer.Write(1)
        $buffer.Write(2)
        $buffer.Overwrite(3)
        $buffer.Read() | Should -BeExactly 2
        $buffer.Read() | Should -BeExactly 3
    }

    It "overwrite replaces the oldest item remaining in buffer following a read" {
        $buffer = [CircularBuffer]::new(3)
        $buffer.Write(1)
        $buffer.Write(2)
        $buffer.Write(3)
        $buffer.Read() | Should -BeExactly 1
        $buffer.Write(4)
        $buffer.Overwrite(5)
        $buffer.Read() | Should -BeExactly 3
        $buffer.Read() | Should -BeExactly 4
        $buffer.Read() | Should -BeExactly 5
    }

    It "initial clear does not affect wrapping around" {
        $buffer = [CircularBuffer]::new(2)
        $buffer.Clear()
        $buffer.Write(1)
        $buffer.Write(2)
        $buffer.Overwrite(3)
        $buffer.Overwrite(4)
        $buffer.Read() | Should -BeExactly 3
        $buffer.Read() | Should -BeExactly 4
        { $buffer.Read() } | Should -Throw "*BufferError: Circular buffer is empty*"
    }
}
