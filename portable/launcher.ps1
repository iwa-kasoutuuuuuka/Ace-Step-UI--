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
        Write-Host "[!] エンジンが見つかりません。" -ForegroundColor Red
        Read-Host "Enterで終了"
        return
    }

    Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

    # --- Gradio UI 起動 (8001) - Node.jsが期待するGradioクライアント接続先 ---
    $gradioScript = Join-Path $engineDir "acestep\acestep_v15_pipeline.py"
    $apiCmd = "cd /d `"$engineDir`" && `"$pyExe`" `"$gradioScript`" --port 8001 --server-name 127.0.0.1"
    Start-Process cmd -ArgumentList "/k $apiCmd"

    # --- Node.js サーバー起動 (3001) - Gradioが立ち上がる時間を確保 ---
    Start-Sleep -Seconds 3
    $serverPath = Join-Path $currentDir "server"
    $nodeCmd = "cd /d `"$serverPath`" && `"$nodeExe`" dist/index.js"
    Start-Process cmd -ArgumentList "/k $nodeCmd"

    Write-Host ""
    Write-Host "--------------------------------------------------"
    Write-Host " Gradio エンジンを読み込み中... (初回は数分かかります)"
    Write-Host " ブラウザは30秒後に自動起動します。"
    Write-Host "--------------------------------------------------"
    Start-Sleep -Seconds 30
    Start-Process "http://localhost:3001"
} catch {
    Write-Host "[!] エラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Enterで終了"
}
