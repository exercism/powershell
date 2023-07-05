BeforeAll {
    . "./GradeSchool.ps1"
}

Describe "Grade School Test cases" {
    It "Roster is empty when no student is added"{
        $roster = [Roster]::new()
        $roster.GetRoster() | Should -BeNullOrEmpty
    }

    It "Add a student" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Aimee') | Should -Be $true
    }

    It "Student is added to the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Aimee') | Should -Be $true
        $roster.GetRoster().Name | Should -Be 'Aimee'
    }

    It "Adding multiple students in the same grade in the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair') | Should -Be $true
        $roster.AddStudent(2,'James') | Should -Be $true
        $roster.AddStudent(2,'Paul') | Should -Be $true
    }

    It "Multiple students in the same grade are added to the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(2,'Paul')
        $roster.GetRoster().Name | Should -Be ('Blair', 'James', 'Paul')
    }

    It "Cannot add student to same grade in the roster more than once" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair') | Should -Be $true
        $roster.AddStudent(2,'James') | Should -Be $true
        $roster.AddStudent(2,'James') | Should -Be $false
        $roster.AddStudent(2,'Paul') | Should -Be $true
    }

    It "A student can't be in two different grades" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Aimee')
        $roster.AddStudent(2,'Aimee') 
        $roster.GetRoster().Name | Should -Be 'Aimee'
    }

    It "Student not added to same grade in the roster more than once" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(2,'Paul')
        $roster.GetRoster().Name | Should -Be ('Blair', 'James', 'Paul')
    }

    It "Adding students in multiple grades" {
        $roster = [Roster]::new()
        $roster.AddStudent(3,'Chelsea') | Should -Be $true
        $roster.AddStudent(7,'Logan') | Should -Be $true
    }

    It "Students in multiple grades are added to the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(3,'Chelsea')
        $roster.AddStudent(7,'Logan')
        $roster.GetRoster().Name | Should -Be ('Chelsea', 'Logan')
    }

    It "Cannot add same student to multiple grades in the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair') | Should -Be $true
        $roster.AddStudent(2,'James') | Should -Be $true
        $roster.AddStudent(3,'James') | Should -Be $false
        $roster.AddStudent(3,'Paul') | Should -Be $true
    }

    It  "Students are sorted by grades in the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(3,'Jim')
        $roster.AddStudent(2,'Peter')
        $roster.AddStudent(1,'Anna')
        $roster.GetRoster().Name | Should -Be ('Anna', 'Peter', 'Jim')
    }

    It "Students are sorted by name in the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Peter')
        $roster.AddStudent(2,'Zoe')
        $roster.AddStudent(2,'Alex')
        $roster.GetRoster().Name | Should -Be ('Alex', 'Peter', 'Zoe')
    }

    It "Students are sorted by grades and then by name in the roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'peter')
        $roster.AddStudent(1,'Anna')
        $roster.AddStudent(1,'Barb')
        $roster.AddStudent(2,'Zoe')
        $roster.AddStudent(2,'Alex')
        $roster.AddStudent(3,'Jim')
        $roster.AddStudent(1,'Charlie')
        $roster.GetRoster().Name | Should -Be ('Anna', 'Barb', 'Charlie', 'Alex', 'Peter', 'Zoe', 'Jim')
    }

    It "Grade is empty if no students in the roster" {
        $roster = [Roster]::new()
        $roster.GetRoster(1).Name | Should -BeNullOrEmpty
    }

    It "Grade is empty if no students in that grade" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Peter')
        $roster.AddStudent(2,'Zoe')
        $roster.AddStudent(2,'Alex')
        $roster.AddStudent(3,'Jim')
        $roster.GetRoster(1).Name | Should -BeNullOrEmpty
    }

    It "Student not added to same grade more than once" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(2,'Paul')
        $roster.GetRoster(2).Name | Should -Be ('Blair', 'James', 'Paul')
    }

    It "Student not added to multiple grades" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(3,'James')
        $roster.AddStudent(3,'Paul')
        $roster.GetRoster(2).Name | Should -Be ('Blair', 'James')
    }

    It "Student not added to other grade for multiple grades" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(3,'James')
        $roster.AddStudent(3,'Paul')
        $roster.GetRoster(3).Name | Should -Be ('Paul')
    }

    It "Students are sorted by name in a grade" {
        $roster = [Roster]::new()
        $roster.AddStudent(5,'Franklin')
        $roster.AddStudent(5,'Bradley')
        $roster.AddStudent(1,'Jeff')
        $roster.GetRoster(5).Name | Should -Be ('Bradley', 'Franklin')
    }
}
