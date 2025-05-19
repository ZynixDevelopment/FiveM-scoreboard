# FiveM Scoreboard - Kills, Morts, Ratio avec Base de Données (TOP 100, NUI/GUI)

Ce script affiche un scoreboard graphique (NUI) des 100 meilleurs joueurs de votre serveur FiveM, basé sur les **kills**, **morts** et le **ratio**. Le menu s’ouvre automatiquement à l’appui sur la touche **TAB** et se ferme à son relâchement. Les statistiques sont stockées dans une base de données MySQL et s’affichent dans une interface moderne.

---

## Installation

### 1. Prérequis

- **FiveM FXServer**
- Une base de données **MySQL** ou **MariaDB**
- **[oxmysql](https://github.com/overextended/oxmysql)** (recommandé)  
  ou **[ghmattimysql](https://github.com/GHMatti/ghmattimysql)**

### 2. Téléchargement & Déploiement

1. Placez ce dossier dans le répertoire `resources` de votre serveur.
2. Ajoutez la ressource à votre `server.cfg` :
   ```
   ensure nom_de_ta_ressource
   ```

### 3. Base de données

Créez la table suivante dans votre base de données :
```sql
CREATE TABLE IF NOT EXISTS `scoreboard_stats` (
  `identifier` VARCHAR(50) NOT NULL PRIMARY KEY,
  `kills` INT NOT NULL DEFAULT 0,
  `deaths` INT NOT NULL DEFAULT 0
);
```

### 4. Configuration MySQL

Dans votre `server.cfg`, ajoutez (exemple pour oxmysql) :
```
set mysql_connection_string "mysql://USER:PASSWORD@HOST/DATABASE?charset=utf8mb4"
ensure oxmysql
```
Adaptez selon votre extension et vos identifiants.

---

## Utilisation

- **Appuyez sur la touche TAB** pour ouvrir le scoreboard. Relâchez TAB pour le fermer.
- Le tableau affiche **les 100 meilleurs joueurs** (classés par kills décroissants), avec leur identifiant, kills, morts et ratio.
- L’affichage se fait dans une interface graphique moderne (NUI).

---

## Dépendances

- [oxmysql](https://github.com/overextended/oxmysql) ou [ghmattimysql](https://github.com/GHMatti/ghmattimysql)
- Un serveur FiveM sous FXServer
- Une base de données MySQL ou MariaDB

---

## Structure des fichiers

- `server.lua` : Gère l’insertion, la mise à jour et la récupération des stats dans la BDD.
- `client.lua` : Gère la détection de la touche TAB, la communication NUI, et l’affichage du scoreboard.
- `html/scoreboard.html` : Interface graphique du scoreboard.
- `html/scoreboard.css` : Style du scoreboard.
- `html/scoreboard.js` : Logique d’affichage et de mise à jour dynamique du tableau.
- `fxmanifest.lua` : Déclaration des scripts et de la NUI.

---

## Explications

- **Serveur** : À chaque kill/mort, les stats sont mises à jour en BDD. À chaque ouverture du menu, le serveur envoie le TOP 100.
- **Client** : 
    - Affiche le menu avec TAB (appui/relâchement = ouvre/ferme).
    - Récupère les données du serveur et les affiche dans la NUI.
- **NUI** : Interface moderne, responsive, affichant le classement en temps réel.  
  (Pour afficher le pseudo, Steam, etc., adaptez la récupération côté serveur.)

---

## Personnalisation

- Pour afficher d'autres infos (pseudo, Steam, etc.), modifiez la requête SQL et la structure des données envoyées à la NUI.
- Pour modifier le style, éditez `html/scoreboard.css`.
- Pour changer la touche, modifiez le code dans `client.lua` (`IsControlPressed(0, 37)` → voir [docs FiveM controls](https://docs.fivem.net/docs/game-references/controls/)).

---

## Aide & Support

Pour toute question, ouvrez une issue ou contactez le développeur.

---
