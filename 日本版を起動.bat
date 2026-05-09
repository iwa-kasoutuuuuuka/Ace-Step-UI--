@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title ACE-Step UI 日本語版 - Launcher

echo ======================================================
echo    ACE-Step UI 日本語版 (Japanese Edition)
echo ======================================================
echo.

REM --- Check dependencies ---
if not exist "node_modules" (
    echo [!] Dependencies not found. Please run setup.bat first.
    pause
    exit /b 1
)

if not exist "server\node_modules" (
    echo [!] Server dependencies not found. Please run setup.bat first.
    pause
    exit /b 1
)

REM --- Config ---
set CONFIG_FILE=.acestep_path
set DEFAULT_PATH=..\ACE-Step-1.5

if exist "%CONFIG_FILE%" (
    set /p ACESTEP_PATH=<"%CONFIG_FILE%"
) else (
    set ACESTEP_PATH=%DEFAULT_PATH%
)

:CHECK_PATH
if not exist "%ACESTEP_PATH%" (
    echo [!] ACE-Step 1.5 not found at: %ACESTEP_PATH%
    echo.
    echo Please drag and drop the ACE-Step 1.5 folder here and press Enter:
    set /p ACESTEP_PATH="Path: "
    set ACESTEP_PATH=!ACESTEP_PATH:"=!
    
    if not exist "!ACESTEP_PATH!" (
        echo [!] Invalid path.
        goto CHECK_PATH
    )
    
    echo !ACESTEP_PATH!>"%CONFIG_FILE%"
    echo [+] Path saved.
)

echo [+] ACE-Step Path: %ACESTEP_PATH%

REM --- API Command ---
set API_COMMAND=
if exist "%ACESTEP_PATH%\python_embeded\python.exe" (
    echo [+] Detected Portable Version.
    set API_COMMAND=python_embeded\python.exe -m acestep --port 8001 --enable-api --backend pt --server-name 127.0.0.1
) else (
    echo [+] Using default start command.
    set API_COMMAND=uv run acestep-api --port 8001
)

echo.
echo ------------------------------------------------------
echo  Starting services...
echo ------------------------------------------------------
echo.

REM Start API
echo [1/3] Starting API...
start "ACE-Step API" cmd /k "chcp 65001 >nul && cd /d "%ACESTEP_PATH%" && %API_COMMAND%"

timeout /t 3 /nobreak >nul

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
echo You can close this window.
pause
