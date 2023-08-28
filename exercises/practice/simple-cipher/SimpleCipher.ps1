Function Invoke-EncodeCipher() {
    <#
    .SYNOPSIS
    Implement a simple shift cipher like Caesar and a more secure substitution cipher.

    .DESCRIPTION
    Given a string of plaintext and a string of key, encode the text using the key.
    If there is no key provided, generate a random key of minumun 100 lowercase letters.
    
    .PARAMETER Plaintext
    String of text to be encrypted.
    This parameter be able to accept value from pipeline.

    .PARAMETER Key
    The key string used to encrypt the plaintext.

    .EXAMPLE
    Invoke-EncodeCipher -Plaintext "b" -Key "d"
    Return: "e"
    #>
    [CmdletBinding()]
    Param(
        [string]$Plaintext,
        [string]$Key
    )
    Throw "Please implement this function"
}

Function Invoke-DecodeCipher() {
    <#
    .SYNOPSIS
    Implement a simple shift cipher like Caesar and a more secure substitution cipher.

    .DESCRIPTION
    Given a string of ciphertext and a string of key, decode the text using the key.
    
    .PARAMETER Ciphertext
    String of encoded text.
    This parameter should be able to accept value from pipeline.

    .PARAMETER Key
    The key string used to decode the ciphertext.

    .EXAMPLE
    Invoke-DecodeCipher -Ciphertext "f" -Key "d"
    Return: "c"
    #>
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [string]$Key
    )
    Throw "Please implement this function"
}

Function GenerateKey() {
    <#
    .SYNOPSIS
    Implement a function to generate a random key to work with the cipher.

    .DESCRIPTION
    Gerate a key string of minimum 100 lowercase letters.

    .EXAMPLE
    GenerateKey
    Return: "zxweavtutoadkjvbtldoljeyahzhaewaujyyowxdqxvxiadkeerloshchnhihmkvpvrwrqfgtbfxwtrnjcwssbawsxqixsbyrlbs"
    #>
    Throw "Please implement this function"
}
