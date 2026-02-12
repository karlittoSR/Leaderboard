# Script PowerShell pour gérer les presets speedrun.com facilement
# Gère plusieurs jeux et categories pour streamers
# Version 1.0.1 - Navigation par flèches et affichage persistant des presets
# Par karlitto__

# === FONCTION NAVIGATION PAR FLÈCHES ===
function Show-ArrowMenu {
  param(
    [string]$Title,
    [array]$Options,
    [int]$SelectedIndex = 0,
    [switch]$AllowCancel = $false,
    [string]$ContextText = ""
  )
  
  $currentIndex = $SelectedIndex
  $maxIndex = $Options.Count - 1
  
  while ($true) {
    Clear-Host
    
    # Afficher le contexte si fourni
    if ($ContextText) {
      Write-Host $ContextText
    }
    
    if ($Title) {
      Write-Host $Title -ForegroundColor Cyan
      Write-Host ""
    }
    
    for ($i = 0; $i -lt $Options.Count; $i++) {
      if ($i -eq $currentIndex) {
        Write-Host "► $($Options[$i])" -ForegroundColor Yellow
      } else {
        Write-Host "  $($Options[$i])" -ForegroundColor White
      }
    }
    
    Write-Host ""
    if ($AllowCancel) {
      Write-Host "Utilisez ↑↓ pour naviguer, Entrée pour sélectionner, Échap pour annuler" -ForegroundColor Gray
    } else {
      Write-Host "Utilisez ↑↓ pour naviguer, Entrée pour sélectionner" -ForegroundColor Gray
    }
    
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
    switch ($key.VirtualKeyCode) {
      38 { # Flèche haut
        $currentIndex = if ($currentIndex -eq 0) { $maxIndex } else { $currentIndex - 1 }
      }
      40 { # Flèche bas
        $currentIndex = if ($currentIndex -eq $maxIndex) { 0 } else { $currentIndex + 1 }
      }
      13 { # Entrée
        return $currentIndex
      }
      27 { # Échap
        if ($AllowCancel) {
          return -1
        }
      }
    }
  }
}

# === FONCTION MENU PRINCIPAL ===
function Write-MainMenu {
  param($currentConfig)
  
  if ($currentConfig -and $currentConfig.presets -and $currentConfig.presets.PSObject.Properties.Count -gt 0) {
    $existingPresets = $currentConfig.presets.PSObject.Properties
    $presetList = @()
    foreach ($preset in $existingPresets) {
      $presetList += $preset
    }
    return $presetList
  } else {
    return @()
  }
}

