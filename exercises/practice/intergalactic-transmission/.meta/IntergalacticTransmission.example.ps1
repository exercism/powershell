Function Invoke-Transmitter() {
    <#
    .SYNOPSIS
    Implement the transmitter to calculates the transmission sequence.

    .DESCRIPTION
    Implement a function that accept a sequence and encode it with parity bits to help detecting transmission errors.

    .PARAMETER Sequence
    An array of hexadecimal values.

    .EXAMPLE
    Invoke-Transmitter -Sequence @(0x05)
    Returns: @(0x05, 0x81)
    #>
    [CmdletBinding()]
    Param(
        [byte[]]$Sequence
    )
    [bigint]$buffer = 0
    [int]$bufferLen = 0
    $encoded = @()
    foreach ($byte in $Sequence) {
        $buffer = $buffer -shl 8 -bor $byte
        $bufferLen += 8
        while ($bufferLen -ge 7) {
            $shift  = $bufferLen - 7
            $sevenBits = ($buffer -shr $shift) -band 0x7f
            $parityBit = [System.Numerics.BitOperations]::PopCount([uint32]$sevenBits) -band 1
            $encodedByte = $sevenBits -shl 1 -bor $parityBit
            $bufferLen -=7
            $encoded += $encodedByte
        }
    }
    if ($bufferLen -gt 0)
    {
        $padRight = 7 - $bufferLen
        $maskedBits = $buffer -band ((1 -shl $bufferLen) - 1)
        $lastParityBit = [System.Numerics.BitOperations]::PopCount([uint32]$maskedBits) -band 1
        $encodedByte = $maskedBits -shl $padRight -shl 1 -bor $lastParityBit
        $encoded += $encodedByte
    }
    $encoded
}

Function Invoke-Receiver() {
    <#
    .SYNOPSIS
    Implement the receiver to decode the transmission sequence.

    .DESCRIPTION
    Implement a function to receive a sequence and decode it to the original message.

    .PARAMETER Sequence
    An array of hexadecimal values.

    .EXAMPLE
    Invoke-Receiver -Sequence @(0x05, 0x81)
    Returns: @(0x05)
    #>
    [CmdletBinding()]
    Param(
        [byte[]]$Sequence
    )
    [bigint]$buffer = 0
    [int]$bufferLen = 0
    $decoded = @()
    
    foreach ($byte in $Sequence) {
        $onesCount = [System.Numerics.BitOperations]::PopCount([uint32]$byte)
        if ($onesCount -band 1 -eq 1)
        {
            throw "wrong parity"
        }
        $sevenBits = $byte -shr 1
        $buffer = $buffer -shl 7 -bor $sevenBits
        $bufferLen += 7
        while ($bufferLen -ge 8)
        {
            $shift = $bufferLen - 8
            $originalByte = $buffer -shr $shift -band 0xff
            $bufferLen -= 8
            $decoded += $originalByte
        }
    }
    $decoded
}
