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
    Throw "Please implement this function"
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
    Throw "Please implement this function"
}
