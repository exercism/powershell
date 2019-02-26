#!/bin/bash

if [ "$OS" == "Windows" ]; then
    POWERSHELL=powershell
else
    POWERSHELL=pwsh
fi

"$POWERSHELL" -Command 'Install-Module -Force -SkipPublisherCheck -Scope CurrentUser -Name Pester'
