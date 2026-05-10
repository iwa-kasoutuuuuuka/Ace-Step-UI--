@echo off
chcp 65001 > nul
title ACE-Step UI Japanese Portable
setlocal enabledelayedexpansion

cls
echo ==================================================
echo    ACE-Step UI 日本語 ポータブル版
echo ==================================================
echo.

REM --- Node.jsの確認 ---
set NODE_EXE=node
if exist "%~dp0node\node.exe" (
    set NODE_EXE="%~dp0node\node.exe"
    echo [+] 同梱版 Node.js を使用します。
)

REM --- ACE-Stepのパスを確認 ---
set CONFIG_FILE=.acestep_path
set ENGINE_DIR=%~dp0engine

if exist "%ENGINE_DIR%\python_embeded\python.exe" (
    set ACESTEP_PATH=%ENGINE_DIR%
) else if exist "%CONFIG_FILE%" (
    set /p ACESTEP_PATH=<"%CONFIG_FILE%"
) else (
    set ACESTEP_PATH=..\ACE-Step-1.5
)

:CHECK_PATH
if not exist "%ACESTEP_PATH%" (
    echo [!] エンジン本体 (ACE-Step 1.5) が見つかりません。
    echo.
    echo [1] 自動セットアップを開始する (5GB / 全自動)
    echo [2] 手動でフォルダを指定する (ドラッグ＆ドロップ)
    echo.
    set /p CHOICE="選択 (1 or 2): "
    
    if "!CHOICE!"=="1" (
        cls
        powershell -ExecutionPolicy Bypass -File "%~dp0download_engine.ps1"
        echo.
        echo [!] セットアップが完了しました。
        echo 何かキーを押すと ACE-Step UI を起動します。
        pause > nul
        goto CHECK_PATH
    )
    
    echo.
    echo ACE-Step 1.5 のフォルダをここにドラッグ＆ドロップしてください。
    set /p ACESTEP_PATH="パス: "
    set ACESTEP_PATH=!ACESTEP_PATH:"=!
    echo !ACESTEP_PATH!>"%CONFIG_FILE%"
    goto CHECK_PATH
)

REM --- サーバー起動 ---
echo [+] サービスを起動中...
start "ACE-Step UI Server" cmd /c "cd /d "%~dp0server" && %NODE_EXE% dist/index.js"

REM --- API起動 ---
if exist "%ACESTEP_PATH%\python_embeded\python.exe" (
    start "ACE-Step API" cmd /c "cd /d "%ACESTEP_PATH%" && python_embeded\python.exe -m acestep --port 8001 --enable-api"
) else (
    start "ACE-Step API" cmd /c "cd /d "%ACESTEP_PATH%" && python -m acestep --port 8001 --enable-api"
)

echo.
echo --------------------------------------------------
echo 全ての準備が整いました。
echo しばらくするとブラウザで画面が開きます。
echo --------------------------------------------------
timeout /t 5 > nul
start http://localhost:3001

exit
