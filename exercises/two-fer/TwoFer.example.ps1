Function Get-TwoFer(){
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false, Position=0)]
        [string]$Name
    )

    # Replace null or empty string with "you"
    If ([string]::IsNullOrEmpty($Name))
    {
        $Name = "you"
    }

    "One for $Name, one for me"
}