BeforeAll {
    . "./lasagna.ps1"
}

Describe 'Lasagna test cases' {
    Describe "Task 1" {
        BeforeEach {
            $constName = "ExpectedBakeTime"
        }
        
        It "Variable exist with correct value" {
            (Get-Variable -Name $constName).Value | Should -BeExactly 40
        }

        It "Variable is defined as a constant" {
            (Get-Variable -Name $constName).Options | Should -Be Constant
        }
    }

    Describe "Task 2" {
        It "Remaining minutes in oven after thirteen minutes" {
            RemainingTime -Minutes 13 | Should -BeExactly 27
        }

        It "Remaining minutes in oven after twenty two minutes" {
            RemainingTime -Minutes 22 | Should -BeExactly 18
        }
    }

    Describe "Task 3" {
        It "Preperation time in minutes for one layer" {
            PreparationTime -Layers 1 | Should -BeExactly 2
        }

        It "Preperation time in minutes for multiple layers" {
            PreparationTime -Layers 5 | Should -BeExactly 10
        }
    }

    Describe "Task 4" {
        It "Elapsed time in minutes for one layer" {
            ElapsedTime -Layers 1 -Minutes 20 | Should -BeExactly 22
        }

        It "Elapsed time in minutes for multiple layers" {
            ElapsedTime -Layers 6 -Minutes 35 | Should -BeExactly 47
        }
    }

    Describe "Task 5" {
        It "Notification function" {
            Notification | Should -BeExactly "Lasagna's ready!"
        }
    }
}
