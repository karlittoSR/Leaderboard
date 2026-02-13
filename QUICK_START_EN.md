# QUICK START: Speedrun Leaderboard

**Automatic 5-minute setup** for streamers!  
🌐 **New**: Interface available in 5 languages!

---

## ⚠️ Prerequisites

**PowerShell 7 is required** (Windows 10/11 only)

1. **Install PowerShell 7**:
  - Go to: https://github.com/PowerShell/PowerShell/releases/
  - Choose the **latest release** (green label), **not** a preview
  - Download the installer that matches your system
  - **Windows**: use the `.msi` (x64 or x86)

2. **Associate .ps1 files with PowerShell 7**:
   - Right-click `main.ps1`
   - Select "Open with" → "Choose another app"
   - Check "Always use this app to open .ps1 files"
   - Select "PowerShell 7" from the list
   - If not visible: click "More apps" and scroll to find it

---

## Automatic method (v1.20+)

### First use
1. **Double-click** on `main.ps1`
2. **Main menu** displays automatically
3. **Navigate** with ↑↓ to select "Add a new preset"
4. **Press Enter** to confirm
5. **Enter** the game name (e.g., "Elden Ring")
6. **Navigate** ↑↓ and **Enter** to select the game from the list
7. **Choose** Full game or Levels (if available)
8. **If Levels**: select the level
9. **Navigate** ↑↓ and **Enter** to choose the category (Any%, 100%, etc.)
10. **Optional**: subcategories (multiple choices possible)
11. **Give an ID** to the preset (auto suggestion provided)
12. **Automatically activate** the preset (if it's the first one)

**Result**: preset saved + activated automatically + URL copied!

### Main menu interface (v1.20)
The script displays a menu with intuitive navigation in your language:

```
================================================
  SRC Preset Manager by karlitto__
================================================

Existing presets:
🟢 Elden Ring - Any% Glitchless
• Dark Souls III - All Bosses

What would you like to do?
► Add a new preset
  View details of an existing preset
  Change active preset
  Delete a preset
  Set player name
  Language settings
  Quit program

Use ↑↓ to navigate, Enter to select
```

### 🌐 Multilingual support (v1.20)
The interface is available in **5 languages**:
- **🇫🇷 Français** (default)
- **🇺🇸 English**
- **🇪🇸 Español**
- **🇧🇷 Português**  
- **🇨🇳 中文**

**Change language**:
1. Main menu → **Option 6** "Language settings"
2. Navigate with ↑↓ to choose your language
3. Press **Enter** → Immediate change!
4. Language is **saved automatically**

**Navigation**: Use **↑↓** to move between options  
**Selection**: Press **Enter** to confirm  
**Go back**: Press **⌫ Backspace** when available (indicated on screen)  
**Cancel input**: Press **Esc** when typing text  
**Confirmations**: Simple **yes/no** dialog (y/N) - no complex typing!

### Available options

**1. Add new preset**: Create new preset (same workflow as first time)  
**2. View details**: View complete details of a preset  
**3. Change active preset**: Select which preset is active in OBS  
**4. Delete preset**: Delete a preset (simple y/N confirmation)  
**5. Set player name**: Show your rank line on the leaderboard  
**6. Language settings**: Change interface language (5 languages available)  
**7. Quit**: Close the program

### Using in OBS
- **Simple URL**: `leaderboard.html` (always the same!)
- **Browser source**: Width 400, Height 280
- **Auto refresh**: every 30 seconds
- **No parameters**: automatically reads the active preset

---

## Common issues

### PowerShell script blocked
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Failed to fetch" when testing in browser
**Normal**: CORS limitations. **Works perfectly in OBS!**

### Preset not displayed
1. Use [main.ps1](main.ps1) → **Option 3** to change the active preset
2. All settings are automatically managed by the script

---

## Useful links

- **Auto configuration**: [main.ps1](main.ps1) (multilingual interface)
- **Display**: [leaderboard.html](leaderboard.html)
- **Full documentation**: [README.md](README.md)

---

**Streamer tip**: Only one URL in OBS (`leaderboard.html`)! Change games with the script → **Option 3** during stream!

**Multilingual tip**: Configure once in your language, everything is saved automatically!

---

## Need help?

- **Can't find Game ID** → Run `main.ps1` - fully automated!
- **No runs showing** → Use the script to reconfigure the preset
- **Carousel doesn't scroll** → Fewer runs than configured amount
- **"Failed to fetch" when double-clicking** → Run local server: `python -m http.server 8000`
- **PS script won't execute** → Right-click → "Run with PowerShell"
- **Change language** → Option 6 in the main script menu