-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.4.12-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных project-guid
CREATE DATABASE IF NOT EXISTS `project-guid` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `project-guid`;

-- Дамп структуры для таблица project-guid.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` varchar(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `color` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_categories_users_id` (`user_id`),
  CONSTRAINT `FK_categories_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1260;

-- Дамп данных таблицы project-guid.categories: ~2 rows (приблизительно)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `user_id`, `color`) VALUES
	('1', 'work', NULL, '#ffd740'),
	('2', 'home', NULL, '#2CA900');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Дамп структуры для таблица project-guid.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` varchar(11) NOT NULL,
  `task_id` varchar(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_comments_tasks_id` (`task_id`),
  CONSTRAINT `FK_comments_tasks_id` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы project-guid.comments: ~3 rows (приблизительно)
DELETE FROM `comments`;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `task_id`, `text`, `date`) VALUES
	('3b38ylt49ba', 'r32hm4ljgxl', 'hello', '2020-05-04 18:35:16'),
	('o2nw21zl1nn', 'r32hm4ljgxl', 'why', '2020-05-04 18:34:58'),
	('pcsypkddqas', 'r32hm4ljgxl', 'lol', '2020-05-04 18:22:38');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- Дамп структуры для процедура project-guid.signup
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `signup`(
	IN `name` varchar(255),
	IN `login` varchar(255),
	IN `password` varchar(255)
)
BEGIN
  INSERT INTO users (Name, Login, Password)
    VALUES (name, login, password);
  COMMIT;
  SELECT
    id, name, login, role
  FROM users u
  WHERE u.Name = name
  AND u.Login = login
  AND u.Password = password;
END//
DELIMITER ;

-- Дамп структуры для таблица project-guid.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` varchar(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `end_date` bigint(13) DEFAULT NULL,
  `is_done` int(1) NOT NULL DEFAULT 0,
  `category_id` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tasks_users_id` (`user_id`),
  KEY `FK_tasks_categories_id` (`category_id`),
  CONSTRAINT `FK_tasks_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_tasks_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы project-guid.tasks: ~1 rows (приблизительно)
DELETE FROM `tasks`;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`, `user_id`, `name`, `description`, `end_date`, `is_done`, `category_id`) VALUES
	('r32hm4ljgxl', 1, 'hello', 'nice', NULL, 0, '1');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;

-- Дамп структуры для таблица project-guid.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы project-guid.users: ~1 rows (приблизительно)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `login`, `password`, `role`) VALUES
	(1, 'admin', 'admin', 'admin', 'admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
