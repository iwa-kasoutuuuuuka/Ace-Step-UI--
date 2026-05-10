$url = 'https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z'
$zipFile = Join-Path $PSScriptRoot 'engine.7z'
$extractDir = Join-Path $PSScriptRoot 'engine_temp'
$finalDir = Join-Path $PSScriptRoot 'engine'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

Write-Host '==================================================' -ForegroundColor Cyan
Write-Host '  ACE-Step 1.5 自動セットアップ (1-Click)' -ForegroundColor Cyan
Write-Host '==================================================' -ForegroundColor Cyan

$isEngineValid = Test-Path (Join-Path $finalDir "python_embeded\python.exe")
if (-not $isEngineValid) {
    if (Test-Path $finalDir) { Remove-Item $finalDir -Recurse -Force }
    
    if (-not (Test-Path $zipFile)) {
        Write-Host '[1/3] エンジン本体 (約5GB) をダウンロード中...' -ForegroundColor Yellow
        Invoke-WebRequest -Uri $url -OutFile $zipFile
    } else {
        Write-Host '[1/3] エンジン本体のアーカイブを発見しました。ダウンロードをスキップします。' -ForegroundColor Green
    }
    
    Write-Host '[2/3] ファイルを解凍しています... (5分-10分かかります)' -ForegroundColor Yellow
    if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
    New-Item -ItemType Directory -Path $extractDir | Out-Null
    
    $sevenZip = "C:\Program Files\7-Zip\7z.exe"
    if (-not (Test-Path $sevenZip)) { $sevenZip = "C:\Program Files (x86)\7-Zip\7z.exe" }
    
    try {
        if (Test-Path $sevenZip) {
            & $sevenZip x $zipFile "-o$extractDir" -y | Out-Null
        } else {
            tar -xf $zipFile -C $extractDir
        }
    } catch {
        Write-Host '[!] 解凍に失敗しました。Windows標準機能が.7zに対応していない可能性があります。' -ForegroundColor Red
        return
    }
    
    Write-Host '[3/3] 仕上げを行っています...' -ForegroundColor Yellow
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
