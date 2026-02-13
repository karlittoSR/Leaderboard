@echo off
chcp 65001 >nul
title Fix PowerShell Security Policy
echo.
echo ================================================
echo   PowerShell Security Policy Fix
echo   For Speedrun Leaderboard Script
echo ================================================
echo.
echo This will fix common issues when running the script:
echo   1. Fix execution policy (allow scripts)
echo   2. Unblock downloaded file
echo.
pause

echo.
echo [1/2] Checking execution policy...
pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "$policy = Get-ExecutionPolicy -Scope CurrentUser; if ($policy -in @('Restricted', 'AllSigned')) { Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force -ErrorAction SilentlyContinue }; $final = Get-ExecutionPolicy -Scope CurrentUser; Write-Host \"Current policy: $final\" -ForegroundColor Cyan; exit 0"
if %errorlevel% equ 0 (
    echo [OK] Execution policy is ready!
) else (
    echo [WARNING] Could not check policy. Script may still work.
)

echo.
echo [2/2] Unblocking script file...
pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "Unblock-File -Path '%~dp0main.ps1' -ErrorAction SilentlyContinue"
echo [OK] Script unblocked!

echo.
echo ================================================
echo   Setup complete! Now launching the script...
echo ================================================
echo.
timeout /t 2 >nul

pwsh.exe -NoProfile -File "%~dp0main.ps1"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Script failed to launch.
    echo Try running this file as Administrator.
    pause
)
