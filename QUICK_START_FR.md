# QUICK START : Leaderboard Speedrun

Configuration **automatique** en 5 minutes pour streamers !
🌐 **Nouveau** : Interface disponible en 5 langues !

---

## ⚠️ Prérequis

**PowerShell 7 est requis** (Windows 10/11 uniquement)

1. **Installer PowerShell 7**:
   - Ouvrir le Microsoft Store (Windows 10/11)
   - Rechercher "PowerShell" (application officielle Microsoft)
   - Cliquer sur "Installer"
   - Ou télécharger depuis : https://github.com/PowerShell/PowerShell/releases

2. **Associer les fichiers .ps1 avec PowerShell 7**:
   - Clic droit sur `main.ps1`
   - Sélectionner "Ouvrir avec" → "Choisir une autre application"
   - Cocher "Toujours utiliser cette app pour ouvrir les fichiers .ps1"
   - Sélectionner "PowerShell 7" dans la liste
   - Si non visible : cliquer "Plus d'applications" et faire défiler

---

## Méthode automatique (v1.20+)

### Première utilisation
1. **Double-clic** sur `main.ps1`
2. **Menu principal** s'affiche automatiquement
3. **Naviguer** avec ↑↓ pour sélectionner "Ajouter un nouveau preset"
4. **Appuyer sur Entrée** pour confirmer
5. **Entrer** le nom du jeu (ex: "Elden Ring")  
6. **Naviguer** ↑↓ et **Entrée** pour sélectionner le jeu dans la liste
7. **Choisir** Full game ou Niveaux (si disponible)
8. **Si Niveaux** : sélectionner le niveau
9. **Naviguer** ↑↓ et **Entrée** pour choisir la catégorie (Any%, 100%, etc.)
10. **Optionnel** : sous-catégories (plusieurs choix possibles)
11. **Donner un ID** au preset (suggestion auto fournie)
12. **Activer automatiquement** le preset (si c'est le premier)

**Résultat** : preset sauvé + activé automatiquement + URL copiée !

### Interface du menu principal (v1.20)
Le script affiche un menu avec navigation intuitive dans votre langue :

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
  Définir le nom du joueur
  Paramètres de langue
  Quitter le programme

Utilisez ↑↓ pour naviguer, Entrée pour sélectionner
```

### 🌐 Support multilingue (v1.20)
L'interface est disponible dans **5 langues** :
- **🇫🇷 Français** (par défaut)
- **🇺🇸 English**  
- **🇪🇸 Español**
- **🇧🇷 Português**
- **🇨🇳 中文**

**Changer de langue** :
1. Menu principal → **Option 6** "Paramètres de langue"
2. Naviguer avec ↑↓ pour choisir votre langue
3. Appuyer sur **Entrée** → Changement immédiat !
4. La langue est **sauvegardée automatiquement**

**Navigation** : Utilisez **↑↓** pour vous déplacer entre les options  
**Sélection** : Appuyez sur **Entrée** pour confirmer  
**Retour** : Appuez sur **⌫ Backspace** quand disponible (indiqué à l'écran)  
**Confirmations** : Simple dialogue **oui/non** (o/N) - plus de saisie complexe !

### Options disponibles

**1. Ajouter un nouveau preset** : Créer un nouveau preset (même workflow que première fois)  
**2. Voir les détails** : Consulter détails complets d'un preset  
**3. Changer le preset actif** : Sélectionner quel preset est actif dans OBS  
**4. Supprimer un preset** : Supprimer un preset (confirmation simple o/N)  
**5. Définir le nom du joueur** : Afficher ta position sur le leaderboard  
**6. Paramètres de langue** : Changer la langue de l'interface (5 langues disponibles)  
**7. Quitter** : Fermer le programme

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
1. Utilise [main.ps1](main.ps1) → **Option 3** pour changer le preset actif
2. Tous les paramètres sont gérés automatiquement par le script

---

## Liens utiles

- **Configuration auto** : [main.ps1](main.ps1) (interface multilingue)
- **Affichage** : [leaderboard.html](leaderboard.html)
- **Doc complète** : [README.md](README.md)

---

**Astuce streamer** : Une seule URL dans OBS (`leaderboard.html`) ! Changez de jeu avec le script → **Option 3** pendant le stream !

**Astuce multilingue** : Configurez une fois dans votre langue, tout est sauvegardé automatiquement !

---

## Besoin d'aide ?

- **Je ne trouve pas le Game ID** → Lance `main.ps1` - tout est automatique !
- **Aucun run n'apparaît** → Utilise le script pour reconfigurer le preset
- **Le carousel ne défile pas** → Il y a moins de runs que configuré
- **"Failed to fetch" en double-cliquant** → Lance un serveur local : `python -m http.server 8000`
- **Le script PS ne s'exécute pas** : Clique-droit → "Exécuter avec PowerShell"
- **Changer de langue** → Option 6 dans le menu principal du script
