# Encoding: UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# PowerShell script to manage speedrun.com presets easily
# Manages multiple games and categories for streamers
# Version 1.41 - PB color customization + improved translations
# By karlitto__

# Ensure we're in the correct directory (where the script is located)
$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

# === SECURITY CHECK (if script can run) ===
# Note: If execution policy is Restricted, this code won't run. Use FIX_ACCESS.bat instead!
# This check is for cases where the script can execute but files are blocked

# Check execution policy and warn if restrictive
$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($currentPolicy -in @("Restricted", "AllSigned")) {
    Write-Host "⚠️  WARNING: Execution policy is restrictive ($currentPolicy)" -ForegroundColor Yellow
    Write-Host "   Run FIX_ACCESS.bat to fix this automatically!" -ForegroundColor Cyan
    Write-Host ""
}

# Unblock this script file if it's marked as downloaded from the internet
$scriptPath = $MyInvocation.MyCommand.Path
if ($scriptPath) {
    $fileStream = Get-Item -Path $scriptPath -Stream Zone.Identifier -ErrorAction SilentlyContinue
    if ($fileStream) {
        try {
            Unblock-File -Path $scriptPath -ErrorAction Stop
            Write-Host "✓ Script file auto-unblocked" -ForegroundColor Green
        } catch {
            Write-Host "⚠️  Run: Unblock-File -Path '$scriptPath'" -ForegroundColor Yellow
        }
    }
}

# === DEFAULT CONFIGURATION ===
$Global:DefaultConfigJSON = @'
{
  "defaults": {
    "topCount": 3,
    "timeFormat": "1:25:25.255",
    "rankAlign": "left",
    "rankPrefixMode": "dot",
    "nameSpacing": 5,
    "pbSeparatorWidth": 320,
    "pbPrefix": "PB",
    "pbColor": "fffff1",
    "pbUseRainbow": true,
    "customFont": "",
    "fontSize": 18,
    "rainbowIntensity": 90,
    "CAROUSEL_DISPLAY_DURATION": 5000,
    "CAROUSEL_FADE_DURATION": 500,
    "useTrophyIcons": true,
    "displayWidth": 500,
    "displayHeight": 450,
    "runsPerBatch": 4,
    "maxRuns": 200,
    "fontStyle": "Arial", 
    "maxNameWidthVisible": 18,
    "categoryNameVisible": true,
    "categoryNameColor": "#ffffff",
    "categoryNameSpacing": 35
  },
  "flagOverrides": {
    "TW": "CN"
  },
  "categories": {
    "elde-any-glitchless": {
      "name": "Elden Ring - Any% Glitchless",
      "gameId": "nd28z0ed",
      "subcategory": "Glitchless",
      "category": "Any%",
      "subcategories": {
        "variableId": "7891zr5n",
        "valueId": "qj740p3q",
        "label": "Glitchless"
      }
    }
  },
  "language": "en",
  "playerName": "Xeill",
  "activeCategory": "elde-any-glitchless",
  "temporaryRun": {
    "active": true,
    "time": "55:05"
  }
}
'@

