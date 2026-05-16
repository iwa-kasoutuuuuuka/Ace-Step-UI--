@echo off
chcp 65001 >nul
title ACE-Step UI - Launch JA

echo Starting ACE-Step UI...
echo.

REM --- Find Engine Absolute Path ---
set ENGINE_REL=..\ACE-Step-UI-JP-Portable\engine
if not exist "%ENGINE_REL%" set ENGINE_REL=..\ACE-Step-1.5

if not exist "%ENGINE_REL%" (
    echo [!] ACE-Step engine not found at %ENGINE_REL%
    pause
    exit /b 1
)

REM Convert to absolute path
pushd "%ENGINE_REL%"
set ACESTEP_PATH=%CD%
popd

echo [+] Engine Absolute Path: %ACESTEP_PATH%
set PYTHON_EXE=%ACESTEP_PATH%\python_embeded\python.exe

REM --- API Flags ---
set FLAGS=--port 8001 --init_service --enable-api --language ja --device cpu

REM --- Start API ---
echo [1/3] Starting API...
start "ACE-Step API" cmd /k "chcp 65001 >nul && cd /d "%ACESTEP_PATH%" && python_embeded\python.exe acestep\acestep_v15_pipeline.py %FLAGS%"

echo Waiting 20 seconds for CPU initialization...
timeout /t 20 /nobreak >nul

REM --- Start Backend ---
echo [2/3] Starting Backend...
REM Pass the absolute path to the backend
start "ACE-Step UI Backend" cmd /k "chcp 65001 >nul && set ACESTEP_PATH=%ACESTEP_PATH% && cd /d "%~dp0server" && npm run dev"

timeout /t 2 /nobreak >nul

REM --- Start Frontend ---
echo [3/3] Starting Frontend...
start "ACE-Step UI Frontend" cmd /k "chcp 65001 >nul && cd /d "%~dp0" && npm run dev"

echo.
echo All services started. Opening browser in 5 seconds...
timeout /t 5 /nobreak >nul
start http://localhost:3000

echo Done.
pause
