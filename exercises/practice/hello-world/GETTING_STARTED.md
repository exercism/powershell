# Getting Started

These exercises lean on Test-Driven Development (TDD),

For information installing Powershell click [here](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1).

Once Powershell is installed you will need to install the Pester module by running the following command in Powershell:

    PS> Install-Module Pester

The following steps assume that you are in the same directory as the test suite.

Run the test suite. It's written using the Pester framework, and can be
run with powershell:

    PS> Invoke-Pester

This will fail. To fix it, open up the HelloWorld.ps1 file and add the following code:

    ```
    function Get-HelloWorld {
        return "Hello World!"
    }
    ```

Run the test again.

## Submit

When everything is passing, you can submit your code with the following
command:

    PS> exercism submit HelloWorld.ps1
