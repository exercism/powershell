Function Get-BobResponse() {
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    # Clear whitespace around the input
    $HeyBob = $HeyBob.Trim()

    # The three types of input
    $shouting = $false
    $question = $false
    $saidnothing = $false

    # Tests for the types of input
    If (($HeyBob.ToUpper() -ceq $HeyBob) -and ($HeyBob -cmatch "[A-Za-z]")) { $shouting = $true }
    If ($HeyBob[$HeyBob.Length - 1] -eq "?") { $question = $true }
    If ([string]::IsNullOrEmpty($HeyBob)) { $saidnothing = $true }

    # Determine the output based on the results of the tests
    If ($saidnothing) { Return "Fine. Be that way!" }
    If ($question -and $shouting ) { Return "Calm down, I know what I'm doing!" }
    If ($question) { Return "Sure." }
    If ($shouting) { Return "Whoa, chill out!" }

    # Default return value
    Return "Whatever."
}
