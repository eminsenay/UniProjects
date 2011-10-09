-- MySQL dump 10.10
--
-- Host: localhost    Database: BTS_DB
-- ------------------------------------------------------
-- Server version	5.0.22-Debian_0ubuntu6.06.2-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `BTS_DB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `BTS_DB` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_turkish_ci */;

USE `BTS_DB`;

--
-- Table structure for table `AUX_INVENTORY_INDX`
--

DROP TABLE IF EXISTS `AUX_INVENTORY_INDX`;
CREATE TABLE `AUX_INVENTORY_INDX` (
  `inventory_indx` int(11) NOT NULL,
  `budget_fk` int(11) NOT NULL,
  KEY `FK_AUX_INVENTORY_INDX` (`budget_fk`),
  CONSTRAINT `FK_AUX_INVENTORY_INDX` FOREIGN KEY (`budget_fk`) REFERENCES `CORE_BUDGET` (`budget_id_i`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AUX_INVENTORY_INDX`
--


/*!40000 ALTER TABLE `AUX_INVENTORY_INDX` DISABLE KEYS */;
LOCK TABLES `AUX_INVENTORY_INDX` WRITE;
INSERT INTO `AUX_INVENTORY_INDX` VALUES (7,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,46),(1,47),(1,48),(7,49),(1,50),(1,51);
UNLOCK TABLES;
/*!40000 ALTER TABLE `AUX_INVENTORY_INDX` ENABLE KEYS */;

--
-- Table structure for table `CORE_APPROPRIATION`
--

