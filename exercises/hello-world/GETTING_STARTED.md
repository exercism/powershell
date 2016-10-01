# Getting Started

These exercises lean on Test-Driven Development (TDD),

The following steps assume that you are in the same directory as the test
suite.

## Step 1

Run the test suite. It's written using the Pester framework, and can be
run with powershell:

    PS> Invoke-Pester

This will fail, complaining that `hello-world` could not be loaded.

To fix the error create an empty file called `HelloWorld.ps1` in the same
directory as the `HelloWorld.Tests.ps1` file.

## Step 2

Run the test again. It will give you a new error since now the file exists,
but is empty and does not contain the expected code.

>The term 'HelloWorld' is not recognized as the name of a cmdlet, function, script file,
or operable program


### Fixing the Error

To fix it, open up the HelloWorld.ps1 file and add the following code:

    function HelloWorld {

    }

Run the test again.

Up until now we've been getting errors, this time we get 3 failures.

An error means Pester cannot run properly because of things like missing files or syntax errors.

A failure is different. A failure is when Pester is running fine and the test is expecting one outcome, but getting another.

```
[-] outputs 'Hello World!' 64ms
  Expected: {Hello World!}
  But was:  {}
  at line: 7 in /Users/spencerowen/Code/github/xpowershell/exercises/hello-world/HelloWorld.Tests.ps1
  7: 		HelloWorld | Should be 'Hello World!'
[-] outputs Hello Alice! 42ms
  Expected: {Hello Alice!}
  But was:  {}
  at line: 11 in /Users/spencerowen/Code/github/xpowershell/exercises/hello-world/HelloWorld.Tests.ps1
  11: 		HelloWorld('Alice') | Should be 'Hello Alice!'
[-] outpus Hello Bob! 46ms
  Expected: {Hello Bob!}
  But was:  {}
  at line: 15 in /Users/spencerowen/Code/github/xpowershell/exercises/hello-world/HelloWorld.Tests.ps1
  15: 		HelloWorld('Bob') | Should be 'Hello Bob!'
  ```

## Step 3

Add a return statement to the function and then run the test again.

```
function HelloWorld {
    return "Hello World!"
}
```

This time the output will be a mix of green and purple text, representing test successes and failures.

```
[+] outputs 'Hello World!' 31ms
[-] outputs Hello Alice! 46ms
  String lengths are both 12. Strings differ at index 6.
  Expected: {Hello Alice!}
  But was:  {Hello World!}
  -----------------^
  at line: 11 in
  ./exercises/hello-world/HelloWorld.Tests.ps1
  11: 		HelloWorld('Alice') | Should be 'Hello Alice!'
  [-] outpus Hello Bob! 46ms
  Expected: {Hello Bob!}
  But was:  {}
  at line: 15 in .
  /exercises/hello-world/HelloWorld.Tests.ps1
  15: 		HelloWorld('Bob') | Should be 'Hello Bob!'
```

The first test passed because the function returned the expected string 'Hello World!'.

Refactor the HelloWorld.ps1 file so that the `HelloWorld()` function takes a parameter.

## Wash, Rinse, Repeat

When doing Test Driven Development, begin with all tests failing.
Refactor your code until a single test passes. Repeat over and over until all tests pass.


## Submit

When everything is passing, you can submit your code with the following
command:

    PS> exercism submit HelloWorld.ps1