# === LANGUAGE DICTIONARY ===
$Global:Languages = @{
    fr = @{
        # Main menu
        menu_title = "Gestionnaire de Leaderboard SRC by karlitto__ v1.41"
        menu_add_category = "Ajouter une nouvelle catégorie"
        menu_view_details = "Voir les détails d'une catégorie existante"
        menu_change_active = "Changer la catégorie active"
        menu_remove_category = "Supprimer une catégorie"
        menu_language_settings = "Paramètres de langue / 语言设置"
        menu_parameters = "Paramètres"
        menu_player_name = "Définir mon nom"
        menu_temp_time = "Mon PB temporaire"
        menu_quit = "Quitter le programme"
        menu_what_to_do = "Que voulez-vous faire ?"
        
        # Navigation
        nav_instructions = "Utilisez flèches HAUT/BAS pour naviguer, Entrée pour sélectionner"
        nav_instructions_cancel = "Utilisez flèches HAUT/BAS pour naviguer, Entrée pour sélectionner, Backspace pour annuler"
        
        # Existing categories
        existing_categories = "Catégories existantes :"
        active_category = "Catégorie actuellement active :"
        not_defined = "Non défini"
        
        # Category details
        details_title = "=== DETAILS D'UNE CATÉGORIE ==="
        details_choose = "Choisissez une catégorie à voir :"
        details_name = "Nom :"
        details_category_id = "ID Catégorie :"
        details_game_id = "Game ID :"
        details_category = "Category :"
        details_subcategory = "Subcategory :"
        details_active_obs = "Actif dans OBS :"
        details_actions = "Actions :"
        details_edit_name = "Editer le nom de la catégorie"
        details_delete_category = "Supprimer cette catégorie"
        details_edit_prompt = "Nouveau nom de la catégorie (Echap pour annuler) :"
        details_edit_empty = "Erreur : le nom ne peut pas etre vide."
        details_edit_saved = "Nom de la catégorie mis a jour :"
        details_edit_cancelled = "Modification annulee."
        details_back = "Retour"
        
        # Common messages
        continue_key = "Appuyez sur une touche pour continuer..."
        yes = "OUI"
        no = "NON"
        null_value = "null"
        cancelled = "Annulé."
        success = "[OK]"
        
        # New category
        add_title = "=== AJOUT D'UNE NOUVELLE CATÉGORIE ==="
        add_game_name = "Nom du jeu :"
        add_game_name_hint = "Appuyez sur ESC pour annuler et revenir au menu principal"
        add_error_empty_name = "Erreur : Vous devez entrer un nom de jeu!"
        add_searching = "Recherche en cours pour :"
        add_no_game_found = "Aucun jeu trouvé pour :"
        add_games_found = "Jeux trouvés :"
        add_loading_categories = "Chargement des catégories..."
        add_loading_levels = "Chargement des niveaux..."
        add_no_categories = "Aucune catégorie trouvée pour ce jeu!"
        add_categories_available = "Catégories disponibles :"
        add_subcategories_available = "Sous-catégories disponibles :"
        add_no_subcategory = "Aucune sous-catégorie (null)"
        
        # Final settings
        final_config = "========[ CONFIGURATION FINALE ]========"
        final_game = "Jeu      :"
        final_game_id = "Game ID  :"
        final_category = "Category :"
        final_subcategory = "Subcategory :"
        final_category_id = "Entrez un ID unique pour cette catégorie :"
        final_suggestion = "Suggestion :"
        final_category_id_prompt = "ID de la catégorie (ou Entrée pour suggestion) "
        final_id_exists = "ATTENTION : Une catégorie avec l'ID '%s' existe déjà !"
        final_overwrite = "Voulez-vous l'écraser ? (o/N)"
        final_operation_cancelled = "Opération annulée."
        final_activate_now = "Voulez-vous activer cette catégorie maintenant ? (o/N)"
        final_saved = "Catégorie '%s' sauvegardée avec succès !"
        final_status = "Status :"
        final_auto_active = "Activé automatiquement (première catégorie)"
        final_active_now = "Activé comme catégorie principale"
        final_saved_inactive = "Sauvegardé sans activation"
        final_obs_will_show = "[OK] OBS affichera automatiquement cette catégorie !"
        final_activate_later = "Pour activer cette catégorie plus tard, utilisez l'option de changement de catégorie active."
        
        # Change active category
        change_active_title = "=== CHANGER LA CATÉGORIE ACTIVE ==="
        change_active_available = "Catégories disponibles :"
        change_active_changed = "[OK] Catégorie active changée vers :"
        change_active_obs_info = "OBS va automatiquement utiliser cette catégorie !"
        
        # Delete category
        remove_title = "=== SUPPRIMER UNE CATÉGORIE ==="
        remove_impossible_title = "=== IMPOSSIBLE DE SUPPRIMER ==="
        remove_impossible_last = "Impossible de supprimer la dernière catégorie !"
        remove_impossible_rule = "Vous devez avoir au moins une catégorie configurée."
        remove_warning = "ATTENTION : Vous allez supprimer définitivement :"
        remove_confirm = "Êtes-vous sûr de vouloir supprimer cette catégorie ? (o/N)"
        remove_cancelled = "Suppression annulée."
        remove_active_deleted = "La catégorie active a été supprimée. Choisissez la nouvelle catégorie active :"
        remove_success = "[OK] Catégorie '%s' supprimée avec succès !"
        remove_new_active = "Nouvelle catégorie active :"
        
        # First launch
        first_launch_no_category = "Aucune catégorie trouvée. Création de la première catégorie..."
        
        # Language
        language_title = "=== PARAMÈTRES DE LANGUE ==="
        language_current = "Langue actuelle :"
        language_available = "Langues disponibles :"
        language_changed = "[OK] Langue changée vers :"
        language_restart_info = "Le changement sera effectif immédiatement dans l'interface."

        parameters_title = "=== PARAMÈTRES ==="
        parameters_visuals = "Ajustements visuels"
        parameters_language = "Paramètres de langue / 语言设置"
        parameters_reset_config = "Réinitialiser la configuration"
        parameters_back = "Retour"
        parameters_visuals_title = "=== AJUSTEMENTS VISUELS ==="
        parameters_select_value = "Nouvelle valeur (Echap pour annuler) :"
        parameters_invalid_number = "Valeur invalide."
        parameters_saved = "[OK] Valeur mise à jour"
        parameters_invalid_format = "Format invalide."
        parameters_flag_override_prompt = "Entrer un override (AA BB, ex: CR FR) :"
        parameters_visuals_section_layout = "Mise en page"
        parameters_visuals_section_list_ranks = "Liste et rangs"
        parameters_visuals_section_category_name = "Nom de catégorie"
        parameters_visuals_section_text_spacing = "Typo et espacement"
        parameters_visuals_max_name_chars = "Largeur Nom (visible)"
        parameters_visuals_section_pb = "PB"
        parameters_visuals_section_effects = "Effets"
        parameters_visuals_section_flags_trophies = "Drapeaux et trophées"
        parameters_visuals_section_carousel = "Carrousel"

        # Parameter descriptions
        param_desc_displayWidth = "Largeur du canevas de l'overlay en pixels"
        param_desc_displayHeight = "Hauteur du canevas de l'overlay en pixels"
        param_desc_topCount = "Nombre de runs fixes en haut du classement"
        param_desc_runsPerBatch = "Nombre de runs affichées par cycle de carrousel"
        param_desc_maxRuns = "Nombre maximum de runs récupérées depuis l'API"
        param_desc_rankAlign = "Alignement des numéros de rang (gauche, centre, droite)"
        param_desc_rankPrefixMode = "Symbole visuel du rang (point, dièse ou rien)"
        param_desc_fontStyle = "Police utilisée pour tout le texte"
        param_desc_customFont = "Nom d'une police personnalisée installée sur votre système (laissez vide pour utiliser fontStyle)"
        param_desc_fontSize = "Taille de la police pour les noms et temps (14-24px)"
        param_desc_categoryNameVisible = "Afficher le nom de catégorie en haut de l'overlay ?"
        param_desc_categoryNameColor = "Couleur du nom de catégorie (6 caractères hexadécimaux, ex: 84c8ff)"
        param_desc_categoryNameSpacing = "Espace vertical entre le nom de catégorie et le classement (12-50px)"
        param_desc_maxNameWidthVisible = "Nombre maximum de caractères pour les noms des joueurs"
        param_desc_nameSpacing = "Espacement horizontal du nom du joueur"
        param_desc_timeFormat = "Format d'affichage des temps de run"
        param_desc_pbSeparatorWidth = "Largeur de la ligne séparatrice avant le PB"
        param_desc_pbPrefix = "Texte de préfixe personnalisé avant le PB (1-3 lettres)"
        param_desc_pbColor = "Couleur du rang PB (6 caractères hexadécimaux, ex: 9fb4ca)"
        param_desc_pbUseRainbow = "Utiliser l'effet arc-en-ciel pour le PB au lieu de la couleur fixe ?"
        param_desc_rainbowIntensity = "Intensité de l'effet arc-en-ciel (0-100%)"
        param_desc_useTrophyIcons = "Afficher les icônes de trophée pour le top 3 ?"
        param_desc_flagOverrides = "Remplacer les codes de drapeau de pays (ex: HR FR)"
        param_desc_CAROUSEL_DISPLAY_DURATION = "Temps d'affichage du carrousel (millisecondes)"
        param_desc_CAROUSEL_FADE_DURATION = "Durée de la transition en fondu (millisecondes)"

        # Player name
        player_name_title = "=== NOM DU JOUEUR ==="
        player_name_current = "Nom actuel :"
        player_name_prompt = "Entrez le nom du joueur (laisser vide pour désactiver, Echap pour annuler) :"
        player_name_saved = "[OK] Nom du joueur enregistré :"
        player_name_cleared = "Nom du joueur désactivé."
        player_name_cancelled = "Opération annulée."
        player_country_current = "Pays actuel :"
        player_country_prompt = "Entrez le code pays (2 lettres, ex: FR) :"
        player_country_invalid = "Invalide. Doit faire 2 lettres."
        player_country_saved = "[OK] Pays enregistré :"

        # Temporary time
        temp_time_title = "=== TEMPS TEMPORAIRE ==="
        temp_time_current = "Temps temporaire actuel :"
        temp_time_action_set = "Définir/modifier le temps temporaire"
        temp_time_action_clear = "Supprimer le temps temporaire"
        temp_time_action_back = "Retour"
        temp_time_prompt = "Entrez le temps temporaire (hh:mm:ss.ms) (Echap pour annuler) :"
        temp_time_invalid = "Format invalide. Exemples : 1:23, 12:34, 1:02:03, 1:18.268"
        temp_time_saved = "[OK] Temps temporaire enregistré :"
        temp_time_cleared = "Temps temporaire supprimé."
        temp_time_cancelled = "Opération annulée."
        temp_time_no_player = "Impossible sans nom du joueur."
        temp_time_check_title = "Vérification du joueur..."
        temp_time_check_status = "Recherche dans la catégorie sélectionnée"
        temp_time_disabled = "PB temporaire désactivé (joueur introuvable dans cette catégorie)."
        
        # Reset
        reset_confirm = "Êtes-vous sûr de vouloir réinitialiser la configuration ? (o/N)"
        reset_success = "[OK] Configuration réinitialisée par défaut."
        reset_cancelled = "Réinitialisation annulée."

        # Errors
        config_load_error = "Erreur lors du chargement de la config :"
        critical_error = "Erreur critique :"
        error_general = "Erreur :"
        close_key = "Appuyez sur une touche pour fermer..."
        
        # Closing messages
        goodbye = "GL pour tes runs !"
    }
    en = @{
        # Main menu
        menu_title = "SRC Leaderboard Manager by karlitto__ v1.41"
        menu_add_category = "Add a new category"
        menu_view_details = "View details of an existing category"
        menu_change_active = "Change active category"
        menu_remove_category = "Delete a category"
        menu_language_settings = "Language settings / 语言设置"
        menu_parameters = "Parameters"
        menu_player_name = "Set my name"
        menu_temp_time = "My temporary PB"
        menu_quit = "Quit program"
        menu_what_to_do = "What would you like to do?"
        
        # Navigation
        nav_instructions = "Use UP/DOWN arrows to navigate, Enter to select"
        nav_instructions_cancel = "Use UP/DOWN arrows to navigate, Enter to select, Backspace to cancel"
        
        # Existing categories
        existing_categories = "Existing categories:"
        active_category = "Currently active category:"
        not_defined = "Not defined"
        
        # Category details
        details_title = "=== CATEGORY DETAILS ==="
        details_choose = "Choose a category to view:"
        details_name = "Name:"
        details_category_id = "Category ID:"
        details_game_id = "Game ID:"
        details_category = "Category:"
        details_subcategory = "Subcategory:"
        details_active_obs = "Active in OBS:"
        details_actions = "Actions:"
        details_edit_name = "Edit category name"
        details_delete_category = "Delete this category"
        details_edit_prompt = "New category name (Esc to cancel):"
        details_edit_empty = "Error: name cannot be empty."
        details_edit_saved = "Category name updated:"
        details_edit_cancelled = "Edit cancelled."
        details_back = "Back"
        
        # Common messages
        continue_key = "Press any key to continue..."
        yes = "YES"
        no = "NO"
        null_value = "null"
        cancelled = "Cancelled."
        success = "[OK]"
        
        # New category
        add_title = "=== ADD NEW CATEGORY ==="
        add_game_name = "Game name:"
        add_game_name_hint = "Press ESC to cancel and return to the main menu"
        add_error_empty_name = "Error: You must enter a game name!"
        add_searching = "Searching for:"
        add_no_game_found = "No game found for:"
        add_games_found = "Games found:"
        add_loading_categories = "Loading categories..."
        add_loading_levels = "Loading levels..."
        add_no_categories = "No categories found for this game!"
        add_categories_available = "Available categories:"
        add_subcategories_available = "Available subcategories:"
        add_no_subcategory = "No subcategory (null)"
        
        # Final settings
        final_config = "========[ FINAL CONFIGURATION ]========"
        final_game = "Game     :"
        final_game_id = "Game ID  :"
        final_category = "Category :"
        final_subcategory = "Subcategory :"
        final_category_id = "Enter a unique ID for this category:"
        final_suggestion = "Suggestion:"
        final_category_id_prompt = "Category ID (or Enter for suggestion)"
        final_id_exists = "WARNING: A category with ID '%s' already exists!"
        final_overwrite = "Do you want to overwrite it? (y/N)"
        final_operation_cancelled = "Operation cancelled."
        final_activate_now = "Do you want to activate this category now? (y/N)"
        final_saved = "Category '%s' saved successfully!"
        final_status = "Status:"
        final_auto_active = "Automatically activated (first category)"
        final_active_now = "Activated as main category"
        final_saved_inactive = "Saved without activation"
        final_obs_will_show = "[OK] OBS will automatically display this category!"
        final_activate_later = "To activate this category later, use the active category change option."
        
        # Change active category
        change_active_title = "=== CHANGE ACTIVE CATEGORY ==="
        change_active_available = "Available categories:"
        change_active_changed = "[OK] Active category changed to:"
        change_active_obs_info = "OBS will automatically use this category!"
        
        # Delete category
        remove_title = "=== DELETE CATEGORY ==="
        remove_impossible_title = "=== CANNOT DELETE ==="
        remove_impossible_last = "Cannot delete the last category!"
        remove_impossible_rule = "You must have at least one configured category."
        remove_warning = "WARNING: You are going to permanently delete:"
        remove_confirm = "Are you sure you want to delete this category? (y/N)"
        remove_cancelled = "Deletion cancelled."
        remove_active_deleted = "The active category was deleted. Choose the new active category:"
        remove_success = "[OK] Category '%s' deleted successfully!"
        remove_new_active = "New active category:"
        
        # First launch
        first_launch_no_category = "No category found. Creating first category..."
        
        # Language
        language_title = "=== LANGUAGE SETTINGS ==="
        language_current = "Current language:"
        language_available = "Available languages:"
        language_changed = "[OK] Language changed to:"
        language_restart_info = "The change will take effect immediately in the interface."

        parameters_title = "=== PARAMETERS ==="
        parameters_visuals = "Visual tweaks"
        parameters_language = "Language settings / 语言设置"
        parameters_reset_config = "Reset configuration"
        parameters_back = "Back"
        parameters_visuals_title = "=== VISUAL TWEAKS ==="
        parameters_select_value = "New value (Esc to cancel):"
        parameters_invalid_number = "Invalid value."
        parameters_saved = "[OK] Value updated"
        parameters_invalid_format = "Invalid format."
        parameters_flag_override_prompt = "Enter override (AA BB, e.g. CR FR):"
        parameters_visuals_section_layout = "Layout"
        parameters_visuals_section_list_ranks = "List and ranks"
        parameters_visuals_section_category_name = "Category Name"
        parameters_visuals_section_text_spacing = "Typography and spacing"
        parameters_visuals_max_name_chars = "Name width (visible)"
        parameters_visuals_section_pb = "PB"
        parameters_visuals_section_effects = "Effects"
        parameters_visuals_section_flags_trophies = "Flags and trophies"
        parameters_visuals_section_carousel = "Carousel"

        # Parameter descriptions
        param_desc_displayWidth = "Width of the overlay canvas in pixels"
        param_desc_displayHeight = "Height of the overlay canvas in pixels"
        param_desc_topCount = "Number of fixed runs at the top of leaderboard"
        param_desc_runsPerBatch = "Number of runs displayed per carousel cycle"
        param_desc_maxRuns = "Maximum total runs fetched from API"
        param_desc_rankAlign = "Alignment of rank numbers (left, center, right)"
        param_desc_rankPrefixMode = "Visual symbol of rank (dot, hash or none)"
        param_desc_fontStyle = "Font family used for all text"
        param_desc_customFont = "Name of a custom font installed on your system (leave empty to use fontStyle)"
        param_desc_fontSize = "Font size for names and times (14-24px)"
        param_desc_categoryNameVisible = "Display category name at the top of the overlay?"
        param_desc_categoryNameColor = "Category name color (6 hex characters, ex: 84c8ff)"
        param_desc_categoryNameSpacing = "Vertical space between category name and leaderboard (12-50px)"
        param_desc_maxNameWidthVisible = "Maximum characters for player names"
        param_desc_nameSpacing = "Horizontal spacing of player name"
        param_desc_timeFormat = "Format for displaying run times"
        param_desc_pbSeparatorWidth = "Width of the separator line before PB"
        param_desc_pbPrefix = "Custom prefix text before player's PB (1-3 letters)"
        param_desc_pbColor = "PB rank color (6 hex characters, ex: 9fb4ca)"
        param_desc_pbUseRainbow = "Use rainbow effect for PB instead of fixed color?"
        param_desc_rainbowIntensity = "Intensity of rainbow effect (0-100%)"
        param_desc_useTrophyIcons = "Show trophy icons for top 3?"
        param_desc_flagOverrides = "Replace country flag codes (e.g., HR FR)"
        param_desc_CAROUSEL_DISPLAY_DURATION = "Carousel display time (milliseconds)"
        param_desc_CAROUSEL_FADE_DURATION = "Duration of fade transition (milliseconds)"

        # Player name
        player_name_title = "=== PLAYER NAME ==="
        player_name_current = "Current name:"
        player_name_prompt = "Enter player name (leave empty to disable, Esc to cancel):"
        player_name_saved = "[OK] Player name saved:"
        player_name_cleared = "Player name disabled."
        player_name_cancelled = "Operation cancelled."
        player_country_current = "Current country:"
        player_country_prompt = "Enter country code (2 letters, e.g. FR):"
        player_country_invalid = "Invalid. Must be 2 letters."
        player_country_saved = "[OK] Country saved:"

        # Temporary time
        temp_time_title = "=== TEMPORARY TIME ==="
        temp_time_current = "Current temporary time:"
        temp_time_action_set = "Set/change temporary time"
        temp_time_action_clear = "Clear temporary time"
        temp_time_action_back = "Back"
        temp_time_prompt = "Enter temporary time (hh:mm:ss.ms) (Esc to cancel):"
        temp_time_invalid = "Invalid format. Examples: 1:23, 12:34, 1:02:03, 1:18.268"
        temp_time_saved = "[OK] Temporary time saved:"
        temp_time_cleared = "Temporary time cleared."
        temp_time_cancelled = "Operation cancelled."
        temp_time_no_player = "Unavailable without player name."
        temp_time_check_title = "Checking player..."
        temp_time_check_status = "Searching in selected category"
        temp_time_disabled = "Temporary PB disabled (player not found in this category)."
        
        # Reset
        reset_confirm = "Are you sure you want to reset the configuration? (y/N)"
        reset_success = "[OK] Configuration reset to default."
        reset_cancelled = "Reset cancelled."

        # Errors
        config_load_error = "Error loading config:"
        critical_error = "Critical error:"
        error_general = "Error:"
        close_key = "Press any key to close..."
        
        # Closing messages
        goodbye = "GL for your runs!"
    }
    es = @{
        # Main menu
        menu_title = "Gestor de Leaderboard SRC by karlitto__ v1.41"
        menu_add_category = "Añadir una nueva categoría"
        menu_view_details = "Ver detalles de una categoría existente"
        menu_change_active = "Cambiar categoría activa"
        menu_remove_category = "Eliminar una categoría"
        menu_language_settings = "Configuración de idioma / 语言设置"
        menu_parameters = "Parametros"
        menu_player_name = "Definir mi nombre"
        menu_temp_time = "Mi PB temporal"
        menu_quit = "Salir del programa"
        menu_what_to_do = "¿Qué te gustaría hacer?"
        
        # Navigation
        nav_instructions = "Usa flechas ARRIBA/ABAJO para navegar, Enter para seleccionar"
        nav_instructions_cancel = "Usa flechas ARRIBA/ABAJO para navegar, Enter para seleccionar, Backspace para cancelar"
        
        # Existing categories
        existing_categories = "Categorías existentes:"
        active_category = "Categoría actualmente activa:"
        not_defined = "No definido"
        
        # Category details
        details_title = "=== DETALLES DE LA CATEGORÍA ==="
        details_choose = "Elige una categoría para ver:"
        details_name = "Nombre:"
        details_category_id = "ID de Categoría:"
        details_game_id = "ID del Juego:"
        details_category = "Categoría:"
        details_subcategory = "Subcategoría:"
        details_active_obs = "Activo en OBS:"
        details_actions = "Acciones:"
        details_edit_name = "Editar nombre de la categoría"
        details_delete_category = "Eliminar esta categoría"
        details_edit_prompt = "Nuevo nombre de la categoría (Esc para cancelar):"
        details_edit_empty = "Error: el nombre no puede estar vacio."
        details_edit_saved = "Nombre de la categoría actualizado:"
        details_edit_cancelled = "Edicion cancelada."
        details_back = "Volver"
        
        # Common messages
        continue_key = "Presiona cualquier tecla para continuar..."
        yes = "SÍ"
        no = "NO"
        null_value = "null"
        cancelled = "Cancelado."
        success = "[OK]"
        
        # New category
        add_title = "=== AÑADIR NUEVA CATEGORÍA ==="
        add_game_name = "Nombre del juego:"
        add_game_name_hint = "Presiona ESC para cancelar y volver al menu principal"
        add_error_empty_name = "Error: ¡Debes introducir un nombre de juego!"
        add_searching = "Buscando:"
        add_no_game_found = "Ningún juego encontrado para:"
        add_games_found = "Juegos encontrados:"
        add_loading_categories = "Cargando categorías..."
        add_loading_levels = "Cargando niveles..."
        add_no_categories = "¡No se encontró ninguna categoría para este juego!"
        add_categories_available = "Categorías disponibles:"
        add_subcategories_available = "Subcategorías disponibles:"
        add_no_subcategory = "Sin subcategoría (null)"
        
        # Final settings
        final_config = "========[ CONFIGURACIÓN FINAL ]========"
        final_game = "Juego    :"
        final_game_id = "ID Juego :"
        final_category = "Categoría :"
        final_subcategory = "Subcategoría :"
        final_category_id = "Introduce un ID único para esta categoría:"
        final_suggestion = "Sugerencia:"
        final_category_id_prompt = "ID de la categoría (o Enter para sugerencia)"
        final_id_exists = "ATENCIÓN: ¡Ya existe una categoría con ID '%s'!"
        final_overwrite = "¿Quieres sobrescribirlo? (s/N)"
        final_operation_cancelled = "Operación cancelada."
        final_activate_now = "¿Quieres activar esta categoría ahora? (s/N)"
        final_saved = "¡Categoría '%s' guardada con éxito!"
        final_status = "Estado:"
        final_auto_active = "Activado automáticamente (primera categoría)"
        final_active_now = "Activado como categoría principal"
        final_saved_inactive = "Guardado sin activar"
        final_obs_will_show = "¡[OK] OBS mostrará automáticamente esta categoría!"
        final_activate_later = "Para activar esta categoría más tarde, usa la opción de cambio de categoría activa."
        
        # Change active category
        change_active_title = "=== CAMBIAR CATEGORÍA ACTIVA ==="
        change_active_available = "Categorías disponibles:"
        change_active_changed = "[OK] Categoría activa cambiada a:"
        change_active_obs_info = "¡OBS usará automáticamente esta categoría!"
        
        # Delete category
        remove_title = "=== ELIMINAR CATEGORÍA ==="
        remove_impossible_title = "=== NO ES POSIBLE ELIMINAR ==="
        remove_impossible_last = "¡No es posible eliminar la última categoría!"
        remove_impossible_rule = "Debes tener al menos una categoría configurada."
        remove_warning = "ATENCIÓN: Vas a eliminar permanentemente:"
        remove_confirm = "¿Seguro que quieres eliminar esta categoría? (s/N)"
        remove_cancelled = "Eliminación cancelada."
        remove_active_deleted = "La categoría activa ha sido eliminada. Elige la nueva categoría activa:"
        remove_success = "[OK] Categoría '%s' eliminada con éxito!"
        remove_new_active = "Nueva categoría activa:"
        
        # First launch
        first_launch_no_category = "No se encontró ninguna categoría. Creando la primera categoría..."
        
        # Language
        language_title = "=== CONFIGURACIÓN DE IDIOMA ==="
        language_current = "Idioma actual:"
        language_available = "Idiomas disponibles:"
        language_changed = "[OK] Idioma cambiado a:"
        language_restart_info = "El cambio se aplicará inmediatamente en la interfaz."

        parameters_title = "=== PARÁMETROS ==="
        parameters_visuals = "Ajustes visuales"
        parameters_language = "Configuración de idioma / 语言设置"
        parameters_reset_config = "Restablecer configuración"
        parameters_back = "Volver"
        parameters_visuals_title = "=== AJUSTES VISUALES ==="
        parameters_select_value = "Nuevo valor (Esc para cancelar):"
        parameters_invalid_number = "Valor inválido."
        parameters_saved = "[OK] Valor actualizado"
        parameters_invalid_format = "Formato inválido."
        parameters_flag_override_prompt = "Introduce override (AA BB, ej.: CR FR):"
        parameters_visuals_section_layout = "Diseño"
        parameters_visuals_section_list_ranks = "Lista y rankings"
        parameters_visuals_section_category_name = "Nombre de categoría"
        parameters_visuals_section_text_spacing = "Tipografía y espaciado"
        parameters_visuals_max_name_chars = "Ancho del nombre (visible)"
        parameters_visuals_section_pb = "PB"
        parameters_visuals_section_effects = "Efectos"
        parameters_visuals_section_flags_trophies = "Banderas y trofeos"
        parameters_visuals_section_carousel = "Carrusel"

        # Parameter descriptions
        param_desc_displayWidth = "Ancho del lienzo del overlay en píxeles"
        param_desc_displayHeight = "Altura del lienzo del overlay en píxeles"
        param_desc_topCount = "Número de runs fijas en la parte superior de la clasificación"
        param_desc_runsPerBatch = "Número de runs mostradas por ciclo de carrusel"
        param_desc_maxRuns = "Número máximo de runs obtenidas de la API"
        param_desc_rankAlign = "Alineación de los números de rango (izquierda, centro, derecha)"
        param_desc_rankPrefixMode = "Símbolo visual del rango (punto, almohadilla o nada)"
        param_desc_fontStyle = "Familia de fuente utilizada para todo el texto"
        param_desc_customFont = "Nombre de una fuente personalizada instalada en su sistema (dejar vacío para usar fontStyle)"
        param_desc_fontSize = "Tamaño de fuente para nombres y tiempos (14-24px)"
        param_desc_categoryNameVisible = "¿Mostrar el nombre de categoría en la parte superior?"
        param_desc_categoryNameColor = "Color del nombre de categoría (6 caracteres hexadecimales, ej: 84c8ff)"
        param_desc_categoryNameSpacing = "Espacio vertical entre nombre de categoría y clasificación (12-50px)"
        param_desc_maxNameWidthVisible = "Máximo de caracteres para nombres de jugadores"
        param_desc_nameSpacing = "Espaciado horizontal del nombre del jugador"
        param_desc_timeFormat = "Formato para mostrar los tiempos de run"
        param_desc_pbSeparatorWidth = "Ancho de la línea separadora antes del PB"
        param_desc_pbPrefix = "Texto de prefijo personalizado antes del PB (1-3 letras)"
        param_desc_pbColor = "Color del rango PB (6 caracteres hexadecimales, ej: 9fb4ca)"
        param_desc_pbUseRainbow = "¿Usar efecto arcoíris para el PB en lugar de color fijo?"
        param_desc_rainbowIntensity = "Intensidad del efecto arcoíris (0-100%)"
        param_desc_useTrophyIcons = "¿Mostrar iconos de trofeo para el top 3?"
        param_desc_flagOverrides = "Reemplazar códigos de bandera de país (ej: HR FR)"
        param_desc_CAROUSEL_DISPLAY_DURATION = "Tiempo de visualización del carrusel (milisegundos)"
        param_desc_CAROUSEL_FADE_DURATION = "Duración de la transición de desvanecimiento (milisegundos)"

        # Player name
        player_name_title = "=== NOMBRE DEL JUGADOR ==="
        player_name_current = "Nombre actual:"
        player_name_prompt = "Introduce el nombre del jugador (vacío para desactivar, Esc para cancelar):"
        player_name_saved = "[OK] Nombre del jugador guardado:"
        player_name_cleared = "Nombre del jugador desactivado."
        player_name_cancelled = "Operación cancelada."
        player_country_current = "País actual:"
        player_country_prompt = "Introduce el código del país (2 letras, ex: FR):"
        player_country_invalid = "Inválido. Debe tener 2 letras."
        player_country_saved = "[OK] País guardado:"

        # Temporary time
        temp_time_title = "=== TIEMPO TEMPORAL ==="
        temp_time_current = "Tiempo temporal actual:"
        temp_time_action_set = "Definir/cambiar tiempo temporal"
        temp_time_action_clear = "Eliminar tiempo temporal"
        temp_time_action_back = "Volver"
        temp_time_prompt = "Introduce el tiempo temporal (hh:mm:ss.ms) (Esc para cancelar):"
        temp_time_invalid = "Formato inválido. Ejemplos: 1:23, 12:34, 1:02:03, 1:18.268"
        temp_time_saved = "[OK] Tiempo temporal guardado:"
        temp_time_cleared = "Tiempo temporal eliminado."
        temp_time_cancelled = "Operación cancelada."
        temp_time_no_player = "No disponible sin nombre de jugador."
        temp_time_check_title = "Verificando jugador..."
        temp_time_check_status = "Buscando en la categoría seleccionada"
        temp_time_disabled = "PB temporal desactivado (jugador no encontrado en esta categoría)."
        
        # Reset
        reset_confirm = "¿Seguro que quieres restablecer la configuración? (s/N)"
        reset_success = "[OK] Configuración restablecida por defecto."
        reset_cancelled = "Restablecimiento cancelado."
        
        # Errors
        config_load_error = "Error al cargar la configuración:"
        critical_error = "Error crítico:"
        error_general = "Error:"
        close_key = "Pulsa cualquier tecla para cerrar..."
        
        # Closing messages
        goodbye = "¡GL en tus runs!"
    }
    pt = @{
        # Main menu
        menu_title = "Gerenciador de Leaderboard SRC by karlitto__ v1.41"
        menu_add_category = "Adicionar uma nova categoria"
        menu_view_details = "Ver detalhes de uma categoria existente"
        menu_change_active = "Alterar categoria ativa"
        menu_remove_category = "Remover uma categoria"
        menu_language_settings = "Configurações de idioma / 语言设置"
        menu_parameters = "Parâmetros"
        menu_player_name = "Definir meu nome"
        menu_temp_time = "Meu PB temporário"
        menu_quit = "Sair do programa"
        menu_what_to_do = "O que você gostaria de fazer?"
        
        # Navigation
        nav_instructions = "Use setas CIMA/BAIXO para navegar, Enter para selecionar"
        nav_instructions_cancel = "Use setas CIMA/BAIXO para navegar, Enter para selecionar, Backspace para cancelar"
        
        # Existing categories
        existing_categories = "Categorias existentes:"
        active_category = "Categoria atualmente ativa:"
        not_defined = "Não definido"
        
        # Category details
        details_title = "=== DETALHES DA CATEGORIA ==="
        details_choose = "Escolha uma categoria para ver:"
        details_name = "Nome:"
        details_category_id = "ID da Categoria:"
        details_game_id = "ID do Jogo:"
        details_category = "Categoria:"
        details_subcategory = "Subcategoria:"
        details_active_obs = "Ativo no OBS:"
        details_actions = "Acoes:"
        details_edit_name = "Editar nome da categoria"
        details_delete_category = "Remover esta categoria"
        details_edit_prompt = "Novo nome da categoria (Esc para cancelar):"
        details_edit_empty = "Erro: o nome nao pode ficar vazio."
        details_edit_saved = "Nome da categoria atualizado:"
        details_edit_cancelled = "Edicao cancelada."
        details_back = "Voltar"
        
        # Common messages
        continue_key = "Pressione qualquer tecla para continuar..."
        yes = "SIM"
        no = "NÃO"
        null_value = "null"
        cancelled = "Cancelado."
        success = "[OK]"
        
        # New category
        add_title = "=== ADICIONAR NOVA CATEGORIA ==="
        add_game_name = "Nome do jogo:"
        add_game_name_hint = "Pressione ESC para cancelar e voltar ao menu principal"
        add_error_empty_name = "Erro: Você deve inserir um nome de jogo!"
        add_searching = "Pesquisando:"
        add_no_game_found = "Nenhum jogo encontrado para:"
        add_games_found = "Jogos encontrados:"
        add_loading_categories = "Carregando categorias..."
        add_loading_levels = "Carregando niveis..."
        add_no_categories = "Nenhuma categoria encontrada para este jogo!"
        add_categories_available = "Categorias disponíveis:"
        add_subcategories_available = "Subcategorias disponíveis:"
        add_no_subcategory = "Sem subcategoria (null)"
        
        # Final settings
        final_config = "========[ CONFIGURAÇÃO FINAL ]========"
        final_game = "Jogo     :"
        final_game_id = "ID Jogo  :"
        final_category = "Categoria :"
        final_subcategory = "Subcategoria :"
        final_category_id = "Digite um ID único para esta categoria:"
        final_suggestion = "Sugestão:"
        final_category_id_prompt = "ID da categoria (ou Enter para sugestão)"
        final_id_exists = "ATENÇÃO: Já existe uma categoria com ID '%s'!"
        final_overwrite = "Você quer sobrescrever? (s/N)"
        final_operation_cancelled = "Operação cancelada."
        final_activate_now = "Você quer ativar esta categoria agora? (s/N)"
        final_saved = "Categoria '%s' salva com sucesso!"
        final_status = "Estado:"
        final_auto_active = "Ativado automaticamente (primeira categoria)"
        final_active_now = "Ativado como categoria principal"
        final_saved_inactive = "Guardado sem ativar"
        final_obs_will_show = "[OK] O OBS mostrará automaticamente esta categoria!"
        final_activate_later = "Para ativar esta categoria mais tarde, use a opção de mudança de categoria ativa."
        
        # Change active category
        change_active_title = "=== ALTERAR CATEGORIA ATIVA ==="
        change_active_available = "Categorias disponíveis:"
        change_active_changed = "[OK] Categoria ativa alterada para:"
        change_active_obs_info = "OBS usará automaticamente esta categoria!"
        
        # Delete category
        remove_title = "=== REMOVER CATEGORIA ==="
        remove_impossible_title = "=== NÃO É POSSÍVEL REMOVER ==="
        remove_impossible_last = "Não é possível remover a última categoria!"
        remove_impossible_rule = "Você deve ter pelo menos uma categoria configurada."
        remove_warning = "ATENÇÃO: Você vai remover permanentemente:"
        remove_confirm = "Tem certeza de que quer remover esta categoria? (s/N)"
        remove_cancelled = "Remoção cancelada."
        remove_active_deleted = "A categoria ativa foi removida. Escolha a nova categoria ativa:"
        remove_success = "[OK] Categoria '%s' removida com sucesso!"
        remove_new_active = "Nova categoria ativa:"
        
        # First launch
        first_launch_no_category = "Nenhuma categoria encontrada. Criando a primeira categoria..."
        
        # Language
        language_title = "=== CONFIGURAÇÕES DE IDIOMA ==="
        language_current = "Idioma atual:"
        language_available = "Idiomas disponíveis:"
        language_changed = "[OK] Idioma alterado para:"
        language_restart_info = "A mudança será aplicada imediatamente na interface."

        parameters_title = "=== PARÂMETROS ==="
        parameters_visuals = "Ajustes visuais"
        parameters_language = "Idioma / 语言设置"
        parameters_reset_config = "Redefinir configuração"
        parameters_back = "Voltar"
        parameters_visuals_title = "=== AJUSTES VISUAIS ==="
        parameters_select_value = "Novo valor (Esc para cancelar):"
        parameters_invalid_number = "Valor inválido."
        parameters_saved = "[OK] Valor atualizado"
        parameters_invalid_format = "Formato inválido."
        parameters_flag_override_prompt = "Digite override (AA BB, ex.: CR FR):"
        parameters_visuals_section_layout = "Layout"
        parameters_visuals_section_list_ranks = "Lista e rankings"
        parameters_visuals_section_category_name = "Nome da categoria"
        parameters_visuals_section_text_spacing = "Tipografia e espaçamento"
        parameters_visuals_max_name_chars = "Largura do nome (visível)"
        parameters_visuals_section_pb = "PB"
        parameters_visuals_section_effects = "Efeitos"
        parameters_visuals_section_flags_trophies = "Bandeiras e trofeus"
        parameters_visuals_section_carousel = "Carrossel"

        # Parameter descriptions
        param_desc_displayWidth = "Largura da tela do overlay em pixels"
        param_desc_displayHeight = "Altura da tela do overlay em pixels"
        param_desc_topCount = "Número de runs fixas no topo da classificação"
        param_desc_runsPerBatch = "Número de runs exibidas por ciclo de carrossel"
        param_desc_maxRuns = "Número máximo de runs obtidas da API"
        param_desc_rankAlign = "Alinhamento dos números de classificação (esquerda, centro, direita)"
        param_desc_rankPrefixMode = "Símbolo visual da classificação (ponto, cerquilha ou nada)"
        param_desc_fontStyle = "Família de fonte usada para todo o texto"
        param_desc_customFont = "Nome de uma fonte personalizada instalada no seu sistema (deixe vazio para usar fontStyle)"
        param_desc_fontSize = "Tamanho da fonte para nomes e tempos (14-24px)"
        param_desc_categoryNameVisible = "Exibir o nome da categoria no topo do overlay?"
        param_desc_categoryNameColor = "Cor do nome da categoria (6 caracteres hexadecimais, ex: 84c8ff)"
        param_desc_categoryNameSpacing = "Espaço vertical entre nome da categoria e classificação (12-50px)"
        param_desc_maxNameWidthVisible = "Máximo de caracteres para nomes de jogadores"
        param_desc_nameSpacing = "Espaçamento horizontal do nome do jogador"
        param_desc_timeFormat = "Formato para exibir os tempos de run"
        param_desc_pbSeparatorWidth = "Largura da linha separadora antes do PB"
        param_desc_pbPrefix = "Texto de prefixo personalizado antes do PB (1-3 letras)"
        param_desc_pbColor = "Cor do ranking PB (6 caracteres hexadecimais, ex: 9fb4ca)"
        param_desc_pbUseRainbow = "Usar efeito arco-íris para o PB em vez de cor fixa?"
        param_desc_rainbowIntensity = "Intensidade do efeito arco-íris (0-100%)"
        param_desc_useTrophyIcons = "Mostrar ícones de troféu para o top 3?"
        param_desc_flagOverrides = "Substituir códigos de bandeira de país (ex: HR FR)"
        param_desc_CAROUSEL_DISPLAY_DURATION = "Tempo de exibição do carrossel (milissegundos)"
        param_desc_CAROUSEL_FADE_DURATION = "Duração da transição de esmaecimento (milissegundos)"

        # Player name
        player_name_title = "=== NOME DO JOGADOR ==="
        player_name_current = "Nome atual:"
        player_name_prompt = "Introduza o nome do jogador (vazio para desativar, Esc para cancelar):"
        player_name_saved = "[OK] Nome do jogador guardado:"
        player_name_cleared = "Nome do jogador desativado."
        player_name_cancelled = "Operação cancelada."
        player_country_current = "País atual:"
        player_country_prompt = "Introduza o código do país (2 letras, ex: FR):"
        player_country_invalid = "Inválido. Deve ter 2 letras."
        player_country_saved = "[OK] País guardado:"

        # Temporary time
        temp_time_title = "=== TEMPO TEMPORÁRIO ==="
        temp_time_current = "Tempo temporário atual:"
        temp_time_action_set = "Definir/alterar tempo temporário"
        temp_time_action_clear = "Eliminar tempo temporário"
        temp_time_action_back = "Voltar"
        temp_time_prompt = "Introduza o tempo temporário (hh:mm:ss.ms) (Esc para cancelar):"
        temp_time_invalid = "Formato inválido. Exemplos: 1:23, 12:34, 1:02:03, 1:18.268"
        temp_time_saved = "[OK] Tempo temporário guardado:"
        temp_time_cleared = "Tempo temporário eliminado."
        temp_time_cancelled = "Operação cancelada."
        temp_time_no_player = "Indisponível sem nome do jogador."
        temp_time_check_title = "Verificando jogador..."
        temp_time_check_status = "Buscando na categoria selecionada"
        temp_time_disabled = "PB temporário desativado (jogador não encontrado nesta categoria)."
        
        # Reset
        reset_confirm = "Tem certeza que deseja redefinir a configuração? (s/N)"
        reset_success = "[OK] Configuração restaurada para o padrão."
        reset_cancelled = "Redefinição cancelada."
        
        # Errors
        config_load_error = "Erro ao carregar configuração:"
        critical_error = "Erro crítico:"
        error_general = "Erro:"
        close_key = "Pressione qualquer tecla para fechar..."
        
        # Closing messages
        goodbye = "GL nas suas runs!"
    }
    zh = @{
        # Main menu
        menu_title = "SRC 排行榜管理器 by karlitto__ v1.41 卡里托"
        menu_add_category = "添加新类别"
        menu_view_details = "查看现有类别详情"
        menu_change_active = "更改活动类别"
        menu_remove_category = "删除类别"
        menu_language_settings = "语言设置 / Language settings"
        menu_parameters = "参数"
        menu_player_name = "设置我的名字"
        menu_temp_time = "我的临时PB"
        menu_quit = "退出程序"
        menu_what_to_do = "您想要做什么？"
        
        # Navigation
        nav_instructions = "使用上/下箭头导航，回车选择"
        nav_instructions_cancel = "使用上/下箭头导航，回车选择，Backspace取消"
        
        # Existing categories
        existing_categories = "现有类别："
        active_category = "当前活动类别："
        not_defined = "未定义"
        
        # Category details
        details_title = "=== 类别详情 ==="
        details_choose = "选择要查看的类别："
        details_name = "名称："
        details_category_id = "类别ID："
        details_game_id = "游戏ID："
        details_category = "类别："
        details_subcategory = "子类别："
        details_active_obs = "在OBS中活动："
        details_actions = "操作："
        details_edit_name = "编辑类别名称"
        details_delete_category = "删除此类别"
        details_edit_prompt = "新的类别名称（Esc 取消）："
        details_edit_empty = "错误：名称不能为空。"
        details_edit_saved = "类别名称已更新："
        details_edit_cancelled = "已取消编辑。"
        details_back = "返回"
        
        # Common messages
        continue_key = "按任意键继续..."
        yes = "是"
        no = "否"
        null_value = "空"
        cancelled = "已取消。"
        success = "[OK]"
        
        # New category
        add_title = "=== 添加新类别 ==="
        add_game_name = "游戏名称"
        add_game_name_hint = "按 ESC 取消并返回主菜单"
        add_error_empty_name = "错误：您必须输入游戏名称！"
        add_searching = "搜索中："
        add_no_game_found = "未找到游戏："
        add_games_found = "找到的游戏："
        add_loading_categories = "加载类别中..."
        add_loading_levels = "加载关卡中..."
        add_no_categories = "未找到此游戏的类别！"
        add_categories_available = "可用类别："
        add_subcategories_available = "可用子类别："
        add_no_subcategory = "无子类别（空）"
        
        # Final settings
        final_config = "========[ ZUI ZHONG PEI ZHI ]========"
        final_game = "游戏     ："
        final_game_id = "游戏ID   ："
        final_category = "类别     ："
        final_subcategory = "子类别   :"
        final_category_id = "为此类别输入唯一ID："
        final_suggestion = "建议："
        final_category_id_prompt = "类别ID（或回车使用建议）"
        final_id_exists = "警告：ID '%s' 的类别已存在！"
        final_overwrite = "您要覆盖它吗？（y/N）"
        final_operation_cancelled = "操作已取消。"
        final_activate_now = "您现在要激活此类别吗？（y/N）"
        final_saved = "类别 '%s' 保存成功！"
        final_status = "状态："
        final_auto_active = "自动激活（第一个类别）"
        final_active_now = "激活为主要类别"
        final_saved_inactive = "保存而不激活"
        final_obs_will_show = "[OK] OBS将自动显示此类别！"
        final_activate_later = "要稍后激活此类别，请使用活动类别更改选项。"
        
        # Change active category
        change_active_title = "=== 更改活动类别 ==="
        change_active_available = "可用类别："
        change_active_changed = "[OK] 活动类别已更改为："
        change_active_obs_info = "OBS将自动使用此类别！"
        
        # Delete category
        remove_title = "=== 删除类别 ==="
        remove_impossible_title = "=== 无法删除 ==="
        remove_impossible_last = "无法删除最后一个类别！"
        remove_impossible_rule = "您必须至少配置一个类别。"
        remove_warning = "警告：您将永久删除："
        remove_confirm = "您确定要删除此类别吗？(y/N)"
        remove_cancelled = "删除已取消。"
        remove_active_deleted = "活动类别已删除。选择新的活动类别："
        remove_success = "[OK] 类别 '%s' 删除成功！"
        remove_new_active = "新活动类别："
        
        # First launch
        first_launch_no_category = "未找到类别。正在创建第一个类别..."
        
        # Language
        language_title = "=== 语言设置 ==="
        language_current = "当前语言："
        language_available = "可用语言："
        language_changed = "[OK] 语言已更改为："
        language_restart_info = "更改将立即在界面中生效。"

        parameters_title = "=== 参数 ==="
        parameters_visuals = "视觉调整"
        parameters_language = "语言设置 / Language settings"
        parameters_reset_config = "重置配置"
        parameters_back = "返回"
        parameters_visuals_title = "=== 视觉调整 ==="
        parameters_select_value = "新值（按 Esc 取消）："
        parameters_invalid_number = "无效的数值。"
        parameters_saved = "[OK] 值已更新"
        parameters_invalid_format = "格式无效。"
        parameters_flag_override_prompt = "输入覆写代码（AA BB，例如：CR FR）："
        parameters_visuals_section_layout = "布局"
        parameters_visuals_section_list_ranks = "列表和名次"
        parameters_visuals_section_category_name = "类别名称"
        parameters_visuals_section_text_spacing = "字体与间距"
        parameters_visuals_max_name_chars = "名称宽度（可见）"
        parameters_visuals_section_pb = "PB"
        parameters_visuals_section_effects = "特效"
        parameters_visuals_section_flags_trophies = "旗帜与奖杯"
        parameters_visuals_section_carousel = "轮播"

        # Parameter descriptions
        param_desc_displayWidth = "覆盖层画布的宽度（像素）"
        param_desc_displayHeight = "覆盖层画布的高度（像素）"
        param_desc_topCount = "排行榜顶部固定记录数量"
        param_desc_runsPerBatch = "每个轮播周期显示的记录数"
        param_desc_maxRuns = "从API获取的最大记录数"
        param_desc_rankAlign = "排名数字的对齐方式（左、中、右）"
        param_desc_rankPrefixMode = "排名的视觉符号（点、井号或无）"
        param_desc_fontStyle = "所有文本使用的字体系列"
        param_desc_customFont = "系统中安装的自定义字体名称（留空则使用fontStyle）"
        param_desc_fontSize = "名称和时间的字体大小（14-24px）"
        param_desc_categoryNameVisible = "在覆盖层顶部显示类别名称？"
        param_desc_categoryNameColor = "类别名称颜色（6位十六进制字符，例：84c8ff）"
        param_desc_categoryNameSpacing = "类别名称和排行榜之间的垂直间距（12-50px）"
        param_desc_maxNameWidthVisible = "玩家名称的最大字符数"
        param_desc_nameSpacing = "玩家名称的水平间距"
        param_desc_timeFormat = "显示记录时间的格式"
        param_desc_pbSeparatorWidth = "PB前的分隔线宽度"
        param_desc_pbPrefix = "玩家PB前的自定义前缀文本（1-3个字母）"
        param_desc_pbColor = "PB排名颜色（6位十六进制字符，例：9fb4ca）"
        param_desc_pbUseRainbow = "为PB使用彩虹效果而不是固定颜色？"
        param_desc_rainbowIntensity = "彩虹效果强度（0-100%）"
        param_desc_useTrophyIcons = "为前3名显示奖杯图标？"
        param_desc_flagOverrides = "替换国家旗帜代码（例如：HR FR）"
        param_desc_CAROUSEL_DISPLAY_DURATION = "轮播显示时间（毫秒）"
        param_desc_CAROUSEL_FADE_DURATION = "淡入淡出过渡的持续时间（毫秒）"

        # Player name
        player_name_title = "=== 玩家名称 ==="
        player_name_current = "当前名称："
        player_name_prompt = "输入玩家名称（留空禁用，Esc 取消）："
        player_name_saved = "[OK] 玩家名称已保存："
        player_name_cleared = "玩家名称已禁用。"
        player_name_cancelled = "操作已取消。"
        player_country_current = "当前国家/地区："
        player_country_prompt = "输入国家/地区代码（2个字母，例如 FR）："
        player_country_invalid = "无效。必须是2个字母。"
        player_country_saved = "[OK] 国家/地区已保存："

        # Temporary time
        temp_time_title = "=== 临时成绩 ==="
        temp_time_current = "当前临时成绩："
        temp_time_action_set = "设置/修改临时成绩"
        temp_time_action_clear = "清除临时成绩"
        temp_time_action_back = "返回"
        temp_time_prompt = "输入临时成绩 (hh:mm:ss.ms)（Esc 取消）："
        temp_time_invalid = "格式无效。示例：1:23, 12:34, 1:02:03, 1:18.268"
        temp_time_saved = "[OK] 临时成绩已保存："
        temp_time_cleared = "临时成绩已清除。"
        temp_time_cancelled = "操作已取消。"
        temp_time_no_player = "未设置玩家名称，无法使用。"
        temp_time_check_title = "正在检查玩家..."
        temp_time_check_status = "在所选类别中查找"
        temp_time_disabled = "临时PB已禁用（该类别中未找到玩家）。"
        
        # Reset
        reset_confirm = "您确定要重置配置吗？(y/N)"
        reset_success = "[OK] 配置已重置为默认值。"
        reset_cancelled = "重置已取消。"
        
        # Errors
        config_load_error = "加载配置时出错："
        critical_error = "严重错误："
        error_general = "错误："
        close_key = "按任意键关闭..."
        
        # Closing messages
        goodbye = "祝你跑得愉快！"
    }
}

