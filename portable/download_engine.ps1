$url = 'https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z'
$output = Join-Path $PSScriptRoot 'engine.7z'

Write-Host '--------------------------------------------------'
Write-Host '  ACE-Step 1.5 Engine Download'
Write-Host '--------------------------------------------------'
Write-Host 'File: engine.7z (approx. 5 GB)'
Write-Host 'Save to: ' $output
Write-Host 'Downloading... Please wait.'

Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop

Write-Host ''
Write-Host 'SUCCESS: Download Complete!'
Write-Host ''
Write-Host 'Next Steps:'
Write-Host '1. Extract ' $output ' using 7-Zip.'
Write-Host '2. Rename the extracted folder to engine.'
Write-Host '3. Run start.bat again.'
