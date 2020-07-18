#region import everything we need
$culture = $host.CurrentCulture.Name -replace '-\w*$', ''
Import-LocalizedData  -UICulture $culture -BindingVariable Strings -FileName Strings -ErrorAction Ignore
if (-not $Strings) {
    Import-LocalizedData  -UICulture "en" -BindingVariable Strings -FileName Strings -ErrorAction Ignore
}
try { [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") }
catch { Write-Warning -Message $Strings.SystemDrawingAvailable }

foreach ($directory in @('Private', 'Public')) {
    Get-ChildItem -Path "${PSScriptRoot}\{$directory}" -Fileter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}