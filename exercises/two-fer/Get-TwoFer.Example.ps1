Function Get-TwoFer(){
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0)]
        [AllowEmptyString()]
        [string]$Name
    )

    # Replace null or empty string with "you"
    If ([string]::IsNullOrEmpty($Name))
    {
        $Name = "you"
    }

    "One for $Name, one for me"
}