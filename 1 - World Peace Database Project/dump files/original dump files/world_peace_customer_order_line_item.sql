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
-- Table structure for table `customer_order_line_item`
--

DROP TABLE IF EXISTS `customer_order_line_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_order_line_item` (
  `customer_order_id` char(10) NOT NULL,
  `merchandise_item_id` char(10) NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`customer_order_id`,`merchandise_item_id`),
  KEY `item_id_fk` (`merchandise_item_id`),
  CONSTRAINT `customer_order_line_item_ibfk_1` FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`customer_order_id`),
  CONSTRAINT `item_id_fk` FOREIGN KEY (`merchandise_item_id`) REFERENCES `merchandise_item` (`merchandise_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order_line_item`
--

LOCK TABLES `customer_order_line_item` WRITE;
/*!40000 ALTER TABLE `customer_order_line_item` DISABLE KEYS */;
INSERT INTO `customer_order_line_item` VALUES ('D000000001','BAMBOOBOOK',4),('D000000001','DRAGONPTNG',2),('D000000001','THORSTATUE',1),('D000000002','BAMBOOBOOK',20),('D000000002','DRAGONPTNG',50),('D000000002','THORSTATUE',15),('D000000003','DRAGONPTNG',1000),('D000000003','THORSTATUE',500);
/*!40000 ALTER TABLE `customer_order_line_item` ENABLE KEYS */;
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
