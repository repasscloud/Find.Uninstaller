Write-Verbose "Importing Module: Find.Uninstaller"
Import-Module -Name Find.Uninstaller

Write-Verbose "Installing Firefox to test against"
choco install firefox -y

Write-Verbose "Testing PS Module"
if ($null -ne (Get-UninstallString -Application firefox)) {
    Write-Output "Success!"
    Write-Host "Build Number: " -ForegroundColor Yellow -NoNewLine
    Write-Host $Env:APPVEYOR_BUILD_NUMBER
    Write-Host "Build ID: " -ForegroundColor Yellow -NoNewLine
    Write-Host $env:APPVEYOR_BUILD_ID
    Write-Host "Build Version: " -ForegroundColor Yellow -NoNewLine
    Write-Host $Env:APPVEYOR_BUILD_VERSION
    Write-Host "Repo Commit: " -ForegroundColor Yellow -NoNewLine
    Write-Host $Env:APPVEYOR_REPO_COMMIT
    Write-Host "Repo Branch: " -ForegroundColor Yellow -NoNewLine
    Write-Host $Env:APPVEYOR_REPO_BRANCH
    Write-Host "Job Number: " -ForegroundColor Yellow -NoNewLine
    Write-Host $Env:APPVEYOR_JOB_NUMBER
} else {
    Write-Output "Fail! :("
    Stop-Computer -ComputerName $Env:COMPUTERNAME -Confirm:$false -Force
}

Write-Host "Unloading Module: Find.Uninstaller"
Remove-Module -Name Find.Uninstaller -Force -Confirm:$false
