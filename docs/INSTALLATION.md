# Installing PowerShell

PowerShell is installed on Windows by default since Windows 7 SP1 and Windows Server 2008 R2 SP1.

Linux, macOS and Windows that would like to use PowerShell 6 (beta) can install the latest version from [GitHub](https://github.com/powershell/powershell#get-powershell).  This also includes specific installation instructions for different operating systems.

## Using Visual Studio Code

On Windows, PowerShell ISE was the original development environment for PowerShell.  It is still a competent tool, however, [Visual Studio Code](https://code.visualstudio.com/) is fast replacing it.  It is highly recommended you use Visual Studio Code for learning and developing PowerShell.

### Installing Visual Studio Code

* Download the latest release from: https://code.visualstudio.com/
* Install the PowerShell extension within Visual Studio Code
  * Open the extensions menu (Windows and Linux: `Ctrl + Shift + X`,  macOS: `⇧ ⌘ X`)
  * Search for PowerShell
  * Install the PowerShell extension developed by Microsoft



## Installing Pester

Pester is the defacto test and mocking framework for PowerShell.  Instructions for installation are available at: https://github.com/pester/Pester/wiki/Installation-and-Update

The following is an abridged version of that wiki article.

### Installing on Windows

Version 3.4.0 ships with Windows 10 and this version conflicts with the standard module update mechanism.  To update, or install if running an earlier version of Windows, run as an administrator:

``` PowerShell
Install-Module -Name Pester -Force -SkipPublisherCheck
```

### Installing on Linux and macOS

Since Pester 4.1.0 it is compatible with PowerShell Core allowing it to be run on Linux and macOS.  It does have some [limitations](https://github.com/pester/Pester/wiki/Pester-on-PSCore-limitations)

``` PowerShell
Install-Module -Name Pester
```

### Updating Pester

For subsequent updating run:

``` PowerShell
Update-Module -Name Pester
```