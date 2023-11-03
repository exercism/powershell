# Installation

## PowerShell language track requirements

The Exercism PowerShell language track requires installed on your system:

- PowerShell or Windows PowerShell Core
- Pester test and mock framework module installed

(PS: Support for PowerShell is limited to critical fixes. PowerShell Core is consistently maintained and has greater cross-platform support)

### Installing PowerShell

PowerShell comes pre-installed on all Windows operating systems from Windows 7 SP1 onward.

You can find the latest version of PowerShell and installation instructions for all platforms (Linux, macOS and Windows) [here][installation].

Source code and manual install for [PowerShell][source-code] is also available.

### Installing and updating the Pester framework

[Pester][pester] is the PowerShell testing framework.
Since version 4.0.9 it is compatible with PowerShell Core on Windows, Linux and MacOS (with some limitations)

It is preinstalled on Windows 10, however, it is recommended you update by running the following PowerShell command:

```PowerShell
Install-Module -Name Pester -Force -SkipPublisherCheck
```

For subsequent updates, run:

```PowerShell
Update-Module -Name Pester
```

If necessary, further instructions for installation are available at: [https://github.com/pester/Pester/wiki/Installation-and-Update]()

## Using an IDE

If you want a more full-featured editing experience, you probably want to use an IDE.
These are the most popular IDE's that support building PowerShell projects:

### All platforms

- [PowerShell ISE (Integrated Scripting Environment)][ise], build-in graphical IDE that comes with PowerShell (Windows only).
  To start PowerShell ISE, type `powershell_ise.exe` in a PowerShell console.
- [Visual Studio Code][vsc] with the [PowerShell extension][vsc-extension].
  Visual Studio Code will also allow you to run the tests and also debug your code.
- [Sublime Text 3][sublime] with the [PowerShell package][sublime-package].

[installation]: https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell
[source-code]: https://github.com/PowerShell/PowerShell/blob/master/README.md#get-powershell
[pester]: https://github.com/pester/Pester
[ise]: https://learn.microsoft.com/en-us/powershell/scripting/windows-powershell/ise/introducing-the-windows-powershell-ise
[vsc]: https://code.visualstudio.com/
[vsc-extension]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[sublime]: https://www.sublimetext.com/3
[sublime-package]: https://packagecontrol.io/packages/PowerShell
