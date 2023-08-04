Function Get-PhoneNumber() {
    <#
    .SYNOPSIS
    Clean up user-entered phone numbers so that they can be sent SMS messages.

    .DESCRIPTION
    Given a phone number string, check if it's a valid phone number that complied with the NANP system.
    Return the cleaned number string if it's valid, otherwise throw the relevant error.
    Also provide user the option to print out the number in pretty format.

    .PARAMETER Number
    The phone number string to be processed.

    .PARAMETER Pretty
    Provide optional flag that will print out the phone number in pretty format: (Area)-Exchange-Number
    
    .EXAMPLE
    Get-PhoneNumber -Number '+1 (223) 456-7890'
    return: '2234567890'

    Get-PhoneNumber -Number '555.888.9999' -Pretty
    return: '(555)-888-9999'
    #>
    [CmdletBinding()]
    Param(
        [string]$Number,
        [switch]$Pretty
    )

    (Get-Digits $Number) -match '^(\d?)(\d{3})(\d{3})(\d{4})$' | Out-Null
    $CountryCode    = $Matches[1]
    $AreaCode       = $Matches[2]
    $ExchangeCode   = $Matches[3]
    $LineNumber     = $Matches[4]

    Test-Number $CountryCode $AreaCode $ExchangeCode
    if ($Pretty) {
        return "($AreaCode)-$ExchangeCode-$LineNumber"
    }
    return "$AreaCode$ExchangeCode$LineNumber"
}
Function Get-Digits($String) {
    if ($String -match '[a-zA-Z]') {
        Throw 'Letters not permitted'
    }
    if ($String -match '[^\s\w+()-.]') {
        Throw 'Punctuations not permitted'
    }
    
    $Digits =  $String -replace '[^\d]',''
    if ($Digits.Length -lt 10) {
        Throw "Number can't be fewer than 10 digits"
    }
    if ($Digits.Length -gt 11) {
        Throw "Number can't be more than 11 digits"
    }
    return $Digits
}

Function Test-Number($Country, $Area, $Exchange) {
    if ($Country -and $Country -ne '1') {
        Throw '11 digits must start with 1'
    }
    if ($Area[0] -eq '1' -or $Area[0] -eq '0') {
        Throw "Area code can't start with $($Area[0])"
    }
    if ($Exchange[0] -eq '1' -or $Exchange[0] -eq '0') {
        Throw "Exchange code can't start with $($Exchange[0])"
    }
}