# QUICK START: Leaderboard Speedrun

**Configuração automática em 5 minutos** para streamers!  
🌐 **Novo**: Interface disponível em 5 idiomas!

---

## ⚠️ Pré-requisitos

**PowerShell 7 é obrigatório** (Apenas Windows 10/11)

1. **Instalar PowerShell 7**:
   - Abrir Microsoft Store (Windows 10/11)
   - Procurar por "PowerShell" (aplicativo oficial da Microsoft)
   - Clique em "Instalar"
   - Ou baixe de: https://github.com/PowerShell/PowerShell/releases

2. **Associar arquivos .ps1 com PowerShell 7**:
   - Clique direito em `main.ps1`
   - Selecione "Abrir com" → "Escolher outro aplicativo"
   - Marque "Sempre usar este aplicativo para abrir arquivos .ps1"
   - Selecione "PowerShell 7" da lista
   - Se não estiver visível: clique "Mais aplicativos" e role

---

## Método automático (v1.20+)

### Primeiro uso
1. **Clique duplo** em `main.ps1`
2. **Menu principal** aparece automaticamente
3. **Navegar** com ↑↓ para selecionar "Adicionar um novo preset"
4. **Pressionar Enter** para confirmar
5. **Inserir** o nome do jogo (ex: "Elden Ring")
6. **Navegar** ↑↓ e **Enter** para selecionar o jogo da lista
7. **Escolher** Jogo completo ou Niveis (se disponível)
8. **Se Niveis**: selecionar o nivel
9. **Navegar** ↑↓ e **Enter** para escolher a categoria (Any%, 100%, etc.)
10. **Opcional**: subcategorias (varias escolhas possiveis)
11. **Dar um ID** ao preset (sugestão automática fornecida)
12. **Ativar automaticamente** o preset (se for o primeiro)

**Resultado**: preset salvo + ativado automaticamente + URL copiada!

### Interface do menu principal (v1.20)
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
  Definir nome do jogador
  Configurações de idioma
  Sair do programa

Use ↑↓ para navegar, Enter para selecionar
```

### 🌐 Suporte multilíngue (v1.20)
A interface está disponível em **5 idiomas**:
- **🇫🇷 Français** (padrão)
- **🇺🇸 English**
- **🇪🇸 Español**
- **🇧🇷 Português**
- **🇨🇳 中文**

**Mudar idioma**:
1. Menu principal → **Opção 6** "Configurações de idioma"
2. Navegar com ↑↓ para escolher seu idioma
3. Pressionar **Enter** → Mudança imediata!
4. O idioma é **salvo automaticamente**

### Opções disponíveis

**1. Adicionar novo preset**: Criar novo preset (mesmo fluxo da primeira vez)  
**2. Ver detalhes**: Ver detalhes completos de um preset  
**3. Alterar preset ativo**: Selecionar qual preset está ativo no OBS  
**4. Remover preset**: Remover um preset (confirmação simples s/N)  
**5. Definir nome do jogador**: Mostrar sua posicao no leaderboard  
**6. Configurações de idioma**: Alterar idioma da interface (5 idiomas disponíveis)  
**7. Sair**: Fechar o programa

**Navegação**: Use **↑↓** para mover entre opções  
**Seleção**: Pressione **Enter** para confirmar  
**Voltar**: Pressione **⌫ Backspace** quando disponível  
**Confirmações**: Diálogo simples **sim/não** (s/N) - sem digitação complexa!

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