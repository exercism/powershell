<#
.SYNOPSIS
Implement a simple shift cipher like Caesar and a more secure substitution cipher.

.DESCRIPTION
Implement a simple cipher class to encode or decode a message with a key.
If there was no key provided, generate one minumum 100 characters long contains only lower case letter (a-z).

.EXAMPLE
$cipher = [SimpleCipher]::new("mykey")

$cipher.Encode("aaaaa")
Return: "mykey"

$cipher.Decode("ecmvcf")
Return: "secret"
#>

Class SimpleCipher {
    $_key

    SimpleCipher() {
        Throw "Please implement this class"
    }

    Encode() {
        Throw "Please implement this function"
    }

    Decode() {
        Throw "Please implement this function"
    }
}