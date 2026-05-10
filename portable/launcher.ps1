$ErrorActionPreference = "Stop"
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $currentDir = Split-Path $MyInvocation.MyCommand.Path -Parent
    if (-not $currentDir) { $currentDir = Get-Location }
    $engineDir = Join-Path $currentDir "engine"
    $configFile = Join-Path $currentDir ".acestep_path"

    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   ACE-Step UI 日本語 ポータブル版" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""

    # Node.js のパス設定 (絶対パス化)
    $nodeExe = "node"
    $localNode = Join-Path $currentDir "node\node.exe"
    if (Test-Path $localNode) {
        $nodeExe = $localNode
        Write-Host "[+] 同梱版 Node.js を使用します。" -ForegroundColor Gray
    }

    function Get-EnginePath {
        param($eDir, $cFile)
        if (Test-Path (Join-Path $eDir "python_embeded\python.exe")) { return $eDir }
        if (Test-Path $cFile) {
            $savedPath = Get-Content $cFile -Raw
            if ($savedPath -and (Test-Path $savedPath.Trim())) { return $savedPath.Trim() }
        }
        return $null
    }

    $aceStepPath = Get-EnginePath $engineDir $configFile
    if ($null -eq $aceStepPath) {
        Write-Host "[!] エンジン本体が見つかりません。セットアップをやり直してください。" -ForegroundColor Red
        Read-Host "Enterで終了"
        return
    }

    Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

    # サーバー起動 (Native PowerShell 方式)
    $serverPath = Join-Path $currentDir "server"
    Start-Process $nodeExe -ArgumentList "dist/index.js" -WorkingDirectory $serverPath -WindowStyle Normal

    # ACE-Step API 起動
    if (Test-Path (Join-Path $aceStepPath "python_embeded\python.exe")) {
        $python = Join-Path $aceStepPath "python_embeded\python.exe"
        Start-Process $python -ArgumentList "-m acestep --port 8001 --enable-api" -WorkingDirectory $aceStepPath -WindowStyle Normal
    } else {
        Start-Process python -ArgumentList "-m acestep --port 8001 --enable-api" -WorkingDirectory $aceStepPath -WindowStyle Normal
    }

    Write-Host ""
    Write-Host "--------------------------------------------------"
    Write-Host " 全ての準備が整いました。ブラウザで開きます。"
    Write-Host "--------------------------------------------------"
    Start-Sleep -Seconds 5
    Start-Process "http://localhost:3001"
} catch {
    Write-Host "[!] エラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Enterで終了"
}
