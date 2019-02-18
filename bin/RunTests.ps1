# Install pester
Install-Module -Name Pester -Force -SkipPublisherCheck

# Run tests
Get-ChildItem -Directory -Path exercises\ | ForEach-Object { Invoke-Pester }
