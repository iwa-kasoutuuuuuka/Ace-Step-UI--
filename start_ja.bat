@echo off
echo Starting ACE-Step UI...
cd /d F:\app\ace-step-ui
start cmd /k "cd /d F:\app\ace-step-ui\server && npm run dev"
timeout /t 2
start cmd /k "cd /d F:\app\ace-step-ui && npm run dev"
timeout /t 5
start http://localhost:3000
echo Done. Press any key to close.
pause
