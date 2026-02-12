# Script PowerShell pour gérer les presets speedrun.com facilement
# Gère plusieurs jeux et categories pour streamers

# === FONCTION MENU PRINCIPAL ===
function Write-MainMenu {
  param($currentConfig)
  
  Clear-Host
  Write-Host "================================================" -ForegroundColor Cyan
  Write-Host "  Gestionnaire de presets SRC by karlitto__" -ForegroundColor Cyan
  Write-Host "================================================" -ForegroundColor Cyan
  Write-Host ""

  if ($currentConfig -and $currentConfig.presets -and $currentConfig.presets.PSObject.Properties.Count -gt 0) {
    $existingPresets = $currentConfig.presets.PSObject.Properties
    
    Write-Host "Presets existants :" -ForegroundColor Green
    Write-Host ""
    $count = 1
    $presetList = @()
    foreach ($preset in $existingPresets) {
      Write-Host "[$count] $($preset.Value.name)" -ForegroundColor White
      Write-Host "     Preset: '$($preset.Name)'" -ForegroundColor Gray
      $presetList += $preset
      $count++
    }
    Write-Host ""
    
    # Afficher le preset actif
    $activePreset = if ($currentConfig.activePreset) { $currentConfig.activePreset } else { "aucun" }
    $activePresetName = if ($currentConfig.activePreset -and $currentConfig.presets.($currentConfig.activePreset)) { 
      $currentConfig.presets.($currentConfig.activePreset).name 
    } else { 
      "Non défini" 
    }
    Write-Host "" 
    Write-Host "Preset actuellement actif : $activePresetName" -ForegroundColor Green
    Write-Host "(ID: $activePreset)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Que voulez-vous faire ?" -ForegroundColor Yellow
    Write-Host "A. Ajouter un nouveau preset" -ForegroundColor White
    Write-Host "B. Voir les details d'un preset existant" -ForegroundColor White
    Write-Host "C. Changer le preset actif" -ForegroundColor Cyan
    Write-Host "D. Supprimer un preset" -ForegroundColor Red
    Write-Host "E. Retour au menu principal" -ForegroundColor Gray  
    Write-Host "F. Quitter le programme" -ForegroundColor DarkGray
    Write-Host ""
    
    return $presetList
  } else {
    Write-Host "Aucun preset trouve. Creation du premier preset..." -ForegroundColor Yellow
    Write-Host ""
    return @()
  }
}

