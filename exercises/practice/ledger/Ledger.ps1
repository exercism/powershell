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
    [string] $Date
    [string] $Desc
    [double] $Change

    LedgerEntry() {
        $this.Date = $null
        $this.Desc = $null
        $this.Change = $null
    }

    LedgerEntry($date, $desc, $change) {
        $this.Date = $date
        $this.Desc = $desc
        $this.Change = $change
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

    $entry = [LedgerEntry]::new()

    if (-not $entry.Date) {
        $entry.Date = $Date
    }

    if (-not $entry.Desc) {
        $entry.Desc = $Desc
    }

    if (-not $entry.Change) {
        $entry.Change = $Amount
    }
    return $entry
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
    $table += MakeHeader $Locale
    $Entries = $Entries | Sort-Object Date, Desc, Change
    foreach ($entry in $Entries) {
        $table += MakeEntry $Currency $Locale $entry
    }
    $result = $table -join "`n"
    return $result
}

Function MakeHeader($Locale) {
    <#
    .DESCRIPTION
    An optional helper function that help creating the header.
    #>
    if ($Locale -eq 'en-Us') {
        $header = @("") * 54
        for ($i = 0; $i -lt $header.Count; $i++) {
            if ($i -lt 4){
                $header[$i] = "Date"[$i]
            }elseif ($i -gt 12 -and $i -lt 24) {
                $header[$i] = "Description"[$i-13]
            }elseif ($i -gt 40 -and $i -lt 47) {
                $header[$i] = "Change"[$i-41]
            }elseif ($i -eq 11 -or $i -eq 39) {
                $header[$i] = "|"
            }else {
                $header[$i] = " "
            }
        }
    }elseif ($Locale -eq 'nl-NL') {
        $header = @("") * 54
        for ($i = 0; $i -lt $header.Count; $i++) {
            if ($i -lt 5){
                $header[$i] = "Datum"[$i]
            }elseif ($i -gt 12 -and $i -lt 25) {
                $header[$i] = "Omschrijving"[$i-13]
            }elseif ($i -gt 40 -and $i -lt 52) {
                $header[$i] = "Verandering"[$i-41]
            }elseif ($i -eq 11 -or $i -eq 39) {
                $header[$i] = "|"
            }else {
                $header[$i] = " "
            }
        }
    }
    return $header -join ""
}

Function MakeEntry {
    <#
    .DESCRIPTION
    An optional helper function that create and format each entry.
    #>
    param (
        [string] $Currency,
        [string] $Locale,
        [LedgerEntry] $Entry
    )

    if ($Currency -eq "USD") {
        if ($Locale -eq "en-US") {
            $symbol = "$"
            $date = [datetime]$Entry.Date
            $dateStr = $date.ToString("MM\/dd\/yyyy")
            if($Entry.Change -lt 0) {
                $money = $entry.Change / 100
                $money = $money.ToString("C2")
                $change = $money
            }else {
                $money = $entry.Change / 100
                $money = $money.ToString("N2", [cultureinfo]"en-US")
                $change = "$symbol$money "
            }

        }elseif ($Locale -eq "nl-NL") {
            $symbol = "$"
            $date = [datetime]$Entry.Date
            $dateStr = $date.ToString("dd-MM-yyyy")
            if($Entry.Change -lt 0) {
                $money = $entry.Change / 100
                $money = $money.ToString("N2", [cultureinfo]"nl-NL")
                $change = "$symbol $money "
            }else {
                $money = $entry.Change / 100
                $money = $money.ToString("N2", [cultureinfo]"nl-NL")
                $change = "$symbol $money "
            }
        }
        
    }elseif ($Currency -eq "EUR") {
        if ($Locale -eq "en-US") {
            $symbol = "€"
            $date = [datetime]$Entry.Date
            $dateStr = $date.ToString("MM\/dd\/yyyy")
            if($Entry.Change -lt 0) {
                $money = $entry.Change / 100
                $money = $money.ToString("C2")
                $change = $money -replace "\$", $symbol
            }else {
                $money = $entry.Change / 100
                $money = $money.ToString("N2", [cultureinfo]"en-US")
                $change = "$symbol$money"
            }
        }elseif ($Locale -eq "nl-NL") {
            $symbol = "€"
            $date = [datetime]$Entry.Date
            $dateStr = $date.ToString("dd-MM-yyyy")
            if($Entry.Change -lt 0) {
                $money = $entry.Change / 100
                $money = $money.ToString("N2", [cultureinfo]"nl-NL")
                $change = "$symbol $money "
            }else {
                $money = $entry.Change / 100
                $money = $money.ToString("N2", [cultureinfo]"nl-NL")
                $change = "$symbol $money "
            }
        }
    }

    #Truncated too long desc
    $desc = ""
    if ($Entry.Desc.Length -gt 25) {
        for ($i = 0; $i -lt 22; $i++) {
            $desc += $Entry.Desc[$i]
        }
        $desc += "..."
    }else {
        $desc = $Entry.Desc
    }

    #Format the text into correct space
    $desc = "{0,-25}" -f $desc
    $change = "{0,13}" -f $change

    "$dateStr | $desc | $change"
}