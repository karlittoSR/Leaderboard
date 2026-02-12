@echo off
REM Leaderboard Game ID Setup Launcher
REM This batch file runs the PowerShell script with appropriate execution permissions

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0get_game_id.ps1"
pause
