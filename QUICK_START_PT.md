# QUICK START: Leaderboard Speedrun

**Configuração automática em 5 minutos** para streamers!  
🌐 **Novo**: Interface disponível em 5 idiomas!

---

## Método automático (v1.1.0+)

### Primeiro uso
1. **Clique duplo** em `get_game_id.ps1`
2. **Menu principal** aparece automaticamente
3. **Navegar** com ↑↓ para selecionar "Adicionar um novo preset"
4. **Pressionar Enter** para confirmar
5. **Inserir** o nome do jogo (ex: "Elden Ring")
6. **Navegar** ↑↓ e **Enter** para selecionar o jogo da lista
7. **Navegar** ↑↓ e **Enter** para escolher a categoria (Any%, 100%, etc.)
8. **Opcional**: subcategoria se disponível
9. **Dar um ID** ao preset (sugestão automática fornecida)
10. **Ativar automaticamente** o preset (se for o primeiro)

**Resultado**: preset salvo + ativado automaticamente + URL copiada!

### Interface do menu principal (v1.1.0)
O script exibe um menu com navegação intuitiva no seu idioma:

```
================================================
  Gerenciador de Presets SRC by karlitto__
================================================

Presets existentes:
• Elden Ring - Any% Glitchless ✓ [ATIVO]
  ID: eldenring-any
• Dark Souls III - All Bosses
  ID: darksouls3-all

📍 Preset atualmente ativo: Elden Ring - Any% Glitchless

O que você gostaria de fazer?
► Adicionar um novo preset
  Ver detalhes de um preset existente
  Alterar preset ativo
  Remover um preset
  Configurações de idioma
  Sair do programa

Use ↑↓ para navegar, Enter para selecionar
```

### 🌐 Suporte multilíngue (v1.1.0)
A interface está disponível em **5 idiomas**:
- **🇫🇷 Français** (padrão)
- **🇺🇸 English**
- **🇪🇸 Español**
- **🇧🇷 Português**
- **🇨🇳 中文**

**Mudar idioma**:
1. Menu principal → **Opção 5** "Configurações de idioma"
2. Navegar com ↑↓ para escolher seu idioma
3. Pressionar **Enter** → Mudança imediata!
4. O idioma é **salvo automaticamente**

### Usar no OBS
- **URL simples**: `leaderboard.html` (sempre a mesma!)
- **Fonte do navegador**: Largura 400, Altura 280
- **Atualização automática**: a cada 30 segundos
- **Sem parâmetros**: lê automaticamente o preset ativo

---

## Problemas comuns

### Script PowerShell bloqueado
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Failed to fetch" ao testar no navegador
**Normal**: limitações CORS. **Funciona perfeitamente no OBS!**

---

**Dica para streamers**: Apenas uma URL no OBS (`leaderboard.html`)! Mude jogos com o script → **Opção 3** durante a live!

**Dica multilíngue**: Configure uma vez no seu idioma, tudo é salvo automaticamente!