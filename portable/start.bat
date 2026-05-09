@echo off
title ACE-Step UI Japanese Portable
setlocal enabledelayedexpansion

echo ==================================================
echo    ACE-Step UI 日本語 ポータブル版
echo ==================================================
echo.

REM --- Node.jsの確認 ---
set NODE_EXE=node
if exist "%~dp0node\node.exe" (
    set NODE_EXE="%~dp0node\node.exe"
    echo [+] ローカルのNode.jsを使用します。
)

REM --- ACE-Stepのパスを確認 ---
set CONFIG_FILE=.acestep_path
set DEFAULT_PATH=..\ACE-Step-1.5

if exist "%CONFIG_FILE%" (
    set /p ACESTEP_PATH=<"%CONFIG_FILE%"
) else (
    set ACESTEP_PATH=%DEFAULT_PATH%
)

:CHECK_PATH
if not exist "%ACESTEP_PATH%" (
    echo [!] ACE-Step 1.5 が見つかりません。
    echo ACE-Step 1.5 のフォルダをここにドラッグ＆ドロップしてください。
    set /p ACESTEP_PATH="パス: "
    set ACESTEP_PATH=!ACESTEP_PATH:"=!
    echo !ACESTEP_PATH!>"%CONFIG_FILE%"
)

REM --- サーバー起動 ---
echo [+] サーバーを起動しています...
start "ACE-Step UI Server" cmd /k "cd /d "%~dp0server" && %NODE_EXE% dist/index.js"

REM --- API起動 ---
echo [+] ACE-Step APIを起動しています...
if exist "%ACESTEP_PATH%\python_embeded\python.exe" (
    start "ACE-Step API" cmd /k "cd /d "%ACESTEP_PATH%" && python_embeded\python.exe -m acestep --port 8001 --enable-api"
) else (
    start "ACE-Step API" cmd /k "cd /d "%ACESTEP_PATH%" && python -m acestep --port 8001 --enable-api"
)

echo.
echo 全てのサービスを起動しました。
echo ブラウザで http://localhost:3001 を開きます...
timeout /t 5
start http://localhost:3001

exit
