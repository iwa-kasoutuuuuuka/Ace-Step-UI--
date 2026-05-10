@echo off
pushd "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "launcher.ps1"
if %errorlevel% neq 0 pause
popd
