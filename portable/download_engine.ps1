$url = 'https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z'
$zipFile = Join-Path $PSScriptRoot 'engine.7z'
$extractDir = Join-Path $PSScriptRoot 'engine_temp'
$finalDir = Join-Path $PSScriptRoot 'engine'

Write-Host '--------------------------------------------------'
Write-Host '  ACE-Step 1.5 Auto Setup (1-Click)'
Write-Host '--------------------------------------------------'

if (-not (Test-Path $finalDir)) {
    Write-Host '[1/3] Downloading engine (5GB)... Please wait.'
    Invoke-WebRequest -Uri $url -OutFile $zipFile -ErrorAction Stop

    Write-Host '[2/3] Extracting... This may take a few minutes.'
    if (-not (Test-Path $extractDir)) { New-Item -ItemType Directory -Path $extractDir }
    
    # Try using Windows native tar (supports 7z in recent Win10/11)
    try {
        tar -xf $zipFile -C $extractDir
    } catch {
        Write-Host '[!] Automatic extraction failed. Please extract engine.7z manually.' -ForegroundColor Red
        return
    }

    Write-Host '[3/3] Finalizing setup...'
    # Find the actual engine folder inside temp and move it
    $innerDir = Get-ChildItem -Path $extractDir -Directory | Select-Object -First 1
    if ($innerDir) {
        Move-Item -Path $innerDir.FullName -Destination $finalDir
    } else {
        Move-Item -Path $extractDir -Destination $finalDir
    }

    # Cleanup
    Remove-Item $zipFile -Force
    if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
}

Write-Host ''
Write-Host 'SUCCESS: Setup Complete! Starting ACE-Step UI...' -ForegroundColor Green
Write-Host ''
