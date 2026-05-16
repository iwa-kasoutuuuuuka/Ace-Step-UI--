@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title ACE-Step UI 日本語版 - Launcher

echo ======================================================
echo    ACE-Step UI 日本語版 (Japanese Edition)
echo ======================================================
echo.

REM --- Check dependencies ---
if not exist "node_modules" echo [!] UI dependencies missing! & pause & exit /b 1
if not exist "server\node_modules" echo [!] Server dependencies missing! & pause & exit /b 1

REM --- Config ---
set CONFIG_FILE=.acestep_path
set ACESTEP_PATH=..\ACE-Step-1.5

REM Detect engine location if default doesn't exist
if not exist "%ACESTEP_PATH%" (
    if exist "..\ACE-Step-UI-JP-Portable\engine" (
        set ACESTEP_PATH=..\ACE-Step-UI-JP-Portable\engine
    )
)

REM Load saved path if exists
if exist "%CONFIG_FILE%" (
    set /p SAVED_PATH=<"%CONFIG_FILE%"
    if exist "!SAVED_PATH!" set ACESTEP_PATH=!SAVED_PATH!
)

:CHECK_PATH
if not exist "%ACESTEP_PATH%" (
    echo [!] ACE-Step not found at: %ACESTEP_PATH%
    echo.
    echo Please drag and drop the ACE-Step 1.5 folder here and press Enter:
    set /p INPUT_PATH="Path: "
    set ACESTEP_PATH=!INPUT_PATH:"=!
    
    if not exist "!ACESTEP_PATH!" (
        echo [!] Invalid path.
        goto CHECK_PATH
    )
    
    echo !ACESTEP_PATH!>"%CONFIG_FILE%"
    echo [+] Path saved.
)

echo [+] ACE-Step Path: %ACESTEP_PATH%

REM --- API Command ---
set API_FLAGS=--port 8001 --init_service --enable-api --language ja --device cpu
set API_COMMAND=

if exist "%ACESTEP_PATH%\python_embeded\python.exe" (
    echo [+] Detected Portable Version.
    set API_COMMAND=python_embeded\python.exe acestep\acestep_v15_pipeline.py %API_FLAGS%
) else (
    echo [+] Detected Standard Version.
    set API_COMMAND=uv run acestep\acestep_v15_pipeline.py %API_FLAGS%
)

echo.
echo ------------------------------------------------------
echo  Starting services (CPU Mode)...
echo ------------------------------------------------------
echo.

REM Start API
echo [1/3] Starting API (Initializing models, please wait)...
start "ACE-Step API" cmd /k "chcp 65001 >nul && cd /d "%ACESTEP_PATH%" && %API_COMMAND%"

REM Wait for CPU initialization
timeout /t 20 /nobreak >nul

REM Start Backend
echo [2/3] Starting Backend...
start "ACE-Step UI Backend" cmd /k "chcp 65001 >nul && cd /d "%~dp0server" && npm run dev"

timeout /t 2 /nobreak >nul

REM Start Frontend
echo [3/3] Starting Frontend...
start "ACE-Step UI Frontend" cmd /k "chcp 65001 >nul && cd /d "%~dp0" && npm run dev"

echo.
echo ------------------------------------------------------
echo  All services started!
echo  Opening browser...
echo ------------------------------------------------------
echo.

timeout /t 5 /nobreak >nul
start http://localhost:3000

echo [Done] Application is running.
pause
