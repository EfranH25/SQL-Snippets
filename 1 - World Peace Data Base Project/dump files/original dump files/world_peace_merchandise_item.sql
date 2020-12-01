-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: world_peace
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `merchandise_item`
--

DROP TABLE IF EXISTS `merchandise_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchandise_item` (
  `merchandise_item_id` char(10) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `unit_price` int DEFAULT NULL,
  `qoh` int DEFAULT NULL,
  `bundle_id` char(10) DEFAULT NULL,
  PRIMARY KEY (`merchandise_item_id`),
  UNIQUE KEY `description_idx` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchandise_item`
--

LOCK TABLES `merchandise_item` WRITE;
/*!40000 ALTER TABLE `merchandise_item` DISABLE KEYS */;
INSERT INTO `merchandise_item` VALUES ('B000000001','Asian Bundle',105000,20,NULL),('B000000002','Japanese Bundle',6800,93,'B000000001'),('B000000003','Tokyo Bundle',5000,93,'B000000002'),('B000000004','Gourmet Bundle',2550,56,'B000000006'),('B000000005','Chef\'s Gift Set',57500,9,'B000000006'),('B000000006','King\'s Feast',599000,5,NULL),('BAMBOOBOOK','Bamboo Notebook',200,464,NULL),('CANADAMPL','Canadian Maple Syrup',2200,251,'B000000004'),('DRAGONPTNG','Dragon Painting',300,23,NULL),('DUTCHOVEN','Dutch Oven',10900,16,'B000000005'),('ITALYPASTA','Italian Pasta Machine',49900,10,'B000000005'),('KENYANDRUM','Kenyan Drum',6250,14,NULL),('KOILIGHT','Koi Nightlight',2250,178,'B000000002'),('KYOTOCBOOK','Kyoto Cookbook',1675,123,'B000000002'),('MAORISPEAR','Maori Spear',50000,5,'B000000006'),('MAYANPRYMD','Mayan Pyramid',1450,240,NULL),('TANGSCROLL','Tang Dynasty Scroll',100000,20,'B000000001'),('THAIMAP','Thailand Map',4600,976,'B000000001'),('THORSTATUE','Thor Statue',2500,98,NULL),('TOKYOGUIDE','Downtown Tokyo Guide Book',3599,93,'B000000003'),('TOKYONOVEL','A Tokyo Love Story',2000,145,'B000000003'),('USCOOKIES','New Orleans Cookies',799,56,'B000000004');
/*!40000 ALTER TABLE `merchandise_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-01  3:54:47
