<#
.SYNOPSIS
    Given students' names along with the grade that they are in, create a roster for the school.
.DESCRIPTION
    Add a student's name to the roster for a grade
    "Add Jim to grade 2."
    "OK."
    Get a list of all students enrolled in a grade
    "Which students are in grade 2?"
    "We've only got Jim just now."
    Get a sorted list of all students in all grades. Grades should sort as 1, 2, 3, etc., and students within a grade should be sorted alphabetically by name.
    "Who all is enrolled in school right now?"
    "Grade 1: Anna, Barb, and Charlie. Grade 2: Alex, Peter, and Zoe. Grade 3…"
    Note that all our students only have one name. (It's a small town, what do you want?)
.EXAMPLE
    $roster = [Roster]::new()
    $roster.AddStudent(1,'Billy')
    $roster.AddStudent(1,'Josh')
    $roster.AddStudent(2,'Allison')
    $roster.GetRoster()
    $roster.GetRoster(2)

    This will create a new roster and add 3 students to it.
    When no arguments are supplied to the GetRoster method, all students will be returned.
    When a grade number is supplied to the GetRoster method, students from that grade will be returned.
#>

class Student {
    # Student properties Grade and Name
    [int]$Grade
    [string]$Name

    # Student constructors - allows the instantiation of a student object with their properties specified
    Student(){}
    Student([int]$grade,[string]$name){
        $this.Grade = $grade
        $this.Name = $name
    }
}

class Roster {
    # An array of Students is the property of the Roster type
    [Student[]]$Student

    # The Add Student method allows the possibility to add Student objects to the Roster
    [bool]AddStudent([int]$grade, [string]$name){
        if ($this.student | Where-Object {$_.name -eq $name}) {
            return $false
        }
        $this.Student += [Student]::new($grade,$name)
        return $true
    }

    # GetRoster without any arguments returns a sorted list of all students
    [Student[]]GetRoster(){
        return $this.Student | Sort-Object -Property Grade, Name
    }

    # GetRoster is overloaded with the grade as the argument and returns a sorted list of all students from the grade specified
    [Student[]]GetRoster([int]$grade){
        return $this.Student | Where-Object {$_.grade -eq $grade} | Sort-Object -Property Name
    }
}