# === FONCTION SHOW PRESET DETAILS ===
function Write-PresetDetails($presetList, $currentConfig) {
  Clear-Host
  Write-Host "=== DETAILS D'UN PRESET ===" -ForegroundColor Cyan
  Write-Host ""
  
  if ($presetList.Count -gt 1) {
    Write-Host "Choisissez un preset :"
    for ($i = 0; $i -lt $presetList.Count; $i++) {
      Write-Host "[$($i + 1)] $($presetList[$i].Value.name)" -ForegroundColor White
    }
    Write-Host ""
    do {
      $presetChoice = Read-Host "Numero du preset a voir (1-$($presetList.Count)) ou 0 pour annuler"
      
      # Validation: vérifier que c'est un nombre
      if (-not [int]::TryParse($presetChoice, [ref]$null)) {
        Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
        continue
      }
      
      $presetChoiceInt = [int]$presetChoice
      if ($presetChoiceInt -eq 0) { return }
      
      if ($presetChoiceInt -lt 1 -or $presetChoiceInt -gt $presetList.Count) {
        Write-Host "Numero invalide. Choisissez entre 1 et $($presetList.Count)." -ForegroundColor Red
        continue
      }
      
      break
    } while ($true)
    $selectedPreset = $presetList[$presetChoiceInt - 1]
  } else {
    $selectedPreset = $presetList[0]
  }
  
  Write-Host ""
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
  Write-Host "URL OBS (toujours la meme) :" -ForegroundColor Yellow
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
  Write-Host "Presets disponibles :"
  for ($i = 0; $i -lt $presetList.Count; $i++) {
    $isActive = if ($presetList[$i].Name -eq $currentConfig.activePreset) { " [ACTIF]" } else { "" }
    Write-Host "[$($i + 1)] $($presetList[$i].Value.name)$isActive" -ForegroundColor White
  }
  Write-Host ""
  do {
    $newActiveChoice = Read-Host "Choisir le nouveau preset actif (1-$($presetList.Count)) ou 0 pour annuler"
    
    # Validation: vérifier que c'est un nombre
    if (-not [int]::TryParse($newActiveChoice, [ref]$null)) {
      Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
      continue
    }
    
    $newActiveChoiceInt = [int]$newActiveChoice
    if ($newActiveChoiceInt -eq 0) { return }
    
    if ($newActiveChoiceInt -lt 1 -or $newActiveChoiceInt -gt $presetList.Count) {
      Write-Host "Numero invalide. Choisissez entre 1 et $($presetList.Count)." -ForegroundColor Red
      continue
    }
    
    break
  } while ($true)
  
  $newActivePreset = $presetList[$newActiveChoiceInt - 1]
  $currentConfig.activePreset = $newActivePreset.Name
  
  # Sauvegarder
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Write-Host ""
  Write-Host "✓ Preset actif change vers : $($newActivePreset.Value.name)" -ForegroundColor Green
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
    Write-Host "Vous devez avoir au moins un preset configure." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }
  
  Write-Host "=== SUPPRIMER UN PRESET ===" -ForegroundColor Red
  Write-Host ""
  Write-Host "Presets disponibles :"
  for ($i = 0; $i -lt $presetList.Count; $i++) {
    $isActive = if ($presetList[$i].Name -eq $currentConfig.activePreset) { " [ACTIF]" } else { "" }
    Write-Host "[$($i + 1)] $($presetList[$i].Value.name)$isActive" -ForegroundColor White
  }
  Write-Host ""
  do {
    $deleteChoice = Read-Host "Choisir le preset a supprimer (1-$($presetList.Count)) ou 0 pour annuler"
    
    # Validation: vérifier que c'est un nombre
    if (-not [int]::TryParse($deleteChoice, [ref]$null)) {
      Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
      continue
    }
    
    $deleteChoiceInt = [int]$deleteChoice
    if ($deleteChoiceInt -eq 0) {
      Write-Host "Suppression annulee." -ForegroundColor Yellow
      return
    }
    
    if ($deleteChoiceInt -lt 1 -or $deleteChoiceInt -gt $presetList.Count) {
      Write-Host "Numero invalide. Choisissez entre 1 et $($presetList.Count)." -ForegroundColor Red
      continue
    }
    
    break
  } while ($true)
  
  $presetToDelete = $presetList[$deleteChoiceInt - 1]
  
  Write-Host ""
  Write-Host "ATTENTION : Vous allez supprimer definitivement :" -ForegroundColor Red
  Write-Host "$($presetToDelete.Value.name)" -ForegroundColor Yellow
  Write-Host ""
  $confirm = Read-Host "Etes-vous sur ? Tapez 'SUPPRIMER' pour confirmer"
  
  if ($confirm -ne "SUPPRIMER") {
    Write-Host "Suppression annulee." -ForegroundColor Yellow
    return
  }
  
  # Supprimer le preset
  $deletedPresetId = $presetToDelete.Name
  $currentConfig.presets.PSObject.Properties.Remove($deletedPresetId)
  
  # Gerer le cas ou le preset supprime etait actif
  if ($currentConfig.activePreset -eq $deletedPresetId) {
    $remainingPresets = $currentConfig.presets.PSObject.Properties
    if ($remainingPresets.Count -gt 0) {
      Write-Host ""
      Write-Host "Le preset actif a ete supprime. Choisissez le nouveau preset actif :" -ForegroundColor Yellow
      Write-Host ""
      $count = 1
      $newPresetList = @()
      foreach ($preset in $remainingPresets) {
        Write-Host "[$count] $($preset.Value.name)" -ForegroundColor White
        $newPresetList += $preset
        $count++
      }
      Write-Host ""
      do {
        $newActiveChoice = Read-Host "Nouveau preset actif (1-$($newPresetList.Count))"
        
        # Validation: vérifier que c'est un nombre
        if (-not [int]::TryParse($newActiveChoice, [ref]$null)) {
          Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
          continue
        }
        
        $newActiveChoiceInt = [int]$newActiveChoice
        
        if ($newActiveChoiceInt -lt 1 -or $newActiveChoiceInt -gt $newPresetList.Count) {
          Write-Host "Numero invalide. Choisissez entre 1 et $($newPresetList.Count)." -ForegroundColor Red
          continue
        }
        
        break
      } while ($true)
      
      $currentConfig.activePreset = $newPresetList[$newActiveChoiceInt - 1].Name
    } else {
      $currentConfig.activePreset = $null
    }
  }
  
  # Sauvegarder
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Write-Host ""
  Write-Host "✓ Preset '$($presetToDelete.Value.name)' supprime avec succes !" -ForegroundColor Green
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
    
    Write-Host ""
    Write-Host "Jeux trouves :" -ForegroundColor Green
    Write-Host ""
    
    $count = 0
    foreach ($game in $games) {
      $count++
      $releaseYear = if ($game.released) { " ($($game.released))" } else { "" }
      Write-Host "[$count] $($game.names.international)$releaseYear" -ForegroundColor White
      Write-Host "     ID: $($game.id)" -ForegroundColor Cyan
      Write-Host ""
    }
    
    # Selection du jeu
    if ($games.Count -gt 1) {
      do {
        $gameChoice = Read-Host "Selectionnez le numero du jeu (1-$($games.Count)) ou 0 pour annuler"
        
        # Validation: vérifier que c'est un nombre
        if (-not [int]::TryParse($gameChoice, [ref]$null)) {
          Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
          continue
        }
        
        $gameChoiceInt = [int]$gameChoice
        
        if ($gameChoiceInt -eq 0) {
          Write-Host "Annule." -ForegroundColor Yellow
          return
        }
        
        if ($gameChoiceInt -lt 1 -or $gameChoiceInt -gt $games.Count) {
          Write-Host "Numero invalide. Choisissez entre 1 et $($games.Count)." -ForegroundColor Red
          continue
        }
        
        break  # Sortir de la boucle si tout est valide
        
      } while ($true)
      
      $selectedGame = $games[$gameChoiceInt - 1]
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
      Write-Host "Aucune categorie trouvee pour ce jeu!" -ForegroundColor Red
      Write-Host "Appuyez sur une touche pour continuer..." -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }
    
    Write-Host ""
    Write-Host "Categories disponibles :" -ForegroundColor Green
    Write-Host ""
    
    for ($i = 0; $i -lt $categories.Count; $i++) {
      Write-Host "[$($i + 1)] $($categories[$i].name)" -ForegroundColor White
    }
    
    # Selection de la categorie
    do {
      $categoryChoice = Read-Host "`nSelectionnez le numero de la categorie (1-$($categories.Count))"
      
      # Validation: vérifier que c'est un nombre
      if (-not [int]::TryParse($categoryChoice, [ref]$null)) {
        Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
        continue
      }
      
      $categoryChoiceInt = [int]$categoryChoice
      
      if ($categoryChoiceInt -lt 1 -or $categoryChoiceInt -gt $categories.Count) {
        Write-Host "Numero invalide. Choisissez entre 1 et $($categories.Count)." -ForegroundColor Red
        continue
      }
      
      break  # Sortir de la boucle si tout est valide
      
    } while ($true)
    
    $selectedCategory = $categories[$categoryChoiceInt - 1]
    
    # === ETAPE 3: Gerer les sous-categories ===
    $selectedSubcategory = $null
    $selectedSubcategoryLabel = "null"
    
    $subcategoryVariables = $selectedCategory.variables.data | Where-Object { $_.'is-subcategory' -eq $true -and $_.values.values }
    
    if ($subcategoryVariables.Count -gt 0) {
      Write-Host ""
      Write-Host "Sous-categories disponibles :" -ForegroundColor Green
      
      # On prend la premiere variable de sous-categorie trouvee
      $subcatVariable = $subcategoryVariables[0]
      $subcatValues = $subcatVariable.values.values.PSObject.Properties
      
      Write-Host ""
      Write-Host "0. Aucune sous-categorie (null)" -ForegroundColor Gray
      
      $subcatCount = 1
      $subcatArray = @()
      foreach ($value in $subcatValues) {
        Write-Host "$subcatCount. $($value.Value.label)" -ForegroundColor White
        $subcatArray += @{
          id = $value.Name
          label = $value.Value.label
        }
        $subcatCount++
      }
      
      # Selection de la sous-categorie
      do {
        $subcatChoice = Read-Host "`nSelectionnez le numero de la sous-categorie (0-$($subcatArray.Count))"
        
        # Validation: vérifier que c'est un nombre
        if (-not [int]::TryParse($subcatChoice, [ref]$null)) {
          Write-Host "Veuillez entrer un numero valide." -ForegroundColor Red
          continue
        }
        
        $subcatChoiceInt = [int]$subcatChoice
        
        if ($subcatChoiceInt -lt 0 -or $subcatChoiceInt -gt $subcatArray.Count) {
          Write-Host "Numero invalide. Choisissez entre 0 et $($subcatArray.Count)." -ForegroundColor Red
          continue
        }
        
        break  # Sortir de la boucle si tout est valide
        
      } while ($true)
      
      if ($subcatChoiceInt -gt 0) {
        $selectedSubcategory = $subcatArray[$subcatChoiceInt - 1]
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
        Write-Host "Operation annulee." -ForegroundColor Yellow
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
      Write-Host "Pour activer ce preset plus tard, utilisez l'option C." -ForegroundColor Yellow
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
        $choice = Read-Host "Votre choix (A/B/C/D/E/F)"
        
        switch ($choice.ToUpper()) {
          "F" {
            Clear-Host
            Write-Host "Au revoir !" -ForegroundColor Green 
            return 
          }
          "E" { 
            # Retour au menu principal (continue la boucle)
            continue 
          }
          "A" { New-Preset $currentConfig }
          "B" { Write-PresetDetails $presetList $currentConfig }
          "C" { Update-ActivePreset $presetList $currentConfig }
          "D" { Remove-Preset $presetList $currentConfig }
          default { 
            Write-Host "Option invalide ! Appuyez sur une touche pour continuer..." -ForegroundColor Red
            $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
          }
        }
      } else {
        # Premier preset
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