# === LOCALIZATION FUNCTION ===
function Get-LocalizedString {
    param(
        [string]$key,
        [string]$lang = $null
    )
    
    # Use settings language or fall back to French
    if (-not $lang) {
        $lang = if ($Global:CurrentLanguage) { $Global:CurrentLanguage } else { "fr" }
    }
    
    # Fall back to French if the language does not exist
    if (-not $Global:Languages.ContainsKey($lang)) {
        $lang = "fr"
    }
    
    # Fetch the string
    if ($Global:Languages[$lang].ContainsKey($key)) {
        return $Global:Languages[$lang][$key]
    }
    
    # Fall back to French if the key does not exist
    if ($lang -ne "fr" -and $Global:Languages.fr.ContainsKey($key)) {
        return $Global:Languages.fr[$key]
    }
    
    # Return the key if nothing is found
    return "[$key]"
}

# === LANGUAGE MANAGEMENT FUNCTION ===
function Set-Language {
    param($currentConfig)
    
    Clear-Host
    Write-Host (Get-LocalizedString "language_title") -ForegroundColor Cyan
    Write-Host ""
    
    $currentLang = if ($currentConfig -and $currentConfig.language) { $currentConfig.language } else { "fr" }
    Write-Host "$(Get-LocalizedString 'language_current') " -NoNewline -ForegroundColor White
    
    $langDisplayNames = @{
        fr = "Français"
        en = "English"
        es = "Español"
        pt = "Português"
        zh = "中文"
    }
    
    Write-Host $langDisplayNames[$currentLang] -ForegroundColor Cyan
    Write-Host ""
    
    $languageOptions = @("Français (FR)", "English (EN)", "Español (ES)", "Português (PT)", "中文 (ZH)")
    $currentLangIndex = switch ($currentLang) {
      "fr" { 0 }
      "en" { 1 }
      "es" { 2 }
      "pt" { 3 }
      "zh" { 4 }
      default { 0 }
    }
    $selectedLangIndex = Show-ArrowMenu -Title (Get-LocalizedString "language_available") -Options $languageOptions -AllowCancel -SelectedIndex $currentLangIndex
    
    if ($selectedLangIndex -eq -1) { 
        return 
    }
    
    $newLang = switch ($selectedLangIndex) {
        0 { "fr" }
        1 { "en" }
        2 { "es" }
        3 { "pt" }
        4 { "zh" }
    }
    
    # Save the new language
    if (-not $currentConfig) {
        $currentConfig = @{
            language = $newLang
            activePreset = $null
            presets = @{}
        }
    } else {
        if ($currentConfig.GetType().Name -eq "PSCustomObject") {
            if ($currentConfig.PSObject.Properties.Name -contains "language") {
                $currentConfig.language = $newLang
            } else {
                $currentConfig | Add-Member -MemberType NoteProperty -Name "language" -Value $newLang
            }
        } else {
            $currentConfig.language = $newLang
        }
    }
    
    # Apply immediately
    $Global:CurrentLanguage = $newLang
    
    # Save
    $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8
    
    Clear-Host
    Write-Host "$(Get-LocalizedString 'language_changed') $($langDisplayNames[$newLang])" -ForegroundColor Green
    Write-Host (Get-LocalizedString "language_restart_info") -ForegroundColor Cyan
    Write-Host ""
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

  function Clamp-IntValue {
    param(
      [int]$Value,
      [int]$Min,
      [int]$Max
    )

    if ($Value -lt $Min) { return $Min }
    if ($Value -gt $Max) { return $Max }
    return $Value
  }

  function Convert-SizeToPx {
    param(
      [string]$Text,
      [int]$Min,
      [int]$Max
    )

    $clean = $Text.Trim()
    if ($clean -match '^\d+$') {
      $num = [int]$clean
    } elseif ($clean -match '^\d+\s*px$') {
      $num = [int]($clean -replace '[^0-9]', '')
    } else {
      return $null
    }

    $clamped = Clamp-IntValue -Value $num -Min $Min -Max $Max
    return "$clamped`px"
  }

  function Test-FontInstalled {
    param(
      [string]$FontName
    )
    
    if ([string]::IsNullOrWhiteSpace($FontName)) {
      return $true  # Empty is valid (means use fontStyle instead)
    }
    
    try {
      # Load System.Drawing assembly to access font families
      Add-Type -AssemblyName System.Drawing -ErrorAction SilentlyContinue
      
      # Get all installed font families
      $installedFonts = [System.Drawing.FontFamily]::Families | ForEach-Object { $_.Name }
      
      # Check if the font name matches any installed font (case-insensitive)
      $found = $installedFonts | Where-Object { $_ -like $FontName }
      
      return ($null -ne $found)
    } catch {
      # If we can't check, assume it's okay (fail-open)
      return $true
    }
  }

  function Save-Config {
    param($Config)

    $jsonOutput = $Config | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8
  }

  function Set-VisualTweaks {
    param($currentConfig)

    $config = Initialize-Config $currentConfig

    $padX = 12.0
    $displayWidthValue = $null
    if ($config.defaults.displayWidth) {
      $displayWidthText = "$($config.defaults.displayWidth)"
      if ($displayWidthText -match '(\d+)') {
        $displayWidthValue = [int]$Matches[1]
      }
    }
    # Fallback for old configs that might have canvasWidth
    if ($displayWidthValue -eq $null -and $config.defaults.canvasWidth) {
      if ([int]::TryParse("$($config.defaults.canvasWidth)", [ref]$displayWidthValue)) {
        # Use canvasWidth as fallback
      }
    }
    
    $baseWidthValue = if ($displayWidthValue -ne $null) { [double]$displayWidthValue } else { 350.0 }

    $timeXValue = [Math]::Min(350.0, $baseWidthValue - $padX)
    if ([double]::IsNaN($timeXValue) -or [double]::IsInfinity($timeXValue)) {
      $timeXValue = 350.0 - $padX
    }
    $pbSeparatorMax = [Math]::Floor($timeXValue - $padX - 12.0)
    if ($pbSeparatorMax -lt 50) { $pbSeparatorMax = 50 }

    function Show-VisualTweaksCategory {
      param(
        [string]$Title,
        [array]$Items,
        [int]$SelectedIndex
      )

      $lastIndex = $SelectedIndex
      while ($true) {
        $options = @()
        $descriptions = @()
        $maxLabel = 0
        foreach ($item in $Items) {
          if ($item.label.Length -gt $maxLabel) {
            $maxLabel = $item.label.Length
          }
        }
        foreach ($item in $Items) {
          if ($item.type -eq "flagOverride") {
            $flagProps = @()
            if ($config.flagOverrides) {
              $flagProps = $config.flagOverrides.PSObject.Properties
            }
            if ($flagProps.Count -gt 0) {
              $first = $flagProps | Select-Object -First 1
              $extraCount = $flagProps.Count - 1
              if ($extraCount -gt 0) {
                $currentValue = "$($first.Name)->$($first.Value) +$extraCount"
              } else {
                $currentValue = "$($first.Name)->$($first.Value)"
              }
            } else {
              $currentValue = (Get-LocalizedString "not_defined")
            }
          } else {
            $currentValue = $config.defaults.PSObject.Properties[$item.key].Value
            if ($null -eq $currentValue) {
              # Property doesn't exist yet, use default value based on type
              if ($item.type -eq "bool") {
                $currentValue = $true
              } else {
                $currentValue = ""
              }
            }
          }
          $labelPad = $item.label.PadRight($maxLabel)
          $options += "$labelPad : $currentValue"
          
          # Add description if available
          if ($item.desc) {
            $descriptions += (Get-LocalizedString $item.desc)
          } else {
            $descriptions += ""
          }
        }
        $options += (Get-LocalizedString "parameters_back")
        $descriptions += ""

        $selectedIndex = Show-ArrowMenu -Title $Title -Options $options -AllowCancel -SelectedIndex $lastIndex -Descriptions $descriptions
        if ($selectedIndex -eq -1 -or $selectedIndex -eq ($options.Count - 1)) {
          return $lastIndex
        }
        $lastIndex = $selectedIndex

        $selected = $Items[$selectedIndex]
        $currentValue = $config.defaults.PSObject.Properties[$selected.key].Value
        if ($null -eq $currentValue) {
          # Property doesn't exist yet, use default value based on type
          if ($selected.type -eq "bool") {
            $currentValue = $true
          } elseif ($selected.type -eq "int") {
            $currentValue = $selected.min
          } else {
            $currentValue = ""
          }
        }

        if ($selected.type -eq "flagOverride") {
          $inputResult = Read-InputWithEscape (Get-LocalizedString "parameters_flag_override_prompt")
          if ($inputResult.Cancelled) {
            continue
          }

          $text = $inputResult.Text.Trim()
          if ($text -match '^(?<from>[A-Za-z]{2})\s+(?<to>[A-Za-z]{2})$') {
            $from = $Matches.from.ToUpperInvariant()
            $to = $Matches.to.ToUpperInvariant()
            if ($config.GetType().Name -eq "PSCustomObject") {
              $config.flagOverrides = [PSCustomObject]@{ $from = $to }
            } else {
              $config.flagOverrides = @{ $from = $to }
            }
            Save-Config $config
            Clear-Host
            Write-Host (Get-LocalizedString "parameters_saved") -ForegroundColor Green
            Start-Sleep -Milliseconds 400
          } else {
            Clear-Host
            Write-Host (Get-LocalizedString "parameters_invalid_format") -ForegroundColor Red
            Write-Host ""
            Start-Sleep -Milliseconds 800
          }
          continue
        }

        if ($selected.type -eq "bool") {
          $newBoolValue = -not [bool]$currentValue
          # Set value - handle PSCustomObject case where property might not exist
          if ($config.defaults.PSObject.Properties[$selected.key]) {
            $config.defaults.$($selected.key) = $newBoolValue
          } else {
            $config.defaults | Add-Member -MemberType NoteProperty -Name $selected.key -Value $newBoolValue -Force
          }
          Save-Config $config
          Clear-Host
          Write-Host (Get-LocalizedString "parameters_saved") -ForegroundColor Green
          Start-Sleep -Milliseconds 400
          continue
        }

        if ($selected.type -eq "enum") {
          $enumOptions = $selected.options
          $currentIndex = 0
          for ($i = 0; $i -lt $enumOptions.Count; $i++) {
            if ($enumOptions[$i].ToLowerInvariant() -eq "$currentValue".ToLowerInvariant()) {
              $currentIndex = $i
              break
            }
          }
          $enumIndex = Show-ArrowMenu -Title $selected.label -Options $enumOptions -SelectedIndex $currentIndex -AllowCancel
          if ($enumIndex -eq -1) {
            continue
          }
          $newEnumValue = $enumOptions[$enumIndex]
          # Set value - handle PSCustomObject case where property might not exist
          if ($config.defaults.PSObject.Properties[$selected.key]) {
            $config.defaults.$($selected.key) = $newEnumValue
          } else {
            $config.defaults | Add-Member -MemberType NoteProperty -Name $selected.key -Value $newEnumValue -Force
          }
          Save-Config $config
          Clear-Host
          Write-Host (Get-LocalizedString "parameters_saved") -ForegroundColor Green
          Start-Sleep -Milliseconds 400
          continue
        }

        $prompt = if ($selected.type -eq "text") {
          if ($selected.key -eq "customFont") {
            "$(Get-LocalizedString 'parameters_select_value') [0-$($selected.maxLength) chars] (current: $currentValue)"
          } else {
            "$(Get-LocalizedString 'parameters_select_value') [$($selected.minLength)-$($selected.maxLength) letters] (current: $currentValue)"
          }
        } else {
          "$(Get-LocalizedString 'parameters_select_value') [$($selected.min)-$($selected.max)] (current: $currentValue)"
        }
        $inputResult = Read-InputWithEscape $prompt
        if ($inputResult.Cancelled) {
          continue
        }

        $newValue = $null
        if ($selected.type -eq "int") {
          $parsed = 0
          if ([int]::TryParse($inputResult.Text.Trim(), [ref]$parsed)) {
            $newValue = Clamp-IntValue -Value $parsed -Min $selected.min -Max $selected.max
          }
        } elseif ($selected.type -eq "px") {
          $newValue = Convert-SizeToPx -Text $inputResult.Text -Min $selected.min -Max $selected.max
        } elseif ($selected.type -eq "text") {
          $text = $inputResult.Text.Trim()
          
          # Different validation for customFont vs pbPrefix vs categoryNameColor
          if ($selected.key -eq "customFont") {
            # Custom font: allow any printable characters, spaces, preserve case
            # Allow empty string (minLength = 0)
            if ($text.Length -eq 0 -or ($text.Length -ge $selected.minLength -and $text.Length -le $selected.maxLength)) {
              $newValue = $text  # Keep original case and spaces
              
              # Check if font is installed (warning only, not blocking)
              if ($text.Length -gt 0) {
                $fontExists = Test-FontInstalled -FontName $text
                if (-not $fontExists) {
                  Clear-Host
                  Write-Host "⚠️  WARNING: Font '$text' not found on your system!" -ForegroundColor Yellow
                  Write-Host "   The overlay will fall back to a default font." -ForegroundColor Yellow
                  Write-Host ""
                  Write-Host "   Do you want to save it anyway? (y/N)" -ForegroundColor Cyan
                  $confirmation = Read-Host
                  if ($confirmation -notmatch '^[yYoO]') {
                    $newValue = $null  # Cancel save
                  }
                }
              }
            }
          } elseif ($selected.key -eq "categoryNameColor" -or $selected.key -eq "pbColor") {
            # Hex color: accept 6 hex characters, prepend # automatically
            if ($text -match '^[0-9A-Fa-f]{6}$') {
              $newValue = "#" + $text.ToLower()  # Prepend # and normalize to lowercase
            } else {
              Clear-Host
              Write-Host "❌ Invalid hex color format!" -ForegroundColor Red
              Write-Host "   Expected: 6 hex characters (e.g., 84c8ff or e2e8f0)" -ForegroundColor Yellow
              Write-Host ""
              Start-Sleep -Milliseconds 800
              $newValue = $null
            }
          } else {
            # pbPrefix: letters only, uppercase
            if ($text -match '^[A-Za-z]+$' -and $text.Length -ge $selected.minLength -and $text.Length -le $selected.maxLength) {
              $newValue = $text.ToUpper()
            }
          }
        }

        if ($null -eq $newValue) {
          Clear-Host
          Write-Host (Get-LocalizedString "parameters_invalid_number") -ForegroundColor Red
          Write-Host ""
          Start-Sleep -Milliseconds 800
          continue
        }

        # Set value - handle PSCustomObject case where property might not exist
        if ($config.defaults.PSObject.Properties[$selected.key]) {
          $config.defaults.$($selected.key) = $newValue
        } else {
          $config.defaults | Add-Member -MemberType NoteProperty -Name $selected.key -Value $newValue -Force
        }
        Save-Config $config
        Clear-Host
        Write-Host (Get-LocalizedString "parameters_saved") -ForegroundColor Green
        Start-Sleep -Milliseconds 400
      }
    }

    $categories = @(
      @{ key = "layout"; label = (Get-LocalizedString "parameters_visuals_section_layout"); items = @(
          @{ key = "displayWidth"; label = "displayWidth"; type = "int"; min = 200; max = 4000; desc = "param_desc_displayWidth" }
          @{ key = "displayHeight"; label = "displayHeight"; type = "int"; min = 100; max = 3000; desc = "param_desc_displayHeight" }
        ) }
      @{ key = "listRanks"; label = (Get-LocalizedString "parameters_visuals_section_list_ranks"); items = @(
          @{ key = "topCount"; label = "topCount"; type = "int"; min = 1; max = 5; desc = "param_desc_topCount" }
          @{ key = "runsPerBatch"; label = "runsPerBatch"; type = "int"; min = 1; max = 5; desc = "param_desc_runsPerBatch" }
          @{ key = "maxRuns"; label = "maxRuns"; type = "int"; min = 10; max = 200; desc = "param_desc_maxRuns" }
          @{ key = "rankAlign"; label = "rankAlign"; type = "enum"; options = @("left", "center", "right"); desc = "param_desc_rankAlign" }
          @{ key = "rankPrefixMode"; label = "rankPrefixMode"; type = "enum"; options = @("dot", "hash", "none"); desc = "param_desc_rankPrefixMode" }
        ) }
      @{ key = "categoryName"; label = (Get-LocalizedString "parameters_visuals_section_category_name"); items = @(
          @{ key = "categoryNameVisible"; label = "categoryNameVisible"; type = "bool"; desc = "param_desc_categoryNameVisible" }
          @{ key = "categoryNameColor"; label = "categoryNameColor"; type = "text"; minLength = 6; maxLength = 6; desc = "param_desc_categoryNameColor" }
          @{ key = "categoryNameSpacing"; label = "categoryNameSpacing"; type = "int"; min = 12; max = 50; desc = "param_desc_categoryNameSpacing" }
        ) }
      @{ key = "textSpacing"; label = (Get-LocalizedString "parameters_visuals_section_text_spacing"); items = @(
          @{ key = "fontStyle"; label = "fontStyle"; type = "enum"; options = @("Arial", "Verdana", "TimesNewRoman", "Georgia", "CourierNew", "Impact", "TrebuchetMS", "Tahoma", "ComicSans", "SegoeUI"); desc = "param_desc_fontStyle" }
          @{ key = "customFont"; label = "customFont"; type = "text"; minLength = 0; maxLength = 30; desc = "param_desc_customFont" }
          @{ key = "fontSize"; label = "fontSize"; type = "int"; min = 14; max = 24; desc = "param_desc_fontSize" }
          @{ key = "maxNameWidthVisible"; label = (Get-LocalizedString "parameters_visuals_max_name_chars"); type = "int"; min = 4; max = 60; desc = "param_desc_maxNameWidthVisible" }
          @{ key = "nameSpacing"; label = "nameSpacing"; type = "int"; min = 0; max = 10; desc = "param_desc_nameSpacing" }
          @{ key = "timeFormat"; label = "timeFormat"; type = "enum"; options = @("1:25:25.255", "1h25m25s225ms"); desc = "param_desc_timeFormat" }
        ) }
      @{ key = "pb"; label = (Get-LocalizedString "parameters_visuals_section_pb"); items = @(
          @{ key = "pbSeparatorWidth"; label = "pbSeparatorWidth"; type = "int"; min = 50; max = $pbSeparatorMax; desc = "param_desc_pbSeparatorWidth" }
          @{ key = "pbPrefix"; label = "pbPrefix"; type = "text"; minLength = 1; maxLength = 3; desc = "param_desc_pbPrefix" }
          @{ key = "pbColor"; label = "pbColor"; type = "text"; minLength = 6; maxLength = 6; desc = "param_desc_pbColor" }
          @{ key = "pbUseRainbow"; label = "pbUseRainbow"; type = "bool"; desc = "param_desc_pbUseRainbow" }
        ) }
      @{ key = "effects"; label = (Get-LocalizedString "parameters_visuals_section_effects"); items = @(
          @{ key = "rainbowIntensity"; label = "rainbowIntensity"; type = "int"; min = 0; max = 100; desc = "param_desc_rainbowIntensity" }
        ) }
      @{ key = "flagsTrophies"; label = (Get-LocalizedString "parameters_visuals_section_flags_trophies"); items = @(
          @{ key = "useTrophyIcons"; label = "useTrophyIcons"; type = "bool"; desc = "param_desc_useTrophyIcons" }
          @{ key = "flagOverrides"; label = "flagOverrides"; type = "flagOverride"; desc = "param_desc_flagOverrides" }
        ) }
      @{ key = "carousel"; label = (Get-LocalizedString "parameters_visuals_section_carousel"); items = @(
          @{ key = "CAROUSEL_DISPLAY_DURATION"; label = "CAROUSEL_DISPLAY_DURATION"; type = "int"; min = 1000; max = 10000; desc = "param_desc_CAROUSEL_DISPLAY_DURATION" }
          @{ key = "CAROUSEL_FADE_DURATION"; label = "CAROUSEL_FADE_DURATION"; type = "int"; min = 50; max = 1000; desc = "param_desc_CAROUSEL_FADE_DURATION" }
        ) }
    )

    $categoryIndexByKey = @{}
    foreach ($cat in $categories) {
      $categoryIndexByKey[$cat.key] = 0
    }

    $lastIndex = 0
    while ($true) {
      $options = @($categories | ForEach-Object { $_.label })
      $options += (Get-LocalizedString "parameters_back")

      if ($lastIndex -lt 0 -or $lastIndex -ge $options.Count) {
        $lastIndex = 0
      }
      $selectedIndex = Show-ArrowMenu -Title (Get-LocalizedString "parameters_visuals_title") -Options $options -AllowCancel -SelectedIndex $lastIndex
      if ($selectedIndex -eq -1 -or $selectedIndex -eq ($options.Count - 1)) {
        return
      }
      $lastIndex = $selectedIndex

      $selectedCategory = $categories[$selectedIndex]
      $lastItemIndex = $categoryIndexByKey[$selectedCategory.key]
      $updatedIndex = Show-VisualTweaksCategory -Title $selectedCategory.label -Items $selectedCategory.items -SelectedIndex $lastItemIndex
      $categoryIndexByKey[$selectedCategory.key] = $updatedIndex
    }
  }

  function Set-Parameters {
    param($currentConfig)

    $config = Initialize-Config $currentConfig

    $lastIndex = 0

    while ($true) {
      $options = @(
        (Get-LocalizedString "parameters_visuals"),
        (Get-LocalizedString "parameters_reset_config"),
        (Get-LocalizedString "parameters_language"),
        (Get-LocalizedString "parameters_back")
      )
      if ($lastIndex -lt 0 -or $lastIndex -ge $options.Count) {
        $lastIndex = 0
      }
      $selectedIndex = Show-ArrowMenu -Title (Get-LocalizedString "parameters_title") -Options $options -AllowCancel -SelectedIndex $lastIndex
      if ($selectedIndex -eq -1 -or $selectedIndex -eq 3) {
        return
      }

      $lastIndex = $selectedIndex

      if ($selectedIndex -eq 0) {
        Set-VisualTweaks $config
      } elseif ($selectedIndex -eq 1) {
        # Reset Config
        Clear-Host
        Write-Host (Get-LocalizedString "reset_confirm") -ForegroundColor Yellow
        
        $expectedAnswer = switch ($Global:CurrentLanguage) {
             "en" { "y" }
             "es" { "s" }
             "pt" { "s" }
             "zh" { "y" }
             default { "o" }
        }
        
        $confirm = Read-Host
        if ($confirm -and $confirm.ToLower().Trim() -eq $expectedAnswer) {
             $Global:DefaultConfigJSON | Set-Content "config.json" -Encoding UTF8
             Write-Host (Get-LocalizedString "reset_success") -ForegroundColor Green
             Start-Sleep -Seconds 1
             # Reload config
             $config = Get-Content "config.json" -Raw | ConvertFrom-Json
             # Reset language from config
             if ($config.language) { $Global:CurrentLanguage = $config.language }
        } else {
             Write-Host (Get-LocalizedString "reset_cancelled") -ForegroundColor Cyan
             Start-Sleep -Seconds 1
        }
      } elseif ($selectedIndex -eq 2) {
        Set-Language $config
        $config = Get-Content "config.json" -Raw | ConvertFrom-Json
      }
    }
  }

# === SETTINGS FUNCTION ===
function Initialize-Config {
  param($config)

  if (-not $config) { $config = @{} }

  # === MIGRATION: Rename presets → categories (backward compatibility) ===
  if ($config.PSObject.Properties.Name -contains "presets") {
    $presetsValue = $config.presets
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "categories" -Value $presetsValue -Force
      $config.PSObject.Properties.Remove("presets")
    } else {
      $config.categories = $presetsValue
      $config.Remove("presets")
    }
  }

  if ($config.PSObject.Properties.Name -contains "activePreset") {
    $activeValue = $config.activePreset
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "activeCategory" -Value $activeValue -Force
      $config.PSObject.Properties.Remove("activePreset")
    } else {
      $config.activeCategory = $activeValue
      $config.Remove("activePreset")
    }
  }
  # === END MIGRATION ===

  if (-not $config.language) {
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "language" -Value "fr" -Force
    } else {
      $config.language = "fr"
    }
  }

  if (-not $config.activeCategory) {
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "activeCategory" -Value $null -Force
    } else {
      $config.activeCategory = $null
    }
  }

  if (-not $config.categories) {
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "categories" -Value @{} -Force
    } else {
      $config.categories = @{}
    }
  }

  if (-not $config.defaults) {
    $defaults = @{
      runsPerBatch = 3
      maxRuns = 200
      topCount = 3
      displayWidth = 400
      displayHeight = 274
      rankAlign = "right"
      rankPrefixMode = "dot"
      fontStyle = "Arial"
      customFont = ""
      maxNameWidthVisible = 30
      timeFormat = "1:25:25.255"
      nameSpacing = 4
      pbSeparatorWidth = 326
      pbPrefix = "PB"
      rainbowIntensity = 50
      CAROUSEL_DISPLAY_DURATION = 3000
      CAROUSEL_FADE_DURATION = 500
      useTrophyIcons = $false
    }
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "defaults" -Value $defaults -Force
    } else {
      $config.defaults = $defaults
    }
  }

  # Ensure rankPrefixMode exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "rankPrefixMode")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "rankPrefixMode" -Value "dot" -Force
    } else {
      $config.defaults.rankPrefixMode = "dot"
    }
  }

  # Ensure fontStyle exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "fontStyle")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "fontStyle" -Value "Arial" -Force
    } else {
      $config.defaults.fontStyle = "Arial"
    }
  }

  # Ensure maxNameWidthVisible exists (migration from maxPlayerNameChars)
  $defaultsObj = $config.defaults
  $hasNewProp = $false
  $oldValue = 14
  
  if ($defaultsObj -is [System.Collections.Hashtable]) {
    $hasNewProp = $defaultsObj.ContainsKey("maxNameWidthVisible")
    if ($defaultsObj.ContainsKey("maxPlayerNameChars")) { $oldValue = $defaultsObj["maxPlayerNameChars"] }
  } elseif ($defaultsObj -is [System.Management.Automation.PSCustomObject]) {
    $hasNewProp = $defaultsObj.PSObject.Properties.Name -contains "maxNameWidthVisible"
    if ($defaultsObj.PSObject.Properties.Name -contains "maxPlayerNameChars") { $oldValue = $defaultsObj.maxPlayerNameChars }
  }

  if (-not $hasNewProp) {
    if ($defaultsObj -is [System.Management.Automation.PSCustomObject]) {
      $defaultsObj | Add-Member -MemberType NoteProperty -Name "maxNameWidthVisible" -Value $oldValue -Force
    } else {
      $defaultsObj["maxNameWidthVisible"] = $oldValue
    }
  }

  # Ensure CAROUSEL_FADE_DURATION exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "CAROUSEL_FADE_DURATION")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "CAROUSEL_FADE_DURATION" -Value 500 -Force
    } else {
      $config.defaults.CAROUSEL_FADE_DURATION = 500
    }
  }

  # Ensure pbPrefix exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "pbPrefix")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "pbPrefix" -Value "PB" -Force
    } else {
      $config.defaults.pbPrefix = "PB"
    }
  }

  # Ensure pbColor exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "pbColor")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "pbColor" -Value "9fb4ca" -Force
    } else {
      $config.defaults.pbColor = "9fb4ca"
    }
  }

  # Ensure pbUseRainbow exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "pbUseRainbow")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "pbUseRainbow" -Value $false -Force
    } else {
      $config.defaults.pbUseRainbow = $false
    }
  }

  # Ensure customFont exists in defaults (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "customFont")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "customFont" -Value "" -Force
    } else {
      $config.defaults.customFont = ""
    }
  }

  # Remove deprecated carouselInterval if it exists (migration)
  if ($config.defaults) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      if ($config.defaults.PSObject.Properties.Name -contains "carouselInterval") {
        $config.defaults.PSObject.Properties.Remove("carouselInterval")
      }
    } elseif ($config.defaults -is [System.Collections.Hashtable]) {
      if ($config.defaults.ContainsKey("carouselInterval")) {
        $config.defaults.Remove("carouselInterval")
      }
    }
  }

  # Ensure categoryNameColor exists (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "categoryNameColor")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "categoryNameColor" -Value "#84c8ff" -Force
    } else {
      $config.defaults.categoryNameColor = "#84c8ff"
    }
  }

  # Ensure categoryNameSpacing exists (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "categoryNameSpacing")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "categoryNameSpacing" -Value 14 -Force
    } else {
      $config.defaults.categoryNameSpacing = 14
    }
  }

  # Ensure categoryNameVisible exists (backward compatibility)
  if ($config.defaults -and -not ($config.defaults.PSObject.Properties.Name -contains "categoryNameVisible")) {
    if ($config.defaults.GetType().Name -eq "PSCustomObject") {
      $config.defaults | Add-Member -MemberType NoteProperty -Name "categoryNameVisible" -Value $true -Force
    } else {
      $config.defaults.categoryNameVisible = $true
    }
  }

  if (-not ($config.PSObject.Properties.Name -contains "playerName")) {
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "playerName" -Value $null -Force
    } else {
      $config.playerName = $null
    }
  }

  if (-not ($config.PSObject.Properties.Name -contains "playerCountry")) {
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "playerCountry" -Value "FR" -Force
    } else {
      $config.playerCountry = "FR"
    }
  }

  if (-not ($config.PSObject.Properties.Name -contains "temporaryRun")) {
    $tempRun = @{ active = $false; time = $null }
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "temporaryRun" -Value $tempRun -Force
    } else {
      $config.temporaryRun = $tempRun
    }
  }

  if (-not ($config.PSObject.Properties.Name -contains "flagOverrides")) {
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "flagOverrides" -Value @{} -Force
    } else {
      $config.flagOverrides = @{}
    }
  }

  return $config
}

