$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$currentDir = Split-Path $MyInvocation.MyCommand.Path -Parent
if (-not $currentDir) { $currentDir = Get-Location }
$engineDir = Join-Path $currentDir 'engine'
$nodeDir = Join-Path $currentDir 'node'

Clear-Host
Write-Host '--------------------------------------------------'
Write-Host ' ACE-Step UI Portable Edition'
Write-Host '--------------------------------------------------'

$nodeExe = Join-Path $nodeDir 'node.exe'
$pyExe = Join-Path $engineDir 'python_embeded\python.exe'
if (-not (Test-Path $pyExe)) { $pyExe = Join-Path $engineDir 'python.exe' }

if (-not (Test-Path $pyExe)) {
    Write-Host '[!] Error: Python not found.'
    Read-Host 'Press Enter to exit'
    return
}

Write-Host '[+] Launching services...'

# --- Gradio UI (8001) ---
$gradioScript = Join-Path $engineDir 'acestep\acestep_v15_pipeline.py'
$apiCmd = 'cd /d "{0}" && "{1}" "{2}" --port 8001 --server-name 127.0.0.1 --init_service --language ja --device cpu' -f $engineDir, $pyExe, $gradioScript
Start-Process cmd -ArgumentList "/k $apiCmd"

# --- Node.js Server (3001) ---
Start-Sleep -Seconds 10
$serverPath = Join-Path $currentDir 'server'
$nodeCmd = 'cd /d "{0}" && "{1}" dist/index.js' -f $serverPath, $nodeExe
Start-Process cmd -ArgumentList "/k $nodeCmd"

Write-Host ''
Write-Host 'Engine loading... Please wait.'
Write-Host 'Browser will open in 20 seconds.'
Start-Sleep -Seconds 20
Start-Process http://localhost:3001
