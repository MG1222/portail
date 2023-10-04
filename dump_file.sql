-- MySQL dump 10.13  Distrib 8.0.33, for macos13.3 (x86_64)
--
-- Host: 127.0.0.1    Database: phP
-- ------------------------------------------------------
-- Server version	5.7.39

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

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL,
  `password` varchar(250) NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `reset_token` varchar(100) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (12,'AdminMain@email.com','$2y$10$lnAbeQny9HcZOKcT3EeyY.tObT6lhkVx7Lcyfhgs2WZ9SB1hTakpa','Main','Admin',1,'fd9f35da37579ac01b72c0e00036af8c018d58b82f5b','2023-08-11 08:17:00'),(17,'adminUx@email.com','$argon2id$v=19$m=65536,t=4,p=1$NjNMVjhMQmR2cDR1N2hnMw$CkhsPmMMdyZXEbui1RQ7Whl9PyLOD20/hpWWppCElAs','David','Ux',17,NULL,NULL),(22,'adminRum@email.com','$argon2id$v=19$m=65536,t=4,p=1$bWlMRkpHcS5yRkxkaW8uTw$kEkzrZuoA8UDAtCwb8bRHSlMIEOv9FjQ3rqGuwpUxik','Ling','RumAdmin',18,NULL,NULL),(23,'adminPerformer@email.com','$argon2id$v=19$m=65536,t=4,p=1$eXQ5V0NXQVVWOU8xMzJSUg$3j0UwHpxdAvRGeGSHAGplsx3iUGfR6A9AWTMwZ03z6U','Alex','Performer',19,NULL,NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_roles`
--

DROP TABLE IF EXISTS `admin_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_admin_role` (`admin_id`,`role_id`),
  KEY `fk_admin_roles_role` (`role_id`),
  CONSTRAINT `fk_admin_roles_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_admin_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_roles`
--

LOCK TABLES `admin_roles` WRITE;
/*!40000 ALTER TABLE `admin_roles` DISABLE KEYS */;
INSERT INTO `admin_roles` VALUES (1,12,1);
/*!40000 ALTER TABLE `admin_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `project_id` int(11) NOT NULL,
  `period` date NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `document` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `documents_ibfk_3` (`admin_id`),
  KEY `documents_ibfk_2` (`user_id`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documents_ibfk_3` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (3,'Test-admin',9,'2023-05-10',NULL,NULL,'c6adce4dc8af4b6ea95847398381b6fa.pdf'),(4,'Test-admin',13,'2023-08-10',15,NULL,'96a3b638ffef079aef0e0544e06a58e4.pdf'),(5,'Doc perf',16,'2023-08-10',17,NULL,'244ab85ed582c3eb39de3d5fa588f383.pdf');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;


--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (12,'Test-admin','2023-08-09','test comm',19,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',NULL,12),(13,'Test-admin jinx','2023-08-10','test com',18,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',15,NULL),(14,'Test-UX','2023-08-10','test comm',17,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',NULL,17),(15,'Test-UX','2023-08-09','test comm',17,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',16,NULL),(16,'Test Perf','2023-08-10','perf comment',19,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',17,NULL),(17,'Perf Second','2023-08-12','test comm',19,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',17,NULL),(18,'Ux Project','2023-07-31','test comm',17,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',16,NULL),(19,'Projet Rum ','2023-08-03','test comm',18,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',15,NULL),(20,'Project Rum','2023-08-02','test comm',18,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',18,NULL),(21,'Project Ux','2023-08-10','test comm',17,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',18,NULL),(22,'Project Perf','2023-08-04','test comm',19,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',18,NULL),(23,'Rum project','2023-08-12','test comm',18,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',NULL,22),(24,'Test-demo2','2023-08-12','test commS',20,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',18,NULL),(26,'Test-admin','2023-08-01','test comm',19,'http://dock3.atakama-technologies.com:3007/login','http://dock3.atakama-technologies.com:3007/login',17,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `type_project` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'main_admin','Super_admin'),(2,'user','Utilisateur'),(17,'admin-ux','UX'),(18,'admin-rum','Rum'),(19,'admin-performer','Performer'),(20,'Synthetique','synthetique'),(21,'Synthetique2','synT2');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `password` varchar(500) NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `reset_token` varchar(100) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_ibfk_1` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (15,'userRUM@email.com','$2y$10$IMR/TQmIknTQdG7HEcHu9eR7JkaOva.gur5lzcsN8IqPZq.vX5s.q','Marc','RUM',2,NULL,NULL),(16,'userUX@email.com','$argon2id$v=19$m=65536,t=4,p=1$SkNZci9sU3phbHNvNXFFVg$bbbt+CZ7RHmei9Meb2NvFA3/FiqCK35CU2GEMrS2CQQ','Michel','Ux',2,NULL,NULL),(17,'userPerformer@email.com','$argon2id$v=19$m=65536,t=4,p=1$QndqLkVML0dMOVZ3bUZZWQ$975wQqJ6+My8NrskWDxF4W0lPTizA6alltrLXFB9Klc','Jean','Performer',2,NULL,NULL),(18,'user@email.com','$2y$10$a.5zb5ywfB7gpADP93HZL.TSOSm3IMXMtawNhKk6azIHjeFwjnse6','test','AllProjects',2,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-29 18:01:05
