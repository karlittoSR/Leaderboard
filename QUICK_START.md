# QUICK START : Leaderboard Speedrun

Configuration **automatique** en 5 minutes pour streamers !

---

## Méthode automatique (v1.0.1+)

### Première utilisation
1. **Double-clic** sur `get_game_id.ps1`
2. **Menu principal** s'affiche automatiquement
3. **Naviguer** avec ↑↓ pour sélectionner "Ajouter un nouveau preset"
4. **Appuyer sur Entrée** pour confirmer
5. **Entrer** le nom du jeu (ex: "Elden Ring")  
6. **Naviguer** ↑↓ et **Entrée** pour sélectionner le jeu dans la liste
7. **Naviguer** ↑↓ et **Entrée** pour choisir la catégorie (Any%, 100%, etc.)
8. **Optionnel** : sous-catégorie si disponible
9. **Donner un ID** au preset (suggestion auto fournie)
10. **Activer automatiquement** le preset (si c'est le premier)

**Résultat** : preset sauvé + activé automatiquement + URL copiée !

### Interface du menu principal (v1.0.1)
Le script affiche un menu avec navigation intuitive :

```
================================================
  Gestionnaire de presets SRC by karlitto__
================================================

Presets existants :
• Elden Ring - Any% Glitchless ✓ [ACTIF]
  ID: eldenring-any
• Dark Souls III - All Bosses
  ID: darksouls3-all

📍 Preset actuellement actif : Elden Ring - Any% Glitchless

Que voulez-vous faire ?
► Ajouter un nouveau preset
  Voir les détails d'un preset existant  
  Changer le preset actif
  Supprimer un preset
  Quitter le programme

Utilisez ↑↓ pour naviguer, Entrée pour sélectionner
```

**Navigation** : Utilisez **↑↓** pour vous déplacer entre les options  
**Sélection** : Appuyez sur **Entrée** pour confirmer  
**Annulation** : Appuez sur **Échap** quand disponible (indiqué à l'écran)

### Options disponibles

**1. Ajouter un nouveau preset** : Créer un nouveau preset (même workflow que première fois)  
**2. Voir les détails** : Consulter détails complets d'un preset  
**3. Changer le preset actif** : Sélectionner quel preset est actif dans OBS  
**4. Supprimer un preset** : Supprimer un preset (avec confirmation)  
**5. Quitter** : Fermer le programme

### Utilisation dans OBS
- **URL simple** : `leaderboard.html` (toujours la même !)
- **Source navigateur** : Width 400, Height 280
- **Actualise seul** : toutes les 30 secondes
- **Pas de paramètres** : lit automatiquement le preset actif

---

## Problèmes courants

### Script PowerShell bloqué
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Failed to fetch" en test navigateur  
**Normal** : limitations CORS. **Fonctionne parfaitement dans OBS !**

### Preset non affiché
1. Vérifie que `activePreset` existe dans [config.json](config.json)
2. Ou utilise [get_game_id.ps1](get_game_id.ps1) → **Choix C** pour changer le preset actif

---

## Liens utiles

- **Configuration auto** : [get_game_id.ps1](get_game_id.ps1)
- **Affichage** : [leaderboard.html](leaderboard.html)
- **Config manuelle** : [config.json](config.json)  
- **Doc complète** : [README.md](README.md)
- **Recherche manuelle** : [FIND_GAME_ID.md](FIND_GAME_ID.md)

---

**Astuce streamer** : Une seule URL dans OBS (`leaderboard.html`) ! Changez de jeu avec le script → **Choix C** pendant le stream !

---

## Guide d'utilisation du script

### Options disponibles dans le menu :
- **A. Ajouter un nouveau preset** : Workflow complet pour nouveau jeu
- **B. Voir les détails** : Affiche toutes les infos + URL d'un preset
- **C. Changer le preset actif** : Switch rapide entre jeux (idéal en stream !)
- **D. Supprimer un preset** : Suppression sécurisée avec confirmation
- **F. Quitter** : Fermer le programme

### Validation automatique :
- **Saisie sécurisée** : Plus de boucles infinies sur entrée invalide
- **Confirmations** : Demandes de confirmation pour suppressions
- **Suggestions intelligentes** : IDs de presets auto-générés
- **Gestion des erreurs** : Messages clairs en cas de problème

---

## Personnaliser le Carousel

Pour modifier les paramètres d'affichage, édite `config.json` → `defaults` :

```json
"defaults": {
  "carouselInterval": 4000,  // Durée entre les slides (ms)
  "runsPerBatch": 3,         // Nombre de runs par slide
  "topCount": 3              // Nombre de top runs toujours visibles
}
```

---

## Personnaliser l'apparence

Pour modifier les couleurs, polices, ou layout du canvas, édite le HTML directement. 

Cherche la section `DRAW` (vers la ligne 90) :

```javascript
const DRAW = {
  FLAG: { w: 20, h: 15, yOffset: 14, radius: 5 },
  COLORS: { top1: '#ffd700', top2: '#c0c0c0', top3: '#cd7f32', other: '#9fb4ca' }
}
```

Tu peux modifier les couleurs HEX, les tailles, les polices, etc.

---

## Besoin d'aide ?

- **Je ne trouve pas le Game ID** → Lance `get_game_id.ps1`
- **Aucun run n'apparaît** → Vérifie `gameId`, `category`, `subcategory` (casse sensible!)
- **Le carousel ne défile pas** → Il y a moins de runs que `runsPerBatch` + `topCount`
- **"Erreur de configuration"** → Regarde la console (F12) pour plus de détails
- **"Failed to fetch" en double-cliquant** → Lance un serveur local : `python -m http.server 8000`
- **Le script PS ne s'exécute pas** : Clique-droit → "Exécuter avec PowerShell"
