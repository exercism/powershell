$ExercisePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'

# Load the script file
If (Test-Path "$ExercisePath\$ScriptFile"){
    Write-Output ("Loading: {0}" -f "$ExercisePath\$ScriptFile")
    . ("$ExercisePath\$ScriptFile")

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

Describe "Grade School Test cases" {
    It "Creates a Student" {
        $student = [Student]::new(1,'Josh')
        $student | Should -Not -BeNullOrEmpty
        $student | Should -BeOfType Student
    }
    It "Creates a Roster" {
        $roster = [Roster]::new()
        $roster | Should -Not -BeNullOrEmpty
        $roster | Should -BeOfType Roster
    }
    It "Adds a Student to a Roster" {
        $roster = [Roster]::new()
        $roster.AddStudent(1,'Josh')
        $roster.Student.Grade | Should -Be 1
        $roster.Student.Name | Should -Be 'Josh'
    }
    It "Returns a list of all enrolled Students" {
        $roster = [Roster]::new()
        $roster.AddStudent(1,'Josh')
        $roster.AddStudent(2,'Billy')
        $students = $roster.GetRoster()
        $students.Count | Should -Be 2
        $students.Grade | Should -Contain 1
        $students.Name | Should -Contain 'Josh'
        $students.Grade | Should -Contain 2
        $students.Name | Should -Contain 'Billy'
    }
    It "Returns a grade of enrolled students" {
        $roster = [Roster]::new()
        $roster.AddStudent(1,'Josh')
        $roster.AddStudent(2,'Billy')
        $students = $roster.GetRoster(2)
        $students.Count | Should -Be 1
        $students.Grade | Should -Be 2
        $students.Name | Should -Be 'Billy'
    }
    It "Returns a sorted list of students" {
        $roster = [Roster]::new()
        $roster.AddStudent(1,'Josh')
        $roster.AddStudent(2,'Billy')
        $roster.AddStudent(2,'Allison')
        $students = $roster.GetRoster()

        $students[0].Name | Should -Be 'Josh'
        $students[0].Grade | Should -Be 1

        $students[1].Name | Should -Be 'Allison'
        $students[1].Grade | Should -Be 2

        $students[2].Name | Should -Be 'Billy'
        $students[2].Grade | Should -Be 2
    }
}