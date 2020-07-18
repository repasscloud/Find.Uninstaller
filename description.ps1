$description = @"
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
    '.\private',
    '.\public',
    '.\LICENSE',
    '.\README.md',
    '.\Find.Uninstaller.psm1',
    '.\Find.Uninstaller.psd1',
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

New-ModuleManifest -Path "${PSScriptRoot}\Find.Uninstaller.psd1" -Author $Author -CompanyName $CompanyName -Copyright $Copyright -RootModule 'Find.Uninstaller.psm1' -ModuleVersion '2.0.0.0' -Description $description -PowerShellVersion '5.1' -ProcessorArchitecture None -FileList $FileList -Tags $Tags -ProjectUri $ProjectUri -LicenseUri $LicenseUri -ReleaseNotes $ReleaseNotes -FunctionsToExport $FunctionsToExport