#!/bin/bash

if [ "$OS" == "Windows" ]; then
    POWERSHELL=powershell
else
    POWERSHELL=pwsh
fi

"$POWERSHELL" -Command '$PSVersionTable.PSVersion'

if [ "$OS" == "Windows" ]; then
    choco install Pester
else
    "$POWERSHELL" -Command 'Install-Module -Force -SkipPublisherCheck -Scope CurrentUser -Name Pester'
fi
