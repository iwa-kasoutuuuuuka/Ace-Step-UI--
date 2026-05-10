$url = 'https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z'
$zipFile = Join-Path $PSScriptRoot 'engine.7z'
$extractDir = Join-Path $PSScriptRoot 'engine_temp'
$finalDir = Join-Path $PSScriptRoot 'engine'
$toolsDir = Join-Path $PSScriptRoot 'tools'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

Write-Host '==================================================' -ForegroundColor Cyan
Write-Host '  ACE-Step 1.5 自動セットアップ (1-Click)' -ForegroundColor Cyan
Write-Host '==================================================' -ForegroundColor Cyan

$isEngineValid = Test-Path (Join-Path $finalDir "python_embeded\python.exe")
if (-not $isEngineValid) {
    if (Test-Path $finalDir) { Remove-Item $finalDir -Recurse -Force }
    
    if (-not (Test-Path $zipFile)) {
        Write-Host '[1/4] エンジン本体 (約5GB) をダウンロード中...' -ForegroundColor Yellow
        Invoke-WebRequest -Uri $url -OutFile $zipFile
    }

    # 7-zip ツールがない場合はダウンロード (zip形式なので標準機能で解凍可能)
    $sevenZipExe = "C:\Program Files\7-Zip\7z.exe"
    if (-not (Test-Path $sevenZipExe)) { $sevenZipExe = "C:\Program Files (x86)\7-Zip\7z.exe" }
    
    if (-not (Test-Path $sevenZipExe)) {
        Write-Host '[2/4] 解凍ツールを準備しています...' -ForegroundColor Yellow
        if (-not (Test-Path $toolsDir)) { New-Item -ItemType Directory -Path $toolsDir | Out-Null }
        $sevenZipPath = Join-Path $toolsDir "7za.exe"
        if (-not (Test-Path $sevenZipPath)) {
            $sevenZipUrl = "https://www.7-zip.org/a/7za920.zip"
            $sevenZipZip = Join-Path $toolsDir "7z.zip"
            Invoke-WebRequest -Uri $sevenZipUrl -OutFile $sevenZipZip
            Expand-Archive -Path $sevenZipZip -DestinationPath $toolsDir -Force
            Remove-Item $sevenZipZip -Force
        }
        $sevenZipExe = $sevenZipPath
    }

    Write-Host '[3/4] ファイルを解凍しています... (5分-10分かかります)' -ForegroundColor Yellow
    if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
    New-Item -ItemType Directory -Path $extractDir | Out-Null
    
    & $sevenZipExe x $zipFile "-o$extractDir" -y | Out-Null

    Write-Host '[4/4] 仕上げを行っています...' -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $finalDir | Out-Null
    $items = Get-ChildItem -Path $extractDir
    if ($items.Count -eq 1 -and $items[0].PSIsContainer) {
        Copy-Item -Path "$($items[0].FullName)\*" -Destination $finalDir -Recurse -Force
    } else {
        Copy-Item -Path "$extractDir\*" -Destination $finalDir -Recurse -Force
    }
    
    Remove-Item $zipFile -Force
    Remove-Item $extractDir -Recurse -Force
}
Write-Host '完了しました！' -ForegroundColor Green
