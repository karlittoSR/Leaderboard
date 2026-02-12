@echo off
echo Starting Leaderboard Setup...
echo.
echo Fixing PowerShell encoding issues...
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& { [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [System.Console]::InputEncoding = [System.Text.Encoding]::UTF8; $PSDefaultParameterValues['*:Encoding'] = 'utf8'; . '.\get_game_id.ps1' }"
echo.
echo If you see encoding errors above, please use the double-click method on get_game_id.ps1
pause