DROP TABLE IF EXISTS `CORE_APPROPRIATION`;
CREATE TABLE `CORE_APPROPRIATION` (
  `appr_id_i` int(11) NOT NULL auto_increment,
  `appr_index_i` int(11) NOT NULL,
  `appr_amount_np13s2` decimal(13,2) default NULL,
  `appr_date_d` date NOT NULL,
  `appr_type_fk_i` int(11) NOT NULL,
  `budget_id_i` int(11) NOT NULL,
  PRIMARY KEY  (`appr_id_i`),
  UNIQUE KEY `UNIQ_INDX` (`appr_id_i`,`appr_index_i`),
  UNIQUE KEY `UNIQ_INDX2` (`budget_id_i`,`appr_index_i`),
  KEY `Ref2063` (`budget_id_i`),
  KEY `Ref1638` (`appr_type_fk_i`),
  CONSTRAINT `RefCORE_BUDGET63` FOREIGN KEY (`budget_id_i`) REFERENCES `CORE_BUDGET` (`budget_id_i`),
  CONSTRAINT `RefREF_APPROPRIATION_TYPE38` FOREIGN KEY (`appr_type_fk_i`) REFERENCES `REF_APPROPRIATION_TYPE` (`appr_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CORE_APPROPRIATION`
--


/*!40000 ALTER TABLE `CORE_APPROPRIATION` DISABLE KEYS */;
LOCK TABLES `CORE_APPROPRIATION` WRITE;
INSERT INTO `CORE_APPROPRIATION` VALUES (34,1,'10000.00','2006-12-24',3,19),(35,1,'100000.00','2006-12-24',6,20),(36,2,'169500.00','2006-12-26',3,29),(37,1,'169500.00','2006-12-26',3,29),(38,3,'169500.00','2006-12-26',3,29),(39,4,'169500.00','2006-12-26',3,29),(40,1,'20000.00','2006-12-26',3,30),(41,2,'20000.00','2006-12-26',3,30),(42,3,'20000.00','2006-12-26',3,30),(43,4,'20000.00','2006-12-26',3,30),(44,1,'1050.00','2006-12-26',3,33),(45,2,'1000.00','2006-12-26',3,33),(46,3,'1050.00','2006-12-26',3,33),(47,4,'1000.00','2006-12-26',3,33),(48,1,'2250.00','2006-12-26',3,36),(49,2,'1800.00','2006-12-26',3,36),(50,3,'1000.00','2006-12-26',3,36),(51,4,'950.00','2006-12-26',3,36),(52,1,'1000.00','2007-01-08',3,49),(53,2,'700.00','2007-01-08',3,49),(54,3,'1000.00','2007-01-09',3,49),(55,4,'1000.00','2007-01-09',3,49);
UNLOCK TABLES;
/*!40000 ALTER TABLE `CORE_APPROPRIATION` ENABLE KEYS */;

--
-- Table structure for table `CORE_BUDGET`
--

DROP TABLE IF EXISTS `CORE_BUDGET`;
CREATE TABLE `CORE_BUDGET` (
  `budget_id_i` int(11) NOT NULL auto_increment,
  `budget_type_i` int(11) NOT NULL,
  `net_budget_np13s2` decimal(13,2) NOT NULL,
  `num_main_appr_i` int(11) NOT NULL,
  `func_code_v9` varchar(9) character set utf8 collate utf8_turkish_ci NOT NULL,
  `eco_code_v4` varchar(4) character set utf8 collate utf8_turkish_ci NOT NULL,
  `inst_code_v11` varchar(11) character set utf8 collate utf8_turkish_ci NOT NULL,
  PRIMARY KEY  (`budget_id_i`),
  UNIQUE KEY `Triple_UNQ` (`inst_code_v11`,`func_code_v9`,`eco_code_v4`),
  KEY `Ref251` (`func_code_v9`),
  KEY `Ref152` (`inst_code_v11`),
  KEY `Ref353` (`eco_code_v4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CORE_BUDGET`
--


/*!40000 ALTER TABLE `CORE_BUDGET` DISABLE KEYS */;
LOCK TABLES `CORE_BUDGET` WRITE;
INSERT INTO `CORE_BUDGET` VALUES (19,1,'16043.87',4,'a','a','a'),(20,2,'98200.00',2,'a','b','a'),(21,1,'0.00',4,'b','c','a'),(22,1,'0.00',2,'b','sd','a'),(23,1,'0.00',2,'b','dgf','a'),(24,2,'0.00',4,'bed','dgf','a'),(25,2,'0.00',2,'bedqwrg','dgf','a'),(26,1,'0.00',4,'32','323','334'),(27,1,'0.00',4,'234','324','324'),(28,1,'0.00',4,'234','324','333'),(29,1,'0.00',4,'09.4.2.00','01.1','38.08.50.59'),(30,1,'0.00',4,'09.4.2.00','01.2','38.08.50.59'),(31,1,'0.00',4,'09.4.2.00','02.1','38.08.50.59'),(32,1,'0.00',4,'09.4.2.00','02.2','38.08.50.59'),(33,2,'40.00',4,'09.4.2.00','03.2','38.08.50.59'),(34,2,'0.00',4,'09.4.2.00','03.3','38.08.50.59'),(35,2,'0.00',4,'09.4.2.00','03.5','38.08.50.59'),(36,2,'200.00',4,'09.4.2.00','03.7','38.08.50.59'),(37,2,'0.00',4,'09.4.2.00','03.9','38.08.50.59'),(41,2,'0.00',2,'09.4.1.00','06.1','38.08.50.59'),(43,1,'0.00',4,'09.6.0.07','01.4','38.08.50.59'),(44,2,'0.00',4,'09.6.0.07','03.2','38.08.50.59'),(45,2,'0.00',4,'09.6.0.07','03.3','38.08.50.59'),(46,1,'0.00',4,'``','`','```'),(47,1,'0.00',4,'`int`','`','```'),(48,1,'0.00',4,'b2','c3','a1'),(49,1,'2135.76',4,'03.1.2','03.2','97.08.43.43'),(50,1,'1100.00',4,'03.1.2','03.7','97.08.43.43'),(51,1,'0.00',4,'03.1.2','03.3','97.08.43.43');
UNLOCK TABLES;
/*!40000 ALTER TABLE `CORE_BUDGET` ENABLE KEYS */;

--
-- Table structure for table `CORE_BUDGET_TRANSFER`
--

DROP TABLE IF EXISTS `CORE_BUDGET_TRANSFER`;
CREATE TABLE `CORE_BUDGET_TRANSFER` (
  `appr_trans_id_i` int(11) NOT NULL auto_increment,
  `appr_trans_date_d` date NOT NULL,
  `appr_trans_amount_np13s2` decimal(13,2) NOT NULL,
  `appr_transfer_desc_v250` varchar(250) character set utf8 collate utf8_turkish_ci default NULL,
  `to_budget_i` int(11) NOT NULL,
  `from_budget_i` int(11) NOT NULL,
  PRIMARY KEY  (`appr_trans_id_i`),
  KEY `Ref2061` (`to_budget_i`),
  KEY `Ref2062` (`from_budget_i`),
  CONSTRAINT `RefCORE_BUDGET61` FOREIGN KEY (`to_budget_i`) REFERENCES `CORE_BUDGET` (`budget_id_i`),
  CONSTRAINT `RefCORE_BUDGET62` FOREIGN KEY (`from_budget_i`) REFERENCES `CORE_BUDGET` (`budget_id_i`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CORE_BUDGET_TRANSFER`
--


/*!40000 ALTER TABLE `CORE_BUDGET_TRANSFER` DISABLE KEYS */;
LOCK TABLES `CORE_BUDGET_TRANSFER` WRITE;
INSERT INTO `CORE_BUDGET_TRANSFER` VALUES (3,'2006-12-26','100.00','100 ytl kalmÃÂ±s',19,20),(4,'2006-12-26','700.00','700luk',19,20),(5,'2006-12-26','200.00','para geldi',36,33),(6,'2007-01-08','500.00','bu birimin acilen paraya ihtiyaci var',50,49),(7,'2007-01-09','100.00','para geldi',50,49),(8,'2007-01-09','500.00','Para',50,49);
UNLOCK TABLES;
/*!40000 ALTER TABLE `CORE_BUDGET_TRANSFER` ENABLE KEYS */;

--
-- Table structure for table `CORE_EXPENSE`
--

DROP TABLE IF EXISTS `CORE_EXPENSE`;
CREATE TABLE `CORE_EXPENSE` (
  `exp_id_i` int(11) NOT NULL auto_increment,
  `inventory_no_i` int(11) NOT NULL,
  `realization_amount_np13s2` decimal(13,2) NOT NULL,
  `towhom_v100` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `realization_id_i` int(11) default NULL,
  `realization_date_d` date default NULL,
  `std_request_date_d` date default NULL,
  `std_request_amount_np13s2` decimal(13,2) default NULL,
  `std_material_type_v250` varchar(250) character set utf8 collate utf8_turkish_ci default NULL,
  `std_unit_v100` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `std_eco_code_v9` varchar(9) character set utf8 collate utf8_turkish_ci default NULL,
  `wgr_additional_1_np13s2` decimal(13,2) default NULL,
  `wgr_additional_2_np13s2` decimal(13,2) default NULL,
  `wgr_additional_3_np13s2` decimal(13,2) default NULL,
  `wgr_additional_4_np13s2` decimal(13,2) default NULL,
  `wgr_additional_5_np13s2` decimal(13,2) default NULL,
  `wgr_additional_6_np13s2` decimal(13,2) default NULL,
  `stat_fk_i` int(11) NOT NULL,
  `budget_id_i` int(11) NOT NULL,
  PRIMARY KEY  (`exp_id_i`),
  KEY `Ref2065` (`budget_id_i`),
  KEY `Ref826` (`stat_fk_i`),
  CONSTRAINT `RefCORE_BUDGET65` FOREIGN KEY (`budget_id_i`) REFERENCES `CORE_BUDGET` (`budget_id_i`),
  CONSTRAINT `RefREF_STATUS26` FOREIGN KEY (`stat_fk_i`) REFERENCES `REF_STATUS` (`stat_id_i`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CORE_EXPENSE`
--


/*!40000 ALTER TABLE `CORE_EXPENSE` DISABLE KEYS */;
LOCK TABLES `CORE_EXPENSE` WRITE;
INSERT INTO `CORE_EXPENSE` VALUES (48,1,'10.00','aselsan',1,'2006-01-09','2006-01-08','10.00','CD','Bilgisayar muh.','03.2.01.1',NULL,NULL,NULL,NULL,NULL,NULL,1,49),(49,2,'30.00','',0,'2007-01-09','2007-01-09','30.00','Kalem','Bilgisayar Muh.','03.2.1.01',NULL,NULL,NULL,NULL,NULL,NULL,3,49),(50,3,'10.00','Aselsan',12,'2007-01-09',NULL,'12.00','CD','Bilgisayar Muh.','03.2.1.01',NULL,NULL,NULL,NULL,NULL,NULL,1,49),(51,4,'10.00','',0,'2007-01-09','2007-01-09','10.00','Defter','Bilgisayar Muh.','03.2.1.01',NULL,NULL,NULL,NULL,NULL,NULL,2,49),(52,5,'15.00','Aselsan',13,'2007-01-09','2007-01-09','15.00','CD','Bil','03.2.1.01',NULL,NULL,NULL,NULL,NULL,NULL,1,49),(53,6,'10.00','',0,'2007-01-09','2007-01-09','10.00','Disket','Bilgisayar Muh.','03.2.1.01',NULL,NULL,NULL,NULL,NULL,NULL,3,49);
UNLOCK TABLES;
/*!40000 ALTER TABLE `CORE_EXPENSE` ENABLE KEYS */;

--
-- Table structure for table `REF_APPROPRIATION_TYPE`
--

DROP TABLE IF EXISTS `REF_APPROPRIATION_TYPE`;
CREATE TABLE `REF_APPROPRIATION_TYPE` (
  `appr_type_id` int(11) NOT NULL auto_increment,
  `appr_type_v3` varchar(3) character set utf8 collate utf8_turkish_ci NOT NULL,
  PRIMARY KEY  (`appr_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `REF_APPROPRIATION_TYPE`
--


/*!40000 ALTER TABLE `REF_APPROPRIATION_TYPE` DISABLE KEYS */;
LOCK TABLES `REF_APPROPRIATION_TYPE` WRITE;
INSERT INTO `REF_APPROPRIATION_TYPE` VALUES (1,'ADD'),(3,'M3'),(6,'M6');
UNLOCK TABLES;
/*!40000 ALTER TABLE `REF_APPROPRIATION_TYPE` ENABLE KEYS */;

--
-- Table structure for table `REF_STATUS`
--

DROP TABLE IF EXISTS `REF_STATUS`;
CREATE TABLE `REF_STATUS` (
  `stat_id_i` int(11) NOT NULL auto_increment,
  `stat_type_v1` varchar(1) character set utf8 collate utf8_turkish_ci NOT NULL,
  `stat_code_v1` varchar(1) character set utf8 collate utf8_turkish_ci NOT NULL,
  `stat_desc_v50` varchar(50) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`stat_id_i`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `REF_STATUS`
--


/*!40000 ALTER TABLE `REF_STATUS` DISABLE KEYS */;
LOCK TABLES `REF_STATUS` WRITE;
INSERT INTO `REF_STATUS` VALUES (1,'E','A','ACTIVE EXPENSE'),(2,'E','D','DELETED EXPENSE'),(3,'A','W','WAITING EXPENSE');
UNLOCK TABLES;
/*!40000 ALTER TABLE `REF_STATUS` ENABLE KEYS */;

--
-- Dumping routines for database 'BTS_DB'
--
DELIMITER ;;
DELIMITER ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

