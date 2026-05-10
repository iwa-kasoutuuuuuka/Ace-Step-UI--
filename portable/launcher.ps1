# 文字コードをUTF-8に設定
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$engineDir = Join-Path $PSScriptRoot "engine"
$configFile = Join-Path $PSScriptRoot ".acestep_path"

Clear-Host
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "   ACE-Step UI 日本語 ポータブル版" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Node.js のパス設定
$nodeExe = "node"
$localNode = Join-Path $PSScriptRoot "node\node.exe"
if (Test-Path $localNode) {
    $nodeExe = "`"$localNode`""
    Write-Host "[+] 同梱版 Node.js を使用します。" -ForegroundColor Gray
}

# エンジンのパス確認
function Get-EnginePath {
    if (Test-Path (Join-Path $engineDir "python_embeded\python.exe")) { return $engineDir }
    if (Test-Path $configFile) {
        $savedPath = Get-Content $configFile -Raw
        if (Test-Path $savedPath.Trim()) { return $savedPath.Trim() }
    }
    return $null
}

$aceStepPath = Get-EnginePath

while ($null -eq $aceStepPath) {
    Write-Host "[!] エンジン本体 (ACE-Step 1.5) が見つかりません。" -ForegroundColor Red
    Write-Host ""
    Write-Host "[1] 自動セットアップを開始する (5GB / 全自動)"
    Write-Host "[2] 手動でフォルダを指定する (ドラッグ＆ドロップ)"
    Write-Host ""
    $choice = Read-Host "選択 (1 or 2)"

    if ($choice -eq "1") {
        & (Join-Path $PSScriptRoot "download_engine.ps1")
        $aceStepPath = Get-EnginePath
        if ($null -ne $aceStepPath) { break }
    } elseif ($choice -eq "2") {
        Write-Host ""
        Write-Host "ACE-Step 1.5 のフォルダをここにドラッグ＆ドロップして Enter を押してください。"
        $inputPath = Read-Host "パス"
        $inputPath = $inputPath.Replace('"', '')
        if (Test-Path $inputPath) {
            $inputPath | Out-File $configFile -NoNewline
            $aceStepPath = $inputPath
            break
        } else {
            Write-Host "[!] 有効なパスではありません。" -ForegroundColor Red
        }
    }
}

# 起動処理
Write-Host ""
Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

# サーバー (Frontend/Backend)
$serverPath = Join-Path $PSScriptRoot "server"
Start-Process cmd -ArgumentList "/c cd /d `"$serverPath`" && $nodeExe dist/index.js" -WindowStyle Normal

# ACE-Step API
if (Test-Path (Join-Path $aceStepPath "python_embeded\python.exe")) {
    $python = Join-Path $aceStepPath "python_embeded\python.exe"
    Start-Process cmd -ArgumentList "/c cd /d `"$aceStepPath`" && `"$python`" -m acestep --port 8001 --enable-api" -WindowStyle Normal
} else {
    Start-Process cmd -ArgumentList "/c cd /d `"$aceStepPath`" && python -m acestep --port 8001 --enable-api" -WindowStyle Normal
}

Write-Host ""
Write-Host "--------------------------------------------------"
Write-Host " 全ての準備が整いました。ブラウザで開きます。"
Write-Host "--------------------------------------------------"
Start-Sleep -Seconds 5
Start-Process "http://localhost:3001"
