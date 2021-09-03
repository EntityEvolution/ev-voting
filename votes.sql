ALTER TABLE `users` ADD `user_voted` INT NOT NULL DEFAULT '0'

CREATE TABLE `ev_voting` (
  `license`     VARCHAR(255) NOT NULL,
  `choice`      VARCHAR(255) NOT NULL,
  
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;