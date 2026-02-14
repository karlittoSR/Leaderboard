# Guide de Démarrage Rapide

**Obtenez votre classement speedrun dans OBS en 5 minutes**

---

## Étape 1 : Installer PowerShell 7

1. Téléchargez depuis : https://github.com/PowerShell/PowerShell/releases/
2. Choisissez la **dernière version stable** (label vert)
3. Téléchargez et installez le fichier `.msi` pour votre système

## Étape 2 : Corriger l'Accès

1. Téléchargez tous les fichiers : `configure.ps1`, `leaderboard.html`, `config.json`, `FIX_ACCESS.bat`
2. Placez-les dans le même dossier
3. **Double-cliquez sur `FIX_ACCESS.bat`** - corrige tout automatiquement

## Étape 3 : Ajouter Votre Jeu

1. Double-cliquez sur `configure.ps1` ou continuez avec la dernière option de `FIX_ACCESS.bat`.
2. Sélectionnez **"Ajouter un nouveau preset"**
3. Tapez le nom de votre jeu (ex: "Elden Ring")
4. Choisissez votre jeu dans la liste
5. Sélectionnez la catégorie (Any%, 100%, etc.)
6. Donnez-lui un nom et activez-le
7. Vous pouvez fermer le programme.

## Étape 4 : Définir Votre Nom (Optionnel)

1. Sélectionnez **"Définir mon nom"**
2. Entrez exactement votre nom d'utilisateur speedrun.com
3. Cela active la fonction PB temporaire - ignorez si non nécessaire

## Étape 5 : Ajouter à OBS

1. Ajoutez une **Source Navigateur**
2. **Fichier Local** → parcourez jusqu'à `leaderboard.html`
3. **Largeur** : 400px
4. **Hauteur** : 250px
5. **Fait !**

Votre classement se mettra à jour automatiquement et affichera votre position en bas sur une ligne séparée quand vous serez en dehors du top 3.

---

## Fonctionnalités avancées

**Pour découvrir toutes les fonctionnalités** (ajustements visuels, polices personnalisées, formats de temps, alignement des rangs, effet arc-en-ciel sur les PB récents, etc.), consultez le **[README.md](README.md)** complet !
