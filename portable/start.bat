@echo off
title ACE-Step UI Japanese Portable
pushd "%~dp0"

:: PowerShellを実行
powershell -NoProfile -ExecutionPolicy Bypass -File "launcher.ps1"

:: もしPowerShell自体が起動できなかった場合（ポリシー制限等）の予備表示
if %errorlevel% neq 0 (
    echo.
    echo [!] PowerShellの起動に失敗しました。
    echo セキュリティ設定により実行がブロックされている可能性があります。
    pause
)

popd
