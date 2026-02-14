# Quick Start Guide

**Get your speedrun leaderboard in OBS in 5 minutes**

---

## Step 1: Install PowerShell 7

1. Download from: https://github.com/PowerShell/PowerShell/releases/
2. Choose **latest stable release** (green label)
3. Download and install the `.msi` file for your system

## Step 2: Fix Access

1. Download all files: `configure.ps1`, `leaderboard.html`, `config.json`, `FIX_ACCESS.bat`
2. Place them in the same folder
3. **Double-click `FIX_ACCESS.bat`** - fixes everything automatically

## Step 3: Add Your Game

1. Double-click `configure.ps1` or continue with the last `FIX_ACCESS.bat` option.
2. Select **"Add a new preset"**
3. Type your game name (e.g., "Elden Ring")
4. Choose your game from the list
5. Select category (Any%, 100%, etc.)
6. Give it a name and activate it
7. You can close the program.

## Step 4: Set Your Name (Optional)

1. Select **"Set my name"**
2. Enter your speedrun.com username exactly
3. This enables the temporary PB feature - skip if not needed

## Step 5: Add to OBS

1. Add **Browser Source**
2. **Local File** → browse to `leaderboard.html`
3. **Width**: 400px
4. **Height**: 250px
5. **Done!**

Your leaderboard will update automatically and display your position at the bottom on a separate row when you're outside the top 3.

---

## Advanced Features

**For all available features** (visual tweaks, custom fonts, time formats, rank alignment, rainbow PB highlighting, etc.), check out the full **[README.md](README.md)** !