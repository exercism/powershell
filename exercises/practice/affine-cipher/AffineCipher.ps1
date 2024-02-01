Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Use the affine cipher, an ancient encryption system created in the Middle East to encrypt text.

    .DESCRIPTION
    The encryption function is: E(x) = (ai + b) mod m
    
    i is the letter's index from 0 to the length of the alphabet - 1
    m is the length of the alphabet. For the Roman alphabet m is 26.
    a and b are integers which make the encryption key
    Values a and m must be coprime, if not you should throw error.

    .PARAMETER Plaintext
    The text to be encrypted.

    .PARAMETER Keys
    A hashtable contain the pair of keys `a` and `b`.

    .EXAMPLE
    Invoke-Encode -Plaintext "test" -Keys @{a = 5; b = 7}
    Returns: "ybty"
    #>
    [CmdletBinding()]
    Param(
        [string]$Plaintext,
        [hashtable]$Keys
    )
    Throw "Please implement this function"
}

Function Invoke-Decode() {
    <#
    .SYNOPSIS
    Use the affine cipher, an ancient encryption system created in the Middle East to decrypt ciphertext.

    .DESCRIPTION
    The decryption function is: D(y) = (a^-1)(y - b) mod m
    
    y is the numeric value of an encrypted letter, i.e., y = E(x)
    it is important to note that a^-1 is the modular multiplicative inverse (MMI) of a mod m
    the modular multiplicative inverse only exists if a and m are coprime, if they are not you should throw error.
    The MMI of a is x such that the remainder after dividing ax by m is 1: ax mod m = 1

    .PARAMETER Ciphertext
    The text to be decrypted.

    .PARAMETER Keys
    A hashtable contain the pair of keys `a` and `b`.

    .EXAMPLE
    Invoke-Decode -Ciphertext "ybty" -Keys @{a = 5; b = 7}
    Returns: "test"
     #>
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [hashtable]$Keys
    )
    Throw "Please implement this function"
}