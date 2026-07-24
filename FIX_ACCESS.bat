@echo off
chcp 65001 >nul
title Fix Access (PowerShell Policy)
echo.
echo ================================================
echo   PowerShell Security Policy Fix
echo   For Speedrun Leaderboard Script
echo ================================================
echo.
echo This will prepare the script without changing your user-wide
echo PowerShell execution policy:
echo   1. Check PowerShell 7
echo   2. Unblock the downloaded script
echo.
pause

echo.
echo [1/2] Checking PowerShell 7...
pwsh.exe -NoProfile -Command "Write-Host \"PowerShell $($PSVersionTable.PSVersion) is available.\" -ForegroundColor Cyan"
if %errorlevel% equ 0 (
    echo [OK] PowerShell 7 is ready!
) else (
    echo [ERROR] PowerShell 7 (pwsh.exe) was not found.
    echo Install it from https://aka.ms/powershell
    pause
    exit /b 1
)

echo.
echo [2/2] Unblocking script file...
pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "Unblock-File -Path '%~dp0configure.ps1' -ErrorAction SilentlyContinue"
echo [OK] Script unblocked!

echo.
echo ================================================
echo   Setup complete!
echo ================================================
echo.
echo Next step: add the file to OBS (leaderboard.html)
echo.
set /p launch=Launch setup now? (Y/N): 
if /I "%launch%"=="Y" goto launch
echo Exiting.
exit /b 0

:launch
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0configure.ps1"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Script failed to launch.
    echo Check the error shown above, then try again.
    pause
)
