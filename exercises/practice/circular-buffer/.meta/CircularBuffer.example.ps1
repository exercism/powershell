<#
.SYNOPSIS
Implement the circular buffer data structure.

.DESCRIPTION
A circular buffer, cyclic buffer or ring buffer is a data structure that uses a single, fixed-size buffer as if it were connected end-to-end.
Please implement the circular buffer class with these methods:
- Write     : write new value into the buffer, raise error if the buffer is full.
- Overwrite : overwrite the oldest element in the buffer if the buffer is full, otherwise behave like write.
- Clear     : clear all elements in the buffer, it is now empty.
- Read      : read the oldest element in the buffer, and return its value.

There is a predefined ToString method to help debugging and print out the buffer just like in instruction.

.EXAMPLE
$buffer = [CircularBuffer]::new(5)

$buffer.ToString()
Return: [ ][ ][ ][ ][ ]

1..5 | Foreach-Object {$buffer.Write($_)}
$buffer.ToString()
Return: [1][2][3][4][5]

$buffer.Read()
Return: 1

$buffer.ToString()
Return: [ ][2][3][4][5]

$buffer.Write('A')
$buffer.ToString()
Return: [A][2][3][4][5]

$buffer.Overwrite('B')
$buffer.ToString()
Return: [A][B][3][4][5]
#>

Class CircularBuffer {
    hidden [object[]]$buffer
    hidden [int] $front
    hidden [int] $back
    hidden [int] $size

    CircularBuffer([int]$capacity) {
        $this.buffer = @($null) * $capacity
        $this.front  = -1
        $this.back   = -1
        $this.size   = $capacity
    }

    [void] Write([object]$Data) {
        if ($this.IsFull()) {
            Throw "BufferError: Circular buffer is full"
        }
        if ($this.IsEmpty()) {
            $this.front = $this.back = 0
        }else {
            $this.back = ($this.back + 1) % $this.size
        }
        $this.buffer[$this.back] = $Data
    }

    [void] Overwrite([object]$Data) {
        if ($this.IsFull()) {
            $this.buffer[$this.front] = $Data
            $this.back  = $this.front
            $this.front = ($this.front + 1) % $this.size
        }else {
            $this.Write($Data)
        }
    }

    [void] Clear() {
        $this.front  = $this.back = -1
        $this.buffer = @($null) * $this.size
    }

    [object] Read() {
        if ($this.IsEmpty()) {
            Throw "BufferError: Circular buffer is empty"
        }
        $value = $this.buffer[$this.front]
        $this.buffer[$this.front] = $null
        if ($this.front -eq $this.back) {
            $this.front = $this.back = -1
        } else {
            $this.front = ($this.front + 1) % $this.size
        }
        return $value
    }

    hidden [bool] IsFull() {
        return $this.front -eq (($this.back + 1) % $this.size)
    }

    hidden [bool] IsEmpty() {
        return ($this.front -eq -1) -and ($this.back -eq -1)
    }

    [string] ToString() {
        <#
        .DESCRIPTION
        Helper function to print out the circular buffer.
        #>
        $formattedBuffer = $this.buffer | ForEach-Object {$_ ? $_ : " "}
        return "[$($formattedBuffer -join "][")]" 
    }
}