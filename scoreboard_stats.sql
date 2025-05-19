CREATE TABLE IF NOT EXISTS `scoreboard_stats` (
  `identifier` VARCHAR(50) NOT NULL PRIMARY KEY,
  `kills` INT NOT NULL DEFAULT 0,
  `deaths` INT NOT NULL DEFAULT 0
);
