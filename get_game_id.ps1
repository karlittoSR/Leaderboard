# Script PowerShell pour gérer les presets speedrun.com facilement
# Gère plusieurs jeux et categories pour streamers
# Version 1.1.0 - Support multilingue (FR/EN) + Navigation par flèches et affichage persistant des presets
# Par karlitto__

# === DICTIONNAIRE DE LANGUES ===
$Global:Languages = @{
    fr = @{
        # Menu principal
        menu_title = "Gestionnaire de presets SRC by karlitto__"
        menu_add_preset = "Ajouter un nouveau preset"
        menu_view_details = "Voir les détails d'un preset existant"
        menu_change_active = "Changer le preset actif"
        menu_remove_preset = "Supprimer un preset"
        menu_language_settings = "Paramètres de langue"
        menu_quit = "Quitter le programme"
        menu_what_to_do = "Que voulez-vous faire ?"
        
        # Navigation
        nav_instructions = "Utilisez flèches HAUT/BAS pour naviguer, Entrée pour sélectionner"
        nav_instructions_cancel = "Utilisez flèches HAUT/BAS pour naviguer, Entrée pour sélectionner, Backspace pour annuler"
        
        # Presets existants
        existing_presets = "Presets existants :"
        active_preset = "Preset actuellement actif :"
        not_defined = "Non défini"
        
        # Détails preset
        details_title = "=== DETAILS D'UN PRESET ==="
        details_choose = "Choisissez un preset à voir :"
        details_name = "Nom :"
        details_preset_id = "Preset ID :"
        details_game_id = "Game ID :"
        details_category = "Category :"
        details_subcategory = "Subcategory :"
        details_active_obs = "Actif dans OBS :"
        details_url_obs = "URL OBS (toujours la même) :"
        
        # Messages communs
        continue_key = "Appuyez sur une touche pour continuer..."
        yes = "OUI"
        no = "NON"
        null_value = "null"
        cancelled = "Annulé."
        success = "[OK]"
        
        # Nouveau preset
        add_title = "=== AJOUT D'UN NOUVEAU PRESET ==="
        add_game_name = "Nom du jeu"
        add_error_empty_name = "Erreur : Vous devez entrer un nom de jeu!"
        add_searching = "Recherche en cours pour :"
        add_no_game_found = "Aucun jeu trouvé pour :"
        add_games_found = "Jeux trouvés :"
        add_loading_categories = "Chargement des catégories..."
        add_no_categories = "Aucune catégorie trouvée pour ce jeu!"
        add_categories_available = "Catégories disponibles :"
        add_subcategories_available = "Sous-catégories disponibles :"
        add_no_subcategory = "Aucune sous-catégorie (null)"
        
        # Configuration finale
        final_config = "========================================\n           CONFIGURATION FINALE\n========================================"
        final_game = "Jeu      :"
        final_game_id = "Game ID  :"
        final_category = "Category :"
        final_subcategory = "Subcategory :"
        final_preset_id = "Entrez un ID unique pour ce preset :"
        final_suggestion = "Suggestion :"
        final_preset_id_prompt = "ID du preset (ou Entrée pour suggestion)"
        final_id_exists = "ATTENTION : Un preset avec l'ID '%s' existe déjà !"
        final_overwrite = "Voulez-vous l'écraser ? (o/N)"
        final_operation_cancelled = "Opération annulée."
        final_activate_now = "Voulez-vous activer ce preset maintenant ? (o/N)"
        final_saved = "Preset '%s' sauvegardé avec succès !"
        final_status = "Status :"
        final_auto_active = "Activé automatiquement (premier preset)"
        final_active_now = "Activé comme preset principal"
        final_saved_inactive = "Sauvegardé sans activation"
        final_url_copied = "URL OBS copiée dans le presse-papiers :"
        final_obs_will_show = "[OK] OBS affichera automatiquement ce preset !"
        final_activate_later = "Pour activer ce preset plus tard, utilisez l'option de changement de preset actif."
        
        # Changer preset actif
        change_active_title = "=== CHANGER LE PRESET ACTIF ==="
        change_active_available = "Presets disponibles :"
        change_active_changed = "[OK] Preset actif changé vers :"
        change_active_obs_info = "OBS va automatiquement utiliser ce preset !"
        
        # Supprimer preset
        remove_title = "=== SUPPRIMER UN PRESET ==="
        remove_impossible_title = "=== IMPOSSIBLE DE SUPPRIMER ==="
        remove_impossible_last = "Impossible de supprimer le dernier preset !"
        remove_impossible_rule = "Vous devez avoir au moins un preset configuré."
        remove_warning = "ATTENTION : Vous allez supprimer définitivement :"
        remove_confirm = "Êtes-vous sûr de vouloir supprimer ce preset ? (o/N)"
        remove_cancelled = "Suppression annulée."
        remove_active_deleted = "Le preset actif a été supprimé. Choisissez le nouveau preset actif :"
        remove_success = "[OK] Preset '%s' supprimé avec succès !"
        remove_new_active = "Nouveau preset actif :"
        
        # Premier lancement
        first_launch_no_preset = "Aucun preset trouvé. Création du premier preset..."
        
        # Langue
        language_title = "=== PARAMÈTRES DE LANGUE ==="
        language_current = "Langue actuelle :"
        language_available = "Langues disponibles :"
        language_changed = "[OK] Langue changée vers :"
        language_restart_info = "Le changement sera effectif immédiatement dans l'interface."
        
        # Erreurs
        config_load_error = "Erreur lors du chargement de la config :"
        critical_error = "Erreur critique :"
        error_general = "Erreur :"
        close_key = "Appuyez sur une touche pour fermer..."
        
        # Messages de fin
        goodbye = "GL pour tes runs !"
    }
    en = @{
        # Menu principal
        menu_title = "SRC Preset Manager by karlitto__"
        menu_add_preset = "Add a new preset"
        menu_view_details = "View details of an existing preset"
        menu_change_active = "Change active preset"
        menu_remove_preset = "Delete a preset"
        menu_language_settings = "Language settings"
        menu_quit = "Quit program"
        menu_what_to_do = "What would you like to do?"
        
        # Navigation
        nav_instructions = "Use UP/DOWN arrows to navigate, Enter to select"
        nav_instructions_cancel = "Use UP/DOWN arrows to navigate, Enter to select, Backspace to cancel"
        
        # Presets existants
        existing_presets = "Existing presets:"
        active_preset = "Currently active preset:"
        not_defined = "Not defined"
        
        # Détails preset
        details_title = "=== PRESET DETAILS ==="
        details_choose = "Choose a preset to view:"
        details_name = "Name:"
        details_preset_id = "Preset ID:"
        details_game_id = "Game ID:"
        details_category = "Category:"
        details_subcategory = "Subcategory:"
        details_active_obs = "Active in OBS:"
        details_url_obs = "OBS URL (always the same):"
        
        # Messages communs
        continue_key = "Press any key to continue..."
        yes = "YES"
        no = "NO"
        null_value = "null"
        cancelled = "Cancelled."
        success = "[OK]"
        
        # Nouveau preset
        add_title = "=== ADD NEW PRESET ==="
        add_game_name = "Game name"
        add_error_empty_name = "Error: You must enter a game name!"
        add_searching = "Searching for:"
        add_no_game_found = "No game found for:"
        add_games_found = "Games found:"
        add_loading_categories = "Loading categories..."
        add_no_categories = "No categories found for this game!"
        add_categories_available = "Available categories:"
        add_subcategories_available = "Available subcategories:"
        add_no_subcategory = "No subcategory (null)"
        
        # Configuration finale
        final_config = "========================================\n           FINAL CONFIGURATION\n========================================"
        final_game = "Game     :"
        final_game_id = "Game ID  :"
        final_category = "Category :"
        final_subcategory = "Subcategory :"
        final_preset_id = "Enter a unique ID for this preset:"
        final_suggestion = "Suggestion:"
        final_preset_id_prompt = "Preset ID (or Enter for suggestion)"
        final_id_exists = "WARNING: A preset with ID '%s' already exists!"
        final_overwrite = "Do you want to overwrite it? (y/N)"
        final_operation_cancelled = "Operation cancelled."
        final_activate_now = "Do you want to activate this preset now? (y/N)"
        final_saved = "Preset '%s' saved successfully!"
        final_status = "Status:"
        final_auto_active = "Automatically activated (first preset)"
        final_active_now = "Activated as main preset"
        final_saved_inactive = "Saved without activation"
        final_url_copied = "OBS URL copied to clipboard:"
        final_obs_will_show = "[OK] OBS will automatically display this preset!"
        final_activate_later = "To activate this preset later, use the active preset change option."
        
        # Changer preset actif
        change_active_title = "=== CHANGE ACTIVE PRESET ==="
        change_active_available = "Available presets:"
        change_active_changed = "[OK] Active preset changed to:"
        change_active_obs_info = "OBS will automatically use this preset!"
        
        # Supprimer preset
        remove_title = "=== DELETE PRESET ==="
        remove_impossible_title = "=== CANNOT DELETE ==="
        remove_impossible_last = "Cannot delete the last preset!"
        remove_impossible_rule = "You must have at least one configured preset."
        remove_warning = "WARNING: You are going to permanently delete:"
        remove_confirm = "Are you sure you want to delete this preset? (y/N)"
        remove_cancelled = "Deletion cancelled."
        remove_active_deleted = "The active preset was deleted. Choose the new active preset:"
        remove_success = "[OK] Preset '%s' deleted successfully!"
        remove_new_active = "New active preset:"
        
        # Premier lancement
        first_launch_no_preset = "No preset found. Creating first preset..."
        
        # Langue
        language_title = "=== LANGUAGE SETTINGS ==="
        language_current = "Current language:"
        language_available = "Available languages:"
        language_changed = "[OK] Language changed to:"
        language_restart_info = "The change will take effect immediately in the interface."
        
        # Erreurs
        config_load_error = "Error loading config:"
        critical_error = "Critical error:"
        error_general = "Error:"
        close_key = "Press any key to close..."
        
        # Messages de fin
        goodbye = "GL for your runs!"
    }
    es = @{
        # Menu principal
        menu_title = "Gestor de Presets SRC by karlitto__"
        menu_add_preset = "Añadir un nuevo preset"
        menu_view_details = "Ver detalles de un preset existente"
        menu_change_active = "Cambiar preset activo"
        menu_remove_preset = "Eliminar un preset"
        menu_language_settings = "Configuración de idioma"
        menu_quit = "Salir del programa"
        menu_what_to_do = "¿Qué te gustaría hacer?"
        
        # Navegación
        nav_instructions = "Usa flechas ARRIBA/ABAJO para navegar, Enter para seleccionar"
        nav_instructions_cancel = "Usa flechas ARRIBA/ABAJO para navegar, Enter para seleccionar, Backspace para cancelar"
        
        # Presets existentes
        existing_presets = "Presets existentes:"
        active_preset = "Preset actualmente activo:"
        not_defined = "No definido"
        
        # Detalles preset
        details_title = "=== DETALLES DEL PRESET ==="
        details_choose = "Elige un preset para ver:"
        details_name = "Nombre:"
        details_preset_id = "ID del Preset:"
        details_game_id = "ID del Juego:"
        details_category = "Categoría:"
        details_subcategory = "Subcategoría:"
        details_active_obs = "Activo en OBS:"
        details_url_obs = "URL de OBS (siempre la misma):"
        
        # Mensajes comunes
        continue_key = "Presiona cualquier tecla para continuar..."
        yes = "SÍ"
        no = "NO"
        null_value = "null"
        cancelled = "Cancelado."
        success = "[OK]"
        
        # Nuevo preset
        add_title = "=== AÑADIR NUEVO PRESET ==="
        add_game_name = "Nombre del juego"
        add_error_empty_name = "Error: ¡Debes introducir un nombre de juego!"
        add_searching = "Buscando:"
        add_no_game_found = "No se encontró ningún juego para:"
        add_games_found = "Juegos encontrados:"
        add_loading_categories = "Cargando categorías..."
        add_no_categories = "¡No se encontraron categorías para este juego!"
        add_categories_available = "Categorías disponibles:"
        add_subcategories_available = "Subcategorías disponibles:"
        add_no_subcategory = "Sin subcategoria (null)"
        
        # Configuracion final
        final_config = "========================================\n         CONFIGURACION FINAL\n========================================"
        final_game = "Juego    :"
        final_game_id = "ID Juego :"
        final_category = "Categoria :"
        final_subcategory = "Subcategoria :"
        final_preset_id = "Introduce un ID unico para este preset:"
        final_suggestion = "Sugerencia:"
        final_preset_id_prompt = "ID del preset (o Enter para sugerencia)"
        final_id_exists = "ATENCIÓN: ¡Ya existe un preset con ID '%s'!"
        final_overwrite = "¿Quieres sobrescribirlo? (s/N)"
        final_operation_cancelled = "Operación cancelada."
        final_activate_now = "¿Quieres activar este preset ahora? (s/N)"
        final_saved = "¡Preset '%s' guardado con éxito!"
        final_status = "Estado:"
        final_auto_active = "Activado automáticamente (primer preset)"
        final_active_now = "Activado como preset principal"
        final_saved_inactive = "Guardado sin activar"
        final_url_copied = "URL de OBS copiada al portapapeles:"
        final_obs_will_show = "¡[OK] OBS mostrará automáticamente este preset!"
        final_activate_later = "Para activar este preset más tarde, usa la opción de cambio de preset activo."
        
        # Cambiar preset activo
        change_active_title = "=== CAMBIAR PRESET ACTIVO ==="
        change_active_available = "Presets disponibles:"
        change_active_changed = "[OK] Preset activo cambiado a:"
        change_active_obs_info = "¡OBS usará automáticamente este preset!"
        
        # Eliminar preset
        remove_title = "=== ELIMINAR PRESET ==="
        remove_impossible_title = "=== NO SE PUEDE ELIMINAR ==="
        remove_impossible_last = "¡No se puede eliminar el último preset!"
        remove_impossible_rule = "Debes tener al menos un preset configurado."
        remove_warning = "ATENCIÓN: Vas a eliminar permanentemente:"
        remove_confirm = "¿Estás seguro de que quieres eliminar este preset? (s/N)"
        remove_cancelled = "Eliminación cancelada."
        remove_active_deleted = "El preset activo fue eliminado. Elige el nuevo preset activo:"
        remove_success = "¡[OK] Preset '%s' eliminado con éxito!"
        remove_new_active = "Nuevo preset activo:"
        
        # Primer lanzamiento
        first_launch_no_preset = "No se encontraron presets. Creando el primer preset..."
        
        # Idioma
        language_title = "=== CONFIGURACIÓN DE IDIOMA ==="
        language_current = "Idioma actual:"
        language_available = "Idiomas disponibles:"
        language_changed = "[OK] Idioma cambiado a:"
        language_restart_info = "El cambio se aplicará inmediatamente en la interfaz."
        
        # Errores
        config_load_error = "Error al cargar la configuración:"
        critical_error = "Error crítico:"
        error_general = "Error:"
        close_key = "Presiona cualquier tecla para cerrar..."
        
        # Mensajes de fin
        goodbye = "¡GL en tus runs!"
    }
    pt = @{
        # Menu principal
        menu_title = "Gerenciador de Presets SRC by karlitto__"
        menu_add_preset = "Adicionar um novo preset"
        menu_view_details = "Ver detalhes de um preset existente"
        menu_change_active = "Alterar preset ativo"
        menu_remove_preset = "Remover um preset"
        menu_language_settings = "Configurações de idioma"
        menu_quit = "Sair do programa"
        menu_what_to_do = "O que você gostaria de fazer?"
        
        # Navegação
        nav_instructions = "Use setas CIMA/BAIXO para navegar, Enter para selecionar"
        nav_instructions_cancel = "Use setas CIMA/BAIXO para navegar, Enter para selecionar, Backspace para cancelar"
        
        # Presets existentes
        existing_presets = "Presets existentes:"
        active_preset = "Preset atualmente ativo:"
        not_defined = "Não definido"
        
        # Detalhes preset
        details_title = "=== DETALHES DO PRESET ==="
        details_choose = "Escolha um preset para ver:"
        details_name = "Nome:"
        details_preset_id = "ID do Preset:"
        details_game_id = "ID do Jogo:"
        details_category = "Categoria:"
        details_subcategory = "Subcategoria:"
        details_active_obs = "Ativo no OBS:"
        details_url_obs = "URL do OBS (sempre a mesma):"
        
        # Mensagens comuns
        continue_key = "Pressione qualquer tecla para continuar..."
        yes = "SIM"
        no = "NÃO"
        null_value = "null"
        cancelled = "Cancelado."
        success = "[OK]"
        
        # Novo preset
        add_title = "=== ADICIONAR NOVO PRESET ==="
        add_game_name = "Nome do jogo"
        add_error_empty_name = "Erro: Você deve inserir um nome de jogo!"
        add_searching = "Pesquisando por:"
        add_no_game_found = "Nenhum jogo encontrado para:"
        add_games_found = "Jogos encontrados:"
        add_loading_categories = "Carregando categorias..."
        add_no_categories = "Nenhuma categoria encontrada para este jogo!"
        add_categories_available = "Categorias disponíveis:"
        add_subcategories_available = "Subcategorias disponíveis:"
        add_no_subcategory = "Sem subcategoria (null)"
        
        # Configuração final
        final_config = "========================================\n        CONFIGURAÇÃO FINAL\n========================================"
        final_game = "Jogo     :"
        final_game_id = "ID Jogo  :"
        final_category = "Categoria :"
        final_subcategory = "Subcategoria :"
        final_preset_id = "Digite um ID único para este preset:"
        final_suggestion = "Sugestão:"
        final_preset_id_prompt = "ID do preset (ou Enter para sugestão)"
        final_id_exists = "ATENÇÃO: Já existe um preset com ID '%s'!"
        final_overwrite = "Você quer sobrescrever? (s/N)"
        final_operation_cancelled = "Operação cancelada."
        final_activate_now = "Você quer ativar este preset agora? (s/N)"
        final_saved = "Preset '%s' salvo com sucesso!"
        final_status = "Status:"
        final_auto_active = "Ativado automaticamente (primeiro preset)"
        final_active_now = "Ativado como preset principal"
        final_saved_inactive = "Salvo sem ativar"
        final_url_copied = "URL do OBS copiada para área de transferência:"
        final_obs_will_show = "[OK] O OBS mostrará automaticamente este preset!"
        final_activate_later = "Para ativar este preset mais tarde, use a opção de mudança de preset ativo."
        
        # Alterar preset ativo
        change_active_title = "=== ALTERAR PRESET ATIVO ==="
        change_active_available = "Presets disponíveis:"
        change_active_changed = "[OK] Preset ativo alterado para:"
        change_active_obs_info = "O OBS usará automaticamente este preset!"
        
        # Remover preset
        remove_title = "=== REMOVER PRESET ==="
        remove_impossible_title = "=== NÃO É POSSÍVEL REMOVER ==="
        remove_impossible_last = "Não é possível remover o último preset!"
        remove_impossible_rule = "Você deve ter pelo menos um preset configurado."
        remove_warning = "ATENÇÃO: Você vai remover permanentemente:"
        remove_confirm = "Tem certeza de que quer remover este preset? (s/N)"
        remove_cancelled = "Remoção cancelada."
        remove_active_deleted = "O preset ativo foi removido. Escolha o novo preset ativo:"
        remove_success = "[OK] Preset '%s' removido com sucesso!"
        remove_new_active = "Novo preset ativo:"
        
        # Primeiro lançamento
        first_launch_no_preset = "Nenhum preset encontrado. Criando o primeiro preset..."
        
        # Idioma
        language_title = "=== CONFIGURAÇÕES DE IDIOMA ==="
        language_current = "Idioma atual:"
        language_available = "Idiomas disponíveis:"
        language_changed = "[OK] Idioma alterado para:"
        language_restart_info = "A mudança será aplicada imediatamente na interface."
        
        # Erros
        config_load_error = "Erro ao carregar configuração:"
        critical_error = "Erro crítico:"
        error_general = "Erro:"
        close_key = "Pressione qualquer tecla para fechar..."
        
        # Mensagens de fim
        goodbye = "GL nas suas runs!"
    }
    zh = @{
        # Menu principal
        menu_title = "SRC 预设管理器 by karlitto__ 卡里托"
        menu_add_preset = "添加新预设"
        menu_view_details = "查看现有预设详情"
        menu_change_active = "更改活动预设"
        menu_remove_preset = "删除预设"
        menu_language_settings = "语言设置 / Language settings"
        menu_quit = "退出程序"
        menu_what_to_do = "您想要做什么？"
        
        # 导航
        nav_instructions = "使用上/下箭头导航，回车选择"
        nav_instructions_cancel = "使用上/下箭头导航，回车选择，Backspace取消"
        
        # 现有预设
        existing_presets = "现有预设："
        active_preset = "当前活动预设："
        not_defined = "未定义"
        
        # 预设详情
        details_title = "=== 预设详情 ==="
        details_choose = "选择要查看的预设："
        details_name = "名称："
        details_preset_id = "预设ID："
        details_game_id = "游戏ID："
        details_category = "类别："
        details_subcategory = "子类别："
        details_active_obs = "在OBS中活动："
        details_url_obs = "OBS URL（始终相同）："
        
        # 通用消息
        continue_key = "按任意键继续..."
        yes = "是"
        no = "否"
        null_value = "空"
        cancelled = "已取消。"
        success = "[OK]"
        
        # 新预设
        add_title = "=== 添加新预设 ==="
        add_game_name = "游戏名称"
        add_error_empty_name = "错误：您必须输入游戏名称！"
        add_searching = "搜索中："
        add_no_game_found = "未找到游戏："
        add_games_found = "找到的游戏："
        add_loading_categories = "加载类别中..."
        add_no_categories = "未找到此游戏的类别！"
        add_categories_available = "可用类别："
        add_subcategories_available = "可用子类别："
        add_no_subcategory = "无子类别（空）"
        
        # 最终配置
        final_config = "========================================\n            最终配置\n========================================"
        final_game = "游戏     ："
        final_game_id = "游戏ID   ："
        final_category = "类别     ："
        final_subcategory = "子类别   ："
        final_preset_id = "为此预设输入唯一ID："
        final_suggestion = "建议："
        final_preset_id_prompt = "预设ID（或回车使用建议）"
        final_id_exists = "警告：ID '%s' 的预设已存在！"
        final_overwrite = "您要覆盖它吗？（y/N）"
        final_operation_cancelled = "操作已取消。"
        final_activate_now = "您现在要激活此预设吗？（y/N）"
        final_saved = "预设 '%s' 保存成功！"
        final_status = "状态："
        final_auto_active = "自动激活（第一个预设）"
        final_active_now = "激活为主要预设"
        final_saved_inactive = "保存而不激活"
        final_url_copied = "OBS URL已复制到剪贴板："
        final_obs_will_show = "[OK] OBS将自动显示此预设！"
        final_activate_later = "要稍后激活此预设，请使用活动预设更改选项。"
        
        # 更改活动预设
        change_active_title = "=== 更改活动预设 ==="
        change_active_available = "可用预设："
        change_active_changed = "[OK] 活动预设已更改为："
        change_active_obs_info = "OBS将自动使用此预设！"
        
        # 删除预设
        remove_title = "=== 删除预设 ==="
        remove_impossible_title = "=== 无法删除 ==="
        remove_impossible_last = "无法删除最后一个预设！"
        remove_impossible_rule = "您必须至少配置一个预设。"
        remove_warning = "警告：您将永久删除："
        remove_confirm = "您确定要删除此预设吗？(y/N)"
        remove_cancelled = "删除已取消。"
        remove_active_deleted = "活动预设已删除。选择新的活动预设："
        remove_success = "[OK] 预设 '%s' 删除成功！"
        remove_new_active = "新活动预设："
        
        # 首次启动
        first_launch_no_preset = "未找到预设。正在创建第一个预设..."
        
        # 语言
        language_title = "=== 语言设置 ==="
        language_current = "当前语言："
        language_available = "可用语言："
        language_changed = "[OK] 语言已更改为："
        language_restart_info = "更改将立即在界面中生效。"
        
        # 错误
        config_load_error = "加载配置时出错："
        critical_error = "严重错误："
        error_general = "错误："
        close_key = "按任意键关闭..."
        
        # 结束消息
        goodbye = "祝你跑得愉快！"
    }
}

