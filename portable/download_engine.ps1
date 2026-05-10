$url = 'https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z'
$zipFile = Join-Path $PSScriptRoot 'engine.7z'
$extractDir = Join-Path $PSScriptRoot 'engine_temp'
$finalDir = Join-Path $PSScriptRoot 'engine'

# 文字コードをUTF-8に固定
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host '==================================================' -ForegroundColor Cyan
Write-Host '  ACE-Step 1.5 自動セットアップ (1-Click)' -ForegroundColor Cyan
Write-Host '==================================================' -ForegroundColor Cyan

if (-not (Test-Path $finalDir)) {
    # 1. ダウンロード
    if (-not (Test-Path $zipFile)) {
        Write-Host '[1/3] エンジン本体 (約5GB) をダウンロード中...' -ForegroundColor Yellow
        Write-Host '      ※環境によっては30分以上かかる場合があります。' -ForegroundColor Gray
        Invoke-WebRequest -Uri $url -OutFile $zipFile
    } else {
        Write-Host '[1/3] 圧縮ファイルは既に存在します。ダウンロードをスキップします。' -ForegroundColor Green
    }

    # 2. 解凍
    Write-Host '[2/3] ファイルを解凍しています... しばらくお待ちください。' -ForegroundColor Yellow
    Write-Host '      ※この処理は5分〜10分ほどかかります。画面が止まって見えますが正常です。' -ForegroundColor Gray
    
    if (-not (Test-Path $extractDir)) { New-Item -ItemType Directory -Path $extractDir | Out-Null }
    
    # 7-Zipを探す
    $sevenZip = "C:\Program Files\7-Zip\7z.exe"
    if (-not (Test-Path $sevenZip)) { $sevenZip = "C:\Program Files (x86)\7-Zip\7z.exe" }

    try {
        if (Test-Path $sevenZip) {
            Write-Host '      (7-Zip を使用して高速解凍中...)' -ForegroundColor Gray
            & $sevenZip x $zipFile "-o$extractDir" -y | Out-Null
        } else {
            Write-Host '      (Windows標準機能で解凍中...)' -ForegroundColor Gray
            tar -xf $zipFile -C $extractDir
        }
    } catch {
        Write-Host '[!] 自動解凍に失敗しました。' -ForegroundColor Red
        Write-Host '    お手数ですが "engine.7z" を手動で解凍して、"engine" という名前にしてください。'
        return
    }

    # 3. 配置
    Write-Host '[3/3] 仕上げを行っています...' -ForegroundColor Yellow
    $innerDir = Get-ChildItem -Path $extractDir -Directory | Select-Object -First 1
    if ($innerDir) {
        if (Test-Path $finalDir) { Remove-Item $finalDir -Recurse -Force }
        Move-Item -Path $innerDir.FullName -Destination $finalDir
    } else {
        if (Test-Path $finalDir) { Remove-Item $finalDir -Recurse -Force }
        Move-Item -Path $extractDir -Destination $finalDir
    }

    # 掃除
    Write-Host '[+] 不要なファイルを削除しています...' -ForegroundColor Gray
    Remove-Item $zipFile -Force
    if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
}

Write-Host ''
Write-Host '完了しました！ACE-Step UI を起動します。' -ForegroundColor Green
Write-Host '--------------------------------------------------'
