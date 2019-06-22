CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `label` varchar(255) COLLATE utf8_bin NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '-1',
  `rare` int(11) NOT NULL DEFAULT '0',
  `can_remove` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `label` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


INSERT INTO `jobs` (`name`, `label`) VALUES
('unemployed', 'Unemployed');

CREATE TABLE IF NOT EXISTS `job_grades` (
`id` int(11) NOT NULL,
  `job_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `label` varchar(255) COLLATE utf8_bin NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8_bin NOT NULL,
  `skin_female` longtext COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}');

CREATE TABLE IF NOT EXISTS `users` (
`id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT '0',
  `loadout` longtext COLLATE utf8mb4_bin,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `user_accounts` (
`id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `money` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `user_inventory` (
`id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8_bin NOT NULL,
  `item` varchar(255) COLLATE utf8_bin NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `items`
 ADD PRIMARY KEY (`name`);

ALTER TABLE `jobs`
 ADD PRIMARY KEY (`name`);

ALTER TABLE `job_grades`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `user_accounts`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `user_inventory`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `job_grades`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;

ALTER TABLE `users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;

ALTER TABLE `user_accounts`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;

ALTER TABLE `user_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE user_inventory
ADD INDEX user_inventory_ident_item (identifier, item);
