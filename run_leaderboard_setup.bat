@echo off
echo Starting Speedrun Leaderboard Setup...
echo.
echo This will temporarily allow PowerShell scripts for this session only.
echo Your system security settings will NOT be permanently changed.
echo.
pause

powershell.exe -ExecutionPolicy Bypass -File "get_game_id.ps1"

echo.
echo Setup completed! You can now close this window.
pause