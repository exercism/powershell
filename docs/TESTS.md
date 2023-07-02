# Tests

The exercises all use the [Pester][pester] framework for mocking and testing.
All tests will be in a file named `[exercise].tests.ps1` as is the standard for the Pester framework.
If you're in the right directory (i.e. the one containing `[exercise].ps1` and `[exercise].tests.ps1`).
You can run the tests from PowerShell by calling:

``` PowerShell
Invoke-Pester
```

This will run all `.tests.ps1` files it can find in the directory.

If you are using another shell than PowerShell, you can run the tests by calling:

``` PowerShell
pwsh -Command "Invoke-Pester"
```

## Running tests in Visual Studio Code

You have to make sure you have [the powershell extension][extension] installed in Visual Studio Code .

You can run tests in visual studio code in a couple of ways:

- Running the `.Tests.ps1` script from the Debug menu. Keyboard short cuts are: `F5` or `Shift + F5`
- From within the editor by clicking on the "Run Tests" link above the `Describe` keyword in the test code itself
- Configuring a Task to run the Pester framework

[pester]: https://github.com/pester/Pester
[extension]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
