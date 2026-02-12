# Speedrun Leaderboard Canvas

**Version** : 1.1.0  
**Gestionnaire de presets multilingue avec interface par flèches**  
🌐 **Support de 5 langues** : Français, English, Español, Português, 中文

Affichage dynamique d'un classement Speedrun.com sur canvas avec carousel, entièrement configurable.

<img width="436" height="229" alt="image" src="https://github.com/user-attachments/assets/f6add34f-9eb3-4272-88d6-565995ee1c80" />


## Installation (2 minutes)

1. **Télécharge** ces fichiers :
   - `leaderboard.html`
   - `config.json`
   - `get_game_id.ps1` (script pour configurer facilement avec interface multilingue)

2. **Mets-les dans le même dossier**

3. **Double-clique** sur le .ps1 → trouve ton jeu et ta catégorie avec les flèches ↑↓
   - **Choisir la langue** : Option 5 dans le menu principal
   - Interface disponible en **5 langues**

4. **Ajoute le fichier dans OBS** (Navigateur) avec ces valeurs: Width 400, Height 280

## � Fonctionnalités v1.1.0

### Support multilingue
- ✅ **5 langues disponibles** : FR, EN, ES, PT, ZH
- ✅ **Interface complètement traduite**
- ✅ **Changement de langue en temps réel** sans redémarrage
- ✅ **Configuration persistante** - langue sauvegardée automatiquement
- ✅ **Accessibilité mondiale** pour toute la communauté speedrun

### Interface
- ✅ **Navigation par flèches** (↑↓) au lieu de saisie numérique
- ✅ **Affichage persistant** des presets pendant la navigation
- ✅ **Indicateurs visuels** : ✓ [ACTIF] et 📍 pour le preset actif
- ✅ **Interface moderne** sans erreurs de saisie
- ✅ **Menu de langue** intégré

### Leaderboard
- Affichage du **top 3** + **carousel** animé des autres runs
- Couleurs pour les places (or, argent, bronze)
- **Drapeaux** des pays (chargés depuis flagcdn)
- **Entièrement configurable** via `config.json`
- **Paramètres d'URL** pour surcharger les settings
- **Responsive** et transparent (parfait pour les streams Twitch)

## Comment ça marche ?

Le fichier **`config.json`** contient des **presets** pour différents jeux/catégories :

```json
"presets": {
  "elden-any-glitchless": {
    "gameId": "nd28z0ed",
    "category": "Any%",
    "subcategory": "Glitchless"
  }
}
```

Tu peux accéder à un preset ainsi :
- **Par défaut** : `leaderboard.html` (utilise le premier preset)
- **Avec un preset spécifique** : `leaderboard.html?preset=elden-100`

## Ajouter un jeu

🎆 **Méthode recommandée** : Utilise le script `get_game_id.ps1` !

1. **Double-clique** sur `get_game_id.ps1`
2. **Choisir la langue** (Option 5) si nécessaire
3. **Sélectionner** "Ajouter un nouveau preset"
4. **Suivre** l'assistant automatique

Tout est géré automatiquement, y compris l'activation du preset !

Vois **[QUICK_START.md](QUICK_START.md)** pour le tutoriel détaillé avec captures.

## Guides complets

- **Comment ajouter un jeu ?** → [QUICK_START.md](QUICK_START.md)
- **Configuration détaillée ?** → Vois les commentaires dans `config.json`
- **Interface multilingue** → Option 5 dans le menu du script

## Personnaliser l'apparence

Les couleurs, polices, et layout sont définis dans la section `DRAW` du HTML. Édite-les directement pour matcher ton branding !

## Aide

**Le carousel ne défile pas ?** 
→ Vérifie qu'il y a plus de runs que le `topCount`

**Aucun run n'apparaît ?**
→ Vérife le `gameId`, `category`, et `subcategory` (casse sensible!)

**"Failed to fetch" en double-cliquant le HTML ?**
→ Normal ! Problème de CORS. Utilise un serveur local : `python -m http.server 8000` puis `http://localhost:8000`

**Je ne sais pas comment faire ?**
→ Commence par [QUICK_START.md](QUICK_START.md)
