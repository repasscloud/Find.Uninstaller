﻿<#
.SYNOPSIS
  Returns Uninstall String for installed applications.

.DESCRIPTION
  Providing just the partial name of an application, the result returned will be the uninstall string from the registry
  for x86 and/or x64 program installations.
  
.PARAMETER Application
  Partial name of application for lookup. Asterix not required.

.PARAMETER FullDetail
  Return all details of string lookup.

.INPUTS
  None

.OUTPUTS
  UninstallString object.

.NOTES
  Version:
  Author:         Copyright © 2020 RePass Cloud Pty Ltd (https://repasscloud.com/). All rights reserved.
  License:        Apache-2.0
  Creation Date:  2020-07-17
  Last Updated:
  
.EXAMPLE
  Get-UninstallString -Application Firefox

.EXAMPLE
  Get-UninstallString -Application Firefox -FullDetail

#>
function Get-UninstallString {
    param(
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage='Name of Application to search for.',
            Position=0)]
        [Alias('App')]
        [String]$Application,

        [Parameter(Mandatory=$false,
            HelpMessage='Return all properties of application matching Application name.',
            Position=1)]
        [Alias('Detail')]
        [switch]$FullDetail
    )

    if ($Application -match '^\w.*$') { $Value = '*' + $Application + '*' } #~> no asterisk
    elseif ($Application -match '^\*\w.*$') { $Value = $Application + '*' } #~> asterisk at start only
    elseif ($Application -match '^\w.*\*$') { $Value = '*' + $Application } #~> asterisk at end only
    elseif ($Application -match '^\*\w.*\*$') { $Value = $Application } #~> asterisk at start and end
    else { $Value = '*' + $Application + '*' } #~> catch all backup
    
    if ($FullDetail) {
        $Path = @(
            'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
            'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
        )
        [String]$returnObj = Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object {$_.DisplayName -like "${Value}" } | Select-Object -Property *
        return $returnObj.UninstallString
    }
    else {
        $Path = @(
            'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
            'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
        )
        $returnObj = Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object {$_.DisplayName -like "${Value}" } | Select-Object -Property UninstallString
        return $returnObj
    }
}
