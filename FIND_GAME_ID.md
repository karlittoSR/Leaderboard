# Trouver les Game IDs Speedrun.com

## Méthode recommandée (script PowerShell menu v1.0.1+)

Double-clique sur **`get_game_id.ps1`** pour le menu complet !

### Premier lancement (aucun preset)
```
================================================
  Gestionnaire de presets SRC by karlitto__
================================================

Aucun preset trouvé. Création du premier preset...

Nom du jeu : Elden Ring

Jeux trouvés :
► Elden Ring (2022)
  Dark Souls III (2016)
  Dark Souls (2011)

Utilisez ↑↓ pour naviguer, Entrée pour sélectionner, Échap pour annuler
```

**Navigation** : ↑↓  
**Sélection** : Entrée  
**Annulation** : Échap

### Sélection de la catégorie
```
Catégories disponibles :
► Any%
  100%
  All Bosses
  Glitchless Any%

Utilisez ↑↓ pour naviguer, Entrée pour sélectionner
```

### Sélection de la sous-catégorie
```
Sous-catégories disponibles :
► Aucune sous-catégorie (null)
  Glitchless
  No Major Glitches
  Any% Unrestricted

Utilisez ↑↓ pour naviguer, Entrée pour sélectionner
```

### Configuration finale et sauvegarde
```
========================================
           CONFIGURATION FINALE
========================================

Jeu      : Elden Ring
Game ID  : nd28z0ed
Category : Any%
Subcategory : Glitchless

Entrez un ID unique pour ce preset :
Suggestion : eldenring-any
ID du preset (ou Entrée pour suggestion) : 

✓ Preset 'eldenring-any' sauvegardé avec succès !
Status : Actif automatiquement (premier preset)

URL OBS copiée dans le presse-papiers :
leaderboard.html

✓ OBS affichera automatiquement ce preset !
```

### Lancements suivants (avec presets existants)
```
================================================
  Gestionnaire de presets SRC by karlitto__
================================================

Presets existants :
• Elden Ring - Any% Glitchless ✓ [ACTIF]
  ID: eldenring-any
• Dark Souls III - All Bosses
  ID: darksouls3-allbosses

📍 Preset actuellement actif : Elden Ring - Any% Glitchless

Que voulez-vous faire ?
► Ajouter un nouveau preset
  Voir les détails d'un preset existant
  Changer le preset actif
  Supprimer un preset
  Quitter le programme

Utilisez ↑↓ pour naviguer, Entrée pour sélectionner
```

Le script te guide **étape par étape** avec un **menu complet** : création → gestion → activation → suppression !

## Navigation intuitive (v1.0.1)

### Touches disponibles
- **↑ Flèche haut** : Naviguer vers le haut dans la liste
- **↓ Flèche bas** : Naviguer vers le bas dans la liste
- **Entrée** : Confirmer la sélection
- **Échap** : Annuler et revenir en arrière (quand disponible)

### Avantages par rapport aux versions antérieures

✅ **Plus intuitif** : Navigation naturelle avec les flèches  
✅ **Moins d'erreurs** : Plus de risque de taper un mauvais numéro  
✅ **Contexte persistant** : Les presets restent visibles pendant la navigation  
✅ **Indicateur visuel** : ✓ [ACTIF] montre le preset actuellement sélectionné  
✅ **Interface moderne** : Utilisation standard pour les menus CLI

---

## Méthode manuelle

### Rapide (depuis le site)

1. Va sur https://www.speedrun.com
2. Cherche ton jeu avec la barre de recherche
3. L'ID apparaît dans l'URL de la page du jeu

Exemple :
```
https://www.speedrun.com/gerrorq/
                         ^^^^^^  <- Game ID
```

### Avec l'API Speedrun.com

Tu peux aussi utiliser l'API directement pour chercher :

```bash
# Cherche "Elden Ring"
curl "https://www.speedrun.com/api/v1/games?name=Elden%20Ring"

# Le résultat inclut l'ID :
# "id":"nd28z0ed"
```

## Trouver les catégories et sous-catégories

Une fois que tu as le Game ID, cherche les catégories :

```bash
# Remplace nd28z0ed par l'ID du jeu
curl "https://www.speedrun.com/api/v1/games/nd28z0ed?embed=categories.variables"
```

Regarde le JSON pour trouver :
- `category.name` : nom de la catégorie (ex: "Any%", "100%")
- `variable.name` : nom de la sous-catégorie si elle existe
- `variable.values` : options possibles (ex: "Glitchless", "No OOB")

## Exemples de configurations

### Elden Ring - Any% Glitchless
```json
{
  "gameId": "nd28z0ed",
  "category": "Any%",
  "subcategory": "Glitchless"
}
```

### Dark Souls III - Any%
```json
{
  "gameId": "h3zzq4d2",
  "category": "Any%",
  "subcategory": null
}
```

### Sekiro - Any%
```json
{
  "gameId": "gx1vm4gp",
  "category": "Any%",
  "subcategory": null
}
```

## Listes de jeux populaires (à vérifier)

| Jeu | ID | Notes |
|-----|----|----|
| Elden Ring | nd28z0ed | Vérifié |
| Dark Souls III | h3zzq4d2 | À vérifier |
| Sekiro: Shadows Die Twice | gx1vm4gp | À vérifier |
| Bloodborne | l00p1zql | À vérifier |
| Dark Souls | 169w4q0x | À vérifier |

## Outils sur Speedrun.com

- **Leaderboard** : https://www.speedrun.com/GAME_ID
- **API** : https://github.com/speedruncomorg/api
- **API Docs** : https://github.com/speedruncomorg/api/blob/master/README.md

## Dépannage du script PowerShell

### Le script ne s'exécute pas ?
- **Clique-droit** sur `get_game_id.ps1` → "Exécuter avec PowerShell"
- Ou tape dans PowerShell : `powershell -ExecutionPolicy Bypass -File "get_game_id.ps1"`
- **Policy bloquée** : `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

### Le menu est bloqué/ne répond plus ?
- **Ferme le terminal** et relance le script
- **Validation renforcée** : Le nouveau script évite les boucles infinies
- **Entrées invalides** : Message d'erreur clair + nouvelle chance

### Aucun résultat trouvé ?
- **Vérifie l'orthographe** du nom du jeu
- **Essaie avec une partie** du nom (ex: "Souls" au lieu de "Dark Souls")
- **Va directement** sur https://www.speedrun.com pour vérifier le nom exact

### URL OBS ne fonctionne pas ?
- **URL simplifiée** : Utilise `leaderboard.html` (plus de paramètres !)
- **Preset actif** : Vérifie avec **Choix B** que ton preset est bien actif
- **Change le preset actif** : **Choix C** dans le menu pour switcher

### Gestion des presets
- **Voir les détails** : **Choix B** → affiche URL, Game ID, catégories, etc.
- **Changer rapidement** : **Choix C** → switch entre jeux en 2 clics
- **Supprimer proprement** : **Choix D** → confirmation de sécurité
- **Problème de sauvegarde** : Vérifier les droits d'écriture sur le dossier

## Problèmes courants

### Mon jeu n'apparaît pas
- Vérifie le nom exact (casse sensible)
- Utilise l'API pour chercher
- La catégorie doit être de type "per-game"

### Sous-catégorie non trouvée
- Assure-toi que `variable[is-subcategory] = true`
- Le label doit correspondre exactement (ex: "Glitchless" pas "glitchless")

### Aucun run n'apparaît
- Vérifie que la catégorie/sous-catégorie est correcte
- Regarde les runs manuellement sur le site pour confirmer
