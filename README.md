# Speedrun Leaderboard Canvas

**Version**: 1.1.0  
**Multilingual preset manager with arrow-based navigation**  
**Supports 5 languages**: French, English, Spanish, Portuguese, Chinese

Dynamic display of Speedrun.com leaderboards on canvas with animated carousel, fully configurable.

<img width="436" height="229" alt="image" src="https://github.com/user-attachments/assets/f6add34f-9eb3-4272-88d6-565995ee1c80" />

## Installation (2 minutes)

1. **Download** these files:
   - leaderboard.html
   - config.json
   - `get_game_id.ps1` (configuration script with multilingual interface)
   - `run_leaderboard_setup.bat` (easy launcher - no setup required)

2. **Place them in the same folder**

3. **Run the setup** - Choose the easiest method for you:
   - **EASIEST:** Double-click `run_leaderboard_setup.bat` ✅ *(No PowerShell setup needed)*
   - **Alternative:** Double-click `get_game_id.ps1` *(May require PowerShell permissions)*
   
   Then navigate with arrow keys to find your game and category.
   - **Choose language**: Option 5 in the main menu
   - Interface available in **5 languages**

4. **Add the file to OBS** (Browser Source) with these values: Width 400, Height 280

### Troubleshooting
**If you get "execution policy" errors when running the .ps1 file:**
- ✅ **Use `run_leaderboard_setup.bat` instead** (bypasses the issue)
- Or run this command first: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- PowerShell 7 is NOT required - works with built-in Windows PowerShell

## Features v1.1.0

### Multilingual Support
- **5 languages available**: FR, EN, ES, PT, ZH
- **Fully translated interface**
- **Real-time language switching** without restart
- **Persistent configuration** - language automatically saved
- **Global accessibility** for the entire speedrun community

### Interface
- **Arrow key navigation** (up/down arrows)
- **Backspace key** for going back
- **Simplified confirmations**: yes/no dialogs
- **Persistent display** of presets during navigation
- **Visual indicators**: checkmark [ACTIVE] and pin for active preset
- **Modern interface**
- **Integrated language menu**

### Leaderboard
- Display of **top 3** + **animated carousel** of other runs
- Colors for placements (gold, silver, bronze)
- **Country flags** (loaded from flagcdn)
- **Fully configurable** via config.json
- **URL parameters** to override settings
- **Responsive** and transparent (perfect for Twitch streams)

## How it works

The **"config.json"** file contains **presets** for different games/categories:

`json
"presets": {
  "elden-any-glitchless": {
    "gameId": "nd28z0ed",
    "category": "Any%",
    "subcategory": "Glitchless"
  }
}
`

You can access a preset like this:
- **Default**: leaderboard.html (uses the first preset)
- **With specific preset**: leaderboard.html?preset=elden-100

## Adding a Game

**Recommended method**: Use the get_game_id.ps1 script!

1. **Double-click** on get_game_id.ps1
2. **Choose language** (Option 5) if needed
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
- **Multilingual interface** → Option 5 in the script menu

## Customizing Appearance

Colors, fonts, and layout are defined in the DRAW section of the HTML. Edit them directly to match your branding!

## Help

**The carousel doesn't scroll?**  
→ Check that there are more runs than the 	opCount

**No runs appear?**  
→ Verify the gameId, category, and subcategory (case sensitive!)

**"Failed to fetch" when double-clicking the HTML?**  
→ Normal! CORS issue. Use a local server: python -m http.server 8000 then http://localhost:8000

**Don't know how to proceed?**  
→ Start with [QUICK_START_EN.md](QUICK_START_EN.md)
