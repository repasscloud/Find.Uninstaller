$PSD1=$PSScriptRoot+'\Find.Uninstaller.psd1'
if (Test-Path -Path $PSD1) {
    Remove-Item -Path $PSD1 -Confirm:$false -Force
}

$Description = @"
PowerShell module to get the uninstall string of any installed application.

Use of the wildcard "*" character is not necessary when searching for items, and will be applied automatically to the search index.

Example 1 - Find an application by common name:
  Get-UninstallString -Application Firefox

Example 2 - Find application by common name and provide all details:
  Get-UninstallString -Application Firefox -FullDetail

Example 3 - Find application by partial name:
  Get-UninstallString -Application firef
"@

$FileList=@(
    '.\public',
    '.\LICENSE',
    '.\README.md',
    '.\Find.Uninstaller.psm1',
    '.\CHANGELOG.md'
)

$Author='Danijel-James Wynyard'
$CompanyName='RePass Cloud Pty Ltd'
$Copyright='Copyright '+[char]0x00A9+' 2020 RePass Cloud Pty Ltd'

$Tags=@('uninstall','remove','applications','uninstaller','program','programs','apps')
$ProjectUri='https://github.com/repasscloud/Find.Uninstaller'
$LicenseUri='https://github.com/repasscloud/Find.Uninstaller/blob/master/LICENSE'
$ReleaseNotes=@"
- Astericks support from either end, or no ends
- Export functions capability to process requests
"@
$FunctionsToExport=@('Get-UninstallString')

$HelpInfoURI='https://raw.githubusercontent.com/repasscloud/Find.Uninstaller/master/README.md'

$ModuleVersion=$Env:APPVEYOR_BUILD_VERSION

New-ModuleManifest -Path $PSD1 `
  -Author $Author `
  -CompanyName $CompanyName `
  -Copyright $Copyright `
  -RootModule 'Find.Uninstaller.psm1' `
  -ModuleVersion $ModuleVersion `
  -Description $Description `
  -PowerShellVersion '5.1' `
  -ProcessorArchitecture None `
  -FileList $FileList `
  -Tags $Tags `
  -ProjectUri $ProjectUri `
  -LicenseUri $LicenseUri `
  -ReleaseNotes $ReleaseNotes `
  -FunctionsToExport $FunctionsToExport `
  -HelpInfoUri $HelpInfoURI

if ($Env:APPVEYOR_BUILD_NUMBER) {
    $CurrentBuild=$Env:APPVEYOR_BUILD_NUMBER
}

# Update the PS Scripts with the version and build
$OldVersionString='  Version:';
$NewVersionString="  Version:        1.0.1.{0}" -f $CurrentBuild
$LastUpdated='  Last Updated:';
$LatestUpdated="  Last Updated:   $((Get-Date).ToString('yyyy-MM-dd'))";
Get-ChildItem -Path "$Env:APPVEYOR_BUILD_FOLDER\public" -Filter "*.ps1" | ForEach-Object {
    $ManifestContent = Get-Content -Path $_.FullName -Raw;
    $ManifestContent = $ManifestContent -replace $OldVersionString,$NewVersionString;
    $ManifestContent = $ManifestContent -replace $LastUpdated,$LatestUpdated;
    Set-Content -Path $_.FullName -Value $ManifestContent -Force;
}
