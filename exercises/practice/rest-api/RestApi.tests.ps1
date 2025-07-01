BeforeAll {
    . "./RestApi.ps1"

    Function Test-ApiResult([object]$got, [object]$want, [string]$path = "expected") {
        <#
        .SYNOPSIS
        Test the result returned from a REST API call to make sure that it matches the expected value.

        .DESCRIPTION
        Recursively test the result returned from a REST API call against the expected value:

        - For a hash table:
          - Make sure that the keys match
          - Recursively check that each value matches
        - For an array:
          - Make sure that the number of values match
          - Recursively check that each value matches
        - For a simple value, make sure that the value matches
        #>
        if ($want -is [hashtable]) {
            $gotKeys = $got.Keys | Sort-Object
            $wantKeys = $want.Keys | Sort-Object
            $gotKeys | Should -BeExactly $wantKeys -Because "those are the expected keys for $path"

            foreach ($entry in $want.GetEnumerator()) {
                Test-ApiResult $got[$entry.Key] $entry.Value "$path[`"$($entry.Key)`"]"
            }
        }
        elseif ($want -is [array]) {
            $gotCount = $got.Count
            $wantCount = $want.Count
            $gotCount | Should -BeExactly $wantCount -Because "that is the expected number of $path values"

            for ($i = 0; $i -lt $wantCount; $i++) {
                Test-ApiResult $got[$i] $want[$i] "$path[$i]"
            }
        }
        else {
            $got | Should -BeExactly $want -Because "that is the expected value for $path"
        }
    }
}

Describe "RestApi test cases" {
    It "user management -> no users" {
        $data = @{Users = @()}
        $api = [RestAPI]::new($data)
        $got = $api.Get("/users") 
        $want = @{users = @()}

        Test-ApiResult $got $want
    }

    It "user management -> add user" {
        $data = @{Users = @()}
        $api = [RestAPI]::new($data)
        $got = $api.Post("/add", '{"user": "Adam"}')
        $want = @{
            name = "Adam"; owes = @{}; owed_by = @{}; balance = 0.0
        }

        Test-ApiResult $got $want
    }

    It "user management -> get single user" {
        $data = @{ 
            users = @(
                @{name = "Adam"; owes = @{}; owed_by = @{}; balance = 0.0}
                @{name = "Bob"  ; owes = @{}; owed_by = @{}; balance = 0.0}
            ) 
        }
        $api = [RestAPI]::new($data)
        $got = $api.Get("/users", '{"users": ["Bob"]}')
        $want = @{
            users = @(
                @{ name = "Bob"; owes = @{}; owed_by = @{};balance = 0.0 }
            )
        } 

        Test-ApiResult $got $want
    }

    # addition test to make sure you can't add existing user
    It "user management -> adding existing user throw error" {
        $data = @{ 
            users = @(
                @{name = "Adam"; owes = @{}; owed_by = @{}; balance = 0.0}
                @{name = "Bob"  ; owes = @{}; owed_by = @{}; balance = 0.0}
            ) 
        }
        $api = [RestAPI]::new($data)

        { $api.Post("/add", '{"user": "Adam"}') } | Should -Throw "*User already existed*"
    }

    It "iou -> both users have 0 balance" {
        $data = @{ 
            users = @(
                @{name = "Adam"; owes = @{}; owed_by = @{}; balance = 0.0}
                @{name = "Bob"  ; owes = @{}; owed_by = @{}; balance = 0.0}
            ) 
        }
        $api  = [RestAPI]::new($data)
        $got  = $api.Post("/iou", '{"lender": "Adam", "borrower": "Bob", "amount": 3.0}')
        $want = @{ 
            users = @(
                @{name = "Adam"; owes = @{}; owed_by = @{Bob = 3.0}; balance = 3.0}
                @{name = "Bob"  ; owes = @{Adam = 3.0}; owed_by = @{}; balance = -3.0}
            )
        }

        Test-ApiResult $got $want
    }

    It "iou -> borrower has negative balance" {
        $data = @{ 
            users = @(
                @{name = "Adam" ; owes = @{}; owed_by = @{}; balance = 0.0}
                @{name = "Bob"   ; owes = @{Chuck = 3.0}; owed_by = @{}; balance = -3.0}
                @{name = "Chuck" ; owes = @{}; owed_by = @{Bob = 3.0}; balance = 3.0}
            ) 
        }
        $api  = [RestAPI]::new($data)
        $got  = $api.Post("/iou", '{"lender": "Adam", "borrower": "Bob", "amount": 3.0}')
        $want = @{ 
            users = @(
                @{name = "Adam" ; owes = @{}; owed_by = @{Bob = 3.0}; balance = 3.0}
                @{name = "Bob"   ; owes = @{Adam = 3.0 ; Chuck = 3.0}; owed_by = @{}; balance = -6.0}
            )
        }

        Test-ApiResult $got $want
    }

    It "iou -> lender has negative balance" {
        $data = @{ 
            users = @(
                @{name = "Adam" ; owes = @{}; owed_by = @{}; balance = 0.0}
                @{name = "Bob"   ; owes = @{Chuck = 3.0}; owed_by = @{}; balance = -3.0}
                @{name = "Chuck" ; owes = @{}; owed_by = @{Bob = 3.0}; balance = 3.0}
            ) 
        }
        $api  = [RestAPI]::new($data)
        $got  = $api.Post("/iou", '{"lender": "Bob", "borrower": "Adam", "amount": 3.0}')
        $want = @{ 
            users = @(
                @{name = "Adam" ; owes = @{Bob = 3.0}; owed_by = @{}; balance = -3.0}
                @{name = "Bob"   ; owes = @{Chuck = 3.0}; owed_by = @{Adam = 3.0}; balance = 0.0}
            )
        }

        Test-ApiResult $got $want
    }

    It "iou -> lender owes borrower" {
        $data = @{ 
            users = @(
                @{name = "Adam" ; owes = @{Bob = 3.0}; owed_by = @{}; balance = -3.0}
                @{name = "Bob"   ; owes = @{}; owed_by = @{Adam = 3.0}; balance = 3.0}
            ) 
        }
        $api  = [RestAPI]::new($data)
        $got  = $api.Post("/iou", '{"lender": "Adam", "borrower": "Bob", "amount": 2.0}')
        $want = @{ 
            users = @(
                @{name = "Adam" ; owes = @{Bob = 1.0}; owed_by = @{}; balance = -1.0}
                @{name = "Bob"   ; owes = @{}; owed_by = @{Adam = 1.0}; balance = 1.0}
            )
        }

        Test-ApiResult $got $want
    }

    It "iou -> lender owes borrower less than new loan" {
        $data = @{ 
            users = @(
                @{name = "Adam" ; owes = @{Bob = 3.0}; owed_by = @{}; balance = -3.0}
                @{name = "Bob"   ; owes = @{}; owed_by = @{Adam = 3.0}; balance = 3.0}
            ) 
        }
        $api  = [RestAPI]::new($data)
        $got  = $api.Post("/iou", '{"lender": "Adam", "borrower": "Bob", "amount": 4.0}')
        $want = @{ 
            users = @(
                @{name = "Adam" ; owes = @{}; owed_by = @{Bob = 1.0}; balance = 1.0}
                @{name = "Bob"   ; owes = @{Adam = 1.0}; owed_by = @{}; balance = -1.0}
            )
        }

        Test-ApiResult $got $want
    }

    It "iou -> lender owes borrower same as new loan" {
        $data = @{ 
            users = @(
                @{name = "Adam" ; owes = @{Bob = 3.0}; owed_by = @{}; balance = -3.0}
                @{name = "Bob"   ; owes = @{}; owed_by = @{Adam = 3.0}; balance = 3.0}
            ) 
        }
        $api  = [RestAPI]::new($data)
        $got  = $api.Post("/iou", '{"lender": "Adam", "borrower": "Bob", "amount": 3.0}')
        $want = @{ 
            users = @(
                @{name = "Adam" ; owes = @{}; owed_by = @{}; balance = 0.0}
                @{name = "Bob"   ; owes = @{}; owed_by = @{}; balance = 0.0}
            )
        }

        Test-ApiResult $got $want
    }
}
