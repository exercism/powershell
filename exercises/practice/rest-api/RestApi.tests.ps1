BeforeAll {
    . "./RestApi.ps1"

    Function Test-ApiResult([object]$got, [object]$want, [string[]]$path = $null) {
        $path = $path ?? @()
        $basePath = $path -join "."
        if ($want -is [hashtable]) {
            # Make sure keys are the same
            $gotKeys = $got.Keys | Sort-Object
            $wantKeys = $want.Keys | Sort-Object
            $gotKeys | Should -BeExactly $wantKeys -Because "$basePath keys"

            # Make sure values are the same
            foreach ($entry in $want.GetEnumerator()) {
                Test-ApiResult $got[$entry.Key] $entry.Value ($path + $entry.Key)
            }
        }
        elseif ($want -is [array]) {
            # Make number of values is the same
            $gotCount = $got.Count
            $wantCount = $want.Count
            $gotCount | Should -BeExactly $wantCount -Because "$basePath value count"

            # Make sure values are the same
            for ($i = 0; $i -lt $wantCount; $i++) {
                Test-ApiResult $got[$i] $want[$i] ($path + "[$i]")
            }
        }
        else {
            # Make sure value is the same
            $got | Should -BeExactly $want -Because $basePath
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
