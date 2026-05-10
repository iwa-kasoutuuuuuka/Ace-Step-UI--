$ErrorActionPreference = "Stop"
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $currentDir = Split-Path $MyInvocation.MyCommand.Path -Parent
    if (-not $currentDir) { $currentDir = Get-Location }
    $engineDir = Join-Path $currentDir "engine"

    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   ACE-Step UI 日本語 ポータブル版" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""

    # Node.js パス (絶対パスで確実に)
    $nodeExe = "node"
    if (Test-Path (Join-Path $currentDir "node\node.exe")) {
        $nodeExe = Join-Path $currentDir "node\node.exe"
        Write-Host "[+] 同梱版 Node.js を使用します。" -ForegroundColor Gray
    }

    # Python パスを全自動で探索
    $pyExe = $null
    $searchPaths = @(
        (Join-Path $engineDir "python_embeded\python.exe"),
        (Join-Path $engineDir "python.exe"),
        (Join-Path $currentDir "engine\python_embeded\python.exe")
    )

    foreach ($path in $searchPaths) {
        if (Test-Path $path) { $pyExe = $path; break }
    }

    if ($null -eq $pyExe) {
        Write-Host "[!] Pythonエンジンが見つかりません。セットアップをやり直してください。" -ForegroundColor Red
        Read-Host "Enterで終了"
        return
    }

    $aceStepPath = Split-Path $pyExe -Parent
    # もし python_embeded の中にいたなら、その親をベースにする
    if ($aceStepPath.EndsWith("python_embeded")) {
        $aceStepPath = Split-Path $aceStepPath -Parent
    }

    Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

    # --- サーバー起動 (最もシンプルな方法) ---
    $serverPath = Join-Path $currentDir "server"
    $nodeCmd = "cd /d `"$serverPath`" && `"$nodeExe`" dist/index.js"
    Start-Process cmd -ArgumentList "/k $nodeCmd"

    # --- API 起動 ---
    $apiCmd = "cd /d `"$aceStepPath`" && `"$pyExe`" -m acestep --port 8001 --enable-api"
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
