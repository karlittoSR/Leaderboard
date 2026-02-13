# Speedrun Leaderboard Canvas
**Version**: 1.20  
**Multilingual preset manager with arrow-based navigation**  
**Supports 5 languages**: French, English, Spanish, Portuguese, Chinese

Dynamic display of Speedrun.com leaderboards on canvas with animated carousel, fully configurable.

<img width="430" height="292" alt="image" src="https://github.com/user-attachments/assets/9b1e9e20-8349-4d7d-abf6-905c66bce986" />


## Installation (2 minutes)

### Prerequisites

**PowerShell 7 is required** (Windows 10/11 only - handles UTF-8 encoding correctly)

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

3. **Fix Execution Policy (if script won't run)**:
   
   **🚀 EASY WAY**: Double-click `LAUNCH_ME_FIRST.bat` - it fixes everything automatically!
   
   **Manual way** (if the .bat doesn't work):
   Open PowerShell 7 and run:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   Unblock-File -Path .\main.ps1
   ```
   
   💡 The `.bat` file will:
   - Fix the execution policy
   - Unblock the downloaded script
   - Launch the script automatically

4. **For Chinese language support** (if experiencing Chinese character display issues):
   - Right-click the PowerShell window title bar
   - Select "Properties" → "Font" tab
   - Change font to a Chinese-compatible font (e.g., SimSun, SimHei, or Microsoft YaHei)
   - Click "OK"
  <img width="460" height="427" alt="image" src="https://github.com/user-attachments/assets/d3f435c3-ae3b-40ac-a1ec-0ca4c09392c0" />


### Installation Steps

1. **Download** these files:
   - `leaderboard.html`
   - `config.json`
   - `main.ps1` (PowerShell script for configuration)

2. **Place them in the same folder**

3. **Run the setup** - Double-click `main.ps1`:
   
   Then navigate with arrow keys to find your game and category.
   - **Choose language**: Option 6 in the main menu
   - Interface available in **5 languages**

4. **Add the file to OBS** (Browser Source) with these values: Width 400, Height 280

## Features v1.20

### Multilingual Support
- **5 languages available**: FR, EN, ES, PT, ZH
- **Fully translated interface**
- **Real-time language switching** without restart
- **Persistent configuration** - language automatically saved
- **Global accessibility** for the entire speedrun community

### Interface
- **Arrow key navigation** (up/down arrows)
- **Backspace key** for going back
- **Esc key** to cancel text input
- **Simplified confirmations**: yes/no dialogs
- **Persistent display** of presets during navigation
- **Visual indicators**: green dot for active preset, bullet for others
- **Modern interface**
- **Integrated language menu**
- **Player name option** (optional rank line on leaderboard)

### Levels
- **Full game or Levels** selection when supported
- **Per-level categories** for games like Celeste
- **Level stored in preset** for automatic display

### Leaderboard
- Display of **top 3** + **animated carousel** of other runs
- Colors for placements (gold, silver, bronze)
- **Country flags** (loaded from flagcdn)
- **Fully configurable** via config.json
- **Configurable fetch limit** via defaults.maxRuns (default: 200)
- **URL parameters** to override settings
- **Responsive** and transparent (perfect for Twitch streams)
- **Optional player line** at the bottom (your position)

## How it works

The **"config.json"** file contains **presets** for different games/categories:

```json
"playerName": "Karlitto",
"presets": {
   "elden-any-glitchless": {
      "gameId": "nd28z0ed",
      "category": "Any%",
      "subcategory": "Glitchless",
      "subcategories": [
         { "variableId": "7891zr5n", "valueId": "qj740p3q", "label": "Glitchless" }
      ]
   },
   "celeste-level": {
      "gameId": "o1y9j9v6",
      "levelId": "r9g4k7p9",
      "levelName": "Celestial Resort",
      "category": "Collectibles",
      "subcategory": "Full Clear"
   }
}
```

You can access a preset like this:
- **Default**: leaderboard.html (uses the first preset)
- **With specific preset**: leaderboard.html?preset=elden-100

## Adding a Game

**Recommended method**: Use the main.ps1 script!

1. **Double-click** on main.ps1
2. **Choose language** (Option 6) if needed
3. **Select** "Add new preset"
4. **Follow** the automatic wizard

Everything is handled automatically, including preset activation!

**Documentation available in your language:**
- Choose your QUICK_START guide according to your preferred language
- The script interface automatically adapts to your choice

See **[QUICK_START_EN.md](QUICK_START_EN.md)** for detailed tutorial with screenshots.

## Complete Guides

### Multilingual Documentation
- **French: How to add a game?** → [QUICK_START_FR.md](QUICK_START_FR.md)
- **English: How to add a game?** → [QUICK_START_EN.md](QUICK_START_EN.md)
- **Spanish: How to add a game?** → [QUICK_START_ES.md](QUICK_START_ES.md)
- **Portuguese: How to add a game?** → [QUICK_START_PT.md](QUICK_START_PT.md)
- **Chinese: How to add a game?** → [QUICK_START_ZH.md](QUICK_START_ZH.md)

### Configuration
- **Detailed configuration?** → See comments in config.json
- **Multilingual interface** → Option 6 in the script menu
- **Runs fetched** → defaults.maxRuns (default: 200)

## Customizing Appearance

Colors, fonts, and layout are defined in the DRAW section of the HTML. Edit them directly to match your branding!

## Help

**Script won't run when double-clicking?**  
→ **Use `LAUNCH_ME_FIRST.bat`** - it fixes security policies automatically!  
→ Or make sure you installed **PowerShell 7** and associated `.ps1` files with it (see Prerequisites above)

**Get "running scripts is disabled" error?**  
→ **Double-click `LAUNCH_ME_FIRST.bat`** to fix execution policy  
→ Or manually run: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`

**If it still doesn't work:**
- Try: Right-click `main.ps1` → "Run with PowerShell 7"
- Or: Open PowerShell 7 directly and run: `cd <folder>; .\main.ps1`

**The carousel doesn't scroll?**  
→ Check that there are more runs than the topCount

**No runs appear?**  
→ Verify the gameId, category, and subcategory (case sensitive!)

**"Failed to fetch" when double-clicking the HTML?**  
→ Normal! CORS issue. Use a local server: `python -m http.server 8000` then `http://localhost:8000`

**Don't know how to proceed?**  
→ Start with [QUICK_START_EN.md](QUICK_START_EN.md)
