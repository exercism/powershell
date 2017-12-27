# Getting Started

These exercises lean on Test-Driven Development (TDD),

The following steps assume that you are in the same directory as the test
suite.

## Step 1

Run the test suite. It's written using the `Pester` framework, and can be
run with powershell:

    PS> Invoke-Pester

This will fail, complaining that the file `HelloWorld.ps1` was not found.

To fix the error create an empty file called `HelloWorld.ps1` in the same
directory as the `HelloWorld.Tests.ps1` file.

## Step 2

Run the test again. It will give you a new error since now the file exists,
but is empty and does not contain the expected code.

>The term 'Hello-World' is not recognized as the name of a cmdlet, function, script file, 
>or operable program


### Fixing the Error

To fix it, open up the HelloWorld.ps1 file and add the following code:

``` PowerShell
Function Hello-World() {

}

```

Run the test again.

Up until now we've been getting errors, this time we get 3 failures.

An error means `Pester` cannot run properly because of things like missing files or syntax errors.

A failure is different. A failure is when `Pester` is running fine and the test is expecting one outcome, but receiving a different outcome.

```

Executing script c:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1

  Describing Hello-World
    [-] Outputs: Hello World! 293ms
      Expected: {Hello World!}
      But was:  {}
      22:               Hello-World | Should -Be "Hello World!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1: line 22
    [-] Outputs: Hello Alice! 74ms
      Expected: {Hello Alice!}
      But was:  {}
      26:               Hello-World "Alice" | Should -Be "Hello Alice!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1: line 26
    [-] Outputs: Hello Bob! 32ms
      Expected: {Hello Bob!}
      But was:  {}
      30:               Hello-World "Bob" | Should -Be "Hello Bob!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1: line 30
Tests completed in 400ms
Tests Passed: 0, Failed: 3, Skipped: 0, Pending: 0, Inconclusive: 0

```

## Step 3

Add a `Write-Output` statement to the function and then run the test again.

``` PowerShell

Function Hello-World() {
    Write-Output "Hello World!"
}

```

This time the output will be a mix of green and purple text, representing test successes and failures.

```

Executing script c:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1

  Describing Hello-World
    [+] Outputs: Hello World! 97ms
    [-] Outputs: Hello Alice! 33ms
      String lengths are both 12. Strings differ at index 6.
      Expected: {Hello Alice!}
      But was:  {Hello World!}
      -----------------^
      26:               Hello-World "Alice" | Should -Be "Hello Alice!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1: line 26
    [-] Outputs: Hello Bob! 44ms
      Expected string length 10 but was 12. Strings differ at index 6.
      Expected: {Hello Bob!}
      But was:  {Hello World!}
      -----------------^
      30:               Hello-World "Bob" | Should -Be "Hello Bob!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Hello-World\HelloWorld.Tests.ps1: line 30
Tests completed in 175ms
Tests Passed: 1, Failed: 2, Skipped: 0, Pending: 0, Inconclusive: 0

```

The first test passed because the function returned the expected string 'Hello World!'.

Refactor the HelloWorld.ps1 file so that the `Hello-World` function takes a parameter that is a person's name.  When supplied a name, the `Hello-World` function should greet that person.

## Wash, Rinse, Repeat

When doing Test Driven Development, begin with all tests failing.
Refactor your code until a single test passes. Repeat over and over until all tests pass.


## Submit

When everything is passing, you can submit your code with the following
command:

``` 

PS> exercism submit HelloWorld.ps1

```