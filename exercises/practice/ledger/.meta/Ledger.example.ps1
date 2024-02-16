<#
.SYNOPSIS
    Refactor a ledger printer.

.DESCRIPTION
    The code below is an attempt of creating a printer for a ledger.
    It barely works (only passed some of the tests), and is generally quite messy.
    Your job here is to refactor the code.

.EXAMPLE
    $entry1 = CreateEntry -Date '2011-12-13' -Desc 'Birthday present' -Amount 1234
    $entry2 = CreateEntry -Date '2011-11-19' -Desc 'Party prep & catering services' -Amount 98765
    FormatEntries -Currency "EUR" -Locale "en-US" -Entries @($entry1, $entry2)

    Returns:
    @"
    Date       | Description               | Change
    11/19/2011 | Party prep & catering ... |      €987.65
    12/13/2011 | Birthday present          |       €12.34
    "@
#>

Class LedgerEntry{
    [datetime] $Date
    [string] $Desc
    [int] $Change

    LedgerEntry($date, $desc, $change) {
        $this.Date = $date
        $this.Desc = $desc
        $this.Change = $change
    }

    [string] Format([string] $Currency, [string] $Locale) {
        $format   = $this.GetFrame($Locale, $this.Change)
        $dateFormat  = $this.GetDateFormat($Currency, $Locale)

        $dateStr  = $this.Date.ToString($dateFormat)
        $culture = [CultureInfo]::new($Locale)
        $moneyStr = ($this.Change / 100).ToString("C2", $culture)

        if ($Currency -eq "EUR" -and $Locale -eq "en-US") {
            $moneyStr = $moneyStr -replace '\$', '€'
        }
        if ($Currency -eq "USD" -and $Locale -eq "nl-NL") {
            $moneyStr = $moneyStr -replace '€', '$'
        }
        if ($this.Desc.Length -gt 25) {
            $this.Desc = $this.Desc.Substring(0,22) + "..."
        }
        return $format -f @($dateStr, $this.Desc, $moneyStr)
    }

    [string] hidden GetFrame([string] $Locale, [int] $Change) {
        if ($Locale -eq "nl-NL" -or $Change -ge 0) {
            return "{0,-10} | {1,-25} | {2,12} "
        }
        return "{0,-10} | {1,-25} | {2,13}"
    }

    [object] hidden GetDateFormat([string] $Currency, [string] $Locale) {
        $dateFrm = switch ($Locale) {
            "en-US" { "MM\/dd\/yyyy" }
            "nl-NL" { "dd-MM-yyyy" }
            Default {Throw "Locale not supported"}
        }
        return $dateFrm
    }

    [string] static Header($Locale) {
        $format = "{0,-10} | {1,-25} | {2,-13}"
        $info = switch ($Locale) {
            "en-US" { @("Date", "Description", "Change")  }
            "nl-NL" { @("Datum", "Omschrijving", "Verandering") }
            Default {Throw "Locale not supported"}
        }
        return $format -f $info
    }
}

Function CreateEntry {
    <#
    .DESCRIPTION
    A function to create an entry for the ledger.
    This function is required for the test suite.

    .PARAMETER Date
    String represent the date.

    .PARAMETER Desc
    String represent the description of the entry.

    .PARAMETER Amount
    Integer represent the amount of money in cents.
    #>
    param (
        [string] $Date,
        [string] $Desc,
        [int] $Amount
    )
    [LedgerEntry]::new($Date, $Desc, $Amount)
}

Function FormatEntries {
    <#
    .DESCRIPTION
    A function to formats the entries of the ledger based on other info.
    This function is required for the test suite.

    .PARAMETER Currency
    String represent the currency symbol.

    .PARAMETER Locale
    String represent the region and culture to be followed.

    .PARAMETER Entries
    Array of entries, each is an instance of the class LedgerEntry, created via CreateEntry function.
    #>
    param (
        [string] $Currency,
        [string] $Locale,
        [LedgerEntry[]] $Entries
    )
    $table = @()
    $table += [LedgerEntry]::Header($Locale)
    $Entries = $Entries | Sort-Object Date, Desc, Change
    foreach ($entry in $Entries) {
        $table += $entry.Format($Currency, $Locale)
    }
    $table -join "`n"
}
