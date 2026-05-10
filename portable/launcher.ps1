# 実行時のエラーを詳細に表示
$ErrorActionPreference = "Stop"

try {
    # 文字コード設定
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

    # 現在のスクリプトのフォルダを確実に取得
    $currentDir = Split-Path $MyInvocation.MyCommand.Path -Parent
    if (-not $currentDir) { $currentDir = Get-Location }

    $engineDir = Join-Path $currentDir "engine"
    $configFile = Join-Path $currentDir ".acestep_path"

    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   ACE-Step UI 日本語 ポータブル版" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""

    # Node.js のパス設定
    $nodeExe = "node"
    $localNode = Join-Path $currentDir "node\node.exe"
    if (Test-Path $localNode) {
        $nodeExe = "`"$localNode`""
        Write-Host "[+] 同梱版 Node.js を使用します。" -ForegroundColor Gray
    }

    # エンジンのパス確認関数
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
        Write-Host "[!] エンジン本体 (ACE-Step 1.5) が見つかりません。" -ForegroundColor Red
        Write-Host ""
        Write-Host "[1] 自動セットアップを開始する (5GB / 全自動)"
        Write-Host "[2] 手動でフォルダを指定する (ドラッグ＆ドロップ)"
        Write-Host ""
        $choice = Read-Host "選択 (1 or 2)"

        if ($choice -eq "1") {
            & (Join-Path $currentDir "download_engine.ps1")
            $aceStepPath = Get-EnginePath $engineDir $configFile
        } elseif ($choice -eq "2") {
            Write-Host ""
            Write-Host "ACE-Step 1.5 のフォルダをここにドラッグ＆ドロップして Enter を押してください。"
            $inputPath = Read-Host "パス"
            $inputPath = $inputPath.Replace('"', '')
            if (Test-Path $inputPath) {
                $inputPath | Out-File $configFile -NoNewline
                $aceStepPath = $inputPath
            } else {
                Write-Host "[!] 有効なパスではありません。" -ForegroundColor Red
                Read-Host "続行するには Enter を押してください..."
                return
            }
        }
    }

    if ($null -eq $aceStepPath) { return }

    # 起動処理
    Write-Host ""
    Write-Host "[+] サービスを起動しています..." -ForegroundColor Green

    # サーバー (Frontend/Backend)
    $serverPath = Join-Path $currentDir "server"
    Start-Process cmd -ArgumentList "/c cd /d `"$serverPath`" && $nodeExe dist/index.js"

    # ACE-Step API
    if (Test-Path (Join-Path $aceStepPath "python_embeded\python.exe")) {
        $python = Join-Path $aceStepPath "python_embeded\python.exe"
        Start-Process cmd -ArgumentList "/c cd /d `"$aceStepPath`" && `"$python`" -m acestep --port 8001 --enable-api"
    } else {
        Start-Process cmd -ArgumentList "/c cd /d `"$aceStepPath`" && python -m acestep --port 8001 --enable-api"
    }

    Write-Host ""
    Write-Host "--------------------------------------------------"
    Write-Host " 全ての準備が整いました。しばらくお待ちください。"
    Write-Host "--------------------------------------------------"
    Start-Sleep -Seconds 5
    Start-Process "http://localhost:3001"

} catch {
    Write-Host ""
    Write-Host "[!] エラーが発生しました:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Read-Host "何かキーを押すと終了します..."
}
