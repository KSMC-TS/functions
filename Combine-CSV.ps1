<#
.SYNOPSIS
Combines multiple CSV files into a single CSV file, excluding initial comment lines.

.DESCRIPTION
This PowerShell script reads all CSV files in a specified target directory, 
    filters out lines at the beginning of each file that start with '#', 
    and combines the content into a single CSV file. 
    The combined CSV is then saved to a specified output directory with a given file name suffix.

.PARAMETER TargetDirectory
The directory where the source CSV files are located. Defaults to the current directory.

.PARAMETER TargetFileFilter
The filter for the source CSV files. Defaults to 'csv', which selects all CSV files in the target directory.

.PARAMETER OutputDirectory
The directory where the combined CSV file will be saved. Defaults to './output'.

.PARAMETER OutputFileSuffix
The suffix for the output file name. Defaults to 'combined.csv', which names the output file 'yyyyMMdd-HHmmss-combined.csv'.

.EXAMPLE
.\Combine-CSV.ps1 -TargetDirectory './data' -OutputDirectory './result' -OutputFileSuffix 'merged_data.csv'

This command reads all CSV files from './data', combines them (excluding initial comment lines), 
    and saves the result as 'yyyyMMdd-HHmmss-merged_data.csv' in the './result' directory.

.NOTES
Author: Zachary Choate
Date: 08/14/2024
Version: 1.0

#>

[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $TargetDirectory = '.',
    [Parameter()]
    [string]
    $TargetFileExtension = 'csv',
    [Parameter()]
    [string]
    $OutputDirectory = './output',
    [Parameter()]
    [string]
    $OutputFileSuffix = 'combined.csv'


)

$fileFilter = "*.$TargetFileExtension"

$files = Get-ChildItem -Path $TargetDirectory -Filter $fileFilter

$combinedCsv = $null

foreach ($file in $files) {
    $fileContent = Get-Content -Path $file
    $processing = $true
    $filteredContent = foreach ($line in $fileContent) {
        if ($processing -and $line -notmatch '^#') {
            $processing = $false
        }
        if (-not $processing) {
            $line
        }
    }
    $csvData = $filteredContent | Out-String | ConvertFrom-Csv
    if ($combinedCsv -eq $null) {
        $combinedCsv = $csvData
    } else {
        $combinedCsv += $csvData
    }
}

$datePrefix = Get-Date -Format 'yyyyMMdd-HHmmss'
$outputFile = "${OutputDirectory}\${datePrefix}-${OutputFileSuffix}"

if (!(Test-Path -Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory
}

$combinedCsv | Export-Csv -Path $outputFile -NoTypeInformation