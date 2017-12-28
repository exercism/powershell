# Getting Started

These exercises lean on Test-Driven Development (TDD),

The following steps assume that you are in the same directory as the test
suite.

## Step 1

Run the test suite. It's written using the `Pester` framework, and can be
run with powershell:

    Invoke-Pester

Without any parameters, this command will look for all files that end with the name `.Tests.ps1`.  These will be loaded and the tests run.  The tests will load the `OutHelloWorld.ps1` script and then call the function to test it.

Initially the tests will fail with:

```

Executing script c:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1

  Describing Out-HelloWorld
    [-] Outputs: Hello World! 293ms
      Expected: {Hello World!}
      But was:  {}
      22:               Out-HelloWorld | Should -Be "Hello World!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1: line 22
    [-] Outputs: Hello Alice! 74ms
      Expected: {Hello Alice!}
      But was:  {}
      26:               Out-HelloWorld "Alice" | Should -Be "Hello Alice!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1: line 26
    [-] Outputs: Hello Bob! 32ms
      Expected: {Hello Bob!}
      But was:  {}
      30:               Out-HelloWorld "Bob" | Should -Be "Hello Bob!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1: line 30
Tests completed in 400ms
Tests Passed: 0, Failed: 3, Skipped: 0, Pending: 0, Inconclusive: 0

```

## Step 2

Update the function to output the `"Hello, World!"` string.

``` PowerShell

Function Out-HelloWorld() {
    Write-Output "Hello World!"
}

```

This time the output will be a mix of green and red text, representing test successes and failures.

```

Executing script c:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1

  Describing Out-HelloWorld
    [+] Outputs: Hello World! 97ms
    [-] Outputs: Hello Alice! 33ms
      String lengths are both 12. Strings differ at index 6.
      Expected: {Hello Alice!}
      But was:  {Hello World!}
      -----------------^
      26:               Out-HelloWorld "Alice" | Should -Be "Hello Alice!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1: line 26
    [-] Outputs: Hello Bob! 44ms
      Expected string length 10 but was 12. Strings differ at index 6.
      Expected: {Hello Bob!}
      But was:  {Hello World!}
      -----------------^
      30:               Out-HelloWorld "Bob" | Should -Be "Hello Bob!"
      at Invoke-Assertion, C:\Users\KentChenery\Documents\WindowsPowerShell\Modules\Pester\4.1.1\Functions\Assertions\Should.ps1: line 209
      at <ScriptBlock>, C:\Dev\Exercism.io\powershell\exercises\Out-HelloWorld\OutHelloWorld.Tests.ps1: line 30
Tests completed in 175ms
Tests Passed: 1, Failed: 2, Skipped: 0, Pending: 0, Inconclusive: 0

```

The first test passed because the function returned the expected string 'Hello World!'.

Refactor the OutHelloWorld.ps1 file so that the `Out-HelloWorld` function takes a parameter that is a person's name.  When supplied a name, the `Out-HelloWorld` function should greet that person.

## Wash, Rinse, Repeat

When doing Test Driven Development, begin with all tests failing.
Refactor your code until a single test passes. Repeat over and over until all tests pass.


## Submit

When everything is passing, you can submit your code with the following
command:

``` 

PS> exercism submit OutHelloWorld.ps1

```