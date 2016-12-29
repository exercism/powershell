# Pester

Tests are executed using the [Pester](https://github.com/pester/Pester) Framework. 

Recent versions of powershell include Pester so no additional installation is necessary. 

Additional information on writting tests can be found in the [Pester Wiki](https://github.com/pester/Pester/wiki)

# Running Tests

To run a test suite, run the command `Invoke-Pester`. This will look in the current directories for any files like `*.tests.ps1`, and run any tests found in that file. 
