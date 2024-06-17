BeforeAll {
    . "./RobotName.ps1"
}

Describe "RobotName test cases" {
    BeforeEach {
        $robot = [Robot]::new()
    }

    It "robot has a name" {
        $robot.Name | Should -MatchExactly "^[A-Z]{2}\d{3}$"
    }

    It "name is the same each time" {
        $robot.Name | Should -BeExactly $robot.Name
    }

    It "different robot has different name" {
        $robot2 = [Robot]::new()
        $robot2.Name | Should -Not -Be $robot.Name
    }

    It "name can be reset" {
        $initialName = $robot.Name
        $robot.Reset()

        $robot.Name | Should -Not -Be $initialName 
    }

    It "name is valid after many reset" {
        for ($i = 0; $i -lt 100; $i++) {
            $initialName = $robot.Name
            $robot.Reset()
            $robot.Name | Should -MatchExactly "^[A-Z]{2}\d{3}$"
            $robot.Name | Should -Not -Be $initialName
        }
    }

    It "robot name are unique" {
        $names = [System.Collections.Generic.HashSet[string]]::new()
        for ($i = 0; $i -lt 1000; $i++) {
            $robot = [Robot]::new()
            $names.Add($robot.Name) | Should -BeTrue
            $robot.Name | Should -MatchExactly "^[A-Z]{2}\d{3}$"
        }
    }
}
