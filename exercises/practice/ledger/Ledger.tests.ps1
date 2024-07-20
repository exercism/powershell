BeforeAll {
    . "./Ledger.ps1"
}

Describe "Ledger test cases" {
    It "empty ledger" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @()
        }
        
        $got  = FormatEntries @params
        $want = 'Date       | Description               | Change       '

        $got | Should -BeExactly $want
    }

    It "one entry" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-01' -Desc 'Buy present' -Amount -1000
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       ',
            '01/01/2015 | Buy present               |      ($10.00)'
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "credit and debit" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-02' -Desc 'Get present' -Amount 1000
                CreateEntry -Date '2015-01-01' -Desc 'Buy present' -Amount -1000
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       '
            '01/01/2015 | Buy present               |      ($10.00)'
            '01/02/2015 | Get present               |       $10.00 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "multiple entries on same date ordered by description" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-01' -Desc 'Get present' -Amount 1000
                CreateEntry -Date '2015-01-01' -Desc 'Buy present' -Amount -1000
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       '
            '01/01/2015 | Buy present               |      ($10.00)'
            '01/01/2015 | Get present               |       $10.00 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "final order tie breaker is change" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-01' -Desc 'Something' -Amount 0
                CreateEntry -Date '2015-01-01' -Desc 'Something' -Amount -1
                CreateEntry -Date '2015-01-01' -Desc 'Something' -Amount 1
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       '
            '01/01/2015 | Something                 |       ($0.01)'
            '01/01/2015 | Something                 |        $0.00 '
            '01/01/2015 | Something                 |        $0.01 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "overlong description is truncated" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-01' -Desc 'Freude schoner Gotterfunken' -Amount -123456
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       ',
            '01/01/2015 | Freude schoner Gotterf... |   ($1,234.56)'
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "euros" {
        $params = @{
            Currency = "EUR"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-01' -Desc 'Buy present' -Amount -1000
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       ',
            '01/01/2015 | Buy present               |      (€10.00)'
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "Dutch locale" {
        $params = @{
            Currency = "USD"
            Locale = "nl-NL"
            Entries = @(
                CreateEntry -Date '2015-03-12' -Desc 'Buy present' -Amount 123456
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Datum      | Omschrijving              | Verandering  ',
            '12-03-2015 | Buy present               |   $ 1.234,56 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "Dutch locale and euros" {
        $params = @{
            Currency = "EUR"
            Locale = "nl-NL"
            Entries = @(
                CreateEntry -Date '2015-03-12' -Desc 'Buy present' -Amount 123456
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Datum      | Omschrijving              | Verandering  ',
            '12-03-2015 | Buy present               |   € 1.234,56 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "Dutch negative number with 3 digits before decimal point" {
        $params = @{
            Currency = "USD"
            Locale = "nl-NL"
            Entries = @(
                CreateEntry -Date '2015-03-12' -Desc 'Buy present' -Amount -12345
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Datum      | Omschrijving              | Verandering  ',
            '12-03-2015 | Buy present               |    $ -123,45 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "American negative number with 3 digits before decimal point" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-03-12' -Desc 'Buy present' -Amount -12345
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       ',
            '03/12/2015 | Buy present               |     ($123.45)'
        ) -join "`n"

        $got | Should -BeExactly $want
    }

    It "multiple entries on same date ordered by description" {
        $params = @{
            Currency = "USD"
            Locale = "en-US"
            Entries = @(
                CreateEntry -Date '2015-01-01' -Desc 'Get present' -Amount 1000
                CreateEntry -Date '2015-01-01' -Desc 'Buy present' -Amount -1000
            )
        }
        
        $got  = FormatEntries @params
        $want = @(
            'Date       | Description               | Change       ',
            '01/01/2015 | Buy present               |      ($10.00)',
            '01/01/2015 | Get present               |       $10.00 '
        ) -join "`n"

        $got | Should -BeExactly $want
    }
}
