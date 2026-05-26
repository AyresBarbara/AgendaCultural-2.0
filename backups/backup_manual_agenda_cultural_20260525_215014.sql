mysqldump: [Warning] Using a password on the command line interface can be insecure.
Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don't want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 
Warning: A dump from a server that has GTIDs enabled will by default include the GTIDs of all transactions, even those that were executed during its extraction and might not be represented in the dumped data. This might result in an inconsistent data dump. 
In order to ensure a consistent backup of the database, pass --single-transaction or --lock-all-tables or --source-data. 
-- MySQL dump 10.13  Distrib 9.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: agenda_cultural
-- ------------------------------------------------------
-- Server version	9.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '299d0d61-5066-11f1-af41-14b5cdbc58c6:1-187';

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id_category` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (_binary '£´\Å\Ö\çøìŽ B¬\0','Cinema','ExibiÃ§Ãµes de filmes, documentÃ¡rios e curtas-metragens'),(_binary '©°Á\Ò\ã\ôìŽ B¬\0 ','Workshop','Oficinas, cursos e atividades educativas'),(_binary '°Á\Ò\ã\ô¥ìŽ B¬\0!','Festival','Eventos que combinam mÃºltiplas atraÃ§Ãµes e categorias'),(_binary '´\Å\Ö\çø©ìŽ B¬\0','DanÃ§a','EspetÃ¡culos de danÃ§a, balÃ© e performances corporais'),(_binary '\Å\Ö\çø©°ìŽ B¬\0','ExposiÃ§Ã£o','ExposiÃ§Ãµes de arte, fotografia e instalaÃ§Ãµes'),(_binary '\Ö\çø©°ÁìŽ B¬\0','Literatura','LanÃ§amentos de livros, saraus e feiras literÃ¡rias'),(_binary '\á\ò£´\Å\ÖìŽ B¬\0','MÃºsica','Eventos relacionados a shows, concertos e apresentaÃ§Ãµes musicais'),(_binary '\çø©°Á\ÒìŽ B¬\0','Gastronomia','Festivais gastronÃ´micos e feiras de comida'),(_binary '\ò£´\Å\Ö\çìŽ B¬\0','Teatro','PeÃ§as teatrais, monÃ³logos e performances cÃªnicas'),(_binary 'ø©°Á\Ò\ãìŽ B¬\0','Esporte','CompetiÃ§Ãµes esportivas e eventos de atividade fÃ­sica');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id_comment` binary(16) NOT NULL,
  `text` text NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` binary(16) DEFAULT NULL,
  `event_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`id_event`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (_binary '¡²\Ã\Ô\å\öìŽ B¬\02','Estou ansioso para este festival! Quem mais vai?','2025-05-20 10:15:00',_binary '²\Ã\Ô\å\ö§ìŽ B¬\0',_binary 'Á\Ò\ã\ô¥¶ìŽ B¬\0\"'),(_binary '§¸\É\Ð\á\òìŽ B¬\08','Adoro comida regional, nÃ£o vou perder!','2025-05-26 13:40:00',_binary '¸\É\Ð\á\ò£ìŽ B¬\0	',_binary '\Ç\Ø\é\ð¡²ìŽ B¬\0('),(_binary '²\Ã\Ô\å\ö§ìŽ B¬\03','Adoro Shakespeare, nÃ£o vejo a hora de assistir!','2025-05-21 14:30:00',_binary '\Ã\Ô\å\ö§¸ìŽ B¬\0',_binary '\Ò\ã\ô¥¶\ÇìŽ B¬\0#'),(_binary '¸\É\Ð\á\ò£ìŽ B¬\09','AlguÃ©m quer formar um grupo para correr junto?','2025-05-27 08:15:00',_binary '\É\Ð\á\ò£´ìŽ B¬\0',_binary '\Ø\é\ð¡²\ÃìŽ B¬\0)'),(_binary '\Ã\Ô\å\ö§¸ìŽ B¬\04','AlguÃ©m sabe quais filmes serÃ£o exibidos?','2025-05-22 09:45:00',_binary '\Ô\å\ö§¸\ÉìŽ B¬\0',_binary '\ã\ô¥¶\Ç\ØìŽ B¬\0$'),(_binary '\É\Ð\á\ò£´ìŽ B¬\0@','Este workshop Ã© para iniciantes tambÃ©m?','2025-05-28 19:30:00',_binary '\Ð\á\ò£´\ÅìŽ B¬\0',_binary '\é\ð¡²\Ã\ÔìŽ B¬\00'),(_binary '\Ð\á\ò£´\ÅìŽ B¬\0A','O festival do ano passado foi incrÃ­vel, este promete ser ainda melhor!','2025-05-29 15:50:00',_binary '¡²\Ã\Ô\å\öìŽ B¬\0',_binary '\ð¡²\Ã\Ô\åìŽ B¬\01'),(_binary '\Ô\å\ö§¸\ÉìŽ B¬\05','JÃ¡ vi este grupo danÃ§ar, sÃ£o incrÃ­veis!','2025-05-23 18:20:00',_binary '\å\ö§¸\É\ÐìŽ B¬\0',_binary '\ô¥¶\Ç\Ø\éìŽ B¬\0%'),(_binary '\å\ö§¸\É\ÐìŽ B¬\06','As fotografias do ano passado eram maravilhosas, mal posso esperar por esta ediÃ§Ã£o.','2025-05-24 11:10:00',_binary '\ö§¸\É\Ð\áìŽ B¬\0',_binary '¥¶\Ç\Ø\é\ðìŽ B¬\0&'),(_binary '\ö§¸\É\Ð\áìŽ B¬\07','Quais autores estarÃ£o presentes na feira?','2025-05-25 16:05:00',_binary '§¸\É\Ð\á\òìŽ B¬\0',_binary '¶\Ç\Ø\é\ð¡ìŽ B¬\0\'');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `id_event` binary(16) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `location` varchar(200) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `category_id` binary(16) DEFAULT NULL,
  `created_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id_event`),
  KEY `category_id` (`category_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id_category`) ON DELETE SET NULL,
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (_binary '¥¶\Ç\Ø\é\ðìŽ B¬\0&','ExposiÃ§Ã£o FotogrÃ¡fica: Olhares da Cidade','Mostra de fotografias urbanas de artistas locais','Galeria de Arte Moderna','2025-07-20 10:00:00',_binary '\Å\Ö\çø©°ìŽ B¬\0',_binary '\å\ö§¸\É\ÐìŽ B¬\0'),(_binary '¶\Ç\Ø\é\ð¡ìŽ B¬\0\'','Feira do Livro','Evento literÃ¡rio com lanÃ§amentos e sessÃµes de autÃ³grafos','PraÃ§a da Liberdade','2025-08-01 09:00:00',_binary '\Ö\çø©°ÁìŽ B¬\0',_binary '\ö§¸\É\Ð\áìŽ B¬\0'),(_binary 'Á\Ò\ã\ô¥¶ìŽ B¬\0\"','Festival de Jazz','Festival com apresentaÃ§Ãµes dos melhores mÃºsicos de jazz da cidade','Parque Municipal','2025-06-15 18:00:00',_binary '\á\ò£´\Å\ÖìŽ B¬\0',_binary '¡²\Ã\Ô\å\öìŽ B¬\0'),(_binary '\Ç\Ø\é\ð¡²ìŽ B¬\0(','Festival GastronÃ´mico','DegustaÃ§Ã£o de pratos tÃ­picos regionais','Mercado Municipal','2025-08-10 11:00:00',_binary '\çø©°Á\ÒìŽ B¬\0',_binary '§¸\É\Ð\á\òìŽ B¬\0'),(_binary '\Ò\ã\ô¥¶\ÇìŽ B¬\0#','Hamlet - O PrÃ­ncipe da Dinamarca','ClÃ¡ssico de Shakespeare em montagem contemporÃ¢nea','Teatro Municipal','2025-06-20 20:00:00',_binary '\ò£´\Å\Ö\çìŽ B¬\0',_binary '²\Ã\Ô\å\ö§ìŽ B¬\0'),(_binary '\Ø\é\ð¡²\ÃìŽ B¬\0)','Corrida pela SaÃºde','Evento esportivo beneficente com percursos de 5km e 10km','Avenida Principal','2025-08-15 07:00:00',_binary 'ø©°Á\Ò\ãìŽ B¬\0',_binary '¸\É\Ð\á\ò£ìŽ B¬\0	'),(_binary '\ã\ô¥¶\Ç\ØìŽ B¬\0$','Mostra de Cinema Latino','ExibiÃ§Ã£o de filmes premiados da AmÃ©rica Latina','Cineteatro Central','2025-07-05 19:00:00',_binary '£´\Å\Ö\çøìŽ B¬\0',_binary '\Ã\Ô\å\ö§¸ìŽ B¬\0'),(_binary '\é\ð¡²\Ã\ÔìŽ B¬\00','Workshop de Fotografia','Aprenda tÃ©cnicas avanÃ§adas de fotografia com profissionais','EspaÃ§o Cultural','2025-08-22 14:00:00',_binary '©°Á\Ò\ã\ôìŽ B¬\0 ',_binary '\É\Ð\á\ò£´ìŽ B¬\0'),(_binary '\ð¡²\Ã\Ô\åìŽ B¬\01','Festival de VerÃ£o','Evento com mÃºsica, gastronomia e atividades culturais','Praia Central','2025-09-01 16:00:00',_binary '°Á\Ò\ã\ô¥ìŽ B¬\0!',_binary '\Ð\á\ò£´\ÅìŽ B¬\0'),(_binary '\ô¥¶\Ç\Ø\éìŽ B¬\0%','EspetÃ¡culo de DanÃ§a ContemporÃ¢nea','ApresentaÃ§Ã£o do grupo Corpo em Movimento','Centro Cultural','2025-07-12 19:30:00',_binary '´\Å\Ö\çø©ìŽ B¬\0',_binary '\Ô\å\ö§¸\ÉìŽ B¬\0');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `id_favorite` binary(16) NOT NULL,
  `user_id` binary(16) DEFAULT NULL,
  `event_id` binary(16) DEFAULT NULL,
  `favorited_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_favorite`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE,
  CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`id_event`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (_binary '£´\Å\Ö\çøìŽ B¬\0D',_binary '\Ã\Ô\å\ö§¸ìŽ B¬\0',_binary '\ã\ô¥¶\Ç\ØìŽ B¬\0$','2026-05-25 21:26:46'),(_binary '©°Á\Ò\ã\ôìŽ B¬\0P',_binary '\É\Ð\á\ò£´ìŽ B¬\0',_binary '\é\ð¡²\Ã\ÔìŽ B¬\00','2026-05-25 21:26:46'),(_binary '°Á\Ò\ã\ô¥ìŽ B¬\0Q',_binary '\Ð\á\ò£´\ÅìŽ B¬\0',_binary '\ð¡²\Ã\Ô\åìŽ B¬\01','2026-05-25 21:26:46'),(_binary '´\Å\Ö\çø©ìŽ B¬\0E',_binary '\Ô\å\ö§¸\ÉìŽ B¬\0',_binary '\ô¥¶\Ç\Ø\éìŽ B¬\0%','2026-05-25 21:26:46'),(_binary '\Å\Ö\çø©°ìŽ B¬\0F',_binary '\å\ö§¸\É\ÐìŽ B¬\0',_binary '¥¶\Ç\Ø\é\ðìŽ B¬\0&','2026-05-25 21:26:46'),(_binary '\Ö\çø©°ÁìŽ B¬\0G',_binary '\ö§¸\É\Ð\áìŽ B¬\0',_binary '¶\Ç\Ø\é\ð¡ìŽ B¬\0\'','2026-05-25 21:26:46'),(_binary '\á\ò£´\Å\ÖìŽ B¬\0B',_binary '¡²\Ã\Ô\å\öìŽ B¬\0',_binary 'Á\Ò\ã\ô¥¶ìŽ B¬\0\"','2026-05-25 21:26:46'),(_binary '\çø©°Á\ÒìŽ B¬\0H',_binary '§¸\É\Ð\á\òìŽ B¬\0',_binary '\Ç\Ø\é\ð¡²ìŽ B¬\0(','2026-05-25 21:26:46'),(_binary '\ò£´\Å\Ö\çìŽ B¬\0C',_binary '²\Ã\Ô\å\ö§ìŽ B¬\0',_binary '\Ò\ã\ô¥¶\ÇìŽ B¬\0#','2026-05-25 21:26:46'),(_binary 'ø©°Á\Ò\ãìŽ B¬\0I',_binary '¸\É\Ð\á\ò£ìŽ B¬\0	',_binary '\Ø\é\ð¡²\ÃìŽ B¬\0)','2026-05-25 21:26:46');
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_user` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `registration_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (_binary 'Q¢œ?\nI›ˆt`±UÐ¨‚','julio','julio@barros.com','$2a$10$Nkp/HUYegLFDHAtPQaE.k.s45vjecBKqPkKRmDVBiIMbZ4IUDhH9S','2026-05-25 21:49:50'),(_binary '¡²\Ã\Ô\å\öìŽ B¬\0','Maria Silva','maria.silva@email.com','senha123','2026-05-25 21:26:46'),(_binary '§¸\É\Ð\á\òìŽ B¬\0','Mariana Lima','mariana.lima@email.com','senha456','2026-05-25 21:26:46'),(_binary '²\Ã\Ô\å\ö§ìŽ B¬\0','JoÃ£o Santos','joao.santos@email.com','senha456','2026-05-25 21:26:46'),(_binary '¸\É\Ð\á\ò£ìŽ B¬\0	','Rafael Alves','rafael.alves@email.com','senha789','2026-05-25 21:26:46'),(_binary '\Ã\Ô\å\ö§¸ìŽ B¬\0','Ana Oliveira','ana.oliveira@email.com','senha789','2026-05-25 21:26:46'),(_binary '\É\Ð\á\ò£´ìŽ B¬\0','Juliana Martins','juliana.martins@email.com','senhaabc','2026-05-25 21:26:46'),(_binary '\Ð\á\ò£´\ÅìŽ B¬\0','Bruno Pereira','bruno.pereira@email.com','senhadef','2026-05-25 21:26:46'),(_binary '\Ô\å\ö§¸\ÉìŽ B¬\0','Pedro Costa','pedro.costa@email.com','senhaabc','2026-05-25 21:26:46'),(_binary '\å\ö§¸\É\ÐìŽ B¬\0','Carla Souza','carla.souza@email.com','senhadef','2026-05-25 21:26:46'),(_binary '\ñû4\ìú3D¶œƒŽs\çN\í­','ALANA','ALANA@XAVIER.COM','$2a$10$UWG7rmuwYWf/MVULdsGkQOWPbvqzyBLfImFZqBkbE1MOOITX25CcW','2026-05-25 21:36:13'),(_binary '\ö§¸\É\Ð\áìŽ B¬\0','Lucas Ferreira','lucas.ferreira@email.com','senha123','2026-05-25 21:26:46');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25 21:50:14
