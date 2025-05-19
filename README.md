# FiveM Scoreboard - Kills, Morts, Ratio avec Base de Données

Ce script permet d'afficher un scoreboard avec les **kills**, **morts** et le **ratio** des 100 meilleurs joueurs sur votre serveur FiveM. Les statistiques sont stockées et récupérées via une base de données MySQL (compatible avec [oxmysql](https://github.com/overextended/oxmysql) ou [ghmattimysql](https://github.com/GHMatti/ghmattimysql)).

---

## Installation

1. **Téléchargez ou clonez** ce repository dans votre dossier `resources` de votre serveur FiveM.

2. **Ajoutez la ressource à votre `server.cfg`** :
   ```
   ensure nom_de_ta_ressource
   ```

3. **Installez une extension MySQL** :
   - [oxmysql](https://github.com/overextended/oxmysql) (recommandé)
   - ou [ghmattimysql](https://github.com/GHMatti/ghmattimysql)

4. **Créez la table SQL** dans votre base de données :
   ```sql
   CREATE TABLE IF NOT EXISTS `scoreboard_stats` (
     `identifier` VARCHAR(50) NOT NULL PRIMARY KEY,
     `kills` INT NOT NULL DEFAULT 0,
     `deaths` INT NOT NULL DEFAULT 0
   );
   ```

5. **Configurez la connexion à votre base de données** dans votre fichier de configuration (`server.cfg`), selon l'extension utilisée :
   - Pour oxmysql :
     ```
     set mysql_connection_string "mysql://USER:PASSWORD@HOST/DATABASE?charset=utf8mb4"
     ensure oxmysql
     ```

---

## Utilisation

- **Affichage du scoreboard :**
  - Tapez `/scoreboard` dans le chat ou la console F8 pour voir le classement des 100 meilleurs joueurs (console, à adapter pour une UI NUI).
- **Les stats sont automatiquement mises à jour** lors de chaque kill ou mort en jeu.
- **Le script gère l'enregistrement des nouveaux joueurs** lors de leur connexion.

---

## Dépendances

- [oxmysql](https://github.com/overextended/oxmysql) **ou** [ghmattimysql](https://github.com/GHMatti/ghmattimysql)
- Un serveur FiveM sous FXServer
- Une base de données MySQL ou MariaDB

---

## Explications

- **Côté serveur (`server.lua`)** :
  - Les kills et morts sont stockés dans la table SQL.
  - Lors d'un kill, le joueur killer gagne +1 kill, la victime +1 mort.
  - Le scoreboard ne remonte que les 100 premiers joueurs classés par kills décroissants.

- **Côté client (`client.lua`)** :
  - Permet d'afficher dans la console le scoreboard avec l'identifiant, le nombre de kills, de morts et le ratio.

- **SQL** :
  - La structure est simple, chaque joueur est identifié par son identifiant unique FiveM (`identifier`), avec le nombre de kills et de morts associés.

---

## Personnalisation

- **UI/NUI** : Ce script affiche le scoreboard dans la console. Pour une interface graphique (HTML/JS), adaptez la fonction `ShowScoreboard()` côté client.
- **Compatibilité** : Par défaut, le script utilise `oxmysql`. Pour utiliser `ghmattimysql`, remplacez simplement `exports.oxmysql` par `exports.ghmattimysql` dans le script serveur.

---

## Aide

- Pour toute question ou suggestion, ouvrez une issue ou contactez le développeur.

---
