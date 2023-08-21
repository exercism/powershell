BeforeAll {
    . "./Allergies.ps1"
}

Describe "Allergy test cases" {
    Context "not allergic to anything" {
        It "testing for <Name> allergy" -ForEach @(
            @{ Name = "eggs"}
            @{ Name = "peanuts"}
            @{ Name = "shellfish"}
            @{ Name = "strawberries"}
            @{ Name = "tomatoes"}
            @{ Name = "chocolate"}
            @{ Name = "pollen"}
            @{ Name = "cats"}
        ) {
            param($Name)

            $person = [Allergies]::new(0)
            $person.IsAllergicTo($Name) | Should -Be $false
        }
    }

    Context "allergic to everything" {
        It "testing for <name> allergy" -ForEach @(
            @{ Name = "eggs"}
            @{ Name = "peanuts"}
            @{ Name = "shellfish"}
            @{ Name = "strawberries"}
            @{ Name = "tomatoes"}
            @{ Name = "chocolate"}
            @{ Name = "pollen"}
            @{ Name = "cats"}
        ) {
            param($Name)

            $person = [Allergies]::new(255)
            $person.IsAllergicTo($Name) | Should -Be $true
        }
    }

    Context "allergic to only one allergen" {
        It "testing for <name> allergy" -ForEach @(
            @{ Score = 1    ; Name = "eggs"}
            @{ Score = 2    ; Name = "peanuts"}
            @{ Score = 4    ; Name = "shellfish"}
            @{ Score = 8    ; Name = "strawberries"}
            @{ Score = 16   ; Name = "tomatoes"}
            @{ Score = 32   ; Name = "chocolate"}
            @{ Score = 64   ; Name = "pollen"}
            @{ Score = 128  ; Name = "cats"}
        ) {
            param($Score, $Name)

            $person = [Allergies]::new($Score)
            $person.IsAllergicTo($Name) | Should -Be $true
        }
    }

    Context "allergic to one specific allergen and something else" {
        It "testing for <name> allergy" -ForEach @(
            @{ Score = 3    ; Name = "eggs"}
            @{ Score = 7    ; Name = "peanuts"}
            @{ Score = 14   ; Name = "shellfish"}
            @{ Score = 28   ; Name = "strawberries"}
            @{ Score = 56   ; Name = "tomatoes"}
            @{ Score = 112  ; Name = "chocolate"}
            @{ Score = 224  ; Name = "pollen"}
            @{ Score = 192  ; Name = "cats"}
        ) {
            param($Score, $Name)

            $person = [Allergies]::new($Score)
            $person.IsAllergicTo($Name) | Should -Be $true
        }
    }

    Context "allergic to something else but not the specific allergen" {
        It "testing for <name> allergy" -ForEach @(
            @{ Score = 2    ; Name = "eggs"}
            @{ Score = 5    ; Name = "peanuts"}
            @{ Score = 10   ; Name = "shellfish"}
            @{ Score = 20   ; Name = "strawberries"}
            @{ Score = 40   ; Name = "tomatoes"}
            @{ Score = 80   ; Name = "chocolate"}
            @{ Score = 160  ; Name = "pollen"}
            @{ Score = 64   ; Name = "cats"}
        ) {
            param($Score, $Name)

            $person = [Allergies]::new($Score)
            $person.IsAllergicTo($Name) | Should -Be $false
        }
    }

    Context "get allergies list" {
        It "no allergies" {
            $got  = [Allergies]::new(0).GetAllergies()
            $want = @()

            $got | Should -BeExactly $want
        }

        It "just eggs" {
            $got  = [Allergies]::new(1).GetAllergies()
            $want = @("eggs")

            $got | Should -BeExactly $want
        }

        It "just peanuts" {
            $got  = [Allergies]::new(2).GetAllergies()
            $want = @("peanuts")

            $got | Should -BeExactly $want
        }

        It "just strawberries" {
            $got  = [Allergies]::new(8).GetAllergies()
            $want = @("strawberries")

            $got | Should -BeExactly $want
        }

        It "eggs and peanuts" {
            $got  = [Allergies]::new(3).GetAllergies()
            $want = @("eggs", "peanuts")

            $got | Should -BeExactly $want
        }

        It "more than eggs but not peanuts" {
            $got  = [Allergies]::new(5).GetAllergies()
            $want = @("eggs", "shellfish")

            $got | Should -BeExactly $want
        }

        It "lots of stuffs" {
            $got  = [Allergies]::new(248).GetAllergies()
            $want = @("strawberries", "tomatoes", "chocolate", "pollen", "cats")
            
            $got | Should -BeExactly $want
        }

        It "everything" {
            $got  = [Allergies]::new(255).GetAllergies()
            $want = @("eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats")
            
            $got | Should -BeExactly $want
        }

        It "no allergen score parts" {
            $got  = [Allergies]::new(509).GetAllergies()
            $want = @("eggs", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats")
            
            $got | Should -BeExactly $want
        }

        It "no allergen score parts without highest valid score" {
            $got  = [Allergies]::new(257).GetAllergies()
            $want = @("eggs")
            
            $got | Should -BeExactly $want
        }
    }
}