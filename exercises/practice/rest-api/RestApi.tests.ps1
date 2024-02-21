BeforeAll {
    . "./RestApi.ps1"
}

Describe "RestApi test cases" {
    It "user management -> no users" {
        $data = @{Users = @()}
        $api = [RestAPI]::new($data)
        $got = $api.Get("/users") 
        $want = @{users = @()}

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
    }

    It "user management -> add user" {
        $data = @{Users = @()}
        $api = [RestAPI]::new($data)
        $got = $api.Post("/add", '{"user": "Adam"}')
        $want = @{
            name = "Adam"; owes = @{}; owed_by = @{}; balance = 0.0
        }

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
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

        ($got | ConvertTo-Json -Depth 5) | Should -BeExactly ($want | ConvertTo-Json -Depth 5)
    }
}
