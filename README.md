# Speedrun Leaderboard Canvas

**Version 1.30** - Professional canvas-based speedrun.com leaderboard display  
**Multilingual preset manager with intelligent automation**  
**Supports 5 languages**: Français, English, Español, Português, 中文

Dynamic and animated display of Speedrun.com leaderboards with advanced features for streamers and speedrunners.

<img src="images/leaderboard-preview.png" width="100%" alt="Leaderboard Preview">

---

## Features

### Personal Best Tracking
- **Temporary PB Display**: Show your current attempt time with rainbow visual effects
- **Real-time Updates**: Update manually your temporary PB during runs
- **Intelligent Validation**: Only shows if you're in the selected category
- **Visual Distinction**: Rainbow colors for temporary unvalidated PB, normal colors for official leaderboard positions

### Game Support
- **Full Games & Individual Levels**: Complete support for all game types
- **Multiple Subcategories**: Handle complex category structures (Levels, Any%, etc.)
- **Millisecond Precision**: Full support for games requiring millisecond timing (Celeste, etc.)
- **Smart Time Parsing**: Accepts formats like `1:22.123` or `82.5` seconds

### Multilingual Interface
- **5 Complete Languages**: French, English, Spanish, Portuguese, Chinese
- **Real-time Switching**: Change language without restart
- **Persistent Settings**: Language automatically saved in configuration
- **Global Accessibility**: Designed for the international speedrun community

### Professional Display
- **Canvas-based Rendering**: Smooth, simple graphics
- **Animated Carousel**: Rotating display of additional leaderboard entries
- **Country Flags**: Automatic flag display from flagcdn.com
- **Ranking Colors**: Gold/Silver/Bronze for top 3, blue-grey for others
- **Smart Text Management**: Configurable player name length limits
- **Responsive Layout**: Adapts to different display sizes

### Intelligent Automation
- **Player Validation**: Automatic verification against speedrun.com API
- **Auto-preset Activation**: When only one preset remains, automatically activates it
- **Smart Configuration**: JSON-based settings with sensible defaults
- **Error Handling**: Comprehensive error messages and recovery

---

## Installation (5 minutes)

### Prerequisites

**PowerShell 7 Required** (Windows 10/11 - handles UTF-8 encoding correctly)

1. **Install PowerShell 7**  
   Download from: https://github.com/PowerShell/PowerShell/releases/
   - Choose latest stable release (green label)
   - Download `.msi` installer for your system (x64/x86)

2. **File Association**  
   - Right-click `configure.ps1` → "Open with" → "Choose another app"
   - Check "Always use this app to open .ps1 files"
   - Select "PowerShell 7"

