# Speedrun Leaderboard Canvas

**Version** : 1.0.1  
**Gestionnaire de presets avec interface par flèches**

Affichage dynamique d'un classement Speedrun.com sur canvas avec carousel, entièrement configurable.

![Aperçu du leaderboard](images/leaderboard-preview.png)

## Installation (2 minutes)

1. **Télécharge** ces fichiers :
   - `leaderboard.html`
   - `config.json`
   - `get_game_id.ps1` (script pour configurer facilement un nouveau jeu)

2. **Mets-les dans le même dossier**

3. **Double-clique** sur le .ps1 → trouve ton jeu et ta catégorie avec les flèches ↑↓

4. **Ajoute le fichier dans OBS** (Navigateur) avec ces valeurs: Width 400, Height 280

## 🎯 Fonctionnalités v1.0.1

### Interface
- ✅ **Navigation par flèches** (↑↓) au lieu de saisie numérique
- ✅ **Affichage persistant** des presets pendant la navigation
- ✅ **Indicateurs visuels** : ✓ [ACTIF] et 📍 pour le preset actif
- ✅ **Interface moderne** sans erreurs de saisie

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

Vois **[QUICK_START.md](QUICK_START.md)** pour le tutoriel complet (5 minutes).

Résumé rapide :
1. Ouvre `config.json`
2. Ajoute un preset avec `gameId`, `category`, `subcategory`
3. Accède via `?preset=son-nom`

## Guides complets

- **Comment ajouter un jeu ?** → [QUICK_START.md](QUICK_START.md)
- **Trouver un Game ID ?** → [FIND_GAME_ID.md](FIND_GAME_ID.md)
- **Configuration détaillée ?** → Vois les commentaires dans `config.json`

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
