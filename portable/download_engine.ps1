$url = 'https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z'
$zipFile = Join-Path $PSScriptRoot 'engine.7z'
$extractDir = Join-Path $PSScriptRoot 'engine_temp'
$finalDir = Join-Path $PSScriptRoot 'engine'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Write-Host '==================================================' -ForegroundColor Cyan
Write-Host '  ACE-Step 1.5 自動セットアップ (1-Click)' -ForegroundColor Cyan
Write-Host '==================================================' -ForegroundColor Cyan
$isEngineValid = Test-Path (Join-Path $finalDir "python_embeded\python.exe")
if (-not $isEngineValid) {
    if (-not (Test-Path $zipFile)) {
        Write-Host '[1/3] エンジン本体 (約5GB) をダウンロード中...' -ForegroundColor Yellow
        Invoke-WebRequest -Uri $url -OutFile $zipFile
    }
    Write-Host '[2/3] ファイルを解凍しています... (5分-10分かかります)' -ForegroundColor Yellow
    if (-not (Test-Path $extractDir)) { New-Item -ItemType Directory -Path $extractDir | Out-Null }
    $sevenZip = "C:\Program Files\7-Zip\7z.exe"
    if (-not (Test-Path $sevenZip)) { $sevenZip = "C:\Program Files (x86)\7-Zip\7z.exe" }
    try {
        if (Test-Path $sevenZip) {
            & $sevenZip x $zipFile "-o$extractDir" -y | Out-Null
        } else {
            tar -xf $zipFile -C $extractDir
        }
    } catch {
        Write-Host '[!] 解凍に失敗しました。' -ForegroundColor Red
        return
    }
    Write-Host '[3/3] 仕上げを行っています...' -ForegroundColor Yellow
    $innerDir = Get-ChildItem -Path $extractDir -Directory | Select-Object -First 1
    if ($innerDir) {
        if (Test-Path $finalDir) { Remove-Item $finalDir -Recurse -Force }
        Move-Item -Path $innerDir.FullName -Destination $finalDir
    } else {
        if (Test-Path $finalDir) { Remove-Item $finalDir -Recurse -Force }
        Move-Item -Path $extractDir -Destination $finalDir
    }
    Remove-Item $zipFile -Force
    if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
}
Write-Host '完了しました！' -ForegroundColor Green
