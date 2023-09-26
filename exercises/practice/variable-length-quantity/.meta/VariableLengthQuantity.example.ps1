Function Invoke-EncodeVLQ() {
    <#
    .SYNOPSIS
    Implement variable length quantity encoding

    .DESCRIPTION
    Given an array of integer values, encoding them using variable-length quantity technique to save spaces.

    .PARAMETER Bytes
    Array of data to be encoded.

    .EXAMPLE
    Invoke-EncodeVLQ -Bytes @(0x40)
    Returns: @(0x40)
    #>
    [CmdletBinding()]
    Param(
        [UInt32[]]$Bytes
    )
    $encodedValues = @()

    foreach ($number in $Bytes) {
        $binStr = [convert]::ToString($number,2)
        if ($number -lt 0x80) {
            $encodedValues += $number
        }else {
            $encodedValues += ProcessBinary $binStr
        }
    }
    $encodedValues
}

function ProcessBinary($binary) {
    <#
    .DESCRIPTION
    Helper function that will take a binary string, read from right to left split and pad them into chunks of lenght 7,
    add the MSB and convert them to normal value.
    #>
    $values = @()
    $bits = 7
    for ($i = $binary.Length; $i -gt 0; $i-=$bits) {
        $startIdx = $i-$bits -ge 0 ? $i-$bits : 0 
        $chunkLength = [math]::Min($bits, $i)
        $binstr = $binary.Substring($startIdx,$chunkLength).PadLeft(7,"0")
        $value  = $i -eq $binary.Length ? [Convert]::ToUInt32("0$binstr",2) : [Convert]::ToUInt32("1$binstr",2)
        $values = @($value) + $values
    }
    $values
}

Function Invoke-DecodeVLQ() {
    <#
    .SYNOPSIS
    Implement variable length quantity decoding.

    .DESCRIPTION
    Given an array of encoded integer values, decoding them to get the original values.

    .PARAMETER Bytes
    Array of data to be decoded.

    .EXAMPLE
    Invoke-DecodeVLQ -Bytes @(0x7F)
    Returns: @(0x7F)
    #>
    [CmdletBinding()]
    Param(
        [UInt32[]]$Bytes
    )
    # Last value in a sequence can't be larger than 0x80 (127)
    if ($Bytes[-1] -ge 0x80) {
        Throw "Incomplete sequence"
    }

    $decodedValues = @()
    # A sequence end when a value smaller than 128 enter
    $sequence = @()
    foreach ($byte in $Bytes) {
        $binary = [convert]::ToString($byte,2).PadLeft(8,"0").Substring(1,7)
        if ($byte -gt 0x7F) {
            $sequence += $binary
        }else {
            $sequence += $binary
            $decimalValue = [Convert]::ToUInt32((-join $sequence),2)
            $decodedValues += $decimalValue
            $sequence = @()
        }
    }
    $decodedValues
}