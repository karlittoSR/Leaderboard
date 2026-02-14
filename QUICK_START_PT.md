# Guia de Início Rápido

**Obtenha seu ranking de speedrun no OBS em 5 minutos**

---

## Passo 1: Instalar PowerShell 7

1. Baixe de: https://github.com/PowerShell/PowerShell/releases/
2. Escolha a **última versão estável** (rótulo verde)
3. Baixe e instale o arquivo `.msi` para seu sistema

## Passo 2: Corrigir Acesso

1. Baixe todos os arquivos: `configure.ps1`, `leaderboard.html`, `config.json`, `FIX_ACCESS.bat`
2. Coloque-os na mesma pasta
3. **Clique duplo em `FIX_ACCESS.bat`** - corrige tudo automaticamente

## Passo 3: Adicionar Seu Jogo

1. Clique duplo em `configure.ps1` ou continue com a última opção de `FIX_ACCESS.bat`.
2. Selecione **"Adicionar um novo preset"**
3. Digite o nome do seu jogo (ex: "Elden Ring")
4. Escolha seu jogo da lista
5. Selecione a categoria (Any%, 100%, etc.)
6. Dê um nome e ative-o
7. Você pode fechar o programa.

## Passo 4: Definir Seu Nome (Opcional)

1. Selecione **"Definir meu nome"**
2. Insira exatamente seu nome de usuário speedrun.com
3. Isso habilita o recurso de PB temporário - pule se não necesário

## Passo 5: Adicionar ao OBS

1. Adicione uma **Fonte do Navegador**
2. **Arquivo Local** → navegue até `leaderboard.html`
3. **Largura**: 400px
4. **Altura**: 250px
5. **Pronto!**

Seu ranking será atualizado automaticamente e exibirá sua posição na parte inferior em uma linha separada quando estiver fora do top 3.

---

## Funcionalidades adicionais
- Menu de ajustes visuais no gerenciador de presets para alterar layout, fontes, espaçamento, efeitos, bandeiras/troféus e carrossel.
- Nova opção `fontStyle` para escolher a família de fonte do overlay.
- Alinhamento e prefixo da colocação configuráveis (`rankAlign`, `rankPrefixMode`).
- Tratamento mais inteligente de nomes com `maxNameWidthVisible` e texto rolando para nomes longos.
- O PB temporário pode aparecer mesmo que sua conta ainda não esteja no leaderboard (usando `playerName` / `playerCountry`).
- Efeito arco-íris para novos PB dos últimos 5 dias, com `rainbowIntensity` ajustável.
- Largura da barra separadora sob sua linha pessoal configurável (`pbSeparatorWidth`).
- Formato de tempo opcional `1h25m25s225ms` além de `1:25:25.255`.
- Opção no script para redefinir facilmente o `config.json` para os valores padrão em caso de problema.
- Traduções revisadas para FR/EN/ES/PT/ZH, incluindo o novo menu de parâmetros/visuais.
- Exibição de bandeiras aprimorada: espaçamento consistente, ícone de globo padrão e suporte a `flagOverrides`.

**Precisa de mais recursos?** Consulte o README.md completo para o sistema de PB temporário, múltiplos presets e configuração avançada.