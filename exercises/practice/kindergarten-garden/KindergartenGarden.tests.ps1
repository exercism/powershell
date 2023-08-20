BeforeAll {
    . ".\KindergartenGarden.ps1"
}

Describe "Kindergarten garden test cases" {
    Context "partial garden" {
        It "garden with single student" {
            $garden = [Garden]::new("RC`nGG")
            $got  = $garden.GetPlants("Alice")
            $want = @('Radishes', 'Clover', 'Grass', 'Grass')

            $got | Should -BeExactly $want
        }

        It "different garden with single student" {
            $garden = [Garden]::new("VC`nRC")
            $got  = $garden.GetPlants("Alice")
            $want = @("Violets", "Clover", "Radishes", "Clover")

            $got | Should -BeExactly $want
        }

        It "garden with two students" {
            $garden = [Garden]::new("VVCG`nVVRC")
            $got  = $garden.GetPlants("Bob")
            $want = @("Clover", "Grass", "Radishes", "Clover")

            $got | Should -BeExactly $want
        }

        It "garden with three students -> second student's garden" {
            $garden = [Garden]::new("VVCCGG`nVVCCGG")
            $got  = $garden.GetPlants("Bob")
            $want = @("Clover", "Clover", "Clover", "Clover")

            $got | Should -BeExactly $want
        }

        It "garden with three students -> third student's garden" {
            $garden = [Garden]::new("VVCCGG`nVVCCGG")
            $got  = $garden.GetPlants("Charlie")
            $want = @("Grass", "Grass", "Grass", "Grass")

            $got | Should -BeExactly $want
        }
    }

    Context "full garden" {
        BeforeAll {
            $global:fullGarden = [Garden]::new("VRCGVVRVCGGCCGVRGCVCGCGV`nVRCCCGCRRGVCGCRVVCVGCGCV")
        }

        It "for Alice, first student's garden" {
            $got  = $fullGarden.GetPlants("Alice")
            $want = @("Violets", "Radishes", "Violets", "Radishes")

            $got | Should -BeExactly $want
        }

        It "for Bob, second student's garden" {
            $got  = $fullGarden.GetPlants("Bob")
            $want = @("Clover", "Grass", "Clover", "Clover")

            $got | Should -BeExactly $want
        }

        It "for Charlie" {
            $got  = $fullGarden.GetPlants("Charlie")
            $want = @("Violets", "Violets", "Clover", "Grass")

            $got | Should -BeExactly $want
        }

        It "for David" {
            $got  = $fullGarden.GetPlants("David")
            $want = @("Radishes", "Violets", "Clover", "Radishes")

            $got | Should -BeExactly $want
        }

        It "for Eve" {
            $got  = $fullGarden.GetPlants("Eve")
            $want = @("Clover", "Grass", "Radishes", "Grass")

            $got | Should -BeExactly $want
        }

        It "for Fred" {
            $got  = $fullGarden.GetPlants("Fred")
            $want = @("Grass", "Clover", "Violets", "Clover")

            $got | Should -BeExactly $want
        }

        It "for Ginny" {
            $got  = $fullGarden.GetPlants("Ginny")
            $want = @("Clover", "Grass", "Grass", "Clover")

            $got | Should -BeExactly $want
        }

        It "for Harriet" {
            $got  = $fullGarden.GetPlants("Harriet")
            $want = @("Violets", "Radishes", "Radishes", "Violets")

            $got | Should -BeExactly $want
        }

        It "for Ileana" {
            $got  = $fullGarden.GetPlants("Ileana")
            $want = @("Grass", "Clover", "Violets", "Clover")

            $got | Should -BeExactly $want
        }

        It "for Joseph" {
            $got  = $fullGarden.GetPlants("Joseph")
            $want = @("Violets", "Clover", "Violets", "Grass")

            $got | Should -BeExactly $want
        }

        It "for Kincaid, second to last student's garden" {
            $got  = $fullGarden.GetPlants("Kincaid")
            $want = @("Grass", "Clover", "Clover", "Grass")

            $got | Should -BeExactly $want
        }

        It "for Larry, last student's garden" {
            $got  = $fullGarden.GetPlants("Larry")
            $want = @("Grass", "Violets", "Clover", "Violets")

            $got | Should -BeExactly $want
        }
    }

    Context "full garden with custom childen, each has two different plants" {
        BeforeAll {
            $children = @('Xavier', 'Jack', 'Nicholas', 'Alex', 'Victoria', 'Cupid', 'Barney', 'Emily', 'Peter', 'Washington', 'Talia', 'Ruby')
            $diagram  = "VVCCRRGGCCGGCCVVRRVVGGCC`nCCVVGGCCVVRRVVGGCCRRCCRR"
            $global:garden = [Garden]::new($diagram, $children)
        }
        It "<Child> get <Plants>" -TestCases @(
            @{ Child = "Alex"       ; Plants = @('Violets', 'Violets', 'Clover', 'Clover') }
            @{ Child = "Barney"     ; Plants = @('Clover', 'Clover', 'Violets', 'Violets') }
            @{ Child = "Cupid"      ; Plants = @('Radishes', 'Radishes', 'Grass', 'Grass') }
            @{ Child = "Emily"      ; Plants = @('Grass', 'Grass', 'Clover', 'Clover') }
            @{ Child = "Jack"       ; Plants = @('Clover', 'Clover', 'Violets', 'Violets') }
            @{ Child = "Nicholas"   ; Plants = @('Grass', 'Grass', 'Radishes', 'Radishes') }
            @{ Child = "Peter"      ; Plants = @('Clover', 'Clover', 'Violets', 'Violets') }
            @{ Child = "Ruby"       ; Plants = @('Violets', 'Violets', 'Grass', 'Grass') }
            @{ Child = "Talia"      ; Plants = @('Radishes', 'Radishes', 'Clover', 'Clover') }
            @{ Child = "Victoria"   ; Plants = @('Violets', 'Violets', 'Radishes', 'Radishes') }
            @{ Child = "Washington" ; Plants = @('Grass', 'Grass', 'Clover', 'Clover') }
            @{ Child = "Xavier"     ; Plants = @('Clover', 'Clover', 'Radishes', 'Radishes') }
        ) {
            Param(
                [string]$Child,
                [string[]]$Plants
            )
            $garden.GetPlants($Child) | Should -BeExactly $Plants
        }


    }
}