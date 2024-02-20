BeforeAll {
    . "./RobotSimulator.ps1"
}

Describe "RobotSimulator test cases" {
    Context "create robot" {
        It "at defaults origin without inputs" {
            $robot = [Robot]::new()
            $want  = @{
                Direction = [Direction]::NORTH
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }

        It "at origin facing north" {
            $robot = [Robot]::new('NORTH', 0 , 0)
            $want  = @{
                Direction = [Direction]::NORTH
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "at negative position facing south" {
            $robot = [Robot]::new('SOUTH', -1, -1)
            $want  = @{
                Direction = [Direction]::SOUTH
                Position  = @(-1, -1)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }

        It "at positive position facing west" {
            $robot = [Robot]::new('WEST', 100, 100)
            $want  = @{
                Direction = [Direction]::WEST
                Position  = @(100, 100)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }

        It "at negative position facing east" {
            $robot = [Robot]::new('EAST', -99, -99)
            $want  = @{
                Direction = [Direction]::EAST
                Position  = @(-99, -99)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    }
    
    Context "rotate robot" {
        It "clockwise -> changes north to east" {
            $robot = [Robot]::new('NORTH', 0, 0)
            $robot.Move("R")
            $want  = @{
                Direction = [Direction]::EAST
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "clockwise -> changes east to south" {
            $robot = [Robot]::new('EAST', 0, 0)
            $robot.Move("R")
            $want  = @{
                Direction = [Direction]::SOUTH
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "clockwise -> changes south to west" {
            $robot = [Robot]::new('SOUTH', 0, 0)
            $robot.Move("R")
            $want  = @{
                Direction = [Direction]::WEST
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "clockwise -> changes west to north" {
            $robot = [Robot]::new('WEST', 0, 0)
            $robot.Move("R")
            $want  = @{
                Direction = [Direction]::NORTH
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "counter-clockwise -> changes north to west" {
            $robot = [Robot]::new('NORTH', 0, 0)
            $robot.Move("L")
            $want  = @{
                Direction = [Direction]::WEST
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "counter-clockwise -> changes west to south" {
            $robot = [Robot]::new('WEST', 0, 0)
            $robot.Move("L")
            $want  = @{
                Direction = [Direction]::SOUTH
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "counter-clockwise -> changes south to east" {
            $robot = [Robot]::new('SOUTH', 0, 0)
            $robot.Move("L")
            $want  = @{
                Direction = [Direction]::EAST
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "counter-clockwise -> changes east to north" {
            $robot = [Robot]::new('EAST', 0, 0)
            $robot.Move("L")
            $want  = @{
                Direction = [Direction]::NORTH
                Position  = @(0, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    }

    Context "move forward one" {
        It "facing north increments Y" {
            $robot = [Robot]::new('NORTH', 0, 0)
            $robot.Move("A")
            $want  = @{
                Direction = [Direction]::NORTH
                Position  = @(0, 1)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "facing south decrements Y" {
            $robot = [Robot]::new('SOUTH', 0, 0)
            $robot.Move("A")
            $want  = @{
                Direction = [Direction]::SOUTH
                Position  = @(0, -1)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
    
        }
    
        It "facing east increments X" {
            $robot = [Robot]::new('EAST', 0, 0)
            $robot.Move("A")
            $want  = @{
                Direction = [Direction]::EAST
                Position  = @(1, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "facing west decrements X" {
            $robot = [Robot]::new('WEST', 0, 0)
            $robot.Move("A")
            $want  = @{
                Direction = [Direction]::WEST
                Position  = @(-1, 0)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    }

    Context "follow series of instructions" {
        It "moving east and north" {
            $robot = [Robot]::new('NORTH', 7, 3)
            $robot.Move("RAALAL")
            $want  = @{
                Direction = [Direction]::WEST
                Position  = @(9, 4)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "moving west and north" {
            $robot = [Robot]::new('NORTH', 0, 0)
            $robot.Move("LAAARALA")
            $want  = @{
                Direction = [Direction]::WEST
                Position  = @(-4, 1)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "moving west and south" {
            $robot = [Robot]::new('EAST', 2, -7)
            $robot.Move("RRAAAAALA")
            $want  = @{
                Direction = [Direction]::SOUTH
                Position  = @(-3, -8)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    
        It "moving east and north" {
            $robot = [Robot]::new('SOUTH', 8, 4)
            $robot.Move("LAAARRRALLLL")
            $want  = @{
                Direction = [Direction]::NORTH
                Position  = @(11, 5)
            }
            
            $robot.Direction     | Should -Be $want.Direction
            $robot.GetPosition() | Should -Be $want.Position
        }
    }

    Context "invalid input" {
        It "create robot with invalid direction" {
            { [Robot]::new('DOWN', 8, 4) } | Should -Throw "*Error: Invalid direction*"
        }

        It "create robot with invalid X coordinate" {
            { [Robot]::new('NORTH', $null, 4) } | Should -Throw "*Error: Invalid X position*"
        }

        It "create robot with invalid Y coordinate" {
            { [Robot]::new('NORTH', 0, 'one') } | Should -Throw "*Error: Invalid Y position*"
        }

        It "move with invalid instruction" {
            $robot = [Robot]::new('NORTH', 0, 0)
            { $robot.Move("U") } | Should -Throw "*Error: Invalid instruction*"
        }

        It "move with series of invalid instruction" {
            $robot = [Robot]::new('NORTH', 0, 0)
            { $robot.Move("EXERCISM") } | Should -Throw "*Error: Invalid instruction*"
        }
    }
}