function Show-ProgressStep {
  param(
    [string]$Activity,
    [string]$Status,
    [int]$PercentComplete
  )

  Write-Progress -Id 1 -Activity $Activity -Status $Status -PercentComplete $PercentComplete
}

function Clear-Progress {
  Write-Progress -Id 1 -Activity " " -Completed
}

function Read-InputWithEscape {
  param(
    [string]$Prompt
  )

  Write-Host "$Prompt " -NoNewline
  $text = ""

  while ($true) {
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    switch ($key.VirtualKeyCode) {
      13 { # Enter
        Write-Host ""
        return @{ Text = $text; Cancelled = $false }
      }
      27 { # Esc
        Write-Host ""
        return @{ Text = $null; Cancelled = $true }
      }
      8 { # Backspace
        if ($text.Length -gt 0) {
          $text = $text.Substring(0, $text.Length - 1)
          Write-Host "`b `b" -NoNewline
        }
      }
      default {
        if ($key.Character -ne [char]0) {
          $text += $key.Character
          Write-Host $key.Character -NoNewline
        }
      }
    }
  }
}

function Convert-TimeStringToSeconds {
  param([string]$Text)

  if ([string]::IsNullOrWhiteSpace($Text)) { return $null }

  $clean = $Text.Trim().Replace(",", ".")

  # Check for a simple number (direct seconds)
  if ($clean -match '^\d+(\.\d+)?$') {
    $val = 0.0
    if ([double]::TryParse($clean, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$val)) { 
      return $val 
    }
    return $null
  }

  $parts = $clean.Split(':')
  if ($parts.Count -lt 2 -or $parts.Count -gt 3) { return $null }

  $hours = 0
  $minutes = 0
  $seconds = 0.0

  if ($parts.Count -eq 2) {
    if (-not [int]::TryParse($parts[0], [ref]$minutes)) { return $null }
    if (-not [double]::TryParse($parts[1], [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$seconds)) { return $null }
  } else {
    if (-not [int]::TryParse($parts[0], [ref]$hours)) { return $null }
    if (-not [int]::TryParse($parts[1], [ref]$minutes)) { return $null }
    if (-not [double]::TryParse($parts[2], [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$seconds)) { return $null }
  }

  if ($minutes -lt 0 -or $seconds -lt 0 -or $seconds -ge 60) { return $null }
  if ($parts.Count -eq 3 -and ($minutes -ge 60)) { return $null }

  return ($hours * 3600) + ($minutes * 60) + $seconds
}

function Invoke-SrcApiJson {
  param(
    [Parameter(Mandatory = $true)][string]$Uri,
    [int]$TimeoutSec = 10
  )

  $response = Invoke-WebRequest -Uri $Uri -TimeoutSec $TimeoutSec
  return ($response.Content | ConvertFrom-Json)
}

function ConvertTo-SubcategoryVariable {
  param(
    [Parameter(Mandatory = $true)]$Variable
  )

  $values = @()
  if ($Variable.values -and $Variable.values.values) {
    foreach ($p in $Variable.values.values.PSObject.Properties) {
      $values += [PSCustomObject]@{
        id = $p.Name
        label = $p.Value.label
      }
    }
  }

  return [PSCustomObject]@{
    id = $Variable.id
    name = $Variable.name
    category = $Variable.category
    scope = $Variable.scope
    values = $values
    raw = $Variable
  }
}

function Get-SubcategoryVariablesForSelection {
  param(
    [Parameter(Mandatory = $true)]$SelectedCategory,
    $SelectedLevel,
    [array]$AllCategories
  )

  $subcategoryVariables = @()
  try {
    $varsData = Invoke-SrcApiJson -Uri "https://www.speedrun.com/api/v1/categories/$($SelectedCategory.id)/variables" -TimeoutSec 10
    $subcategoryVariables = $varsData.data
  } catch {
    if ($SelectedCategory.variables -and $SelectedCategory.variables.data) {
      $subcategoryVariables = $SelectedCategory.variables.data
    } else {
      $subcategoryVariables = @()
    }
  }
  if (-not $subcategoryVariables) { $subcategoryVariables = @() }

  $allowedVarIds = @{}
  if ($SelectedCategory.variables -and $SelectedCategory.variables.data) {
    foreach ($var in $SelectedCategory.variables.data) {
      if ($var.id) { $allowedVarIds[$var.id] = $true }
    }
  }

  $subcategoryVariables = $subcategoryVariables | Where-Object { $_.'is-subcategory' -eq $true -and $_.values.values }

  $categoryNameSet = @{}
  foreach ($catItem in $AllCategories) {
    if ($catItem.name) {
      $categoryNameSet[$catItem.name.ToLowerInvariant()] = $true
    }
  }

  if ($allowedVarIds.Count -gt 0) {
    $subcategoryVariables = $subcategoryVariables | Where-Object { $_.id -and $allowedVarIds.ContainsKey($_.id) }
  } else {
    # Filter irrelevant variables (category)
    $subcategoryVariables = $subcategoryVariables | Where-Object {
      (-not $_.category) -or ($_.category -eq $SelectedCategory.id)
    }
  }

  # Filter irrelevant variables (scope)
  $subcategoryVariables = $subcategoryVariables | Where-Object {
    if (-not $_.scope -or -not $_.scope.type) { return $true }
    if ($SelectedLevel) {
      if ($_.scope.type -eq "all-levels") { return $true }
      if ($_.scope.type -eq "single-level") { return $_.scope.level -eq $SelectedLevel.id }
      if ($_.scope.type -eq "global") { return $true }
      return $false
    }
    return $_.scope.type -in @("full-game", "all-levels", "global")
  }

  # Ignore global variables that only select a category
  if ($categoryNameSet.Count -gt 0) {
    $subcategoryVariables = $subcategoryVariables | Where-Object {
      if ($_.category) { return $true }
      $valueLabels = @()
      if ($_.values -and $_.values.values) {
        $valueLabels = $_.values.values.PSObject.Properties | ForEach-Object { $_.Value.label }
      }
      if (-not $valueLabels -or $valueLabels.Count -eq 0) { return $true }
      foreach ($label in $valueLabels) {
        if (-not $categoryNameSet.ContainsKey($label.ToLowerInvariant())) {
          return $true
        }
      }
      return $false
    }
  }

  # Normalize + skip variables with <= 1 value (website won't show those)
  $normalized = @()
  foreach ($var in $subcategoryVariables) {
    $n = ConvertTo-SubcategoryVariable -Variable $var
    if ($n.values.Count -le 1) { continue }
    $normalized += $n
  }

  return $normalized
}

function Select-SubcategorySelections {
  param(
    [array]$SubcategoryVariables
  )

  $selectedSubcategoryLabels = @()
  $selectedSubcategories = @()

  foreach ($subcatVariable in $SubcategoryVariables) {
    $varName = $subcatVariable.name

    $subcatOptions = @()
    $subcatArray = @()

    $anyLabel = switch ($Global:CurrentLanguage) {
      "en" { "Any (skip this filter)" }
      "es" { "Cualquiera (omitir este filtro)" }
      "pt" { "Qualquer (pular este filtro)" }
      "zh" { "任意（跳过此过滤器）" }
      default { "Any (ignorer ce filtre)" }
    }
    $subcatOptions += $anyLabel

    foreach ($v in $subcatVariable.values) {
      $subcatOptions += $v.label
      $subcatArray += $v
    }
    $subcatOptions += (Get-LocalizedString "details_back")

    $menuTitle = switch ($Global:CurrentLanguage) {
      "en" { "$varName - Select value:" }
      "es" { "$varName - Selecciona valor:" }
      "pt" { "$varName - Selecione valor:" }
      "zh" { "$varName - 选择值：" }
      default { "$varName - Sélectionnez la valeur :" }
    }

    $selectedSubcatIndex = Show-ArrowMenu -Title $menuTitle -Options $subcatOptions -AllowCancel

    if ($selectedSubcatIndex -eq -1) {
      return [PSCustomObject]@{ Restart = $true; Labels = @(); Selections = @() }
    }
    if ($selectedSubcatIndex -eq ($subcatOptions.Count - 1)) {
      return [PSCustomObject]@{ Restart = $true; Labels = @(); Selections = @() }
    }

    if ($selectedSubcatIndex -gt 0) {
      $selectedEntry = $subcatArray[$selectedSubcatIndex - 1]
      $selectedSubcategoryLabels += $selectedEntry.label
      $selectedSubcategories += [PSCustomObject]@{
        variableId = $subcatVariable.id
        valueId = $selectedEntry.id
        label = $selectedEntry.label
      }
    }
  }

  return [PSCustomObject]@{
    Restart = $false
    Labels = $selectedSubcategoryLabels
    Selections = $selectedSubcategories
  }
}

function Resolve-CategoryDetailsAndVariables {
  param($preset)

  $gameId = $preset.gameId
  $categoryName = $preset.category
  $levelId = $preset.levelId

  $response = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games/$gameId?embed=categories.variables" -TimeoutSec 10
  $data = $response.Content | ConvertFrom-Json
  $cats = $data.data.categories.data
  $targetType = if ($levelId) { "per-level" } else { "per-game" }
  $cat = $cats | Where-Object { $_.type -eq $targetType -and $_.name -eq $categoryName } | Select-Object -First 1
  if (-not $cat) {
    throw "Categorie non trouvee: $categoryName"
  }

  $vars = @()
  if ($cat.variables -and $cat.variables.data) {
    $vars = $cat.variables.data
  }

  $variablePairs = @()
  $subcats = $preset.subcategories
  if ($subcats) {
    $subcatList = @()
    if ($subcats -is [System.Collections.IEnumerable] -and -not ($subcats -is [string])) {
      $subcatList = @($subcats)
    } else {
      $subcatList = @($subcats)
    }

    foreach ($entry in $subcatList) {
      if ($entry -and $entry.variableId -and $entry.valueId) {
        $variablePairs += @{ variableId = $entry.variableId; valueId = $entry.valueId }
      }
    }

    return @{ CategoryId = $cat.id; VariablePairs = $variablePairs }
  }

  $label = $preset.subcategory
  if (-not $label) {
    return @{ CategoryId = $cat.id; VariablePairs = @() }
  }

  $labels = $label -split " - " | ForEach-Object { $_.Trim() } | Where-Object { $_ }
  $usedVars = @{}

  foreach ($item in $labels) {
    $targetLabel = $item.ToLowerInvariant()
    $sub = $vars | Where-Object {
      $_.'is-subcategory' -eq $true -and $_.values.values -and -not $usedVars.ContainsKey($_.id) -and
      ($_.values.values.PSObject.Properties | Where-Object { $_.Value.label -and $_.Value.label.ToLowerInvariant() -eq $targetLabel })
    } | Select-Object -First 1

    if (-not $sub) { continue }

    $entry = $sub.values.values.PSObject.Properties | Where-Object { $_.Value.label -and $_.Value.label.ToLowerInvariant() -eq $targetLabel } | Select-Object -First 1
    if ($entry) {
      $variablePairs += @{ variableId = $sub.id; valueId = $entry.Name }
      $usedVars[$sub.id] = $true
    }
  }

  return @{ CategoryId = $cat.id; VariablePairs = $variablePairs }
}

function Test-PlayerInCategory {
  param($config, $preset)

  $playerName = if ($config.playerName) { $config.playerName.Trim() } else { "" }
  if ([string]::IsNullOrWhiteSpace($playerName)) {
    return $false
  }

  $resolved = Resolve-CategoryDetailsAndVariables $preset
  $categoryId = $resolved.CategoryId
  $variablePairs = $resolved.VariablePairs

  $limit = 200
  if ($config.defaults -and $config.defaults.maxRuns) {
    $limit = [int]$config.defaults.maxRuns
  }

  if ($preset.levelId) {
    $lbUrl = "https://www.speedrun.com/api/v1/leaderboards/$($preset.gameId)/level/$($preset.levelId)/$categoryId?top=$limit&embed=players"
  } else {
    $lbUrl = "https://www.speedrun.com/api/v1/leaderboards/$($preset.gameId)/category/$categoryId?top=$limit&embed=players"
  }

  if ($variablePairs -and $variablePairs.Count -gt 0) {
    foreach ($pair in $variablePairs) {
      if ($pair.variableId -and $pair.valueId) {
        $lbUrl += "&var-$($pair.variableId)=$($pair.valueId)"
      }
    }
  }

  $lbResponse = Invoke-WebRequest -Uri $lbUrl -TimeoutSec 10
  $lb = $lbResponse.Content | ConvertFrom-Json

  $playerMap = @{}
  if ($lb.data.players -and $lb.data.players.data) {
    foreach ($p in $lb.data.players.data) {
      $displayName = if ($p.rel -eq "guest") { $p.name } else { $p.names.international }
      $playerMap[$p.id] = $displayName
    }
  }

  $target = $playerName.ToLowerInvariant()
  foreach ($entry in $lb.data.runs) {
    foreach ($p in $entry.run.players) {
      $name = if ($p.rel -eq "guest") { $p.name } else { $playerMap[$p.id] }
      if ($name -and $name.ToLowerInvariant() -eq $target) {
        return $true
      }
    }
  }

  return $false
}

# === PLAYER NAME FUNCTION ===
function Set-PlayerName {
  param($currentConfig)

  $config = Initialize-Config $currentConfig

  Clear-Host
  Write-Host (Get-LocalizedString "player_name_title") -ForegroundColor Cyan
  Write-Host ""

  $currentName = if ($config.playerName) { $config.playerName } else { (Get-LocalizedString "not_defined") }
  Write-Host "$(Get-LocalizedString 'player_name_current') $currentName" -ForegroundColor White
  Write-Host ""

  $inputResult = Read-InputWithEscape (Get-LocalizedString "player_name_prompt")
  if ($inputResult.Cancelled) {
    Clear-Host
    Write-Host (Get-LocalizedString "player_name_cancelled") -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Milliseconds 800
    return
  }

  $newName = $inputResult.Text
  $trimmedName = $newName.Trim()
  $baseCancelKeywords = @("back", "retour", "annuler", "cancel", "cancelar", "voltar", "atras")
  $languageCancelKeywords = switch ($Global:CurrentLanguage) {
    "en" { @("back", "cancel") }
    "es" { @("atras", "cancelar") }
    "pt" { @("voltar", "cancelar") }
    "zh" { @("back") }
    default { @("retour", "annuler", "back") }
  }
  $cancelKeywords = ($baseCancelKeywords + $languageCancelKeywords) | Select-Object -Unique
  $cancelKeywordsWithSlash = $cancelKeywords | ForEach-Object { "/$_" }
  $allCancelKeywords = ($cancelKeywords + $cancelKeywordsWithSlash) | Select-Object -Unique
  $normalizedInput = $trimmedName.ToLowerInvariant()
  $normalizedNoSlash = $normalizedInput.TrimStart("/", "\")

  if ($allCancelKeywords -contains $normalizedInput -or $allCancelKeywords -contains $normalizedNoSlash) {
    Clear-Host
    Write-Host (Get-LocalizedString "player_name_cancelled") -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Milliseconds 800
    return
  }

  if ([string]::IsNullOrWhiteSpace($newName)) {
    if ($config.GetType().Name -eq "PSCustomObject" -and -not ($config.PSObject.Properties.Name -contains "playerName")) {
      $config | Add-Member -MemberType NoteProperty -Name "playerName" -Value $null -Force
    } else {
      $config.playerName = $null
    }
    Clear-Host
    Write-Host (Get-LocalizedString "player_name_cleared") -ForegroundColor Yellow
  } else {
    if ($config.GetType().Name -eq "PSCustomObject" -and -not ($config.PSObject.Properties.Name -contains "playerName")) {
      $config | Add-Member -MemberType NoteProperty -Name "playerName" -Value $newName.Trim() -Force
    } else {
      $config.playerName = $trimmedName
    }
    Clear-Host
    Write-Host "$(Get-LocalizedString 'player_name_saved') $($config.playerName)" -ForegroundColor Green
    Write-Host ""
    
    # === ASK FOR COUNTRY ===
    $currentCountry = if ($config.playerCountry) { $config.playerCountry } else { "FR" }
    Write-Host "$(Get-LocalizedString 'player_country_current') $currentCountry" -ForegroundColor White
    
    while ($true) {
        Write-Host (Get-LocalizedString "player_country_prompt") -NoNewline -ForegroundColor Cyan
        $countryInput = Read-Host " "
        $countryInput = $countryInput.Trim()
        
        if ([string]::IsNullOrWhiteSpace($countryInput)) {
            # Keep existing value (or ensure default)
            if (-not ($config.playerCountry)) {
               if ($config.GetType().Name -eq "PSCustomObject") {
                  $config | Add-Member -MemberType NoteProperty -Name "playerCountry" -Value "FR" -Force
               } else {
                  $config.playerCountry = "FR"
               }
            }
            break
        } elseif ($countryInput.Length -eq 2) {
            $countryInput = $countryInput.ToUpper()
            
            # Save the value
            if ($config.GetType().Name -eq "PSCustomObject") {
               if ($config.PSObject.Properties.Name -contains "playerCountry") {
                  $config.playerCountry = $countryInput
               } else {
                  $config | Add-Member -MemberType NoteProperty -Name "playerCountry" -Value $countryInput -Force
               }
            } else {
               $config.playerCountry = $countryInput
            }
            Write-Host "$(Get-LocalizedString 'player_country_saved') $countryInput" -ForegroundColor Green
            break
        } else {
            Write-Host (Get-LocalizedString "player_country_invalid") -ForegroundColor Red
        }
    }
  }

  $jsonOutput = $config | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8

  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function Set-TemporaryRun {
  param($currentConfig)

  $config = Initialize-Config $currentConfig
  $playerName = if ($config.playerName) { $config.playerName.Trim() } else { "" }
  if ([string]::IsNullOrWhiteSpace($playerName)) {
    Clear-Host
    Write-Host (Get-LocalizedString "temp_time_no_player") -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Milliseconds 800
    return
  }

  $currentTemp = $config.temporaryRun
  $hasTempTime = ($currentTemp -and $currentTemp.active -and $currentTemp.time)
  $currentTime = if ($hasTempTime) { $currentTemp.time } else { (Get-LocalizedString "not_defined") }

  # Prepare context text with current time
  $contextText = "$(Get-LocalizedString 'temp_time_current') $currentTime"

  $actionItems = @()
  $actionItems += @{ Label = (Get-LocalizedString "temp_time_action_set"); Key = "set" }
  if ($hasTempTime) {
    $actionItems += @{ Label = (Get-LocalizedString "temp_time_action_clear"); Key = "clear" }
  }
  $actionItems += @{ Label = (Get-LocalizedString "temp_time_action_back"); Key = "back" }
  $actionOptions = $actionItems | ForEach-Object { $_.Label }
  $actionIndex = Show-ArrowMenu -Title (Get-LocalizedString "temp_time_title") -Options $actionOptions -AllowCancel -ContextText $contextText
  if ($actionIndex -eq -1) {
    return
  }

  $actionKey = $actionItems[$actionIndex].Key
  if ($actionKey -eq "back") {
    return
  }

  if ($actionKey -eq "clear") {
    $newTemp = @{ active = $false; time = $null }
    if ($config.GetType().Name -eq "PSCustomObject") {
      $config | Add-Member -MemberType NoteProperty -Name "temporaryRun" -Value $newTemp -Force
    } else {
      $config.temporaryRun = $newTemp
    }

    $jsonOutput = $config | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8

    Clear-Host
    Write-Host (Get-LocalizedString "temp_time_cleared") -ForegroundColor Yellow
    Write-Host ""
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }

  $inputResult = Read-InputWithEscape (Get-LocalizedString "temp_time_prompt")
  if ($inputResult.Cancelled) {
    Clear-Host
    Write-Host (Get-LocalizedString "temp_time_cancelled") -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Milliseconds 800
    return
  }

  $newTime = $inputResult.Text.Trim()
  $seconds = Convert-TimeStringToSeconds $newTime
  if ($null -eq $seconds) {
    Clear-Host
    Write-Host (Get-LocalizedString "temp_time_invalid") -ForegroundColor Red
    Write-Host ""
    Start-Sleep -Milliseconds 800
    return
  }

  $newTemp = @{ active = $true; time = $newTime }
  if ($config.GetType().Name -eq "PSCustomObject") {
    $config | Add-Member -MemberType NoteProperty -Name "temporaryRun" -Value $newTemp -Force
  } else {
    $config.temporaryRun = $newTemp
  }

  $jsonOutput = $config | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8

  Clear-Host
  Write-Host "$(Get-LocalizedString 'temp_time_saved') $newTime" -ForegroundColor Green
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === ARROW NAVIGATION FUNCTION ===
function Show-ArrowMenu {
  param(
    [string]$Title,
    [array]$Options,
    [int]$SelectedIndex = 0,
    [switch]$AllowCancel = $false,
    [string]$ContextText = "",
    [array]$ColoredOptions = @(),
    [array]$Descriptions = @()
  )
  
  $currentIndex = $SelectedIndex
  $maxIndex = $Options.Count - 1
  
  # Flush input buffer to prevent ghost inputs
  while ($Host.UI.RawUI.KeyAvailable) { 
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown,IncludeKeyUp") | Out-Null 
  }

  while ($true) {
    Clear-Host
    
    # Show context if provided
    if ($ContextText) {
      Write-Host $ContextText
    }
    
    if ($Title) {
      Write-Host $Title -ForegroundColor Cyan
      Write-Host ""
    }
    
    $removeLabel = Get-LocalizedString "menu_remove_category"
    $deleteLabel = Get-LocalizedString "details_delete_category"
    for ($i = 0; $i -lt $Options.Count; $i++) {
      $isRemove = $Options[$i] -eq $removeLabel -or $Options[$i] -eq $deleteLabel -or $i -in $ColoredOptions
      if ($i -eq $currentIndex) {
        $color = if ($isRemove) { "Red" } else { "Yellow" }
        Write-Host "► $($Options[$i])" -ForegroundColor $color
      } else {
        $color = if ($isRemove) { "Red" } else { "White" }
        Write-Host "  $($Options[$i])" -ForegroundColor $color
      }
    }
    
    Write-Host ""
    
    # Show description for currently selected item if available
    if ($Descriptions.Count -gt 0 -and $currentIndex -lt $Descriptions.Count -and $Descriptions[$currentIndex]) {
      Write-Host $Descriptions[$currentIndex] -ForegroundColor DarkGray
      Write-Host ""
    }
    
    if ($AllowCancel) {
      Write-Host (Get-LocalizedString "nav_instructions_cancel") -ForegroundColor Gray
    } else {
      Write-Host (Get-LocalizedString "nav_instructions") -ForegroundColor Gray
    }
    
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
    switch ($key.VirtualKeyCode) {
      38 { # Up arrow
        $currentIndex = if ($currentIndex -eq 0) { $maxIndex } else { $currentIndex - 1 }
      }
      40 { # Down arrow
        $currentIndex = if ($currentIndex -eq $maxIndex) { 0 } else { $currentIndex + 1 }
      }
      13 { # Enter
        return $currentIndex
      }
      27 { # Escape -> changed to Backspace (code 8)
        # Inactive code - see next line
      }
      8 { # Backspace
        if ($AllowCancel) {
          return -1
        }
      }
    }
  }
}

# === MAIN MENU FUNCTION ===
function Write-MainMenu {
  param($currentConfig)
  
  if ($currentConfig -and $currentConfig.categories -and $currentConfig.categories.PSObject.Properties.Count -gt 0) {
    $existingPresets = $currentConfig.categories.PSObject.Properties
    $presetList = @()
    foreach ($preset in $existingPresets) {
      $presetList += $preset
    }
    return $presetList
  } else {
    return @()
  }
}

# === SHOW PRESET DETAILS FUNCTION ===
function Write-PresetDetails($presetList, $currentConfig) {
  Clear-Host
  Write-Host (Get-LocalizedString "details_title") -ForegroundColor Cyan
  Write-Host ""
  
  if ($presetList.Count -gt 1) {
    $options = @()
    foreach ($preset in $presetList) {
      $options += "$($preset.Value.name)"
    }
    
    $selectedIndex = Show-ArrowMenu -Title (Get-LocalizedString "details_choose") -Options $options -AllowCancel
    
    if ($selectedIndex -eq -1) { return }
    $selectedPreset = $presetList[$selectedIndex]
  } else {
    $selectedPreset = $presetList[0]
  }
  
  Clear-Host
  Write-Host (Get-LocalizedString "details_title") -ForegroundColor Cyan
  Write-Host "$(Get-LocalizedString 'details_name') $($selectedPreset.Value.name)" -ForegroundColor White
  Write-Host "$(Get-LocalizedString 'details_category_id') $($selectedPreset.Name)" -ForegroundColor Cyan
  Write-Host "$(Get-LocalizedString 'details_game_id') $($selectedPreset.Value.gameId)" -ForegroundColor Cyan
  Write-Host "$(Get-LocalizedString 'details_category') $($selectedPreset.Value.category)" -ForegroundColor Cyan
  $subcat = if ($selectedPreset.Value.subcategory) { $selectedPreset.Value.subcategory } else { (Get-LocalizedString "null_value") }
  Write-Host "$(Get-LocalizedString 'details_subcategory') $subcat" -ForegroundColor Cyan
  $isActive = if ($currentConfig.activeCategory -eq $selectedPreset.Name) { (Get-LocalizedString "yes") } else { (Get-LocalizedString "no") }
  Write-Host "$(Get-LocalizedString 'details_active_obs') $isActive" -ForegroundColor $(if ($isActive -eq (Get-LocalizedString "yes")) { "Green" } else { "Yellow" })
  $actionOptions = @(
    (Get-LocalizedString "details_edit_name"),
    (Get-LocalizedString "details_delete_category"),
    (Get-LocalizedString "details_back")
  )
  $actionContext = "$(Get-LocalizedString 'details_name') $($selectedPreset.Value.name)"
  $actionIndex = Show-ArrowMenu -Title (Get-LocalizedString "details_actions") -Options $actionOptions -AllowCancel -ContextText $actionContext -ColoredOptions @(1)
  if ($actionIndex -eq -1 -or $actionIndex -eq 2) {
    return
  }

  if ($actionIndex -eq 0) {
    # Edit name
    $inputResult = Read-InputWithEscape (Get-LocalizedString "details_edit_prompt")
    if ($inputResult.Cancelled) {
      Clear-Host
      Write-Host (Get-LocalizedString "details_edit_cancelled") -ForegroundColor Yellow
      Write-Host ""
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }

    $newName = $inputResult.Text
    if ([string]::IsNullOrWhiteSpace($newName)) {
      Clear-Host
      Write-Host (Get-LocalizedString "details_edit_empty") -ForegroundColor Red
      Write-Host ""
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }

    $trimmedName = $newName.Trim()
    $presetId = $selectedPreset.Name
    if ($currentConfig.categories.GetType().Name -eq "PSCustomObject") {
      if ($currentConfig.categories.$presetId.PSObject.Properties.Name -contains "name") {
        $currentConfig.categories.$presetId.name = $trimmedName
      } else {
        $currentConfig.categories.$presetId | Add-Member -MemberType NoteProperty -Name "name" -Value $trimmedName -Force
      }
    } else {
      $currentConfig.categories[$presetId].name = $trimmedName
    }

    $selectedPreset.Value.name = $trimmedName
    $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8

    Clear-Host
    Write-Host "$(Get-LocalizedString 'details_edit_saved') $trimmedName" -ForegroundColor Green
    Write-Host ""
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }

  if ($actionIndex -eq 1) {
    # Delete preset
    Remove-PresetSingle $selectedPreset $currentConfig
    return
  }
}

# === CHANGE ACTIVE PRESET FUNCTION ===
function Update-ActivePreset($presetList, $currentConfig) {
  $currentConfig = Initialize-Config $currentConfig

  Clear-Host
  Write-Host (Get-LocalizedString "change_active_title") -ForegroundColor Cyan
  Write-Host ""
  
  $options = @()
  foreach ($preset in $presetList) {
    $isActive = if ($preset.Name -eq $currentConfig.activePreset) { " [ACTIF]" } else { "" }
    $options += "$($preset.Value.name)$isActive"
  }
  
  $selectedIndex = Show-ArrowMenu -Title (Get-LocalizedString "change_active_available") -Options $options -AllowCancel
  
  if ($selectedIndex -eq -1) { return }
  
  $newActivePreset = $presetList[$selectedIndex]
  $currentConfig.activeCategory = $newActivePreset.Name

  $tempDisabled = $false
  $playerNameValue = if ($currentConfig.playerName) { $currentConfig.playerName.Trim() } else { "" }
  $tempRun = $currentConfig.temporaryRun
  if (-not [string]::IsNullOrWhiteSpace($playerNameValue) -and $tempRun -and $tempRun.active -and $tempRun.time) {
    try {
      Show-ProgressStep -Activity (Get-LocalizedString "temp_time_check_title") -Status (Get-LocalizedString "temp_time_check_status") -PercentComplete 60
      $exists = Test-PlayerInCategory $currentConfig $newActivePreset.Value
      Clear-Progress
      if (-not $exists) {
        $currentConfig.temporaryRun.active = $false
        $currentConfig.temporaryRun.time = $null
        $tempDisabled = $true
      }
    } catch {
      Clear-Progress
    }
  }
  
  # Save
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host "$(Get-LocalizedString 'change_active_changed') $($newActivePreset.Value.name)" -ForegroundColor Green
  Write-Host (Get-LocalizedString "change_active_obs_info") -ForegroundColor Green
  if ($tempDisabled) {
    Write-Host (Get-LocalizedString "temp_time_disabled") -ForegroundColor Yellow
  }
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === REMOVE SINGLE PRESET FUNCTION (from details) ===
function Remove-PresetSingle($selectedPreset, $currentConfig) {
  # Check if there's only one preset left
  $presetCount = 0
  foreach ($preset in $currentConfig.categories.PSObject.Properties) {
    $presetCount++
  }
  
  if ($presetCount -eq 1) {
    Clear-Host
    Write-Host (Get-LocalizedString "remove_impossible_title") -ForegroundColor Red
    Write-Host ""
    Write-Host (Get-LocalizedString "remove_impossible_last") -ForegroundColor Red
    Write-Host (Get-LocalizedString "remove_impossible_rule") -ForegroundColor Cyan
    Write-Host ""
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }

  Clear-Host
  Write-Host (Get-LocalizedString "remove_warning") -ForegroundColor Red
  Write-Host "$($selectedPreset.Value.name)" -ForegroundColor Cyan
  Write-Host ""
  
  # Immediate deletion without confirmation
  
  # Delete the preset
  $deletedPresetId = $selectedPreset.Name
  $currentConfig.categories.PSObject.Properties.Remove($deletedPresetId)
  
  # Handle the case where the deleted preset was active
  if ($currentConfig.activeCategory -eq $deletedPresetId) {
    $remainingPresets = $currentConfig.categories.PSObject.Properties
    if ($remainingPresets.Count -gt 1) {
      # Multiple presets remaining: ask the user to choose
      $newOptions = @()
      $newPresetList = @()
      foreach ($preset in $remainingPresets) {
        $newOptions += "$($preset.Value.name)"
        $newPresetList += $preset
      }
      
      $newActiveIndex = Show-ArrowMenu -Title (Get-LocalizedString "remove_active_deleted") -Options $newOptions
      $currentConfig.activeCategory = $newPresetList[$newActiveIndex].Name
    } elseif ($remainingPresets.Count -eq 1) {
      # One preset remaining: activate automatically
      $currentConfig.activeCategory = $remainingPresets[0].Name
    } else {
      $currentConfig.activeCategory = $null
    }
  }
  
  # Save
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host (Get-LocalizedString "remove_success" -f $selectedPreset.Value.name) -ForegroundColor Green
  if ($currentConfig.activeCategory) {
    $newActiveName = $currentConfig.categories.($currentConfig.activeCategory).name
    Write-Host "$(Get-LocalizedString 'remove_new_active') $newActiveName" -ForegroundColor Cyan
  }
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === REMOVE PRESET FUNCTION ===
function Remove-Preset($presetList, $currentConfig) {
  Clear-Host
  
  if ($presetList.Count -eq 1) {
    Write-Host (Get-LocalizedString "remove_impossible_title") -ForegroundColor Red
    Write-Host ""
    Write-Host (Get-LocalizedString "remove_impossible_last") -ForegroundColor Red
    Write-Host (Get-LocalizedString "remove_impossible_rule") -ForegroundColor Cyan
    Write-Host ""
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }
  
  Write-Host (Get-LocalizedString "remove_title") -ForegroundColor Red
  Write-Host ""
  
  $options = @()
  foreach ($preset in $presetList) {
    $isActive = if ($preset.Name -eq $currentConfig.activePreset) { " [ACTIF]" } else { "" }
    $options += "$($preset.Value.name)$isActive"
  }
  
  $selectedIndex = Show-ArrowMenu -Title (Get-LocalizedString "change_active_available") -Options $options -AllowCancel
  
  if ($selectedIndex -eq -1) {
    Write-Host (Get-LocalizedString "remove_cancelled") -ForegroundColor Cyan
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }
  
  $presetToDelete = $presetList[$selectedIndex]
  
  Clear-Host
  Write-Host (Get-LocalizedString "remove_warning") -ForegroundColor Red
  Write-Host "$($presetToDelete.Value.name)" -ForegroundColor Cyan
  Write-Host ""
  
  # Immediate deletion without confirmation
  
  # Delete the preset
  $deletedPresetId = $presetToDelete.Name
  $currentConfig.categories.PSObject.Properties.Remove($deletedPresetId)
  
  # Handle the case where the deleted preset was active
  if ($currentConfig.activeCategory -eq $deletedPresetId) {
    $remainingPresets = $currentConfig.categories.PSObject.Properties
    if ($remainingPresets.Count -gt 1) {
      # Multiple presets remaining: ask the user to choose
      $newOptions = @()
      $newPresetList = @()
      foreach ($preset in $remainingPresets) {
        $newOptions += "$($preset.Value.name)"
        $newPresetList += $preset
      }
      
      $newActiveIndex = Show-ArrowMenu -Title (Get-LocalizedString "remove_active_deleted") -Options $newOptions
      $currentConfig.activeCategory = $newPresetList[$newActiveIndex].Name
    } elseif ($remainingPresets.Count -eq 1) {
      # One preset remaining: activate automatically
      $currentConfig.activeCategory = $remainingPresets[0].Name
    } else {
      $currentConfig.activeCategory = $null
    }
  }
  
  # Save
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host (Get-LocalizedString "remove_success" -f $presetToDelete.Value.name) -ForegroundColor Green
  if ($currentConfig.activeCategory) {
    $newActiveName = $currentConfig.categories.($currentConfig.activeCategory).name
    Write-Host "$(Get-LocalizedString 'remove_new_active') $newActiveName" -ForegroundColor Cyan
  }
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === ADD NEW PRESET FUNCTION ===
function New-Preset($currentConfig) {
  :GameNameLoop while ($true) {
    Clear-Host
    Write-Host (Get-LocalizedString "add_title") -ForegroundColor Green
    Write-Host ""
    Write-Host (Get-LocalizedString "add_game_name_hint") -ForegroundColor Gray
    Write-Host ""

    $gameInput = Read-InputWithEscape (Get-LocalizedString "add_game_name")
    if ($gameInput.Cancelled) {
      Write-Host (Get-LocalizedString "cancelled") -ForegroundColor Cyan
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }

    $gameName = $gameInput.Text

    if ([string]::IsNullOrWhiteSpace($gameName)) {
      Write-Host (Get-LocalizedString "add_error_empty_name") -ForegroundColor Red
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      continue
    }

    Show-ProgressStep -Activity (Get-LocalizedString "add_searching") -Status $gameName -PercentComplete 10
    Start-Sleep -Milliseconds 50

    $completed = $false
    try {
    # === STEP 1: Search for the game ===
    $response = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games?name=$([System.Web.HttpUtility]::UrlEncode($gameName))" -TimeoutSec 10
    $data = $response.Content | ConvertFrom-Json
    
    $games = $data.data
    
    if ($games.Count -eq 0) {
      Clear-Progress
      Write-Host "$(Get-LocalizedString 'add_no_game_found') $gameName" -ForegroundColor Red
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      continue GameNameLoop
    }
    
    Clear-Progress

    $selectedGame = $null
    $selectedLevel = $null

    :GameLoop while ($true) {
      # Game selection
      if ($games.Count -gt 1) {
        $gameOptions = @()
        foreach ($game in $games) {
          $releaseYear = if ($game.released) { " ($($game.released))" } else { "" }
          $gameOptions += "$($game.names.international)$releaseYear"
        }
        
        $selectedGameIndex = Show-ArrowMenu -Title (Get-LocalizedString "add_games_found") -Options $gameOptions -AllowCancel
        
        if ($selectedGameIndex -eq -1) {
          Clear-Progress
          continue GameNameLoop
        }
        
        $selectedGame = $games[$selectedGameIndex]
      } else {
        $selectedGame = $games[0]
      }

      Show-ProgressStep -Activity (Get-LocalizedString "add_loading_categories") -Status $selectedGame.names.international -PercentComplete 40
      Start-Sleep -Milliseconds 50
      
      # Fetch categories first to determine what types are available
      $categoriesResponse = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games/$($selectedGame.id)?embed=categories.variables" -TimeoutSec 10
      $categoriesData = $categoriesResponse.Content | ConvertFrom-Json
      $allCategories = $categoriesData.data.categories.data
      
      # Check if game has per-level categories
      $hasPerLevelCategories = ($allCategories | Where-Object { $_.type -eq "per-level" }).Count -gt 0
      
      Clear-Progress
      
      # === STEP 2: Full game or levels ===
      $selectedLevel = $null
      $levels = @()
      
      # Only fetch and show levels if game actually has per-level categories
      if ($hasPerLevelCategories) {
        Show-ProgressStep -Activity (Get-LocalizedString "add_loading_levels") -Status $selectedGame.names.international -PercentComplete 50
        Start-Sleep -Milliseconds 50
        
        try {
          $levelsResponse = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games/$($selectedGame.id)/levels" -TimeoutSec 10
          $levelsData = $levelsResponse.Content | ConvertFrom-Json
          $levels = $levelsData.data
        } catch {
          $levels = @()
        }
        
        Clear-Progress
      }

      :ModeCategoryLoop while ($true) {
        $selectedLevel = $null
        
        # Only show prompt if game has both levels AND per-level categories
        if ($levels.Count -gt 0 -and $hasPerLevelCategories) {
          while ($true) {
            $modeTitle = switch ($Global:CurrentLanguage) {
              "en" { "Choose leaderboard type:" }
              "es" { "Elige el tipo de leaderboard:" }
              "pt" { "Escolha o tipo de leaderboard:" }
              "zh" { "选择排行榜类型：" }
              default { "Choisissez le type de leaderboard :" }
            }
            $modeOptions = switch ($Global:CurrentLanguage) {
              "en" { @("Full game", "Levels") }
              "es" { @("Juego completo", "Niveles") }
              "pt" { @("Jogo completo", "Niveis") }
              "zh" { @("完整游戏", "关卡") }
              default { @("Full game", "Niveaux") }
            }

            $selectedMode = Show-ArrowMenu -Title $modeTitle -Options $modeOptions -AllowCancel
            if ($selectedMode -eq -1) {
              Clear-Progress
              continue GameLoop
            }

            if ($selectedMode -eq 1) {
              $levelOptions = @()
              foreach ($level in $levels) {
                $levelOptions += $level.name
              }
              $levelTitle = switch ($Global:CurrentLanguage) {
                "en" { "Select a level:" }
                "es" { "Selecciona un nivel:" }
                "pt" { "Selecione um nivel:" }
                "zh" { "选择一个关卡：" }
                default { "Selectionnez un niveau :" }
              }
              $selectedLevelIndex = Show-ArrowMenu -Title $levelTitle -Options $levelOptions -AllowCancel
              if ($selectedLevelIndex -eq -1) {
                Clear-Progress
                continue
              }
              $selectedLevel = $levels[$selectedLevelIndex]
            }
            break
          }
        }

        # === STEP 3: Filter categories by type ===
        $categoryType = if ($selectedLevel) { "per-level" } else { "per-game" }
        $categories = $allCategories | Where-Object { $_.type -eq $categoryType }
        
        Clear-Progress

        if ($categories.Count -eq 0) {
          Write-Host (Get-LocalizedString "add_no_categories") -ForegroundColor Red
          Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
          $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
          return
        }
        
        :CategoryLoop while ($true) {
          # Category selection
          $categoryOptions = @()
          foreach ($category in $categories) {
            $categoryOptions += $category.name
          }
          
          $selectedCategoryIndex = Show-ArrowMenu -Title (Get-LocalizedString "add_categories_available") -Options $categoryOptions -AllowCancel
          if ($selectedCategoryIndex -eq -1) {
            if ($levels.Count -gt 0) {
              continue ModeCategoryLoop
            }
            continue GameLoop
          }
          $selectedCategory = $categories[$selectedCategoryIndex]
          
          # === STEP 3: Handle subcategories (all) ===
          $selectedSubcategoryLabels = @()  # Human-readable display
          $selectedSubcategories = @()      # IDs for the API
          
          $subcategoryVariables = @()
          try {
            $varsResponse = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/categories/$($selectedCategory.id)/variables" -TimeoutSec 10
            $varsData = $varsResponse.Content | ConvertFrom-Json
            $subcategoryVariables = $varsData.data
          } catch {
            $subcategoryVariables = $selectedCategory.variables.data
          }
          if (-not $subcategoryVariables) { $subcategoryVariables = @() }

          $allowedVarIds = @{}
          if ($selectedCategory.variables -and $selectedCategory.variables.data) {
            foreach ($var in $selectedCategory.variables.data) {
              if ($var.id) { $allowedVarIds[$var.id] = $true }
            }
          }

          $subcategoryVariables = $subcategoryVariables | Where-Object { $_.'is-subcategory' -eq $true -and $_.values.values }

          $categoryNameSet = @{}
          foreach ($catItem in $categories) {
            if ($catItem.name) {
              $categoryNameSet[$catItem.name.ToLowerInvariant()] = $true
            }
          }

          if ($allowedVarIds.Count -gt 0) {
            $subcategoryVariables = $subcategoryVariables | Where-Object { $_.id -and $allowedVarIds.ContainsKey($_.id) }
          } else {
            # Filter irrelevant variables (category)
            $subcategoryVariables = $subcategoryVariables | Where-Object {
              (-not $_.category) -or ($_.category -eq $selectedCategory.id)
            }
          }

          # Filter irrelevant variables (scope)
          $subcategoryVariables = $subcategoryVariables | Where-Object {
            if (-not $_.scope -or -not $_.scope.type) { return $true }
            if ($selectedLevel) {
              if ($_.scope.type -eq "all-levels") { return $true }
              if ($_.scope.type -eq "single-level") { return $_.scope.level -eq $selectedLevel.id }
              if ($_.scope.type -eq "global") { return $true }
              return $false
            }
            return $_.scope.type -in @("full-game", "all-levels", "global")
          }

          # Ignore global variables that only select a category
          if ($categoryNameSet.Count -gt 0) {
            $subcategoryVariables = $subcategoryVariables | Where-Object {
              if ($_.category) { return $true }
              $valueLabels = @()
              if ($_.values -and $_.values.values) {
                $valueLabels = $_.values.values.PSObject.Properties | ForEach-Object { $_.Value.label }
              }
              if (-not $valueLabels -or $valueLabels.Count -eq 0) { return $true }
              foreach ($label in $valueLabels) {
                if (-not $categoryNameSet.ContainsKey($label.ToLowerInvariant())) {
                  return $true
                }
              }
              return $false
            }
          }

          # De-dup by label and keep the variable with the largest value set
          # Do not deduplicate; present all subcategory variables in the order provided by the API
          # This allows for chained filters like 'Moon Berry' after 'All Red Berries+Heart'
          # $subcategoryVariables is already in correct order
          
          $restartCategorySelection = $false
          if ($subcategoryVariables.Count -gt 0) {
            # Iterate over all subcategory variables
            foreach ($subcatVariable in $subcategoryVariables) {
              $varName = $subcatVariable.name
              $subcatValues = $subcatVariable.values.values.PSObject.Properties
              
              # Build options for this variable
              $subcatOptions = @()
              $subcatArray = @()
              
              # "Any" option (skip this variable)
              $anyLabel = switch ($Global:CurrentLanguage) {
                "en" { "Any (skip this filter)" }
                "es" { "Cualquiera (omitir este filtro)" }
                "pt" { "Qualquer (pular este filtro)" }
                "zh" { "任意（跳过此过滤器）" }
                default { "Any (ignorer ce filtre)" }
              }
              $subcatOptions += $anyLabel
              
              foreach ($value in $subcatValues) {
                $subcatOptions += $value.Value.label
                $subcatArray += @{
                  id = $value.Name
                  label = $value.Value.label
                }
              }

              $subcatOptions += (Get-LocalizedString "details_back")
              
              # Show the menu for this specific variable
              $menuTitle = switch ($Global:CurrentLanguage) {
                "en" { "$varName - Select value:" }
                "es" { "$varName - Selecciona valor:" }
                "pt" { "$varName - Selecione valor:" }
                "zh" { "$varName - 选择值：" }
                default { "$varName - Sélectionnez la valeur :" }
              }
              
              $selectedSubcatIndex = Show-ArrowMenu -Title $menuTitle -Options $subcatOptions -AllowCancel
              
              # Backspace/Esc -> return to category selection (like "Back")
              if ($selectedSubcatIndex -eq -1) {
                $restartCategorySelection = $true
                break
              }

              # Return to category selection
              if ($selectedSubcatIndex -eq ($subcatOptions.Count - 1)) {
                $restartCategorySelection = $true
                break
              }
              
              # If the user selects a value (not "Any")
              if ($selectedSubcatIndex -gt 0) {
                $selectedEntry = $subcatArray[$selectedSubcatIndex - 1]
                $selectedSubcategoryLabels += $selectedEntry.label
                $selectedSubcategories += [PSCustomObject]@{
                  variableId = $subcatVariable.id
                  valueId = $selectedEntry.id
                  label = $selectedEntry.label
                }
                # If this value is a terminal/leaf (no further subcategory variables should be prompted), break
                # For Celeste, after selecting 'All Red Berries+Heart', 'Full Clear', or 'Heart+Cassette', stop prompting for more
                if ($selectedEntry.label -match 'All Red Berries\+Heart|Full Clear|Heart\+Cassette') {
                  break
                }
              }
            }
          }

          if ($restartCategorySelection) {
            continue CategoryLoop
          }
          break GameLoop
        }
      }
    }
    
    # Combine all selected subcategories into one string
    $selectedSubcategoryLabel = if ($selectedSubcategoryLabels.Count -gt 0) {
      $selectedSubcategoryLabels -join " - "
    } else {
      (Get-LocalizedString "null_value")
    }
    
    # === STEP 4: Preset ID and save ===
    Write-Host ""
    Write-Host (Get-LocalizedString "final_config") -ForegroundColor Green
    Write-Host ""
    Write-Host "$(Get-LocalizedString 'final_game') $($selectedGame.names.international)" -ForegroundColor White
    Write-Host "$(Get-LocalizedString 'final_game_id') $($selectedGame.id)" -ForegroundColor Cyan
    if ($selectedLevel) {
      $levelLabel = switch ($Global:CurrentLanguage) {
        "en" { "Level" }
        "es" { "Nivel" }
        "pt" { "Nivel" }
        "zh" { "关卡" }
        default { "Niveau" }
      }
      Write-Host "$levelLabel : $($selectedLevel.name)" -ForegroundColor Cyan
    }
    Write-Host "$(Get-LocalizedString 'final_category') $($selectedCategory.name)" -ForegroundColor Cyan
    Write-Host "$(Get-LocalizedString 'final_subcategory') $selectedSubcategoryLabel" -ForegroundColor Cyan
    Write-Host ""
    
    # Generate full name with subcategory if it exists
    $fullName = if ($selectedSubcategoryLabel -eq (Get-LocalizedString "null_value")) {
      if ($selectedLevel) {
        "$($selectedGame.names.international) - $($selectedLevel.name) - $($selectedCategory.name)"
      } else {
        "$($selectedGame.names.international) - $($selectedCategory.name)"
      }
    } else {
      if ($selectedLevel) {
        "$($selectedGame.names.international) - $($selectedLevel.name) - $($selectedCategory.name) $selectedSubcategoryLabel"
      } else {
        "$($selectedGame.names.international) - $($selectedCategory.name) $selectedSubcategoryLabel"
      }
    }
    
    # Preset ID suggestions
    $cleanGame = $selectedGame.names.international -replace '[^a-zA-Z0-9]', ''
    $gamePart = if ($cleanGame.Length -ge 4) { $cleanGame.Substring(0, 4) } else { $cleanGame }
    $catPart = $selectedCategory.name -replace '[^a-zA-Z0-9]', ''
    $subcatPart = if ($selectedSubcategoryLabel -ne (Get-LocalizedString "null_value")) {
      $selectedSubcategoryLabel -replace '[^a-zA-Z0-9]', ''
    } else { "" }
    $levelPart = if ($selectedLevel) { $selectedLevel.name -replace '[^a-zA-Z0-9]', '' } else { "" }

    $idParts = @($gamePart, $catPart, $levelPart, $subcatPart) | Where-Object { $_ -and $_.Length -gt 0 }
    $defaultPresetId = ($idParts -join "-").ToLower() -replace '--+', '-'
    
    Write-Host (Get-LocalizedString "final_category_id") -ForegroundColor Yellow
    Write-Host "$(Get-LocalizedString 'final_suggestion') $defaultPresetId" -ForegroundColor Gray
    $presetId = Read-Host (Get-LocalizedString "final_category_id_prompt")
    
    if ([string]::IsNullOrWhiteSpace($presetId)) {
      $presetId = $defaultPresetId
    }
    
    # Check that the ID does not already exist
    if ($currentConfig -and $currentConfig.categories -and $currentConfig.categories.$presetId) {
      Write-Host (Get-LocalizedString "final_id_exists" -f $presetId) -ForegroundColor Red
      $overwritePrompt = switch ($Global:CurrentLanguage) {
        "en" { "Do you want to overwrite it? (y/N)" }
        "es" { "¿Quieres sobrescribirlo? (s/N)" }
        "pt" { "Você quer sobrescrever? (s/N)" }
        "zh" { "您要覆盖它吗？（y/N)" }
        default { "Voulez-vous l'écraser ? (o/N)" }
      }
      $expectedAnswer = switch ($Global:CurrentLanguage) {
        "en" { "y" }
        "es" { "s" }
        "pt" { "s" }
        "zh" { "y" }
        default { "o" }
      }
      $overwrite = Read-Host $overwritePrompt
      if ($overwrite.ToLower() -ne $expectedAnswer) {
        Write-Host (Get-LocalizedString "final_operation_cancelled") -ForegroundColor Cyan
        Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
        $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
        return
      }
    }
    
    # Prepare the preset object
    $subcatValue = if ($selectedSubcategoryLabel -eq (Get-LocalizedString "null_value")) { $null } else { $selectedSubcategoryLabel }
    $subcatSelections = if ($selectedSubcategories.Count -gt 0) { @($selectedSubcategories) } else { $null }
    
    $newPreset = @{
      name = $fullName
      gameId = $selectedGame.id
      category = $selectedCategory.name
      subcategory = $subcatValue
    }
    if ($selectedLevel) {
      $newPreset.levelId = $selectedLevel.id
      $newPreset.levelName = $selectedLevel.name
    }
    if ($subcatSelections) {
      $newPreset.subcategories = $subcatSelections
    }
    
    # Load or create the settings
    $config = Initialize-Config $currentConfig

    $tempDisabled = $false
    $playerNameValue = if ($config.playerName) { $config.playerName.Trim() } else { "" }
    $tempRun = $config.temporaryRun
    if (-not [string]::IsNullOrWhiteSpace($playerNameValue) -and $tempRun -and $tempRun.active -and $tempRun.time) {
      try {
        Show-ProgressStep -Activity (Get-LocalizedString "temp_time_check_title") -Status (Get-LocalizedString "temp_time_check_status") -PercentComplete 60
        $exists = Test-PlayerInCategory $config $newPreset
        Clear-Progress
        if (-not $exists) {
          $config.temporaryRun.active = $false
          $config.temporaryRun.time = $null
          $tempDisabled = $true
        }
      } catch {
        Clear-Progress
      }
    }
    
    # Add the new preset
    # If it's a PSCustomObject (loaded from JSON), use Add-Member
    if ($config.categories.GetType().Name -eq "PSCustomObject") {
      $config.categories | Add-Member -MemberType NoteProperty -Name $presetId -Value $newPreset -Force
    } else {
      # If it's a hashtable (new settings), use normal assignment
      $config.categories.$presetId = $newPreset
    }
    
    # Ask whether to activate it (or auto-activate if first)
    $isFirstPreset = $config.categories.Count -eq 1 -or -not $config.activeCategory
    
    if ($isFirstPreset) {
      $config.activeCategory = $presetId
      $activationMessage = (Get-LocalizedString "final_auto_active")
    } else {
      Write-Host ""
      $activatePrompt = switch ($Global:CurrentLanguage) {
        "en" { "Do you want to activate this preset now? (y/N)" }
        "es" { "¿Quieres activar este preset ahora? (s/N)" }
        "pt" { "Você quer ativar este preset agora? (s/N)" }
        "zh" { "您现在要激活此预设吗？（y/N)" }
        default { "Voulez-vous activer ce preset maintenant ? (o/N)" }
      }
      $expectedAnswer = switch ($Global:CurrentLanguage) {
        "en" { "y" }
        "es" { "s" }
        "pt" { "s" }
        "zh" { "y" }
        default { "o" }
      }
      $activate = Read-Host $activatePrompt
      if ($activate.ToLower() -eq $expectedAnswer) {
        $config.activeCategory = $presetId
        $activationMessage = (Get-LocalizedString "final_active_now")
      } else {
        $activationMessage = (Get-LocalizedString "final_saved_inactive")
      }
    }
    
    # Save
    $jsonOutput = $config | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8
    
    Write-Host ""
    Write-Host (Get-LocalizedString "final_saved" -f $presetId) -ForegroundColor Green
    Write-Host "$(Get-LocalizedString 'final_status') $activationMessage" -ForegroundColor Cyan
    if ($tempDisabled) {
      Write-Host (Get-LocalizedString "temp_time_disabled") -ForegroundColor Yellow
    }
    
    if ($config.activeCategory -eq $presetId) {
      Write-Host (Get-LocalizedString "final_obs_will_show") -ForegroundColor Green
    } else {
      Write-Host (Get-LocalizedString "final_activate_later") -ForegroundColor Cyan
    }
    Write-Host ""
    $completed = $true
  } catch {
    Clear-Progress
    Write-Host ""
    Write-Host "$(Get-LocalizedString 'error_general') $_" -ForegroundColor Red
  }
  
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    if ($completed) {
      return
    }
  }
}

# === MAIN FUNCTION ===
function Start-MainLoop {
  $mainMenuIndex = 0
  while ($true) {
    try {
      # === LOAD EXISTING PRESETS ===
      if (-not (Test-Path "config.json")) {
        $Global:DefaultConfigJSON | Set-Content "config.json" -Encoding UTF8
      }

      $configExists = Test-Path "config.json"
      $currentConfig = $null
      
      if ($configExists) {
        $configContent = Get-Content "config.json" -Raw | ConvertFrom-Json
        $currentConfig = $configContent
      }
      
      # === INITIALIZE SETTINGS (adds missing properties) ===
      $currentConfig = Initialize-Config $currentConfig
      
      # === INITIALIZE LANGUAGE ===
      $Global:CurrentLanguage = "fr" # Default
      if ($currentConfig -and $currentConfig.language) {
        $Global:CurrentLanguage = $currentConfig.language
      }
      
      $presetList = Write-MainMenu $currentConfig
      
      if ($presetList.Count -gt 0) {
        # Prepare context to display above the menu
        $contextLines = @()
        $contextLines += "================================================"
        $contextLines += "  $(Get-LocalizedString 'menu_title')"
        $contextLines += "================================================"
        $contextLines += ""
        $contextLines += "$(Get-LocalizedString 'existing_categories')"
        $contextLines += ""
        
        foreach ($preset in $presetList) {
          $marker = if ($preset.Name -eq $currentConfig.activeCategory) { "🟢 " } else { "   " }
          $contextLines += "$marker$($preset.Value.name)"
        }
        $contextLines += ""
        
        $contextText = $contextLines -join "`n"
        
        $menuItems = @()
        $menuItems += @{ Label = (Get-LocalizedString "menu_add_category"); Action = { param($cfg) New-Preset $cfg } }
        $menuItems += @{ Label = (Get-LocalizedString "menu_view_details"); Action = { param($cfg) Write-PresetDetails $presetList $cfg } }
        $menuItems += @{ Label = (Get-LocalizedString "menu_change_active"); Action = { param($cfg) Update-ActivePreset $presetList $cfg } }

        $playerNameValue = if ($currentConfig -and $currentConfig.playerName) { $currentConfig.playerName.Trim() } else { "" }
        if (-not [string]::IsNullOrWhiteSpace($playerNameValue)) {
          $menuItems += @{ Label = (Get-LocalizedString "menu_temp_time"); Action = { param($cfg) Set-TemporaryRun $cfg } }
        }

        $menuItems += @{ Label = (Get-LocalizedString "menu_player_name"); Action = { param($cfg) Set-PlayerName $cfg } }
        $menuItems += @{ Label = (Get-LocalizedString "menu_parameters"); Action = { param($cfg) Set-Parameters $cfg } }
        $menuItems += @{ Label = (Get-LocalizedString "menu_quit"); Action = { param($cfg) "__QUIT__" } }

        $menuOptions = $menuItems | ForEach-Object { $_.Label }
        if ($mainMenuIndex -lt 0 -or $mainMenuIndex -ge $menuOptions.Count) {
          $mainMenuIndex = 0
        }
        $selectedOption = Show-ArrowMenu -Title (Get-LocalizedString "menu_what_to_do") -Options $menuOptions -ContextText $contextText -SelectedIndex $mainMenuIndex
        $mainMenuIndex = $selectedOption

        $actionResult = & $menuItems[$selectedOption].Action $currentConfig
        if ($actionResult -eq "__QUIT__") {
          Clear-Host
          Write-Host (Get-LocalizedString "goodbye") -ForegroundColor Green
          return
        }
      } else {
        # First category - direct display
        Clear-Host
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host "  $(Get-LocalizedString 'menu_title')" -ForegroundColor Cyan
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host (Get-LocalizedString "first_launch_no_category") -ForegroundColor Yellow
        Write-Host ""
        New-Preset $currentConfig
      }
    } catch {
      Write-Host ""
      Write-Host "$(Get-LocalizedString 'config_load_error') $_" -ForegroundColor Red
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    }
  }
}

# === PROGRAM START ===
try {
  Start-MainLoop
} catch {
  Write-Host ""
  Write-Host "$(Get-LocalizedString 'critical_error') $_" -ForegroundColor Red
  Write-Host ""
  Write-Host (Get-LocalizedString "close_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# Keep console open on exit
Write-Host ""
Write-Host (Get-LocalizedString "close_key") -ForegroundColor Gray
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
