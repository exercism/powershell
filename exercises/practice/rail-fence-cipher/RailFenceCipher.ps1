Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Implement encoding for the rail fence cipher.

    .DESCRIPTION
    In the Rail Fence cipher, the message is written downwards on successive "rails" of an imaginary fence, then moving up when we get to the bottom (like a zig-zag).
    Finally the message is then read off in rows.

    .PARAMETER Message
    The message to be encoded.

    .PARAMETER Rails
    The number of rails to be use to construct the rail fence.

    .EXAMPLE
    Invoke-Encode -Message "EXERCISM" -Rails 2
    Returns: "EECSXRIM"
    #>
    [CmdletBinding()]
    Param(
        [string]$Message,
        [int]$Rails
    )

    Throw "Please implement this function"
}

Function Invoke-Decode() {
    <#
    .SYNOPSIS
    Implement decoding for the rail fence cipher.

    .DESCRIPTION

    .PARAMETER CipherText
    The ciphertext to be decoded.

    .PARAMETER Rails
    The number of rails to be use to construct the rail fence.

    .EXAMPLE
    Invoke-Decode -Ciphertext "EECSXRIM" -Rails 2
    Returns: "EXERCISM"
    #>
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [int]$Rails
    )

    Throw "Please implement this function"
}