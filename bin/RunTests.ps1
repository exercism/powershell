# Run tests
Get-ChildItem -Directory -Path exercises\ | ForEach-Object { Invoke-Pester }
