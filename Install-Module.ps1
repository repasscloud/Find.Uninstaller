param ($fullPath)
#$fullPath = 'C:\Program Files\WindowsPowerShell\Modules\ImportExcel'
if (-not $fullPath) {
    $fullpath = $env:PSModulePath -split ":(?!\\)|;|," |
        Where-Object {$_ -notlike ([System.Environment]::GetFolderPath("UserProfile")+"*") -and $_ -notlike "$pshome*"} |
            Select-Object -First 1
            $fullPath = Join-Path $fullPath -ChildPath "Find.Uninstaller"
}
Push-location $PSScriptRoot
Robocopy . $fullPath /mir /XD .devbots .github .git CI /XF appveyor.yml .gitignore InstallModule.ps1 CODE-OF-CONDUCT.md CONTRIBUTING.md
Pop-Location