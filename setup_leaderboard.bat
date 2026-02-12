@echo off
chcp 65001 >nul
echo Starting Leaderboard Setup...
echo.
powershell.exe -ExecutionPolicy Bypass -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; & '.\get_game_id.ps1'"
pause