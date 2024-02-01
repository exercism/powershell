BeforeAll {
    . "./ErrorHandling.ps1"
}

Describe "ErrorHandling test cases" {
    BeforeEach {
        #The Error variable is used to store all the errors that occured.
        #Before each test, this got run so the count will be reflected correctly for each case.
        $Error.Clear()
    }

    It "non terminal error" {
        #This got enable so it won't show the error msg in pester.
        $ErrorActionPreference = "SilentlyContinue"
        NonTerminationError

        #However there is still an $Error variable with value in it to be run against for testing
        $Error.Count | Should -BeGreaterThan 0
        $Error[0].Exception.Message | Should -Contain "Error: This is a non termination error"
    }

    It "ValueErrorHandling : valid input" {
        $got = ValueErrorHandling -Age 25
        $want = "I'm 25 years old!"

        $got | Should -BeExactly $want
    }

    It "ValueErrorHandling : invalid inputs" {
        $got1  = ValueErrorHandling -Age "ten"
        $want1 = "Error: Age need to be 18 and up"

        $got1 | Should -BeExactly $want1
        $Error.Count | Should -Be 1


        $got2  = ValueErrorHandling -Age 14
        $want2 = "Error: Age need to be 18 and up"

        $got2 | Should -BeExactly $want2
        $Error.Count | Should -Be 2
    }

    It "multiple terminal error catch: file not found - with custom error message" {
        $got  = TypedErrorHandling -Path "nonexistant"
        $want = "Error: File not found"

        $got | Should -BeExactly $want
    }

    It "multiple terminal error catch: file path is too long - defaul error message" {
        $got  = TypedErrorHandling -Path ("nonexistant" * 50)
        $want = "The specified file name or path is too long, or a component of the specified path is too long."

        $got | Should -BeExactly $want
    }

    It "rethrow error" {
        { ReThrowErrorHandling } | Should -Throw "*Error: Path wasn't provided.*"
    }
}
