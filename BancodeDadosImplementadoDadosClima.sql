CREATE DATABASE  IF NOT EXISTS `dadosclima` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `dadosclima`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dadosclima
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `clima`
--

DROP TABLE IF EXISTS `clima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clima` (
  `id_clima` int(11) NOT NULL AUTO_INCREMENT,
  `descrição` varchar(200) DEFAULT NULL,
  `categoria` varchar(200) DEFAULT NULL,
  `nivel_intensidade` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_clima`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clima`
--

LOCK TABLES `clima` WRITE;
/*!40000 ALTER TABLE `clima` DISABLE KEYS */;
/*!40000 ALTER TABLE `clima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_clima`
--

DROP TABLE IF EXISTS `local_clima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_clima` (
  `id_local` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` int(11) DEFAULT NULL,
  `longitude` int(11) DEFAULT NULL,
  `timezone` varchar(100) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp(),
  `ativo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_local`),
  UNIQUE KEY `timezone` (`timezone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_clima`
--

LOCK TABLES `local_clima` WRITE;
/*!40000 ALTER TABLE `local_clima` DISABLE KEYS */;
/*!40000 ALTER TABLE `local_clima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicao`
--

DROP TABLE IF EXISTS `medicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicao` (
  `id_medico` int(11) NOT NULL AUTO_INCREMENT,
  `horario` time NOT NULL,
  `temperatura` int(11) DEFAULT NULL,
  `velocidade_vento` decimal(5,2) DEFAULT NULL,
  `data_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_clima` int(11) DEFAULT NULL,
  `id_local` int(11) DEFAULT NULL,
  `data_medicao` datetime DEFAULT NULL,
  PRIMARY KEY (`id_medico`),
  UNIQUE KEY `unique_medicao` (`data_medicao`,`id_local`),
  KEY `fk_medicao_clima` (`id_clima`),
  KEY `fk_medicao_local` (`id_local`),
  CONSTRAINT `fk_medicao_clima` FOREIGN KEY (`id_clima`) REFERENCES `clima` (`id_clima`),
  CONSTRAINT `fk_medicao_local` FOREIGN KEY (`id_local`) REFERENCES `local_clima` (`id_local`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicao`
--

LOCK TABLES `medicao` WRITE;
/*!40000 ALTER TABLE `medicao` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicao` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-25 16:34:47
