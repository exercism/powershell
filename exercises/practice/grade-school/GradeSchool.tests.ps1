BeforeAll {
    $ScriptFile = '.\GradeSchool.ps1'

    # Load the script file
    If (Test-Path "$ScriptFile"){
        Write-Output ("Loading: {0}" -f "$ScriptFile")
        . ("$ScriptFile")

        try {
            $Types = @([Student],[Roster])
            foreach ($type in $Types) {
                $type | Out-Null
            }
        }
        catch {
            # Display an error and stop the tests
            Write-Error "The file $ScriptFile must implement the two PowerShell classes Student and Roster" -ErrorAction Stop
        }
    }
    Else {
        # Display an error and stop the tests
        Write-Error "The file $ScriptFile was not found. You need to create your answer in a file named $ScriptFile" -ErrorAction Stop
    }
}

Describe "Grade School Test cases" {
    It "Adding a student adds them to the sorted roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Aimee')
        $roster.Student.Name | Should -Be 'Aimee'
    }
    It "Adding more student adds them to the sorted roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Blair')
        $roster.AddStudent(2,'James')
        $roster.AddStudent(2,'Paul')
        $roster.GetRoster().Name | Should -Be ('Blair', 'James', 'Paul')
    }
    It "Adding students to different grades adds them to the same sorted roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(3,'Chelsea')
        $roster.AddStudent(7,'Logan')
        $roster.GetRoster().Name | Should -Be ('Chelsea', 'Logan')
    }
    It "Roster returns an empty list if there are no students enrolled" {
        $roster = [Roster]::new()
        $roster.GetRoster() | Should -BeNullOrEmpty
    }
    It "Student names with grades are displayed in the same sorted roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(2,'Peter')
        $roster.AddStudent(1,'Anna')
        $roster.AddStudent(1,'Barb')
        $roster.AddStudent(2,'Zoe')
        $roster.AddStudent(2,'Alex')
        $roster.AddStudent(3,'Jim')
        $roster.AddStudent(1,'Charlie')
        $roster.GetRoster().Name | Should -Be ('Anna', 'Barb', 'Charlie', 'Alex', 'Peter', 'Zoe', 'Jim')
    }
    It "Grade returns the students in that grade in alphabetical order" {
        $roster = [Roster]::new()
        $roster.AddStudent(5,'Franklin')
        $roster.AddStudent(5,'Bradley')
        $roster.AddStudent(1,'Jeff')
        $roster.GetRoster(5).Name | Should -Be ('Bradley', 'Franklin')
    }
    It "Grade returns an empty list if there are no students in that grade" {
        $roster = [Roster]::new()
        $roster.GetRoster(1) | Should -BeNullOrEmpty
    }
}