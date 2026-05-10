@echo off
pushd "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "launcher.ps1"
pause
popd
