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
    $buffer

    CircularBuffer() {
        Throw "Please implement this class"
    }

    Write() {
        Throw "Please implement this function"
    }

    Overwrite() {
        Throw "Please implement this function"
    }

    Clear() {
        Throw "Please implement this function"
    }

    Read() {
        Throw "Please implement this function"
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

