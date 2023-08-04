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
    Throw "Please implement this function"
}