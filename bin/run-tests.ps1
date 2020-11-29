$tmpRoot = [System.IO.Path]::GetTempPath()
$exercises = Get-ChildItem -Path exercises -Directory
$failed = 0
Foreach($exercise in $exercises)
{
    $tmpDirName = Join-Path $tmpRoot $exercise.Name
    $tmpDir = New-Item -ItemType Directory -Path $tmpDirName
    Get-ChildItem $exercise.FullName -Recurse -Include *.tests.ps1 | Copy-Item -Destination $tmpDir.FullName
    $exampleSolutionFile = Get-ChildItem $exercise.FullName -Recurse -Include *.example.ps1
    if ($null -eq $exampleSolutionFile)
    {
        Write-Output "Error: no example solution found"
        exit 1
    }
    $solutionFile = Join-Path $tmpDir.FullName $exampleSolutionFile.Name.Replace("example.","")
    Copy-Item -Path $exampleSolutionFile.FullName -Destination $solutionFile
    Push-Location $tmpDir.FullName
    $result = Invoke-Pester $tmpDir.FullName -PassThru
    Pop-Location
    if ($result.TotalCount -eq 0)
    {
        Write-Output "Error: no tests run"
        exit 1
    }
    elseif ($result.FailedCount -ne 0)
    {
        $failed += $result.FailedCount
    }
}

Write-Output "$failed failed exercises."
exit $failed
