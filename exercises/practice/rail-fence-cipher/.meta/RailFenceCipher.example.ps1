#Adapt from the awesome solution:
#https://exercism.org/tracks/python/exercises/rail-fence-cipher/solutions/tcarobruce
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
    $pattern = RailPattern -Text $Message -Number $Rails
    $zipped  = Zipper -Values $Message.ToCharArray() -Indexes $pattern

    $encoded = $zipped | Sort-Object -Property Index -Stable | ForEach-Object {$_.Value} 
    -join $encoded
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
    $pattern = RailPattern -Text $Ciphertext -Number $Rails
    # sorted index based on pattern
    $indexes = (Zipper -Values (0..($Ciphertext.Length-1)) -Indexes $pattern) | Sort-Object -Property Index -Stable | ForEach-Object {$_.Value}

    $decode  = @($null) * $Ciphertext.Length
    for ($i = 0; $i -lt $Ciphertext.Length; $i++) {
        $decode[$indexes[$i]] = $Ciphertext[$i]
    }
    -join $decode
}

function RailPattern() {
    <#
    .DESCRIPTION
    Helper function to get the pattern of the rail fence. This will match the full length of the input text.
    For example: 3 rails will yield: 0,1,2,1,0...
    #>
    param (
        [string]$Text,
        [int]$Number
    )
    $pattern = 0..($Number-1) + ($Number-2)..1

    #get the pattern to match the text
    $fullPattern = $pattern * [math]::Ceiling($Text.Length/$pattern.Count)       
    $fullPattern[0..($Text.Length-1)]
}

function Zipper() {
    <#
    .DESCRIPTION
    Helper function act as a zipper for two collections.
    Return one collection with custom objects
    #>
    param (
        [object[]]$Values,
        [object[]]$Indexes
    )
    $zipped =  0..($Values.Count-1) | ForEach-Object {
        [PSCustomObject]@{
            Value = $Values[$_]
            Index = $Indexes[$_]
        }
    }
    $zipped
} 