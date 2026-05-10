$ErrorActionPreference = "Stop"
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $currentDir = Split-Path $MyInvocation.MyCommand.Path -Parent
    if (-not $currentDir) { $currentDir = Get-Location }
    $engineDir = Join-Path $currentDir "engine"
    $nodeDir = Join-Path $currentDir "node"

    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   ACE-Step UI 日本語 ポータブル版" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""

    $nodeExe = Join-Path $nodeDir "node.exe"
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
        Write-Host "[!] エンジンが見つかりません。セットアップをやり直してください。" -ForegroundColor Red
        Read-Host "Enterで終了"
        return
    }
    $aceStepPath = Split-Path $pyExe -Parent
    if ($aceStepPath.ToLower().EndsWith("python_embeded")) { $aceStepPath = Split-Path $aceStepPath -Parent }

    Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

    # --- サーバー起動 (3001) ---
    $serverPath = Join-Path $currentDir "server"
    $nodeCmd = "cd /d `"$serverPath`" && `"$nodeExe`" dist/index.js"
    Start-Process cmd -ArgumentList "/k $nodeCmd"

    # --- API 起動 (8001) - 余計な引数(--enable-api)を削除 ---
    $apiTarget = "acestep.api_server"
    $apiCmd = "cd /d `"$aceStepPath`" && `"$pyExe`" -m $apiTarget --port 8001"
    Start-Process cmd -ArgumentList "/k $apiCmd"

    Write-Host ""
    Write-Host "--------------------------------------------------"
    Write-Host " 全ての準備が整いました！"
    Write-Host " ブラウザで曲の生成をお楽しみください。"
    Write-Host "--------------------------------------------------"
    Start-Sleep -Seconds 5
    if (-not (Get-Process msedge, chrome, firefox -ErrorAction SilentlyContinue)) {
        Start-Process "http://localhost:3001"
    }
} catch {
    Write-Host "[!] エラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Enterで終了"
}
