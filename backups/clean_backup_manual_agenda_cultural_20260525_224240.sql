
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

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (_binary '��\�\�\��쎠B�\0','Cinema','Exibições de filmes, documentários e curtas-metragens'),(_binary '���\�\�\�쎠B�\0 ','Workshop','Oficinas, cursos e atividades educativas'),(_binary '��\�\�\��쎠B�\0!','Festival','Eventos que combinam múltiplas atrações e categorias'),(_binary '�\�\�\���쎠B�\0','Dança','Espetáculos de dança, balé e performances corporais'),(_binary '\�\�\����쎠B�\0','Exposição','Exposições de arte, fotografia e instalações'),(_binary '\�\�����쎠B�\0','Literatura','Lançamentos de livros, saraus e feiras literárias'),(_binary '\�\�\�\�쎠B�\0','Música','Eventos relacionados a shows, concertos e apresentações musicais'),(_binary '\�����\�쎠B�\0','Gastronomia','Festivais gastronômicos e feiras de comida'),(_binary '\�\�\�\�쎠B�\0','Teatro','Peças teatrais, monólogos e performances cênicas'),(_binary '����\�\�쎠B�\0','Esporte','Competições esportivas e eventos de atividade física');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (_binary '��\�\�\�\�쎠B�\02','Estou ansioso para este festival! Quem mais vai?','2025-05-20 10:15:00',_binary '�\�\�\�\��쎠B�\0',_binary '�\�\�\���쎠B�\0\"'),(_binary '��\�\�\�\�쎠B�\08','Adoro comida regional, não vou perder!','2025-05-26 13:40:00',_binary '�\�\�\�\�쎠B�\0	',_binary '\�\�\�\�쎠B�\0('),(_binary '�\�\�\�\��쎠B�\03','Adoro Shakespeare, não vejo a hora de assistir!','2025-05-21 14:30:00',_binary '\�\�\�\���쎠B�\0',_binary '\�\�\���\�쎠B�\0#'),(_binary '�\�\�\�\�쎠B�\09','Alguém quer formar um grupo para correr junto?','2025-05-27 08:15:00',_binary '\�\�\�\�쎠B�\0',_binary '\�\�\�\�쎠B�\0)'),(_binary '\�\�\�\���쎠B�\04','Alguém sabe quais filmes serão exibidos?','2025-05-22 09:45:00',_binary '\�\�\���\�쎠B�\0',_binary '\�\���\�\�쎠B�\0$'),(_binary '\�\�\�\�쎠B�\0@','Este workshop é para iniciantes também?','2025-05-28 19:30:00',_binary '\�\�\�\�쎠B�\0',_binary '\�\�\�\�쎠B�\00'),(_binary '\�\�\�\�쎠B�\0A','O festival do ano passado foi incrível, este promete ser ainda melhor!','2025-05-29 15:50:00',_binary '��\�\�\�\�쎠B�\0',_binary '\�\�\�\�쎠B�\01'),(_binary '\�\�\���\�쎠B�\05','Já vi este grupo dançar, são incríveis!','2025-05-23 18:20:00',_binary '\�\���\�\�쎠B�\0',_binary '\���\�\�\�쎠B�\0%'),(_binary '\�\���\�\�쎠B�\06','As fotografias do ano passado eram maravilhosas, mal posso esperar por esta edição.','2025-05-24 11:10:00',_binary '\���\�\�\�쎠B�\0',_binary '��\�\�\�\�쎠B�\0&'),(_binary '\���\�\�\�쎠B�\07','Quais autores estarão presentes na feira?','2025-05-25 16:05:00',_binary '��\�\�\�\�쎠B�\0',_binary '�\�\�\�\�쎠B�\0\'');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (_binary '��\�\�\�\�쎠B�\0&','Exposição Fotográfica: Olhares da Cidade','Mostra de fotografias urbanas de artistas locais','Galeria de Arte Moderna','2025-07-20 10:00:00',_binary '\�\�\����쎠B�\0',_binary '\�\���\�\�쎠B�\0'),(_binary '�\�\�\�\�쎠B�\0\'','Feira do Livro','Evento literário com lançamentos e sessões de autógrafos','Praça da Liberdade','2025-08-01 09:00:00',_binary '\�\�����쎠B�\0',_binary '\���\�\�\�쎠B�\0'),(_binary '�\�\�\���쎠B�\0\"','Festival de Jazz','Festival com apresentações dos melhores músicos de jazz da cidade','Parque Municipal','2025-06-15 18:00:00',_binary '\�\�\�\�쎠B�\0',_binary '��\�\�\�\�쎠B�\0'),(_binary '\�\�\�\�쎠B�\0(','Festival Gastronômico','Degustação de pratos típicos regionais','Mercado Municipal','2025-08-10 11:00:00',_binary '\�����\�쎠B�\0',_binary '��\�\�\�\�쎠B�\0'),(_binary '\�\�\���\�쎠B�\0#','Hamlet - O Príncipe da Dinamarca','Clássico de Shakespeare em montagem contemporânea','Teatro Municipal','2025-06-20 20:00:00',_binary '\�\�\�\�쎠B�\0',_binary '�\�\�\�\��쎠B�\0'),(_binary '\�\�\�\�쎠B�\0)','Corrida pela Saúde','Evento esportivo beneficente com percursos de 5km e 10km','Avenida Principal','2025-08-15 07:00:00',_binary '����\�\�쎠B�\0',_binary '�\�\�\�\�쎠B�\0	'),(_binary '\�\���\�\�쎠B�\0$','Mostra de Cinema Latino','Exibição de filmes premiados da América Latina','Cineteatro Central','2025-07-05 19:00:00',_binary '��\�\�\��쎠B�\0',_binary '\�\�\�\���쎠B�\0'),(_binary '\�\�\�\�쎠B�\00','Workshop de Fotografia','Aprenda técnicas avançadas de fotografia com profissionais','Espaço Cultural','2025-08-22 14:00:00',_binary '���\�\�\�쎠B�\0 ',_binary '\�\�\�\�쎠B�\0'),(_binary '\�\�\�\�쎠B�\01','Festival de Verão','Evento com música, gastronomia e atividades culturais','Praia Central','2025-09-01 16:00:00',_binary '��\�\�\��쎠B�\0!',_binary '\�\�\�\�쎠B�\0'),(_binary '\���\�\�\�쎠B�\0%','Espetáculo de Dança Contemporânea','Apresentação do grupo Corpo em Movimento','Centro Cultural','2025-07-12 19:30:00',_binary '�\�\�\���쎠B�\0',_binary '\�\�\���\�쎠B�\0');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (_binary '��\�\�\��쎠B�\0D',_binary '\�\�\�\���쎠B�\0',_binary '\�\���\�\�쎠B�\0$','2026-05-25 21:26:46'),(_binary '���\�\�\�쎠B�\0P',_binary '\�\�\�\�쎠B�\0',_binary '\�\�\�\�쎠B�\00','2026-05-25 21:26:46'),(_binary '��\�\�\��쎠B�\0Q',_binary '\�\�\�\�쎠B�\0',_binary '\�\�\�\�쎠B�\01','2026-05-25 21:26:46'),(_binary '�\�\�\���쎠B�\0E',_binary '\�\�\���\�쎠B�\0',_binary '\���\�\�\�쎠B�\0%','2026-05-25 21:26:46'),(_binary '\�\�\����쎠B�\0F',_binary '\�\���\�\�쎠B�\0',_binary '��\�\�\�\�쎠B�\0&','2026-05-25 21:26:46'),(_binary '\�\�����쎠B�\0G',_binary '\���\�\�\�쎠B�\0',_binary '�\�\�\�\�쎠B�\0\'','2026-05-25 21:26:46'),(_binary '\�\�\�\�쎠B�\0B',_binary '��\�\�\�\�쎠B�\0',_binary '�\�\�\���쎠B�\0\"','2026-05-25 21:26:46'),(_binary '\�����\�쎠B�\0H',_binary '��\�\�\�\�쎠B�\0',_binary '\�\�\�\�쎠B�\0(','2026-05-25 21:26:46'),(_binary '\�\�\�\�쎠B�\0C',_binary '�\�\�\�\��쎠B�\0',_binary '\�\�\���\�쎠B�\0#','2026-05-25 21:26:46'),(_binary '����\�\�쎠B�\0I',_binary '�\�\�\�\�쎠B�\0	',_binary '\�\�\�\�쎠B�\0)','2026-05-25 21:26:46');
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (_binary 'JØ�S�Ag�`��\�\'؏','julio','julio@barros2.com','$2a$10$3OVHXZ3C6H0xikWZ9bOqjekl11fg4W2hqQNes/WIdNF5iaMYtNTVq','2026-05-25 22:08:01'),(_binary 'Q��?\nI��t`�UШ�','julio','julio@barros.com','$2a$10$Nkp/HUYegLFDHAtPQaE.k.s45vjecBKqPkKRmDVBiIMbZ4IUDhH9S','2026-05-25 21:49:50'),(_binary '��\�\�\�\�쎠B�\0','Maria Silva','maria.silva@email.com','senha123','2026-05-25 21:26:46'),(_binary '��\�\�\�\�쎠B�\0','Mariana Lima','mariana.lima@email.com','senha456','2026-05-25 21:26:46'),(_binary '�\�\�\�\��쎠B�\0','João Santos','joao.santos@email.com','senha456','2026-05-25 21:26:46'),(_binary '�\�\�\�\�쎠B�\0	','Rafael Alves','rafael.alves@email.com','senha789','2026-05-25 21:26:46'),(_binary '\�\�\�\���쎠B�\0','Ana Oliveira','ana.oliveira@email.com','senha789','2026-05-25 21:26:46'),(_binary '\�\�\�\�쎠B�\0','Juliana Martins','juliana.martins@email.com','senhaabc','2026-05-25 21:26:46'),(_binary '\�\�\�\�쎠B�\0','Bruno Pereira','bruno.pereira@email.com','senhadef','2026-05-25 21:26:46'),(_binary '\�\�\���\�쎠B�\0','Pedro Costa','pedro.costa@email.com','senhaabc','2026-05-25 21:26:46'),(_binary '\�\���\�\�쎠B�\0','Carla Souza','carla.souza@email.com','senhadef','2026-05-25 21:26:46'),(_binary '\��4\��3D����s\�N\�','ALANA','ALANA@XAVIER.COM','$2a$10$UWG7rmuwYWf/MVULdsGkQOWPbvqzyBLfImFZqBkbE1MOOITX25CcW','2026-05-25 21:36:13'),(_binary '\���\�\�\�쎠B�\0','Lucas Ferreira','lucas.ferreira@email.com','senha123','2026-05-25 21:26:46');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