3. **Fix Execution Policy**
   
   **Quick Fix**: Double-click `FIX_ACCESS.bat` - fixes everything automatically
   
   **Manual method**:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   Unblock-File -Path .\configure.ps1
   ```

4. **For Chinese language support** (if experiencing Chinese character display issues):
   - Right-click the PowerShell window title bar
   - Select "Properties" → "Font" tab
   - Change font to a Chinese-compatible font (e.g., SimSun, SimHei, or Microsoft YaHei)
   - Click "OK"
   
   <img src="images/chinesecharacters.png" width="50%" alt="Chinese Font Setup">

### Quick Setup

Follow the [QUICK_START_EN.md](QUICK_START_EN.md) guide for step-by-step instructions to get your leaderboard in OBS within 5 minutes.

---

## Usage Guide

### Initial Setup
1. Run `configure.ps1`
2. Add your first preset
3. Search for your game and select category
4. (Optional) Set your player name - enables temporary PB feature
5. (Optional) Change language anytime

### Managing Presets
- **Create**: Add new presets for different games/categories
- **Switch**: Change active preset anytime
- **Edit**: Rename presets from details view
- **Delete**: Remove unused presets (auto-activates last remaining)
- **Visual Indicator**: Green dot shows active preset

### Temporary PB System
1. Access "My Temporary PB"
2. Enter your current attempt time (e.g., `1:23.45`)
3. Watch it display with rainbow effects on the leaderboard
4. Clear when run is complete

### OBS Integration
- **Browser Source**: Local File → `leaderboard.html`
- **Dimensions**: Width: 400px, Height: 250px
- **Refresh**: Not needed - updates automatically

---

## Configuration

### Basic Settings
Edit `config.json` for customization:

```json
{
  "defaults": {
    "topCount": 3,                    // Number of top positions always shown
    "maxPlayerNameChars": 20,         // Character limit for player names
    "carouselInterval": 5000,         // Carousel rotation speed (ms)
    "displayWidth": "900px",          // OBS Browser Source width
    "displayHeight": "274px",         // OBS Browser Source height
    "canvasWidth": 1200,              // Internal canvas resolution
    "canvasHeight": 400,              // Internal canvas resolution
    "runsPerBatch": 3                 // Carousel entries per rotation
  }
}
```

### Flag Overrides
Override country flags for specific players using ISO 3166-1 alpha-2 codes

**Format**: The left side is the original country code (what players have), the right side is the flag to display instead.

```json
{
  "flagOverrides": {
    "HR": "FR"               // Players from HR (Croatia) will display FR (France) flag
  }
}
```

### Display Customization
- **Canvas Dimensions**: Adjust `canvasWidth`/`canvasHeight` for resolution
- **OBS Dimensions**: Modify `displayWidth`/`displayHeight` for browser source
- **Text Limits**: Change `maxPlayerNameChars` for name truncation
- **Carousel Speed**: Adjust `carouselInterval` for rotation timing
- **Batch Size**: Modify `runsPerBatch` for entries per carousel page

### Color Scheme
- **1st Place**: Gold (#FFD700)
- **2nd Place**: Silver (#C0C0C0)  
- **3rd Place**: Bronze (#CD7F32)
- **Other Positions**: Blue-grey (#9FB4CA)
- **Temporary PB**: Animated rainbow colors

---

## Advanced Features

### Game Types Supported
- **Full Game Categories**: Any%, 100%, All Bosses, Low%, etc.
- **Individual Level Runs**: Celeste chapters, Mario stages, etc.
- **Complex Subcategories**: Multiple variable filters
- **Mixed Formats**: Supports both timed categories and score-based

### Time Format Support
- **Standard**: `1:23:45` (hours:minutes:seconds)
- **Short**: `1:23` (minutes:seconds)
- **Decimal**: `82.5` (seconds with decimals)
- **Millisecond**: `1:22.123` (with millisecond precision)

### Player Features
- **Smart Validation**: Verifies usernames against speedrun.com
- **Position Display**: Shows your rank at the bottom on a separate row when outside top 3
- **Country Detection**: Automatic flag display
- **Name Handling**: Intelligent truncation with visual indicators

---

## Troubleshooting

### Common Issues

**Script won't execute**  
Solution: Run `FIX_ACCESS.bat` or manually set execution policy

**Game not found**  
Solution: Verify game exists on speedrun.com, check spelling, try alternate names

**Missing categories**  
Solution: Some games have complex structures, verify category exists on website

**Flags not loading**  
Solution: Requires internet connection, flags load from flagcdn.com

**Temporary PB not showing**  
Solution: Ensure player name matches speedrun.com username exactly

**Carousel not working**  
Solution: Check if enough entries exist beyond top 3 positions

### Error Messages

**"Player not found in category"**  
Your username doesn't appear in the selected category leaderboard

**"Category not found"**  
The category doesn't exist or has been renamed on speedrun.com

**"Invalid time format"**  
Use formats like `1:23.45` or `82.5` for time entry

---

## File Structure

```
leaderboard/
├── configure.ps1          # Main configuration script (multilingual)
├── leaderboard.html       # Canvas display (for OBS)
├── config.json           # Settings and presets storage
├── FIX_ACCESS.bat        # Execution policy fixer
├── README.md             # Complete documentation
├── QUICK_START_*.md      # Language-specific quick guides
└── images/              # Documentation assets
```

---

## Technical Details

### API Integration
- **Speedrun.com API v1**: Full integration with official REST API
- **Real-time Data**: Live leaderboard updates
- **Player Validation**: Username verification against API database
- **Category Resolution**: Automatic mapping of categories and subcategories

### Canvas Rendering
- **High DPI Support**: Device pixel ratio awareness for crisp display
- **Smooth Animations**: 60fps carousel transitions with fade effects
- **Efficient Drawing**: Optimized render loops for performance
- **Responsive Design**: Adapts to different canvas resolutions

### Data Management
- **JSON Configuration**: Human-readable settings format
- **Preset System**: Multiple game/category configurations
- **Persistent Storage**: Settings saved automatically
- **Validation Layer**: Input verification and error handling

---

**Professional speedrun leaderboard solution by karlitto__**
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

**Recommended method**: Use the configure.ps1 script!

1. **Double-click** on configure.ps1
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
→ **Use `FIX_ACCESS.bat`** - it fixes security policies automatically!  
→ Or make sure you installed **PowerShell 7** and associated `.ps1` files with it (see Prerequisites above)

**Get "running scripts is disabled" error?**  
→ **Double-click `FIX_ACCESS.bat`** to fix execution policy  
→ Or manually run: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`

**If it still doesn't work:**
- Try: Right-click `configure.ps1` → "Run with PowerShell 7"
- Or: Open PowerShell 7 directly and run: `cd <folder>; .\configure.ps1`

**The carousel doesn't scroll?**  
→ Check that there are more runs than the topCount

**No runs appear?**  
→ Verify the gameId, category, and subcategory (case sensitive!)

**"Failed to fetch" when double-clicking the HTML?**  
→ Normal! Only works with OBS integration.
