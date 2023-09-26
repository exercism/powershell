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

    Throw "Please implement this function"
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

    Throw "Please implement this function"
}