# === FONCTION SHOW PRESET DETAILS ===
function Write-PresetDetails($presetList, $currentConfig) {
  Clear-Host
  Write-Host "=== DETAILS D'UN PRESET ===" -ForegroundColor Cyan
  Write-Host ""
  
  if ($presetList.Count -gt 1) {
    $options = @()
    foreach ($preset in $presetList) {
      $options += "$($preset.Value.name)"
    }
    
    $selectedIndex = Show-ArrowMenu -Title "Choisissez un preset à voir :" -Options $options -AllowCancel
    
    if ($selectedIndex -eq -1) { return }
    $selectedPreset = $presetList[$selectedIndex]
  } else {
    $selectedPreset = $presetList[0]
  }
  
  Clear-Host
  Write-Host "=== DETAILS DU PRESET ===" -ForegroundColor Cyan
  Write-Host "Nom : $($selectedPreset.Value.name)" -ForegroundColor White
  Write-Host "Preset ID : $($selectedPreset.Name)" -ForegroundColor Cyan
  Write-Host "Game ID : $($selectedPreset.Value.gameId)" -ForegroundColor Cyan
  Write-Host "Category : $($selectedPreset.Value.category)" -ForegroundColor Cyan
  $subcat = if ($selectedPreset.Value.subcategory) { $selectedPreset.Value.subcategory } else { "null" }
  Write-Host "Subcategory : $subcat" -ForegroundColor Cyan
  $isActive = if ($currentConfig.activePreset -eq $selectedPreset.Name) { "OUI" } else { "NON" }
  Write-Host "Actif dans OBS : $isActive" -ForegroundColor $(if ($isActive -eq "OUI") { "Green" } else { "Yellow" })
  Write-Host ""
  Write-Host "URL OBS (toujours la meme) :" -ForegroundColor Cyan
  Write-Host "leaderboard.html" -ForegroundColor Gray
  Write-Host ""
  Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION CHANGE ACTIVE PRESET ===
function Update-ActivePreset($presetList, $currentConfig) {
  Clear-Host
  Write-Host "=== CHANGER LE PRESET ACTIF ===" -ForegroundColor Cyan
  Write-Host ""
  
  $options = @()
  foreach ($preset in $presetList) {
    $isActive = if ($preset.Name -eq $currentConfig.activePreset) { " [ACTIF]" } else { "" }
    $options += "$($preset.Value.name)$isActive"
  }
  
  $selectedIndex = Show-ArrowMenu -Title "Presets disponibles :" -Options $options -AllowCancel
  
  if ($selectedIndex -eq -1) { return }
  
  $newActivePreset = $presetList[$selectedIndex]
  $currentConfig.activePreset = $newActivePreset.Name
  
  # Sauvegarder
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host "✓ Preset actif changé vers : $($newActivePreset.Value.name)" -ForegroundColor Green
  Write-Host "OBS va automatiquement utiliser ce preset !" -ForegroundColor Green
  Write-Host ""
  Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION REMOVE PRESET ===
function Remove-Preset($presetList, $currentConfig) {
  Clear-Host
  
  if ($presetList.Count -eq 1) {
    Write-Host "=== IMPOSSIBLE DE SUPPRIMER ===" -ForegroundColor Red
    Write-Host ""
    Write-Host "Impossible de supprimer le dernier preset !" -ForegroundColor Red
    Write-Host "Vous devez avoir au moins un preset configuré." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }
  
  Write-Host "=== SUPPRIMER UN PRESET ===" -ForegroundColor Red
  Write-Host ""
  
  $options = @()
  foreach ($preset in $presetList) {
    $isActive = if ($preset.Name -eq $currentConfig.activePreset) { " [ACTIF]" } else { "" }
    $options += "$($preset.Value.name)$isActive"
  }
  
  $selectedIndex = Show-ArrowMenu -Title "Presets disponibles :" -Options $options -AllowCancel
  
  if ($selectedIndex -eq -1) {
    Write-Host "Suppression annulée." -ForegroundColor Cyan
    Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }
  
  $presetToDelete = $presetList[$selectedIndex]
  
  Clear-Host
  Write-Host "ATTENTION : Vous allez supprimer définitivement :" -ForegroundColor Red
  Write-Host "$($presetToDelete.Value.name)" -ForegroundColor Cyan
  Write-Host ""
  $confirm = Read-Host "Êtes-vous sûr ? Tapez 'SUPPRIMER' pour confirmer"
  
  if ($confirm -ne "SUPPRIMER") {
    Write-Host "Suppression annulée." -ForegroundColor Cyan
    Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }
  
  # Supprimer le preset
  $deletedPresetId = $presetToDelete.Name
  $currentConfig.presets.PSObject.Properties.Remove($deletedPresetId)
  
  # Gérer le cas où le preset supprimé était actif
  if ($currentConfig.activePreset -eq $deletedPresetId) {
    $remainingPresets = $currentConfig.presets.PSObject.Properties
    if ($remainingPresets.Count -gt 0) {
      $newOptions = @()
      $newPresetList = @()
      foreach ($preset in $remainingPresets) {
        $newOptions += "$($preset.Value.name)"
        $newPresetList += $preset
      }
      
      $newActiveIndex = Show-ArrowMenu -Title "Le preset actif a été supprimé. Choisissez le nouveau preset actif :" -Options $newOptions
      $currentConfig.activePreset = $newPresetList[$newActiveIndex].Name
    } else {
      $currentConfig.activePreset = $null
    }
  }
  
  # Sauvegarder
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host "✓ Preset '$($presetToDelete.Value.name)' supprimé avec succès !" -ForegroundColor Green
  if ($currentConfig.activePreset) {
    $newActiveName = $currentConfig.presets.($currentConfig.activePreset).name
    Write-Host "Nouveau preset actif : $newActiveName" -ForegroundColor Cyan
  }
  Write-Host ""
  Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION ADD NEW PRESET ===
function New-Preset($currentConfig) {
  Clear-Host
  Write-Host "=== AJOUT D'UN NOUVEAU PRESET ===" -ForegroundColor Green
  Write-Host ""

  $gameName = Read-Host "Nom du jeu"

  if ([string]::IsNullOrWhiteSpace($gameName)) {
    Write-Host "Erreur : Vous devez entrer un nom de jeu!" -ForegroundColor Red
    Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }

  Write-Host "Recherche en cours pour : $gameName" -ForegroundColor Yellow

  try {
    # === ETAPE 1: Chercher le jeu ===
    $response = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games?name=$([System.Web.HttpUtility]::UrlEncode($gameName))" -TimeoutSec 10
    $data = $response.Content | ConvertFrom-Json
    
    $games = $data.data
    
    if ($games.Count -eq 0) {
      Write-Host "Aucun jeu trouve pour : $gameName" -ForegroundColor Red
      Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }
    
    # Selection du jeu
    if ($games.Count -gt 1) {
      $gameOptions = @()
      foreach ($game in $games) {
        $releaseYear = if ($game.released) { " ($($game.released))" } else { "" }
        $gameOptions += "$($game.names.international)$releaseYear"
      }
      
      $selectedGameIndex = Show-ArrowMenu -Title "Jeux trouvés :" -Options $gameOptions -AllowCancel
      
      if ($selectedGameIndex -eq -1) {
        Write-Host "Annulé." -ForegroundColor Cyan
        return
      }
      
      $selectedGame = $games[$selectedGameIndex]
    } else {
      $selectedGame = $games[0]
    }
    
    # === ETAPE 2: Recuperer les categories ===
    Write-Host ""
    Write-Host "Chargement des categories..." -ForegroundColor Yellow
    
    $categoriesResponse = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games/$($selectedGame.id)?embed=categories.variables" -TimeoutSec 10
    $categoriesData = $categoriesResponse.Content | ConvertFrom-Json
    
    $categories = $categoriesData.data.categories.data | Where-Object { $_.type -eq "per-game" }
    
    if ($categories.Count -eq 0) {
      Write-Host "Aucune catégorie trouvée pour ce jeu!" -ForegroundColor Red
      Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }
    
    # Sélection de la catégorie
    $categoryOptions = @()
    foreach ($category in $categories) {
      $categoryOptions += $category.name
    }
    
    $selectedCategoryIndex = Show-ArrowMenu -Title "Catégories disponibles :" -Options $categoryOptions
    $selectedCategory = $categories[$selectedCategoryIndex]
    
    # === ETAPE 3: Gérer les sous-catégories ===
    $selectedSubcategory = $null
    $selectedSubcategoryLabel = "null"
    
    $subcategoryVariables = $selectedCategory.variables.data | Where-Object { $_.'is-subcategory' -eq $true -and $_.values.values }
    
    if ($subcategoryVariables.Count -gt 0) {
      # On prend la première variable de sous-catégorie trouvée
      $subcatVariable = $subcategoryVariables[0]
      $subcatValues = $subcatVariable.values.values.PSObject.Properties
      
      $subcatOptions = @("Aucune sous-catégorie (null)")
      $subcatArray = @()
      
      foreach ($value in $subcatValues) {
        $subcatOptions += $value.Value.label
        $subcatArray += @{
          id = $value.Name
          label = $value.Value.label
        }
      }
      
      # Sélection de la sous-catégorie
      $selectedSubcatIndex = Show-ArrowMenu -Title "Sous-catégories disponibles :" -Options $subcatOptions
      
      if ($selectedSubcatIndex -gt 0) {
        $selectedSubcategory = $subcatArray[$selectedSubcatIndex - 1]
        $selectedSubcategoryLabel = $selectedSubcategory.label
      }
    }
    
    # === ETAPE 4: Preset ID et sauvegarde ===
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "           CONFIGURATION FINALE" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Jeu      : $($selectedGame.names.international)" -ForegroundColor White
    Write-Host "Game ID  : $($selectedGame.id)" -ForegroundColor Cyan
    Write-Host "Category : $($selectedCategory.name)" -ForegroundColor Cyan
    Write-Host "Subcategory : $selectedSubcategoryLabel" -ForegroundColor Cyan
    Write-Host ""
    
    # Generer le nom complet avec sous-categorie si elle existe
    $fullName = if ($selectedSubcategoryLabel -eq "null") {
      "$($selectedGame.names.international) - $($selectedCategory.name)"
    } else {
      "$($selectedGame.names.international) - $($selectedCategory.name) $selectedSubcategoryLabel"
    }
    
    # Suggestions d'ID pour le preset
    $gamePart = $selectedGame.names.international -replace '[^a-zA-Z0-9]', '' -replace '\s+', ''
    $catPart = $selectedCategory.name -replace '[^a-zA-Z0-9]', '' -replace '\s+', ''
    $defaultPresetId = ($gamePart.ToLower() + "-" + $catPart.ToLower()) -replace '--+', '-'
    
    Write-Host "Entrez un ID unique pour ce preset :" -ForegroundColor Yellow
    Write-Host "Suggestion : $defaultPresetId" -ForegroundColor Gray
    $presetId = Read-Host "ID du preset (ou Entree pour suggestion)"
    
    if ([string]::IsNullOrWhiteSpace($presetId)) {
      $presetId = $defaultPresetId
    }
    
    # Verification que l'ID n'existe pas deja
    if ($currentConfig -and $currentConfig.presets.$presetId) {
      Write-Host "ATTENTION : Un preset avec l'ID '$presetId' existe deja !" -ForegroundColor Red
      $overwrite = Read-Host "Voulez-vous l'ecraser ? (o/N)"
      if ($overwrite.ToLower() -ne "o") {
        Write-Host "Operation annulee." -ForegroundColor Cyan
        Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
        $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
        return
      }
    }
    
    # Preparer l'objet preset
    $subcatValue = if ($selectedSubcategoryLabel -eq "null") { $null } else { $selectedSubcategoryLabel }
    
    $newPreset = @{
      name = $fullName
      gameId = $selectedGame.id
      category = $selectedCategory.name
      subcategory = $subcatValue
    }
    
    # Charger ou creer la config
    if ($currentConfig) {
      $config = $currentConfig
    } else {
      $config = @{
        activePreset = $null
        presets = @{}
        defaults = @{
          carouselInterval = 15000
          runsPerBatch = 10
          topCount = 10
          canvasWidth = 1200
          canvasHeight = 400
          displayWidth = "900px"
          displayHeight = "174px"
          CAROUSEL_DISPLAY_DURATION = 10000
          API_CALL_INTERVAL = 30000
          FLAGS_API_ENABLED = $true
          DISPLAY_COUNTRY_FLAGS = $true
        }
      }
    }
    
    # Ajouter le nouveau preset
    # Si c'est un PSCustomObject (chargé depuis JSON), utiliser Add-Member
    if ($config.presets.GetType().Name -eq "PSCustomObject") {
      $config.presets | Add-Member -MemberType NoteProperty -Name $presetId -Value $newPreset -Force
    } else {
      # Si c'est un hashtable (nouveau config), utiliser l'assignation normale
      $config.presets.$presetId = $newPreset
    }
    
    # Demander si on veut l'activer (ou l'activer automatiquement si c'est le premier)
    $isFirstPreset = $config.presets.Count -eq 1 -or -not $config.activePreset
    
    if ($isFirstPreset) {
      $config.activePreset = $presetId
      $activationMessage = "Active automatiquement (premier preset)"
    } else {
      Write-Host ""
      $activate = Read-Host "Voulez-vous activer ce preset maintenant ? (o/N)"
      if ($activate.ToLower() -eq "o") {
        $config.activePreset = $presetId
        $activationMessage = "Active comme preset principal"
      } else {
        $activationMessage = "Sauvegarde sans activation"
      }
    }
    
    # Sauvegarder
    $jsonOutput = $config | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8
    
    Write-Host ""
    Write-Host "✓ Preset '$presetId' sauvegarde avec succes !" -ForegroundColor Green
    Write-Host "Status : $activationMessage" -ForegroundColor Cyan
    
    # Copier l'URL simplifiee dans le presse-papiers
    $simpleUrl = "leaderboard.html"
    $simpleUrl | Set-Clipboard
    
    Write-Host ""
    Write-Host "URL OBS copiee dans le presse-papiers :" -ForegroundColor Green
    Write-Host "$simpleUrl" -ForegroundColor White
    Write-Host ""
    if ($config.activePreset -eq $presetId) {
      Write-Host "✓ OBS affichera automatiquement ce preset !" -ForegroundColor Green
    } else {
      Write-Host "Pour activer ce preset plus tard, utilisez l'option C." -ForegroundColor Cyan
    }
    Write-Host ""
  } catch {
    Write-Host ""
    Write-Host "Erreur : $_" -ForegroundColor Red
  }
  
  Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION PRINCIPALE ===
function Start-MainLoop {
  while ($true) {
    try {
      # === CHARGER LES PRESETS EXISTANTS ===
      $configExists = Test-Path "config.json"
      $currentConfig = $null
      
      if ($configExists) {
        $configContent = Get-Content "config.json" -Raw | ConvertFrom-Json
        $currentConfig = $configContent
      }
      
      $presetList = Write-MainMenu $currentConfig
      
      if ($presetList.Count -gt 0) {
        # Préparer le contexte à afficher au-dessus du menu
        $contextLines = @()
        $contextLines += "================================================"
        $contextLines += "  Gestionnaire de presets SRC by karlitto__"
        $contextLines += "================================================"
        $contextLines += ""
        $contextLines += "Presets existants :"
        $contextLines += ""
        
        foreach ($preset in $presetList) {
          $isActive = if ($preset.Name -eq $currentConfig.activePreset) { " ✓ [ACTIF]" } else { "" }
          $contextLines += "• $($preset.Value.name)$isActive"
          $contextLines += "  ID: $($preset.Name)"
        }
        $contextLines += ""
        
        # Affichage du preset actif en évidence
        $activePresetName = if ($currentConfig.activePreset -and $currentConfig.presets.($currentConfig.activePreset)) { 
          $currentConfig.presets.($currentConfig.activePreset).name 
        } else { 
          "Non défini" 
        }
        $contextLines += "📍 Preset actuellement actif : $activePresetName"
        $contextLines += ""
        
        $contextText = $contextLines -join "`n"
        
        $menuOptions = @(
          "Ajouter un nouveau preset",
          "Voir les détails d'un preset existant", 
          "Changer le preset actif",
          "Supprimer un preset",
          "Quitter le programme"
        )
        
        $selectedOption = Show-ArrowMenu -Title "Que voulez-vous faire ?" -Options $menuOptions -ContextText $contextText
        
        switch ($selectedOption) {
          4 { # Quitter le programme
            Clear-Host
            Write-Host "GL pour tes runs !" -ForegroundColor Green 
            return 
          }
          0 { New-Preset $currentConfig }
          1 { Write-PresetDetails $presetList $currentConfig }
          2 { Update-ActivePreset $presetList $currentConfig }
          3 { Remove-Preset $presetList $currentConfig }
        }
      } else {
        # Premier preset - affichage direct
        Clear-Host
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host "  Gestionnaire de presets SRC by karlitto__" -ForegroundColor Cyan
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Aucun preset trouvé. Création du premier preset..." -ForegroundColor Yellow
        Write-Host ""
        New-Preset $currentConfig
      }
    } catch {
      Write-Host ""
      Write-Host "Erreur lors du chargement de la config : $_" -ForegroundColor Red
      Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    }
  }
}

# === DEMARRAGE DU PROGRAMME ===
try {
  Start-MainLoop
} catch {
  Write-Host ""
  Write-Host "Erreur critique : $_" -ForegroundColor Red
  Write-Host ""
  Write-Host "Appuyez sur une touche pour fermer..." -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}
