' VBScript wrapper to execute PowerShell script
' Double-click this file to run get_game_id.ps1 with PowerShell

Set objShell = CreateObject("WScript.Shell")
strPath = objShell.CurrentDirectory
strScript = chr(34) & strPath & "\get_game_id.ps1" & chr(34)
strCommand = "powershell.exe -ExecutionPolicy Bypass -File " & strScript

objShell.Run strCommand, 1, False