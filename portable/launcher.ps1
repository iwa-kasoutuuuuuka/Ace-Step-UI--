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

    # --- サーバー起動 ---
    $serverPath = Join-Path $currentDir "server"
    $serverCmd = "/k cd /d "$serverPath" && "$nodeExe" dist/index.js"
    Start-Process cmd -ArgumentList $serverCmd

    # --- ACE-Step API 起動 ---
    if (Test-Path (Join-Path $aceStepPath "python_embeded\python.exe")) {
        $python = Join-Path $aceStepPath "python_embeded\python.exe"
        $apiCmd = "/k cd /d "$aceStepPath" && "$python" -m acestep --port 8001 --enable-api"
        Start-Process cmd -ArgumentList $apiCmd
    } else {
        $apiCmd = "/k cd /d "$aceStepPath" && python -m acestep --port 8001 --enable-api"
        Start-Process cmd -ArgumentList $apiCmd
    }

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
