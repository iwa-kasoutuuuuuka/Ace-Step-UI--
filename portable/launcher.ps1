$ErrorActionPreference = "Stop"
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $currentDir = Split-Path $MyInvocation.MyCommand.Path -Parent
    if (-not $currentDir) { $currentDir = Get-Location }
    $engineDir = Join-Path $currentDir "engine"
    $nodeDir = Join-Path $currentDir "node"
    $tempNodeDir = Join-Path $currentDir "node_temp"

    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   ACE-Step UI 日本語 ポータブル版" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""

    # --- Node.js v22 (v127) の強制セットアップ ---
    $nodeExe = Join-Path $nodeDir "node.exe"
    $needsNodeUpdate = $true
    if (Test-Path $nodeExe) {
        $version = & $nodeExe -v
        if ($version.StartsWith("v22")) { $needsNodeUpdate = $false }
    }

    if ($needsNodeUpdate) {
        Write-Host "[+] Node.js v22 を準備しています (初回のみ)..." -ForegroundColor Yellow
        
        # 起動中の Node があれば止める
        Get-Process node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

        if (Test-Path $tempNodeDir) { Remove-Item $tempNodeDir -Recurse -Force }
        New-Item -ItemType Directory -Path $tempNodeDir | Out-Null
        
        $nodeZip = Join-Path $tempNodeDir "node.zip"
        $nodeUrl = "https://nodejs.org/dist/v22.2.0/node-v22.2.0-win-x64.zip"
        Invoke-WebRequest -Uri $nodeUrl -OutFile $nodeZip
        Expand-Archive -Path $nodeZip -DestinationPath $tempNodeDir -Force
        
        $extractedFolder = Get-ChildItem -Path $tempNodeDir -Directory | Where-Object { $_.Name -like "node-v22*" } | Select-Object -First 1
        
        # 古いフォルダを一旦消去
        if (Test-Path $nodeDir) { Remove-Item $nodeDir -Recurse -Force }
        New-Item -ItemType Directory -Path $nodeDir | Out-Null
        
        Copy-Item -Path "$($extractedFolder.FullName)\*" -Destination $nodeDir -Recurse -Force
        
        Remove-Item $tempNodeDir -Recurse -Force
    }
    Write-Host "[+] Node.js v22 を使用します。" -ForegroundColor Gray

    # --- Python パス探索 ---
    $pyExe = $null
    $searchPaths = @(
        (Join-Path $engineDir "python_embeded\python.exe"),
        (Join-Path $engineDir "python.exe")
    )
    foreach ($path in $searchPaths) {
        if (Test-Path $path) { $pyExe = $path; break }
    }

    if ($null -eq $pyExe) {
        Write-Host "[!] エンジンが見つかりません。" -ForegroundColor Red
        Read-Host "Enterで終了"
        return
    }
    $aceStepPath = Split-Path $pyExe -Parent
    if ($aceStepPath.EndsWith("python_embeded")) { $aceStepPath = Split-Path $aceStepPath -Parent }

    Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

    $serverPath = Join-Path $currentDir "server"
    $nodeCmd = "cd /d `"$serverPath`" && `"$nodeExe`" dist/index.js"
    Start-Process cmd -ArgumentList "/k $nodeCmd"

    $apiTarget = "acestep"
    if (Test-Path (Join-Path $aceStepPath "acestep\api.py")) { $apiTarget = "acestep.api" }
    $apiCmd = "cd /d `"$aceStepPath`" && `"$pyExe`" -m $apiTarget --port 8001 --enable-api"
    Start-Process cmd -ArgumentList "/k $apiCmd"

    Write-Host ""
    Write-Host "--------------------------------------------------"
    Write-Host " サービスを起動しました。5秒後にブラウザを開きます。"
    Write-Host "--------------------------------------------------"
    Start-Sleep -Seconds 5
    Start-Process "http://localhost:3001"
} catch {
    Write-Host "[!] エラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Enterで終了"
}