# === FONCTION DE LOCALISATION ===
function Get-LocalizedString {
    param(
        [string]$key,
        [string]$lang = $null
    )
    
    # Utiliser la langue du config ou fallback vers français
    if (-not $lang) {
        $lang = if ($Global:CurrentLanguage) { $Global:CurrentLanguage } else { "fr" }
    }
    
    # Fallback vers français si la langue n'existe pas
    if (-not $Global:Languages.ContainsKey($lang)) {
        $lang = "fr"
    }
    
    # Récupérer la chaîne
    if ($Global:Languages[$lang].ContainsKey($key)) {
        return $Global:Languages[$lang][$key]
    }
    
    # Fallback vers français si la clé n'existe pas
    if ($lang -ne "fr" -and $Global:Languages.fr.ContainsKey($key)) {
        return $Global:Languages.fr[$key]
    }
    
    # Retourner la clé si rien n'est trouvé
    return "[$key]"
}

# === FONCTION GESTION LANGUE ===
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
    $selectedLangIndex = Show-ArrowMenu -Title (Get-LocalizedString "language_available") -Options $languageOptions -AllowCancel
    
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
    
    # Sauvegarder la nouvelle langue
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
    
    # Appliquer immédiatement
    $Global:CurrentLanguage = $newLang
    
    # Sauvegarder
    $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8
    
    Clear-Host
    Write-Host "$(Get-LocalizedString 'language_changed') $($langDisplayNames[$newLang])" -ForegroundColor Green
    Write-Host (Get-LocalizedString "language_restart_info") -ForegroundColor Cyan
    Write-Host ""
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

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
      Write-Host (Get-LocalizedString "nav_instructions_cancel") -ForegroundColor Gray
    } else {
      Write-Host (Get-LocalizedString "nav_instructions") -ForegroundColor Gray
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
      27 { # Échap -> changé vers Backspace (code 8)
        # Code inactif - voir ligne suivante
      }
      8 { # Backspace (Retour arrière)
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
  Write-Host "$(Get-LocalizedString 'details_preset_id') $($selectedPreset.Name)" -ForegroundColor Cyan
  Write-Host "$(Get-LocalizedString 'details_game_id') $($selectedPreset.Value.gameId)" -ForegroundColor Cyan
  Write-Host "$(Get-LocalizedString 'details_category') $($selectedPreset.Value.category)" -ForegroundColor Cyan
  $subcat = if ($selectedPreset.Value.subcategory) { $selectedPreset.Value.subcategory } else { (Get-LocalizedString "null_value") }
  Write-Host "$(Get-LocalizedString 'details_subcategory') $subcat" -ForegroundColor Cyan
  $isActive = if ($currentConfig.activePreset -eq $selectedPreset.Name) { (Get-LocalizedString "yes") } else { (Get-LocalizedString "no") }
  Write-Host "$(Get-LocalizedString 'details_active_obs') $isActive" -ForegroundColor $(if ($isActive -eq (Get-LocalizedString "yes")) { "Green" } else { "Yellow" })
  Write-Host ""
  Write-Host "$(Get-LocalizedString 'details_url_obs')" -ForegroundColor Cyan
  Write-Host "leaderboard.html" -ForegroundColor Gray
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION CHANGE ACTIVE PRESET ===
function Update-ActivePreset($presetList, $currentConfig) {
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
  $currentConfig.activePreset = $newActivePreset.Name
  
  # Sauvegarder
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host "$(Get-LocalizedString 'change_active_changed') $($newActivePreset.Value.name)" -ForegroundColor Green
  Write-Host (Get-LocalizedString "change_active_obs_info") -ForegroundColor Green
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION REMOVE PRESET ===
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
  
  # Confirmation simple selon la langue
  $confirm = Read-Host (Get-LocalizedString "remove_confirm")
  
  $expectedAnswer = switch ($Global:CurrentLanguage) {
    "en" { "y" }
    "es" { "s" }
    "pt" { "s" }
    "zh" { "y" }
    default { "o" }
  }
  
  if ($confirm.ToLower() -ne $expectedAnswer) {
    Write-Host (Get-LocalizedString "remove_cancelled") -ForegroundColor Cyan
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
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
      
      $newActiveIndex = Show-ArrowMenu -Title (Get-LocalizedString "remove_active_deleted") -Options $newOptions
      $currentConfig.activePreset = $newPresetList[$newActiveIndex].Name
    } else {
      $currentConfig.activePreset = $null
    }
  }
  
  # Sauvegarder
  $jsonOutput = $currentConfig | ConvertTo-Json -Depth 10
  $jsonOutput | Set-Content "config.json" -Encoding UTF8
  
  Clear-Host
  Write-Host (Get-LocalizedString "remove_success" -f $presetToDelete.Value.name) -ForegroundColor Green
  if ($currentConfig.activePreset) {
    $newActiveName = $currentConfig.presets.($currentConfig.activePreset).name
    Write-Host "$(Get-LocalizedString 'remove_new_active') $newActiveName" -ForegroundColor Cyan
  }
  Write-Host ""
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

# === FONCTION ADD NEW PRESET ===
function New-Preset($currentConfig) {
  Clear-Host
  Write-Host (Get-LocalizedString "add_title") -ForegroundColor Green
  Write-Host ""

  $gameName = Read-Host (Get-LocalizedString "add_game_name")

  if ([string]::IsNullOrWhiteSpace($gameName)) {
    Write-Host (Get-LocalizedString "add_error_empty_name") -ForegroundColor Red
    Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    return
  }

  Write-Host "$(Get-LocalizedString 'add_searching') $gameName" -ForegroundColor Yellow

  try {
    # === ETAPE 1: Chercher le jeu ===
    $response = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games?name=$([System.Web.HttpUtility]::UrlEncode($gameName))" -TimeoutSec 10
    $data = $response.Content | ConvertFrom-Json
    
    $games = $data.data
    
    if ($games.Count -eq 0) {
      Write-Host "$(Get-LocalizedString 'add_no_game_found') $gameName" -ForegroundColor Red
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
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
      
      $selectedGameIndex = Show-ArrowMenu -Title (Get-LocalizedString "add_games_found") -Options $gameOptions -AllowCancel
      
      if ($selectedGameIndex -eq -1) {
        Write-Host (Get-LocalizedString "cancelled") -ForegroundColor Cyan
        return
      }
      
      $selectedGame = $games[$selectedGameIndex]
    } else {
      $selectedGame = $games[0]
    }
    
    # === ETAPE 2: Recuperer les categories ===
    Write-Host ""
    Write-Host (Get-LocalizedString "add_loading_categories") -ForegroundColor Yellow
    
    $categoriesResponse = Invoke-WebRequest -Uri "https://www.speedrun.com/api/v1/games/$($selectedGame.id)?embed=categories.variables" -TimeoutSec 10
    $categoriesData = $categoriesResponse.Content | ConvertFrom-Json
    
    $categories = $categoriesData.data.categories.data | Where-Object { $_.type -eq "per-game" }
    
    if ($categories.Count -eq 0) {
      Write-Host (Get-LocalizedString "add_no_categories") -ForegroundColor Red
      Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
      $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
      return
    }
    
    # Sélection de la catégorie
    $categoryOptions = @()
    foreach ($category in $categories) {
      $categoryOptions += $category.name
    }
    
    $selectedCategoryIndex = Show-ArrowMenu -Title (Get-LocalizedString "add_categories_available") -Options $categoryOptions
    $selectedCategory = $categories[$selectedCategoryIndex]
    
    # === ETAPE 3: Gérer les sous-catégories ===
    $selectedSubcategory = $null
    $selectedSubcategoryLabel = (Get-LocalizedString "null_value")
    
    $subcategoryVariables = $selectedCategory.variables.data | Where-Object { $_.'is-subcategory' -eq $true -and $_.values.values }
    
    if ($subcategoryVariables.Count -gt 0) {
      # On prend la première variable de sous-catégorie trouvée
      $subcatVariable = $subcategoryVariables[0]
      $subcatValues = $subcatVariable.values.values.PSObject.Properties
      
      $subcatOptions = @((Get-LocalizedString "add_no_subcategory"))
      $subcatArray = @()
      
      foreach ($value in $subcatValues) {
        $subcatOptions += $value.Value.label
        $subcatArray += @{
          id = $value.Name
          label = $value.Value.label
        }
      }
      
      # Sélection de la sous-catégorie
      $selectedSubcatIndex = Show-ArrowMenu -Title (Get-LocalizedString "add_subcategories_available") -Options $subcatOptions
      
      if ($selectedSubcatIndex -gt 0) {
        $selectedSubcategory = $subcatArray[$selectedSubcatIndex - 1]
        $selectedSubcategoryLabel = $selectedSubcategory.label
      }
    }
    
    # === ETAPE 4: Preset ID et sauvegarde ===
    Write-Host ""
    Write-Host (Get-LocalizedString "final_config") -ForegroundColor Green
    Write-Host ""
    Write-Host "$(Get-LocalizedString 'final_game') $($selectedGame.names.international)" -ForegroundColor White
    Write-Host "$(Get-LocalizedString 'final_game_id') $($selectedGame.id)" -ForegroundColor Cyan
    Write-Host "$(Get-LocalizedString 'final_category') $($selectedCategory.name)" -ForegroundColor Cyan
    Write-Host "$(Get-LocalizedString 'final_subcategory') $selectedSubcategoryLabel" -ForegroundColor Cyan
    Write-Host ""
    
    # Generer le nom complet avec sous-categorie si elle existe
    $fullName = if ($selectedSubcategoryLabel -eq (Get-LocalizedString "null_value")) {
      "$($selectedGame.names.international) - $($selectedCategory.name)"
    } else {
      "$($selectedGame.names.international) - $($selectedCategory.name) $selectedSubcategoryLabel"
    }
    
    # Suggestions d'ID pour le preset
    $gamePart = $selectedGame.names.international -replace '[^a-zA-Z0-9]', '' -replace '\s+', ''
    $catPart = $selectedCategory.name -replace '[^a-zA-Z0-9]', '' -replace '\s+', ''
    $defaultPresetId = ($gamePart.ToLower() + "-" + $catPart.ToLower()) -replace '--+', '-'
    
    Write-Host (Get-LocalizedString "final_preset_id") -ForegroundColor Yellow
    Write-Host "$(Get-LocalizedString 'final_suggestion') $defaultPresetId" -ForegroundColor Gray
    $presetId = Read-Host (Get-LocalizedString "final_preset_id_prompt")
    
    if ([string]::IsNullOrWhiteSpace($presetId)) {
      $presetId = $defaultPresetId
    }
    
    # Verification que l'ID n'existe pas deja
    if ($currentConfig -and $currentConfig.presets.$presetId) {
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
    
    # Preparer l'objet preset
    $subcatValue = if ($selectedSubcategoryLabel -eq (Get-LocalizedString "null_value")) { $null } else { $selectedSubcategoryLabel }
    
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
        language = "fr"
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
        $config.activePreset = $presetId
        $activationMessage = (Get-LocalizedString "final_active_now")
      } else {
        $activationMessage = (Get-LocalizedString "final_saved_inactive")
      }
    }
    
    # Sauvegarder
    $jsonOutput = $config | ConvertTo-Json -Depth 10
    $jsonOutput | Set-Content "config.json" -Encoding UTF8
    
    Write-Host ""
    Write-Host (Get-LocalizedString "final_saved" -f $presetId) -ForegroundColor Green
    Write-Host "$(Get-LocalizedString 'final_status') $activationMessage" -ForegroundColor Cyan
    
    # Copier l'URL simplifiee dans le presse-papiers
    $simpleUrl = "leaderboard.html"
    $simpleUrl | Set-Clipboard
    
    Write-Host ""
    Write-Host (Get-LocalizedString "final_url_copied") -ForegroundColor Green
    Write-Host "$simpleUrl" -ForegroundColor White
    Write-Host ""
    if ($config.activePreset -eq $presetId) {
      Write-Host (Get-LocalizedString "final_obs_will_show") -ForegroundColor Green
    } else {
      Write-Host (Get-LocalizedString "final_activate_later") -ForegroundColor Cyan
    }
    Write-Host ""
  } catch {
    Write-Host ""
    Write-Host "$(Get-LocalizedString 'error_general') $_" -ForegroundColor Red
  }
  
  Write-Host (Get-LocalizedString "continue_key") -ForegroundColor Gray
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
      
      # === INITIALISER LA LANGUE ===
      $Global:CurrentLanguage = "fr" # Défaut
      if ($currentConfig -and $currentConfig.language) {
        $Global:CurrentLanguage = $currentConfig.language
      }
      
      $presetList = Write-MainMenu $currentConfig
      
      if ($presetList.Count -gt 0) {
        # Préparer le contexte à afficher au-dessus du menu
        $contextLines = @()
        $contextLines += "================================================"
        $contextLines += "  $(Get-LocalizedString 'menu_title')"
        $contextLines += "================================================"
        $contextLines += ""
        $contextLines += "$(Get-LocalizedString 'existing_presets')"
        $contextLines += ""
        
        foreach ($preset in $presetList) {
          $isActive = if ($preset.Name -eq $currentConfig.activePreset) { " [OK] [ACTIF]" } else { "" }
          $contextLines += "• $($preset.Value.name)$isActive"
          $contextLines += "  ID: $($preset.Name)"
        }
        $contextLines += ""
        
        # Affichage du preset actif en évidence
        $activePresetName = if ($currentConfig.activePreset -and $currentConfig.presets.($currentConfig.activePreset)) { 
          $currentConfig.presets.($currentConfig.activePreset).name 
        } else { 
          (Get-LocalizedString "not_defined")
        }
        $contextLines += "📍 $(Get-LocalizedString 'active_preset') $activePresetName"
        $contextLines += ""
        
        $contextText = $contextLines -join "`n"
        
        $menuOptions = @(
          (Get-LocalizedString "menu_add_preset"),
          (Get-LocalizedString "menu_view_details"), 
          (Get-LocalizedString "menu_change_active"),
          (Get-LocalizedString "menu_remove_preset"),
          (Get-LocalizedString "menu_language_settings"),
          (Get-LocalizedString "menu_quit")
        )
        
        $selectedOption = Show-ArrowMenu -Title (Get-LocalizedString "menu_what_to_do") -Options $menuOptions -ContextText $contextText
        
        switch ($selectedOption) {
          5 { # Quitter le programme
            Clear-Host
            Write-Host (Get-LocalizedString "goodbye") -ForegroundColor Green 
            return 
          }
          0 { New-Preset $currentConfig }
          1 { Write-PresetDetails $presetList $currentConfig }
          2 { Update-ActivePreset $presetList $currentConfig }
          3 { Remove-Preset $presetList $currentConfig }
          4 { Set-Language $currentConfig }
        }
      } else {
        # Premier preset - affichage direct
        Clear-Host
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host "  $(Get-LocalizedString 'menu_title')" -ForegroundColor Cyan
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host (Get-LocalizedString "first_launch_no_preset") -ForegroundColor Yellow
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

# === DEMARRAGE DU PROGRAMME ===
try {
  Start-MainLoop
} catch {
  Write-Host ""
  Write-Host "$(Get-LocalizedString 'critical_error') $_" -ForegroundColor Red
  Write-Host ""
  Write-Host (Get-LocalizedString "close_key") -ForegroundColor Gray
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}
