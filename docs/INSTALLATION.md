## Installing Windows PowerShell

PowerShell comes pre-installed on all Windows operating systems from Windows 7 SP1 onward.

You can find the latest version of PowerShell and installation instructions for all platforms (Linux, macOS and Windows) [here](https://github.com/PowerShell/PowerShell/blob/master/README.md#get-powershell).

## Installing and updating the Pester framework

[Pester](https://github.com/pester/Pester) is the PowerShell testing framework.  Since version 4.0.9 it is compatible with PowerShell Core on Windows, Linux and MacOS (with some limitations)

It is preinstalled on Windows 10, however, it is recommended you update by running the following PowerShell command:

```PowerShell

Install-Module -Name Pester -Force -SkipPublisherCheck

```
For subsequent updates, run:

``` PowerShell
Update-Module -Name Pester
```
if necessary, further instructions for installation are available at: https://github.com/pester/Pester/wiki/Installation-and-Update

## Using an IDE

If you want a more full-featured editing experience, you probably want to use an IDE. These are the most popular IDE's that support building PowerShell projects:

### All platforms
* [PowerShell ISE], build-in graphical IDE that comes with PowerShell
* [Visual Studio Code](https://code.visualstudio.com/download) with the [PowerShell extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell).  Visual Studio Code will also allow you to run the tests and also debug your code.
* [Atom](https://atom.io/) with the [PowerShell package](https://atom.io/packages/language-powershell)
* [Sublime Text 3](https://www.sublimetext.com/3) with the [PowerShell package](https://packagecontrol.io/packages/PowerShell)
