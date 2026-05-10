@echo off
title ACE-Step UI Japanese Portable (Debug)
pushd "%~dp0"

echo [+] PowerShell ランチャーを起動しています...
echo.

:: PowerShell を実行し、もしエラーがあれば画面を止めます
powershell -NoProfile -ExecutionPolicy Bypass -File "launcher.ps1"

if %errorlevel% neq 0 (
    echo.
    echo [!] ランチャーの実行中にエラーが発生しました。
    echo 上記のエラーメッセージを確認してください。
    pause
)

popd
