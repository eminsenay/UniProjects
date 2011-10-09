-- MySQL dump 10.10
--
-- Host: localhost    Database: SAS_DB
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
-- Current Database: `SAS_DB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `SAS_DB` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_turkish_ci */;

USE `SAS_DB`;

--
-- Table structure for table `AKADEMIK_UST_BIRIM`
--

DROP TABLE IF EXISTS `AKADEMIK_UST_BIRIM`;
CREATE TABLE `AKADEMIK_UST_BIRIM` (
  `AkademikUstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AkademikUstBirimAdi` varchar(150) character set utf8 collate utf8_turkish_ci NOT NULL,
  PRIMARY KEY  (`AkademikUstBirimNo`),
  UNIQUE KEY `AkademikUstBirimNo` (`AkademikUstBirimNo`),
  CONSTRAINT `AKADEMIK_UST_BIRIM_fk1` FOREIGN KEY (`AkademikUstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AKADEMIK_UST_BIRIM`
--


/*!40000 ALTER TABLE `AKADEMIK_UST_BIRIM` DISABLE KEYS */;
LOCK TABLES `AKADEMIK_UST_BIRIM` WRITE;
INSERT INTO `AKADEMIK_UST_BIRIM` VALUES ('000001-UBR','Eğitim Fakültesi'),('000002-UBR','Fen-Edebiyat Fakültesi'),('000003-UBR','İktisadi ve İdari Bilimler Fakültesi'),('000004-UBR','Mühendislik Fakültesi'),('000005-UBR','Uygulamalı Bilimler Yüksekokulu'),('000006-UBR','Yabancı Diller Yüksekokulu'),('000007-UBR','Atatürk İlkeleri ve İnkılap Tarihi Enstitüsü'),('000008-UBR','Biyo-Medikal Mühendisliği Enstitüsü'),('000009-UBR','Çevre Bilimleri Enstitüsü'),('00000A-UBR','Fen Bilimleri Enstitüsü'),('00000B-UBR','Kandilli Rasathanesi ve Deprem Araştırma Enstitüsü'),('00000C-UBR','Sosyal Bilimler Enstitüsü'),('00000D-UBR','Otelcilik Meslek Yüksekokulu');
UNLOCK TABLES;
/*!40000 ALTER TABLE `AKADEMIK_UST_BIRIM` ENABLE KEYS */;

--
-- Table structure for table `ANA_KALEM`
--

DROP TABLE IF EXISTS `ANA_KALEM`;
CREATE TABLE `ANA_KALEM` (
  `AnaKalemNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '',
  `AnaKalemAdi` varchar(80) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AnaKalemKodu` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1','2') default '1',
  PRIMARY KEY  (`AnaKalemNo`),
  UNIQUE KEY `AnaKalemKodu` (`AnaKalemKodu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ANA_KALEM`
--


/*!40000 ALTER TABLE `ANA_KALEM` DISABLE KEYS */;
LOCK TABLES `ANA_KALEM` WRITE;
INSERT INTO `ANA_KALEM` VALUES ('000000-AKL','DEFAULT ANA KALEM','DEFAULT','2'),('000001-AKL','MEMURLAR','01.1','1'),('000002-AKL','SÖZLEŞMELİ PERSONEL','01.2','1'),('000003-AKL','DİĞER PERSONEL','01.5','1'),('000004-AKL','MEMURLAR','02.1','1'),('000005-AKL','SÖZLEŞMELİ PERSONEL','02.2','1'),('000006-AKL','TÜKETİME YÖNELİK MAL VE MALZEME ALIMLARI','03.2','1'),('000007-AKL','YOLLUKLAR','03.3','1'),('000008-AKL','GÖREV GİDERLERİ','03.4','1'),('000009-AKL','HİZMET ALIMLARI','03.5','1'),('00000A-AKL','TEMSİL VE TANITMA GİDERLERİ','03.6','1'),('00000B-AKL','MENKUL MAL, GAYRİMADDI HAK ALIM, BAKIM VE ONARIM GİDERLERİ','03.7','1'),('00000C-AKL','GAYRİMENKUL MAL BAKIM VE ONARIM GİDERLERİ','03.8','1'),('00000D-AKL','TEDAVİ VE CENAZE GİDERLERİ','03.9','1'),('00000E-AKL','GÖREV ZARARLARI','05.1','1'),('00000F-AKL','HAZİNE YARDIMLARI','05.2','1'),('00000G-AKL','KAR AMACI GÜTMEYEN KURULUŞLARA YAPILAN TRANSFERLER','05.3','1'),('00000H-AKL','HANE HALKINA YAPILAN TRANSFERLER','05.4','1'),('00000I-AKL','YURTDIŞINA YAPILAN TRANSFERLER','05.6','1'),('00000J-AKL','MAMUL MAL ALIMLARI','06.1','1'),('00000K-AKL','GAYRİ MADDİ HAK ALIMLARI','06.3','1'),('00000L-AKL','GAYRİMENKUL SERMAYE İŞLETİM GIDERLERI','06.5','1'),('00000M-AKL','MENKUL MALLARIN BAKIM ONARIM GİDERLERİ','06.6','1'),('00000N-AKL','GAYRIMENKUL BAKIM ONARIM GİDERLERİ','06.7','1'),('00000O-AKL','DİĞER SERMAYE GİDERLERİ','06.9','1'),('00000P-AKL','BTS YEMEK GIDERLERI','01.4','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `ANA_KALEM` ENABLE KEYS */;

--
-- Table structure for table `AYNIYAT_BILGILERI`
--

DROP TABLE IF EXISTS `AYNIYAT_BILGILERI`;
CREATE TABLE `AYNIYAT_BILGILERI` (
  `AyniyatBilgileriNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `PusulaDuzenlemeTarihi` date default NULL,
  `Cilt` int(11) NOT NULL,
  `ButceTipi` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `VarakNo` int(11) default NULL,
  `MuayeneRaporuNo` int(11) default NULL,
  `TalepMuzekkeresiNo` int(11) default NULL,
  `Uye1No` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Uye1Imzaladi` enum('0','1','2') default '0',
  `Uye1ImzaTarihi` date default NULL,
  `Uye2No` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Uye2Imzaladi` enum('0','1','2') default '0',
  `Uye2ImzaTarihi` date default NULL,
  `Uye3No` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Uye3Imzaladi` enum('0','1','2') default '0',
  `Uye3ImzaTarihi` date default NULL,
  `Uye4No` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Uye4Imzaladi` enum('0','1','2') default '0',
  `Uye4ImzaTarihi` date default NULL,
  `MakbuzDuzenlemeTarihi` date NOT NULL,
  `MakbuzNo` int(11) default '0',
  `Statu` enum('0','1') default '1',
  `ToplamFaturaTutari` decimal(11,2) default NULL,
  PRIMARY KEY  (`AyniyatBilgileriNo`),
  UNIQUE KEY `AyniyatBilgileriNo` (`AyniyatBilgileriNo`),
  UNIQUE KEY `IstekFisiNo` (`IstekFisiNo`),
  KEY `Uye1No` (`Uye1No`),
  KEY `Uye2No_2` (`Uye2No`),
  KEY `Uye3No` (`Uye3No`),
  KEY `Uye4No` (`Uye4No`),
  CONSTRAINT `AYNIYAT_BILGILERI_fk` FOREIGN KEY (`IstekFisiNo`) REFERENCES `ISTEK_FISI` (`IstekFisiNo`),
  CONSTRAINT `AYNIYAT_BILGILERI_fk1` FOREIGN KEY (`Uye1No`) REFERENCES `KULLANICI` (`KullaniciNo`),
  CONSTRAINT `AYNIYAT_BILGILERI_fk2` FOREIGN KEY (`Uye2No`) REFERENCES `KULLANICI` (`KullaniciNo`),
  CONSTRAINT `AYNIYAT_BILGILERI_fk3` FOREIGN KEY (`Uye3No`) REFERENCES `KULLANICI` (`KullaniciNo`),
  CONSTRAINT `AYNIYAT_BILGILERI_fk4` FOREIGN KEY (`Uye4No`) REFERENCES `KULLANICI` (`KullaniciNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AYNIYAT_BILGILERI`
--


/*!40000 ALTER TABLE `AYNIYAT_BILGILERI` DISABLE KEYS */;
LOCK TABLES `AYNIYAT_BILGILERI` WRITE;
INSERT INTO `AYNIYAT_BILGILERI` VALUES ('00000O-AYN','00001G-RFM','2007-01-09',2007,'kdb',2,2,2,'00000F-USR','1','2007-01-09','00000G-USR','1','2007-01-09','00000G-USR','1','2007-01-09','000001-USR','1','2007-01-09','2007-01-09',1,'1','35.00');
UNLOCK TABLES;
/*!40000 ALTER TABLE `AYNIYAT_BILGILERI` ENABLE KEYS */;

--
-- Table structure for table `BEKLEYEN_URUNLER`
--

DROP TABLE IF EXISTS `BEKLEYEN_URUNLER`;
CREATE TABLE `BEKLEYEN_URUNLER` (
  `FaturaNo` char(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `TalepEdenGrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `TalepEdenBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `TalepEdenUstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FaturaTarihi` date NOT NULL,
  `Miktar` int(11) NOT NULL,
  `Aciklama` varchar(200) character set utf8 collate utf8_turkish_ci default NULL,
  `geldimi` enum('0','1') default '0',
  PRIMARY KEY  (`FaturaNo`,`UrunNo`,`TalepEdenGrupNo`),
  KEY `UrunNo` (`UrunNo`),
  KEY `TalepEdenBirimNo` (`TalepEdenBirimNo`),
  KEY `TalepEdenGrupNo` (`TalepEdenGrupNo`),
  KEY `TalepEdenUstBirimNo` (`TalepEdenUstBirimNo`),
  CONSTRAINT `bekleyen_urunler_fk` FOREIGN KEY (`TalepEdenGrupNo`) REFERENCES `GRUP` (`GrupNo`),
  CONSTRAINT `bekleyen_urunler_ibfk_1` FOREIGN KEY (`UrunNo`) REFERENCES `URUN` (`UrunNo`),
  CONSTRAINT `bekleyen_urunler_ibfk_2` FOREIGN KEY (`TalepEdenBirimNo`) REFERENCES `BIRIM` (`BirimNo`),
  CONSTRAINT `bekleyen_urunler_ibfk_3` FOREIGN KEY (`TalepEdenUstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BEKLEYEN_URUNLER`
--


/*!40000 ALTER TABLE `BEKLEYEN_URUNLER` DISABLE KEYS */;
LOCK TABLES `BEKLEYEN_URUNLER` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `BEKLEYEN_URUNLER` ENABLE KEYS */;

--
-- Table structure for table `BIRIM`
--

DROP TABLE IF EXISTS `BIRIM`;
CREATE TABLE `BIRIM` (
  `BirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `BirimAdi` varchar(150) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`BirimNo`),
  UNIQUE KEY `BirimNo` (`BirimNo`),
  KEY `UstBirimNo` (`UstBirimNo`),
  KEY `BirimAdi` (`BirimAdi`),
  CONSTRAINT `BIRIM_fk` FOREIGN KEY (`UstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BIRIM`
--


/*!40000 ALTER TABLE `BIRIM` DISABLE KEYS */;
LOCK TABLES `BIRIM` WRITE;
INSERT INTO `BIRIM` VALUES ('000000-BRM','Strateji Geliştirme Daire Başkanlığı','000000-UBR','0'),('000001-BRM','İdari ve Mali İşler Daire Başkanlığı','000000-UBR','1'),('000002-BRM','Rektörlük','000000-UBR','1'),('000003-BRM','Eğitim Fakültesi ','000001-UBR','1'),('000004-BRM','Bilgisayar ve Öğretim Teknolojileri Egitimi','000001-UBR','1'),('000005-BRM','Eğitim Bilimleri','000001-UBR','1'),('000006-BRM','İlköğretim ','000001-UBR','1'),('000007-BRM','Ortaöğretim Fen ve Matematik Alanları Eğitimi','000001-UBR','1'),('000008-BRM','Yabancı Diller Eğitimi ','000001-UBR','1'),('000009-BRM','Fen-Edebiyat Fakültesi','000002-UBR','1'),('00000A-BRM','Batı Dilleri ve Edebiyatı','000002-UBR','1'),('00000B-BRM','Çeviribilim ','000002-UBR','1'),('00000C-BRM','Felsefe','000002-UBR','1'),('00000D-BRM','Fizik','000002-UBR','1'),('00000E-BRM','Kimya ','000002-UBR','1'),('00000F-BRM','Matematik','000002-UBR','1'),('00000G-BRM','Moleküler Biyoloji ve Genetik ','000002-UBR','1'),('00000H-BRM','Psikoloji ','000002-UBR','1'),('00000I-BRM','Sosyoloji ','000002-UBR','1'),('00000J-BRM','Tarih','000002-UBR','1'),('00000K-BRM','Türk Dili ve Edebiyatı','000002-UBR','1'),('00000L-BRM','İktisadi ve İdari Bilimler Fakültesi ','000003-UBR','1'),('00000M-BRM','İktisat ','000003-UBR','1'),('00000N-BRM','İşletme ','000003-UBR','1'),('00000O-BRM','Siyaset Bilimi ve Uluslararasi İlişkiler ','000003-UBR','1'),('00000P-BRM','Mühendislik Fakültesi ','000004-UBR','1'),('00000Q-BRM','Bilgisayar Mühendisliği','000004-UBR','1'),('00000R-BRM','Elektrik-Elektronik Mühendisliği','000004-UBR','1'),('00000S-BRM','Endüstri Mühendisliği','000004-UBR','1'),('00000T-BRM','İnşaat Mühendisliği ','000004-UBR','1'),('00000U-BRM','Kimya Mühendisliği ','000004-UBR','1'),('00000V-BRM','Makina Mühendisliği ','000004-UBR','1'),('00000W-BRM','Uygulamalı Bilimler Yüksekokulu','000005-UBR','1'),('00000X-BRM','Turizm İşletmeciliği ','000005-UBR','1'),('00000Y-BRM','Uluslararası Ticaret ','000005-UBR','1'),('00000Z-BRM','Yönetim Bilişim Sistemleri ','000005-UBR','1'),('000010-BRM','Yabancı Diller Yüksekokulu ','000006-UBR','1'),('000011-BRM','Almanca Fransızca İspanyolca Birimi','000006-UBR','1'),('000012-BRM','İleri İngilizce ','000006-UBR','1'),('000013-BRM','İngilizce Hazırlık','000006-UBR','1'),('000014-BRM','Atatürk İlkeleri ve İnkılap Tarihi Enstitüsü','000007-UBR','1'),('000015-BRM','Biyo-Medikal Mühendisliği Enstitüsü ','000008-UBR','1'),('000016-BRM','Çevre Bilimleri Enstitüsü ','000009-UBR','1'),('000017-BRM','Fen Bilimleri Enstitüsü ','00000A-UBR','1'),('000018-BRM','Bilgisayar Mühendisliği (M.S., Ph.D.) ','00000A-UBR','1'),('000019-BRM','Elektrik- Elektronik Mühendisliği (M.S., Ph.D.) ','00000A-UBR','1'),('00001A-BRM','Endüstri Mühendisliği (M.S., Ph.D.) ','00000A-UBR','1'),('00001B-BRM','Finans Mühendisliği (M.S.) ','00000A-UBR','1'),('00001C-BRM','Fizik (M.S., Ph.D.) ','00000A-UBR','1'),('00001D-BRM','Hesaplamalı Bilim ve Mühendislik Yüksek Lisans Anabilim Dalı (M.S.) ','00000A-UBR','1'),('00001E-BRM','İnşaat Mühendisliği (M.S., Ph.D.) ','00000A-UBR','1'),('00001F-BRM','Kimya (M.S., Ph.D.) ','00000A-UBR','1'),('00001G-BRM','Kimya Mühendisliği (M.S., Ph.D.) ','00000A-UBR','1'),('00001H-BRM','Makina Mühendisliği (M.S., Ph.D.) ','00000A-UBR','1'),('00001I-BRM','Matematik (M.S., Ph.D.) ','00000A-UBR','1'),('00001J-BRM','Moleküler Biyoloji ve Genetik (M.S., Ph.D.) ','00000A-UBR','1'),('00001K-BRM','Mühendislik ve Teknoloji Yönetimi (M.S.) ','00000A-UBR','1'),('00001L-BRM','Nkleer Mhendislik (M.S., Ph.D.) ','00000A-UBR','1'),('00001M-BRM','Ortaöğretim Fen ve Matematik Alanları Eğitimi (M.S., Ph.D.) ','00000A-UBR','1'),('00001N-BRM','Otomotiv Mühendisliği Yüksek Lisans Programı ','00000A-UBR','1'),('00001O-BRM','Sistem ve Kontrol Mühendisliği (M.S.) ','00000A-UBR','1'),('00001P-BRM','Tıbbi Sistemler ve Bilişim Tezsiz Yüksek Lisans Programı (M.S.) ','00000A-UBR','1'),('00001Q-BRM','Yazılım Mühendisliği Tezsiz Yüksek Lisans Programı (M.S.) ','00000A-UBR','1'),('00001R-BRM','Kandilli Rasathanesi ve Deprem Araştırma Enstitüsü ','00000B-UBR','1'),('00001S-BRM','Deprem Mühendisliği ','00000B-UBR','1'),('00001T-BRM','Jeodezi ','00000B-UBR','1'),('00001U-BRM','Jeofizik ','00000B-UBR','1'),('00001V-BRM','Sosyal Bilimler Enstitüsü ','00000C-UBR','1'),('00001W-BRM','Avrupa Çalışmaları (M.A.) ','00000C-UBR','1'),('00001X-BRM','Bilişsel Bilim (M.A.) ','00000C-UBR','1'),('00001Y-BRM','Çeviribilim (Ph.D .) ','00000C-UBR','1'),('00001Z-BRM','Dilbilim (M.A.,Ph.D.) ','00000C-UBR','1'),('000020-BRM','Eğitim Bilimleri (M.A., Ph. D.) ','00000C-UBR','1'),('000021-BRM','Eleştiri ve Kültür Araştırmaları (M.A.) ','00000C-UBR','1'),('000022-BRM','Ekonomi ve Finans Tezsiz Yüksek Lisans Programı (M.A.) ','00000C-UBR','1'),('000023-BRM','Executive MBA Programı- İşletme Bölümü ','00000C-UBR','1'),('000024-BRM','Felsefe (M.A.) ','00000C-UBR','1'),('000025-BRM','İktisat (M.A., Ph.D.) ','00000C-UBR','1'),('000026-BRM','İngiliz Dili ve Edebiyatı (M.A.,Ph.D.) ','00000C-UBR','1'),('000027-BRM','İşletme (M.A.,Ph. D.) ','00000C-UBR','1'),('000028-BRM','İşletme Bilişim Sistemleri Programı (M.A.) ','00000C-UBR','1'),('000029-BRM','Konferans Çevirmenliği Tezsiz Yüksek Lisans Programı (M.A.) ','00000C-UBR','1'),('00002A-BRM','Psikoloji (M.A.) ','00000C-UBR','1'),('00002B-BRM','Siyaset Bilimi ve Uluslararasi İlişkiler (M.A., Ph.D.) ','00000C-UBR','1'),('00002C-BRM','Sosyoloji (M.A.) ','00000C-UBR','1'),('00002D-BRM','Tarih (M.A., Ph.D.) ','00000C-UBR','1'),('00002E-BRM','Türk Dili ve Edebiyatı (M.A., Ph.D.) ','00000C-UBR','1'),('00002F-BRM','Yabancı Diller Eğitimi (M.A., Ph.D.) ','00000C-UBR','1'),('00002G-BRM','Yazılı Çeviri Yüksek Lisans Programı (M.A.) ','00000C-UBR','1'),('00002H-BRM','Yönetim Bilişim Sistemleri Yüksek Lisans Programı','00000C-UBR','1'),('00002I-BRM','Otelcilik Meslek Yüksekokulu','00000D-UBR','1'),('00002J-BRM','Turizm İşletmeciliği (İkinci Öğretim) ','00000D-UBR','1'),('00002K-BRM','Diğer Birimler','00000E-UBR','1'),('00002L-BRM','Beden Eğitimi ','00000E-UBR','1'),('00002M-BRM','Güzel Sanatlar','00000E-UBR','1'),('00002N-BRM','Genel Sekreterlik','000000-UBR','1'),('00002O-BRM','Bilgi İşlem ve Yayım Daire Başkanlığı','000000-UBR','1'),('00002P-BRM','Öğrenci İşleri Daire Başkanlığı','000000-UBR','1'),('00002Q-BRM','Personel Daire Başkanlığı','000000-UBR','1'),('00002R-BRM','Sağlık Kültür Spor Daire Başkanlığı','000000-UBR','1'),('00002S-BRM','Yapı İşleri Teknik Daire Başkanlığı','000000-UBR','1'),('00002T-BRM','Yüksek Lisans Program Koordinatörleri','000000-UBR','1'),('00002U-BRM','Merkezler','000000-UBR','1'),('00002V-BRM','Çevre Bilimleri Enstitüsü (BTS)','000009-UBR','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `BIRIM` ENABLE KEYS */;

--
-- Table structure for table `BIRIM_DEPO_GIRIS`
--

DROP TABLE IF EXISTS `BIRIM_DEPO_GIRIS`;
CREATE TABLE `BIRIM_DEPO_GIRIS` (
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `BirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `DepoGirisNo` int(11) NOT NULL auto_increment,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Miktar` int(10) NOT NULL,
  `FaturaNo` char(20) character set utf8 collate utf8_turkish_ci default NULL,
  `FaturaTarihi` date NOT NULL,
  `Aciklama` varchar(200) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`GrupNo`,`DepoGirisNo`),
  KEY `BirimNo` (`BirimNo`),
  KEY `UrunNo` (`UrunNo`),
  KEY `UstBirimNo` (`UstBirimNo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BIRIM_DEPO_GIRIS`
--


/*!40000 ALTER TABLE `BIRIM_DEPO_GIRIS` DISABLE KEYS */;
LOCK TABLES `BIRIM_DEPO_GIRIS` WRITE;
INSERT INTO `BIRIM_DEPO_GIRIS` VALUES ('00002N-GRP','00000Q-BRM','000004-UBR',1,'00000D-ITM',5,NULL,'2007-01-12','ok'),('00002S-GRP','00000V-BRM','000004-UBR',1,'00000D-ITM',2,NULL,'2007-01-12','tamam');
UNLOCK TABLES;
/*!40000 ALTER TABLE `BIRIM_DEPO_GIRIS` ENABLE KEYS */;

--
-- Table structure for table `BIRIM_DEPO_HARCAMA`
--

DROP TABLE IF EXISTS `BIRIM_DEPO_HARCAMA`;
CREATE TABLE `BIRIM_DEPO_HARCAMA` (
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `BDepoHarcamaNo` int(11) NOT NULL auto_increment,
  `UstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `BirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Miktar` int(10) NOT NULL,
  `HarcamaTarihi` date NOT NULL,
  `Aciklama` varchar(200) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`GrupNo`,`BDepoHarcamaNo`),
  KEY `UrunNo` (`UrunNo`),
  KEY `UstBirimNo` (`UstBirimNo`),
  KEY `birim_depo_Harcama_ibfk_1` (`BirimNo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BIRIM_DEPO_HARCAMA`
--


/*!40000 ALTER TABLE `BIRIM_DEPO_HARCAMA` DISABLE KEYS */;
LOCK TABLES `BIRIM_DEPO_HARCAMA` WRITE;
INSERT INTO `BIRIM_DEPO_HARCAMA` VALUES ('00002N-GRP',1,'00000Q-BRM','000004-UBR','00000D-ITM',-1000,'5000-00-00',NULL),('00002N-GRP',2,'000004-UBR','','00000D-ITM',2,'2007-01-12','ok'),('00002N-GRP',3,'000004-UBR','','00000D-ITM',2,'2007-01-12','tamam'),('00002S-GRP',1,'00000V-BRM','000004-UBR','00000D-ITM',-1000,'5000-00-00',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `BIRIM_DEPO_HARCAMA` ENABLE KEYS */;

--
-- Table structure for table `BIRIM_DEPO_URUN_MIKTAR`
--

DROP TABLE IF EXISTS `BIRIM_DEPO_URUN_MIKTAR`;
CREATE TABLE `BIRIM_DEPO_URUN_MIKTAR` (
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `BirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AltLimit` int(11) NOT NULL,
  `Mevcut` int(11) default '0',
  `Aciklama` varchar(200) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`GrupNo`,`UrunNo`),
  KEY `UstBirimNo` (`UstBirimNo`),
  KEY `BirimNo` (`BirimNo`),
  KEY `birim_depo_urun_miktar_ibfk_2` (`UrunNo`),
  CONSTRAINT `birim_depo_urun_miktar_fk` FOREIGN KEY (`GrupNo`) REFERENCES `GRUP` (`GrupNo`),
  CONSTRAINT `birim_depo_urun_miktar_ibfk_1` FOREIGN KEY (`BirimNo`) REFERENCES `BIRIM` (`BirimNo`),
  CONSTRAINT `birim_depo_urun_miktar_ibfk_2` FOREIGN KEY (`UrunNo`) REFERENCES `URUN` (`UrunNo`),
  CONSTRAINT `birim_depo_urun_miktar_ibfk_3` FOREIGN KEY (`UstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BIRIM_DEPO_URUN_MIKTAR`
--


/*!40000 ALTER TABLE `BIRIM_DEPO_URUN_MIKTAR` DISABLE KEYS */;
LOCK TABLES `BIRIM_DEPO_URUN_MIKTAR` WRITE;
INSERT INTO `BIRIM_DEPO_URUN_MIKTAR` VALUES ('00002N-GRP','00000Q-BRM','000004-UBR','00000D-ITM',4,1,NULL),('00002S-GRP','00000V-BRM','000004-UBR','00000D-ITM',0,2,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `BIRIM_DEPO_URUN_MIKTAR` ENABLE KEYS */;

--
-- Table structure for table `BUTCE_BLOKE`
--

DROP TABLE IF EXISTS `BUTCE_BLOKE`;
CREATE TABLE `BUTCE_BLOKE` (
  `ButceBlokeNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `ButceDagilimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Miktar` decimal(11,2) NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1' COMMENT '0 - onceki bloke\r\n1 - aktif bloke',
  PRIMARY KEY  (`ButceBlokeNo`),
  UNIQUE KEY `ButceBlokeNo` (`ButceBlokeNo`),
  KEY `IstekFisiNo` (`IstekFisiNo`),
  KEY `ButceDagilimNo` (`ButceDagilimNo`),
  CONSTRAINT `BUTCE_BLOKE_fk` FOREIGN KEY (`IstekFisiNo`) REFERENCES `ISTEK_FISI` (`IstekFisiNo`),
  CONSTRAINT `BUTCE_BLOKE_fk1` FOREIGN KEY (`ButceDagilimNo`) REFERENCES `BUTCE_DAGILIM` (`ButceDagilimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BUTCE_BLOKE`
--


/*!40000 ALTER TABLE `BUTCE_BLOKE` DISABLE KEYS */;
LOCK TABLES `BUTCE_BLOKE` WRITE;
INSERT INTO `BUTCE_BLOKE` VALUES ('00001V-BBL','00001G-RFM','00000J-BDG','35.00','0'),('00001W-BBL','00001G-RFM','00000J-BDG','35.00','0'),('00001X-BBL','00001H-RFM','00000J-BDG','10.00','0'),('00001Y-BBL','00001H-RFM','00000J-BDG','10.00','1'),('00001Z-BBL','00001I-RFM','00000J-BDG','20.00','0'),('000020-BBL','00001I-RFM','00000J-BDG','20.00','1'),('000021-BBL','00001J-RFM','00000J-BDG','4.00','0'),('000022-BBL','00001J-RFM','00000J-BDG','4.00','1'),('000023-BBL','00001K-RFM','00000J-BDG','12.00','0'),('000024-BBL','00001L-RFM','00000J-BDG','30.00','0'),('000025-BBL','00001L-RFM','00000J-BDG','30.00','1'),('000026-BBL','00001M-RFM','00000J-BDG','10.00','0'),('000027-BBL','00001K-RFM','00000J-BDG','12.00','1'),('000028-BBL','00001M-RFM','00000J-BDG','10.00','1'),('000029-BBL','00001N-RFM','00000J-BDG','10.00','0'),('00002A-BBL','00001N-RFM','00000J-BDG','10.00','1'),('00002B-BBL','00001O-RFM','00000J-BDG','35.00','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `BUTCE_BLOKE` ENABLE KEYS */;

--
-- Table structure for table `BUTCE_DAGILIM`
--

DROP TABLE IF EXISTS `BUTCE_DAGILIM`;
CREATE TABLE `BUTCE_DAGILIM` (
  `ButceDagilimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FonksiyonelNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `BirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AnaKalemNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KurumsalNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `ToplamButce` decimal(11,2) NOT NULL,
  `KalanButce` decimal(11,2) NOT NULL,
  `BlokeEdilmis` decimal(11,2) NOT NULL,
  `ButceAtanmis` enum('0','1') NOT NULL default '1',
  `Statu` enum('0','1','2') NOT NULL default '1' COMMENT '0:deleted_1:active_2:passive',
  `DefaultButce` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`ButceDagilimNo`),
  UNIQUE KEY `ButceDagilimNo` (`ButceDagilimNo`),
  KEY `BirimButceNo` (`FonksiyonelNo`),
  KEY `AnaKalemNo` (`AnaKalemNo`),
  KEY `BirimNo` (`BirimNo`),
  CONSTRAINT `BUTCE_DAGILIM_fk` FOREIGN KEY (`FonksiyonelNo`) REFERENCES `FONKSIYONEL` (`FonksiyonelNo`),
  CONSTRAINT `BUTCE_DAGILIM_fk1` FOREIGN KEY (`AnaKalemNo`) REFERENCES `ANA_KALEM` (`AnaKalemNo`),
  CONSTRAINT `BUTCE_DAGILIM_fk2` FOREIGN KEY (`BirimNo`) REFERENCES `BIRIM` (`BirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BUTCE_DAGILIM`
--


/*!40000 ALTER TABLE `BUTCE_DAGILIM` DISABLE KEYS */;
LOCK TABLES `BUTCE_DAGILIM` WRITE;
INSERT INTO `BUTCE_DAGILIM` VALUES ('000001-BDG','000000-FNK','000001-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000002-BDG','000000-FNK','000002-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000003-BDG','000000-FNK','00002N-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000004-BDG','000000-FNK','00002O-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000005-BDG','000000-FNK','00002P-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000006-BDG','000000-FNK','00002Q-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000007-BDG','000000-FNK','00002R-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000008-BDG','000000-FNK','00002S-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('000009-BDG','000000-FNK','00002T-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('00000A-BDG','000000-FNK','00002U-BRM','000000-AKL','000000-KRM','0.00','0.00','0.00','1','1','1'),('00000B-BDG','00000P-FNK','00000P-BRM','00000J-AKL','00000N-KRM','0.00','0.00','0.00','0','1','0'),('00000C-BDG','00000P-FNK','00000Q-BRM','00000J-AKL','00000N-KRM','5000.00','5000.00','0.00','1','1','0'),('00000D-BDG','00000P-FNK','00000R-BRM','00000J-AKL','00000N-KRM','0.00','0.00','0.00','0','1','0'),('00000E-BDG','00000P-FNK','00000S-BRM','00000J-AKL','00000N-KRM','0.00','0.00','0.00','0','1','0'),('00000F-BDG','00000P-FNK','00000T-BRM','00000J-AKL','00000N-KRM','0.00','0.00','0.00','0','1','0'),('00000G-BDG','00000P-FNK','00000U-BRM','00000J-AKL','00000N-KRM','0.00','0.00','0.00','0','1','0'),('00000H-BDG','00000P-FNK','00000V-BRM','00000J-AKL','00000N-KRM','0.00','0.00','0.00','0','1','0'),('00000I-BDG','00000P-FNK','00000P-BRM','000006-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000J-BDG','00000P-FNK','00000Q-BRM','000006-AKL','000002-KRM','500000.00','499930.00','131.00','1','1','0'),('00000K-BDG','00000P-FNK','00000R-BRM','000006-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000L-BDG','00000P-FNK','00000S-BRM','000006-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000M-BDG','00000P-FNK','00000T-BRM','000006-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000N-BDG','00000P-FNK','00000U-BRM','000006-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000O-BDG','00000P-FNK','00000V-BRM','000006-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000P-BDG','00000T-FNK','00000P-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','0','0'),('00000Q-BDG','00000T-FNK','00000Q-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000R-BDG','00000T-FNK','00000R-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000S-BDG','00000T-FNK','00000S-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000T-BDG','00000T-FNK','00000T-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000U-BDG','00000T-FNK','00000U-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000V-BDG','00000T-FNK','00000V-BRM','00000D-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000W-BDG','00000T-FNK','00000P-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000X-BDG','00000T-FNK','00000Q-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000Y-BDG','00000T-FNK','00000R-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00000Z-BDG','00000T-FNK','00000S-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000010-BDG','00000T-FNK','00000T-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000011-BDG','00000T-FNK','00000U-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000012-BDG','00000T-FNK','00000V-BRM','00000C-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000013-BDG','00000T-FNK','00000P-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000014-BDG','00000T-FNK','00000Q-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000015-BDG','00000T-FNK','00000R-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000016-BDG','00000T-FNK','00000S-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000017-BDG','00000T-FNK','00000T-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000018-BDG','00000T-FNK','00000U-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('000019-BDG','00000T-FNK','00000V-BRM','00000O-AKL','000002-KRM','0.00','0.00','0.00','0','1','0'),('00001P-BDG','00003L-FNK','00002V-BRM','000001-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001R-BDG','00003L-FNK','00002V-BRM','000002-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001S-BDG','00003L-FNK','00002V-BRM','000001-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001T-BDG','00003L-FNK','00002V-BRM','000002-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001U-BDG','00003L-FNK','00002V-BRM','000004-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001V-BDG','00003L-FNK','00002V-BRM','000005-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001Y-BDG','00003L-FNK','00002V-BRM','000006-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('00001Z-BDG','00003L-FNK','00002V-BRM','000007-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000020-BDG','00003L-FNK','00002V-BRM','000009-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000021-BDG','00003L-FNK','00002V-BRM','00000B-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000022-BDG','00003L-FNK','00002V-BRM','00000D-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000023-BDG','00003M-FNK','00002V-BRM','00000J-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000024-BDG','00003N-FNK','00002V-BRM','00000P-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000025-BDG','00003N-FNK','00002V-BRM','000006-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0'),('000026-BDG','00003N-FNK','00002V-BRM','000007-AKL','00000Y-KRM','1000.00','1000.00','0.00','1','1','0');
UNLOCK TABLES;
/*!40000 ALTER TABLE `BUTCE_DAGILIM` ENABLE KEYS */;

--
-- Table structure for table `FATURA_KALEMLERI`
--

DROP TABLE IF EXISTS `FATURA_KALEMLERI`;
CREATE TABLE `FATURA_KALEMLERI` (
  `FaturaKalemiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Nevi` varchar(30) character set utf8 collate utf8_turkish_ci default NULL,
  `Miktar` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `BirimFiyat` char(15) character set utf8 collate utf8_turkish_ci default NULL,
  `KDVOrani` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `AmbarDefteriSayfaNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `YevmiyeDefteriSayfaNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `TuketimMalzemeNo` int(11) NOT NULL default '0',
  `Statu` enum('0','1') default '1',
  `OlcuBirimi` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`FaturaKalemiNo`),
  UNIQUE KEY `FaturaMaddesiNo` (`FaturaKalemiNo`),
  KEY `FATURA_MADDELERI_fk` (`IstekFisiNo`),
  CONSTRAINT `FATURA_MADDELERI_fk` FOREIGN KEY (`IstekFisiNo`) REFERENCES `ISTEK_FISI` (`IstekFisiNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `FATURA_KALEMLERI`
--


/*!40000 ALTER TABLE `FATURA_KALEMLERI` DISABLE KEYS */;
LOCK TABLES `FATURA_KALEMLERI` WRITE;
INSERT INTO `FATURA_KALEMLERI` VALUES ('00000M-FAK','00001G-RFM','Defter','5','7','18','23','12',1,'1',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `FATURA_KALEMLERI` ENABLE KEYS */;

--
-- Table structure for table `FONKSIYONEL`
--

DROP TABLE IF EXISTS `FONKSIYONEL`;
CREATE TABLE `FONKSIYONEL` (
  `FonksiyonelNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FonksiyonelKodu` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FonksiyonelAdi` varchar(150) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aciklama` text character set utf8 collate utf8_turkish_ci,
  `Statu` enum('0','1','2') NOT NULL default '1',
  PRIMARY KEY  (`FonksiyonelNo`),
  UNIQUE KEY `FonksiyonelNo` (`FonksiyonelNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `FONKSIYONEL`
--


/*!40000 ALTER TABLE `FONKSIYONEL` DISABLE KEYS */;
LOCK TABLES `FONKSIYONEL` WRITE;
INSERT INTO `FONKSIYONEL` VALUES ('000000-FNK','DEFAULT','FONKSIYONEL','DEFAULT FONKSIYONEL KOD','2'),('000001-FNK','01.1.1','Yasama ve yürütme organları hizmetleri',NULL,'1'),('000002-FNK','01.1.2','Finansal ve mali işler hizmetleri',NULL,'1'),('000003-FNK','01.1.3','Dış işleri hizmetleri',NULL,'1'),('000004-FNK','01.1.9','Sınıflandırmaya girmeyen yasama ve yürütme organları, finansal ve mali işler, dışişleri hizmetleri',NULL,'1'),('000005-FNK','01.2.1','Gelişmekte olan Ükelere yapılan ekonomik yardım hizmetleri',NULL,'1'),('000006-FNK','01.2.2','Uluslararası kuruluşlar aracılığı ile yapılan ekonomik yardım hizmetleri',NULL,'1'),('000007-FNK','01.2.9','Sınıflandırmaya girmeyen dış ekonomik yardım hizmetleri',NULL,'1'),('000008-FNK','01.3.1','Genel personel hizmetleri',NULL,'1'),('000009-FNK','01.3.2','Genel planlama ve istatistik hizmetleri',NULL,'1'),('00000A-FNK','01.3.9','Diğer genel hizmetler',NULL,'1'),('00000B-FNK','01.4.1','Doğal bilimler, mühendislik ve teknoloji konusundaki temel araştırma hizmetleri',NULL,'1'),('00000C-FNK','01.4.2','Sosyal ve beşeri bilimler konusundaki temel araştırma hizmetleri',NULL,'1'),('00000D-FNK','01.4.3','İk branşlı temel araştırma hizmetleri',NULL,'1'),('00000E-FNK','01.4.9','Sınıflandırmaya girmeyen temel araştırma hizmetleri',NULL,'1'),('00000F-FNK','01.5.0','Borç yönetimi hizmetleri',NULL,'1'),('00000G-FNK','01.6.0','Genel nitelikli transferlere ilişkin hizmetler',NULL,'1'),('00000H-FNK','01.8.8','Genel Kamu Hizmetlerine İlişkin Araştırma ve Geliştirme Hizmetleri',NULL,'1'),('00000I-FNK','01.9.9','Sınıflandırmaya girmeyen genel kamu hizmetleri',NULL,'1'),('00000J-FNK','02.1.0','Askeri  savunma hizmetleri',NULL,'1'),('00000K-FNK','02.2.0','Sivil savunma hizmetleri',NULL,'1'),('00000L-FNK','02.3.0','Dış askeri yardım hizmetleri',NULL,'1'),('00000M-FNK','02.8.8','Savunmaya ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('00000N-FNK','02.9.9','Sınıflandırmaya girmeyen savunma hizmetleri',NULL,'1'),('00000O-FNK','03.1.1','Genel güvenlik hizmetleri',NULL,'1'),('00000P-FNK','03.1.2','Adli güvenlik hizmetleri',NULL,'1'),('00000Q-FNK','03.1.3','Trafik güvenliği hizmetleri',NULL,'1'),('00000R-FNK','03.1.4','Kurumsal güvenlik hizmetleri',NULL,'1'),('00000S-FNK','03.1.9','Sınıflandırmaya girmeyen güvenlik hizmetleri',NULL,'1'),('00000T-FNK','03.2.0','Yangından korunma hizmetleri',NULL,'1'),('00000U-FNK','03.3.1','Yüksek mahkeme hizmetleri',NULL,'1'),('00000V-FNK','03.3.2','Adli mahkeme hizmetleri',NULL,'1'),('00000W-FNK','03.3.3','İdari mahkeme hizmetleri',NULL,'1'),('00000X-FNK','03.3.4','Tahkim kurulları ve ombudsmanlık vb. hizmetleri',NULL,'1'),('00000Y-FNK','03.3.9','Diğer mahkeme hizmetleri',NULL,'1'),('00000Z-FNK','03.4.0','Cezaevi idaresi hizmetleri',NULL,'1'),('000010-FNK','03.8.8','Kamu düzeni ve güvenliğe ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('000011-FNK','03.9.9','Sınıflandırmaya girmeyen kamu düzeni ve güvenlik hizmetleri',NULL,'1'),('000012-FNK','04.1.1','Genel ekonomik ve ticari  işler ve hizmetler',NULL,'1'),('000013-FNK','04.1.2','Isgc işleri ve hizmetleri',NULL,'1'),('000014-FNK','04.2.1','Tarım hizmetleri',NULL,'1'),('000015-FNK','04.2.2','Ormancılık hizmetleri',NULL,'1'),('000016-FNK','04.2.3','Balıkçılık ve avcılık hizmetleri',NULL,'1'),('000017-FNK','04.3.1','Kömür ve diğer katı yakıt hizmetleri',NULL,'1'),('000018-FNK','04.3.2','Petrol ve gaz işleri ve hizmetleri',NULL,'1'),('000019-FNK','04.3.3','Nükleer yakıt işleri ve hizmetleri',NULL,'1'),('00001A-FNK','04.3.4','Elektrik işleri ve hizmetleri',NULL,'1'),('00001B-FNK','04.3.5','Elektrik dışındaki enerji işleri ve hizmetleri',NULL,'1'),('00001C-FNK','04.3.9','Sınıflandırmaya girmeyen yakıt işleri ve hizmetleri',NULL,'1'),('00001D-FNK','04.4.1','Yakıt diışındaki madencilik, imalat ve inşaat hizmetleri',NULL,'1'),('00001E-FNK','04.4.2','İmalat işleri hizmetleri',NULL,'1'),('00001F-FNK','04.4.3','İnşaat işleri hizmetleri',NULL,'1'),('00001G-FNK','04.5.1','Karayolu inşaat işleri ve hizmetleri',NULL,'1'),('00001H-FNK','04.5.2','Karayolu sistemi işletme işleri ve hizmetleri',NULL,'1'),('00001I-FNK','04.5.3','Suyolu taşımacılığı tesisleri inşaat işleri ve hizmetleri',NULL,'1'),('00001J-FNK','04.5.4','Suyolu taşımacılığı işletme işleri ve hizmetleri',NULL,'1'),('00001K-FNK','04.5.5','Demiryolu inşaatı ve işletme işleri ve hizmetleri',NULL,'1'),('00001L-FNK','04.5.6','Havayolu taşımacılığı tesisleri inşaat ve işletme işleri ve hizmetleri',NULL,'1'),('00001M-FNK','04.5.7','Boru hattı ve diğer nakil tesislerinin inşaat işleri ve hizmetleri',NULL,'1'),('00001N-FNK','04.5.8','Boru hattı ile nakletme ve diğer taşımacılık sistemi işletme işleri ve hizmetleri',NULL,'1'),('00001O-FNK','04.5.9','Sınıflandırmaya girmeyen ulaştırma hizmetleri',NULL,'1'),('00001P-FNK','04.6.0','İletişim hizmetleri',NULL,'1'),('00001Q-FNK','04.7.1','Dağıtım ticareti, ambar ve depolama hizmetleri',NULL,'1'),('00001R-FNK','04.7.2','Otel ve lokanta hizmetleri',NULL,'1'),('00001S-FNK','04.7.3','Turizm hizmetleri',NULL,'1'),('00001T-FNK','04.7.4','İk amaçlı gelistirme projeleri işleri ve hizmetleri',NULL,'1'),('00001U-FNK','04.8.1','Genel ekonomik,ticari ve isgc araştırma ve geliştirme hizmetleri',NULL,'1'),('00001V-FNK','04.8.2','Tarım, ormancılık ,balıkçılık ve  avcılık araştırma ve geliştirme hizmetleri',NULL,'1'),('00001W-FNK','04.8.3','Yakıt ve enerji araştırma ve geliştirme hizmetleri',NULL,'1'),('00001X-FNK','04.8.4','Madencilik, imalat ve inşaat  araştırma ve geliştirme hizmetleri',NULL,'1'),('00001Y-FNK','04.8.5','Ulaştırma araştırma ve geliştirme hizmetleri',NULL,'1'),('00001Z-FNK','04.8.6','İletişim araştırma ve geliştirme hizmetleri',NULL,'1'),('000020-FNK','04.8.7','Diğer endüstriler araştırma ve geliştirme hizmetleri',NULL,'1'),('000021-FNK','04.9.9','Sınıflandırmaya girmeyen ekonomik işler ve hizmetleri',NULL,'1'),('000022-FNK','05.1.0','Atık yönetimi hizmetleri',NULL,'1'),('000023-FNK','05.2.0','Atık su yönetimi hizmetleri',NULL,'1'),('000024-FNK','05.3.0','Kirliliğin azaltılması hizmetleri',NULL,'1'),('000025-FNK','05.4.0','Doğal ortamın ve bio çeşitliliğin korunması',NULL,'1'),('000026-FNK','05.8.8','Çevre korumaya ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('000027-FNK','05.9.9','Sınıflandırmaya girmeyen Çevre koruma hizmetleri',NULL,'1'),('000028-FNK','06.1.0','İskan işleri ve hizmetleri',NULL,'1'),('000029-FNK','06.2.0','Toplum refahı hizmetleri',NULL,'1'),('00002A-FNK','06.3.0','Su temini işleri ve hizmetleri',NULL,'1'),('00002B-FNK','06.4.0','Sokak ve caddelerin aydınlatılması hizmetleri',NULL,'1'),('00002C-FNK','06.8.8','İskan ve toplum refahına ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('00002D-FNK','06.9.9','Sınıflandırmaya girmeyen iskan ve toplum refahı hizmetleri',NULL,'1'),('00002E-FNK','07.1.1','İlaç ve ilaç benzerlerinin temini hizmetleri',NULL,'1'),('00002F-FNK','07.1.2','Diğer tıbbi ürünler',NULL,'1'),('00002G-FNK','07.1.3','Terapik alet ve araç hizmetleri',NULL,'1'),('00002H-FNK','07.2.1','Genel poliklinikler',NULL,'1'),('00002I-FNK','07.2.2','İhtisaslaşmış poliklinikler',NULL,'1'),('00002J-FNK','07.2.3','Disçilik hizmetleri',NULL,'1'),('00002K-FNK','07.2.4','Yardımcı sağlik hizmetleri',NULL,'1'),('00002L-FNK','07.3.1','Genel hastane hizmetleri',NULL,'1'),('00002M-FNK','07.3.2','İhtisas hastaneleri tarafından verilen hizmetler',NULL,'1'),('00002N-FNK','07.3.3','Tıp merkezi ve doğumevlerinde verilen hizmetler',NULL,'1'),('00002O-FNK','07.3.4','Hastane bakım ve nekahat merkezlerinde verilen hizmetler',NULL,'1'),('00002P-FNK','07.3.9','Sınıflandırmaya girmeyen hastane işleri ve hizmetleri',NULL,'1'),('00002Q-FNK','07.4.0','Halk sağlığı hizmetleri',NULL,'1'),('00002R-FNK','07.8.8','Sağlık hizmetlerine ilişkin araştırma ve gelistirme hizmetleri',NULL,'1'),('00002S-FNK','07.9.9','Sınıflandırmaya girmeyen sağlık hizmetleri',NULL,'1'),('00002T-FNK','08.1.0','Dinlenme ve spor hizmetleri',NULL,'1'),('00002U-FNK','08.2.0','Kültür hizmetleri',NULL,'1'),('00002V-FNK','08.3.0','Yayın ve yayım hizmetleri',NULL,'1'),('00002W-FNK','08.4.0','Din hizmetleri',NULL,'1'),('00002X-FNK','08.8.8','Dinlenme kültür ve din hizmetlerine ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('00002Y-FNK','08.9.9','Sınıflandırmaya girmeyen dinlenme, kültür ve din hizmetleri',NULL,'1'),('00002Z-FNK','09.1.1','Okul öncesi eğitim hizmetleri',NULL,'1'),('000030-FNK','09.1.2','İlköğretim hizmetleri',NULL,'1'),('000031-FNK','09.2.1','Ortaöğretim genel programlar',NULL,'1'),('000032-FNK','09.2.2','Mesleki ve teknik ortaöğretim',NULL,'1'),('000033-FNK','09.2.9','Sınıflandırmaya girmeyen ortaöğretim hizmetleri',NULL,'1'),('000034-FNK','09.3.0','Ortaöğretim sonrası mesleki eğitim hizmetleri',NULL,'1'),('000035-FNK','09.4.1','Üniversiteler ve yükseköğretim hizmeti veren kurumlar',NULL,'1'),('000036-FNK','09.4.2','Okul öncesi eğitim hizmetleri',NULL,'1'),('000037-FNK','09.5.0','Seviyeye göre sınıflandırılamayan eğitim hizmetleri',NULL,'1'),('000038-FNK','09.6.0','Eğitime yardımcı hizmetler',NULL,'1'),('000039-FNK','09.8.8','Eğitime ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('00003A-FNK','09.9.9','Sınıflandırmaya girmeyen eğitim hizmetleri',NULL,'1'),('00003B-FNK','10.1.1','Hastalık yardım hizmetleri',NULL,'1'),('00003C-FNK','10.1.2','Malullük yardım hizmetleri',NULL,'1'),('00003D-FNK','10.2.0','Yaşlılık yardımı hizmetleri',NULL,'1'),('00003E-FNK','10.3.0','Dul ve yetim aylığı hizmetleri',NULL,'1'),('00003F-FNK','10.4.0','Aile ve çocuk yardımı hizmetleri',NULL,'1'),('00003G-FNK','10.5.0','İşsizlik yardımları hizmetleri',NULL,'1'),('00003H-FNK','10.6.0','İskan yardımı hizmetleri',NULL,'1'),('00003I-FNK','10.7.0','Sosyal güvenliği bulunmayanlara sağlanan hizmetler',NULL,'1'),('00003J-FNK','10.8.8','Sosyal güvenlik ve sosyal yardımlara ilişkin araştırma ve geliştirme hizmetleri',NULL,'1'),('00003K-FNK','10.9.9','Sınıflandırmaya girmeyen sosyal güvenlik ve sosyal yardım hizmetleri',NULL,'1'),('00003L-FNK','09.4.2.00','Eğitime yardımcı hizmetler (BTS)',NULL,'1'),('00003M-FNK','09.4.1.00','Okul öncesi eğitim hizmetleri (BTS)',NULL,'1'),('00003N-FNK','09.6.0.07','Hastalık yardım hizmetleri (BTS)',NULL,'1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `FONKSIYONEL` ENABLE KEYS */;

--
-- Table structure for table `GECMIS`
--

DROP TABLE IF EXISTS `GECMIS`;
CREATE TABLE `GECMIS` (
  `GecmisNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aciklama` text character set utf8 collate utf8_turkish_ci,
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KullaniciNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `OncekiGecmisNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `OlusturmaTarihi` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Onay` enum('0','1') default NULL COMMENT '0:RED 1:ONAY',
  PRIMARY KEY  (`GecmisNo`),
  KEY `IstekFisiNo` (`IstekFisiNo`),
  KEY `KullaniciNo` (`KullaniciNo`),
  KEY `OncekiGecmisNo` (`OncekiGecmisNo`),
  KEY `SayfaNo` (`SayfaNo`),
  KEY `GrupNo` (`GrupNo`),
  CONSTRAINT `GECMIS_fk` FOREIGN KEY (`IstekFisiNo`) REFERENCES `ISTEK_FISI` (`IstekFisiNo`),
  CONSTRAINT `GECMIS_fk1` FOREIGN KEY (`KullaniciNo`) REFERENCES `KULLANICI` (`KullaniciNo`),
  CONSTRAINT `GECMIS_fk4` FOREIGN KEY (`SayfaNo`) REFERENCES `SAYFA` (`SayfaNo`),
  CONSTRAINT `GECMIS_fk5` FOREIGN KEY (`GrupNo`) REFERENCES `GRUP` (`GrupNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `GECMIS`
--


/*!40000 ALTER TABLE `GECMIS` DISABLE KEYS */;
LOCK TABLES `GECMIS` WRITE;
INSERT INTO `GECMIS` VALUES ('0000DL-HTR','Istek fiþi olusturuldu.','00001G-RFM','000001-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 00:38:30',NULL),('0000DM-HTR','Lütfen bir yorum giriniz.','00001G-RFM','000004-USR','000002-PAG','00002N-GRP','0000DL-HTR','2007-01-09 00:39:25',NULL),('0000DN-HTR','Lütfen bir yorum giriniz.','00001G-RFM','000003-USR','000001-PAG','00002M-GRP','0000DM-HTR','2007-01-09 00:39:46',NULL),('0000DO-HTR','Lütfen bir yorum giriniz.','00001G-RFM','000005-USR','000007-PAG','000004-GRP','0000DN-HTR','2007-01-09 00:40:02',NULL),('0000DP-HTR','null','00001G-RFM','00000E-USR','000006-PAG','000004-GRP','0000DO-HTR','2007-01-09 00:40:38',NULL),('0000DQ-HTR','null','00001G-RFM','00000D-USR','000008-PAG','000005-GRP','0000DP-HTR','2007-01-09 00:40:57',NULL),('0000DR-HTR','Lutfen bir yorum giriniz.','00001G-RFM','00000C-USR','00000V-PAG','000005-GRP','0000DQ-HTR','2007-01-09 00:41:19',NULL),('0000DS-HTR','Lütfen bir yorum giriniz.','00001G-RFM','00000C-USR','00000R-PAG','000007-GRP','0000DR-HTR','2007-01-09 00:41:53',NULL),('0000DT-HTR','LÃ¼tfen bir yorum giriniz.','00001G-RFM','00000I-USR','00000U-PAG','000005-GRP','0000DS-HTR','2007-01-09 00:42:07',NULL),('0000DU-HTR','Lütfen bir yorum giriniz.','00001G-RFM','00000C-USR','00000N-PAG','000003-GRP','0000DT-HTR','2007-01-09 00:42:24',NULL),('0000DV-HTR','Fatura bilgileri girildi.','00001G-RFM','00000H-USR','00000P-PAG','000003-GRP','0000DU-HTR','2007-01-09 00:43:51',NULL),('0000DW-HTR','Muayene raporu imzalandi.','00001G-RFM','00000F-USR','00000P-PAG','000003-GRP','0000DV-HTR','2007-01-09 00:44:09',NULL),('0000DX-HTR','Muayene raporu imzalandi.','00001G-RFM','00000G-USR','00000P-PAG','000003-GRP','0000DW-HTR','2007-01-09 00:44:28',NULL),('0000DY-HTR','Muayene raporu imzalandi.','00001G-RFM','00000G-USR','00000P-PAG','000003-GRP','0000DX-HTR','2007-01-09 00:47:04',NULL),('0000DZ-HTR','Muayene raporu imzalandi.','00001G-RFM','000001-USR','00000Q-PAG','000003-GRP','0000DY-HTR','2007-01-09 00:47:41',NULL),('0000E0-HTR',NULL,'00001G-RFM','00000G-USR','00000S-PAG','000005-GRP','0000DZ-HTR','2007-01-09 00:47:58',NULL),('0000E2-HTR','Istek fiþi olusturuldu.','00001H-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 06:45:24',NULL),('0000E3-HTR','Lütfen bir yorum giriniz.','00001H-RFM','000004-USR','000002-PAG','00002N-GRP','0000E2-HTR','2007-01-09 06:45:33',NULL),('0000E4-HTR','Lütfen bir yorum giriniz.','00001H-RFM','000003-USR','000001-PAG','00002M-GRP','0000E3-HTR','2007-01-09 06:46:02',NULL),('0000E5-HTR','Lütfen bir yorum giriniz.','00001H-RFM','000005-USR','000007-PAG','000004-GRP','0000E4-HTR','2007-01-09 06:46:32',NULL),('0000E6-HTR','null','00001H-RFM','00000E-USR','000006-PAG','000004-GRP','0000E5-HTR','2007-01-09 06:48:12',NULL),('0000E7-HTR','null','00001H-RFM','00000D-USR','00000D-PAG','000007-GRP','0000E6-HTR','2007-01-09 06:48:38',NULL),('0000E8-HTR','Istek fiþi olusturuldu.','00001I-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 07:01:30',NULL),('0000E9-HTR','Lütfen bir yorum giriniz.','00001I-RFM','000004-USR','000002-PAG','00002N-GRP','0000E8-HTR','2007-01-09 07:01:48',NULL),('0000EA-HTR','Lütfen bir yorum giriniz.','00001I-RFM','000003-USR','000001-PAG','00002M-GRP','0000E9-HTR','2007-01-09 07:02:12',NULL),('0000EB-HTR','Lütfen bir yorum giriniz.','00001I-RFM','000005-USR','000007-PAG','000004-GRP','0000EA-HTR','2007-01-09 07:02:56',NULL),('0000EC-HTR','null','00001I-RFM','00000E-USR','000006-PAG','000004-GRP','0000EB-HTR','2007-01-09 07:03:26',NULL),('0000ED-HTR','null','00001I-RFM','00000D-USR','00000D-PAG','000007-GRP','0000EC-HTR','2007-01-09 07:04:06',NULL),('0000EE-HTR','Istek fiþi olusturuldu.','00001J-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 07:14:46',NULL),('0000EF-HTR','Lütfen bir yorum giriniz.','00001J-RFM','000004-USR','000002-PAG','00002N-GRP','0000EE-HTR','2007-01-09 07:15:03',NULL),('0000EG-HTR','Lütfen bir yorum giriniz.','00001J-RFM','000003-USR','000001-PAG','00002M-GRP','0000EF-HTR','2007-01-09 07:15:38',NULL),('0000EH-HTR','Lütfen bir yorum giriniz.','00001J-RFM','000005-USR','000007-PAG','000004-GRP','0000EG-HTR','2007-01-09 07:16:02',NULL),('0000EI-HTR','null','00001J-RFM','00000E-USR','000006-PAG','000004-GRP','0000EH-HTR','2007-01-09 07:16:21',NULL),('0000EJ-HTR','null','00001J-RFM','00000D-USR','00000D-PAG','000007-GRP','0000EI-HTR','2007-01-09 07:16:48',NULL),('0000EK-HTR','Istek fiþi olusturuldu.','00001K-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 07:27:52',NULL),('0000EL-HTR','Lütfen bir yorum giriniz.','00001K-RFM','000004-USR','000002-PAG','00002N-GRP','0000EK-HTR','2007-01-09 07:28:08',NULL),('0000EM-HTR','Istek fiþi olusturuldu.','00001L-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 07:36:05',NULL),('0000EN-HTR','Lütfen bir yorum giriniz.','00001L-RFM','000004-USR','000002-PAG','00002N-GRP','0000EM-HTR','2007-01-09 07:36:23',NULL),('0000EO-HTR','Lütfen bir yorum giriniz.','00001L-RFM','000003-USR','000001-PAG','00002M-GRP','0000EN-HTR','2007-01-09 07:36:50',NULL),('0000EP-HTR','Lütfen bir yorum giriniz.','00001L-RFM','000005-USR','000007-PAG','000004-GRP','0000EO-HTR','2007-01-09 07:37:20',NULL),('0000EQ-HTR','null','00001L-RFM','00000E-USR','000006-PAG','000004-GRP','0000EP-HTR','2007-01-09 07:37:48',NULL),('0000ER-HTR','null','00001L-RFM','00000D-USR','00000D-PAG','000007-GRP','0000EQ-HTR','2007-01-09 07:41:40',NULL),('0000ES-HTR','Istek fiþi olusturuldu.','00001M-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 07:43:25',NULL),('0000ET-HTR','Lütfen bir yorum giriniz.','00001M-RFM','000004-USR','000002-PAG','00002N-GRP','0000ES-HTR','2007-01-09 07:43:41',NULL),('0000EU-HTR','Lütfen bir yorum giriniz.','00001M-RFM','000003-USR','000001-PAG','00002M-GRP','0000ET-HTR','2007-01-09 07:44:05',NULL),('0000EV-HTR','Lütfen bir yorum giriniz.','00001K-RFM','000003-USR','000001-PAG','00002M-GRP','0000EL-HTR','2007-01-09 07:44:13',NULL),('0000EW-HTR','Lütfen bir yorum giriniz.','00001K-RFM','000005-USR','000007-PAG','000004-GRP','0000EV-HTR','2007-01-09 07:44:31',NULL),('0000EX-HTR','Lütfen bir yorum giriniz.','00001M-RFM','000005-USR','000007-PAG','000004-GRP','0000EU-HTR','2007-01-09 07:44:34',NULL),('0000EY-HTR','null','00001K-RFM','00000E-USR','000006-PAG','000004-GRP','0000EW-HTR','2007-01-09 07:44:48',NULL),('0000EZ-HTR','null','00001M-RFM','00000E-USR','000006-PAG','000004-GRP','0000EX-HTR','2007-01-09 07:44:51',NULL),('0000F0-HTR','null','00001K-RFM','00000D-USR','00000D-PAG','000007-GRP','0000EY-HTR','2007-01-09 07:45:06',NULL),('0000F1-HTR','null','00001M-RFM','00000D-USR','00000D-PAG','000007-GRP','0000EZ-HTR','2007-01-09 07:45:09',NULL),('0000F2-HTR','Istek fiþi olusturuldu.','00001N-RFM','000004-USR','000003-PAG','00002N-GRP',NULL,'2007-01-09 08:15:39',NULL),('0000F3-HTR','Lütfen bir yorum giriniz.','00001N-RFM','000004-USR','000002-PAG','00002N-GRP','0000F2-HTR','2007-01-09 08:15:53',NULL),('0000F4-HTR','Lütfen bir yorum giriniz.','00001N-RFM','000003-USR','000001-PAG','00002M-GRP','0000F3-HTR','2007-01-09 08:16:06',NULL),('0000F5-HTR','Lütfen bir yorum giriniz.','00001N-RFM','000005-USR','000007-PAG','000004-GRP','0000F4-HTR','2007-01-09 08:16:17',NULL),('0000F6-HTR','null','00001N-RFM','00000E-USR','000006-PAG','000004-GRP','0000F5-HTR','2007-01-09 08:16:29',NULL),('0000F7-HTR','null','00001N-RFM','00000D-USR','00000D-PAG','000007-GRP','0000F6-HTR','2007-01-09 08:16:51',NULL),('0000F8-HTR','Istek fiþi olusturuldu.','00001O-RFM','000001-USR','000003-PAG','00002N-GRP',NULL,'2007-01-12 08:03:54',NULL),('0000F9-HTR','ok','00001O-RFM','000004-USR','000002-PAG','00002N-GRP','0000F8-HTR','2007-01-12 08:04:24',NULL),('0000FA-HTR','istek fisi tamamlandi.','00001G-RFM','00000D-USR','00000M-PAG','000004-GRP','0000E1-HTR','2007-01-12 08:05:00',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `GECMIS` ENABLE KEYS */;

--
-- Table structure for table `GENEL_DEPO_GIRIS`
--

DROP TABLE IF EXISTS `GENEL_DEPO_GIRIS`;
CREATE TABLE `GENEL_DEPO_GIRIS` (
  `DepoGirisNo` int(11) NOT NULL auto_increment,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `TalepEdenGrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '000000-GRP',
  `TalepEdenBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '000000-BRM',
  `TalepEdenUstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '000000-UBR',
  `RafNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Miktar` int(10) NOT NULL,
  `FaturaNo` char(20) character set utf8 collate utf8_turkish_ci default NULL,
  `FaturaTarihi` date NOT NULL,
  `Onaylandimi` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`DepoGirisNo`,`TalepEdenGrupNo`),
  KEY `UrunNo` (`UrunNo`),
  KEY `TalepEdenGrupNo` (`TalepEdenGrupNo`),
  KEY `TalepEdenBirimNo` (`TalepEdenBirimNo`),
  KEY `TalepEdenUstBirimNo` (`TalepEdenUstBirimNo`),
  KEY `RafNo` (`RafNo`),
  CONSTRAINT `genel_depo_giris_fk` FOREIGN KEY (`TalepEdenGrupNo`) REFERENCES `GRUP` (`GrupNo`),
  CONSTRAINT `genel_depo_giris_ibfk_1` FOREIGN KEY (`UrunNo`) REFERENCES `URUN` (`UrunNo`),
  CONSTRAINT `genel_depo_giris_ibfk_2` FOREIGN KEY (`TalepEdenBirimNo`) REFERENCES `BIRIM` (`BirimNo`),
  CONSTRAINT `genel_depo_giris_ibfk_3` FOREIGN KEY (`TalepEdenUstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`),
  CONSTRAINT `genel_depo_giris_ibfk_4` FOREIGN KEY (`RafNo`) REFERENCES `GENEL_DEPO_RAF` (`RafNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `GENEL_DEPO_GIRIS`
--


/*!40000 ALTER TABLE `GENEL_DEPO_GIRIS` DISABLE KEYS */;
LOCK TABLES `GENEL_DEPO_GIRIS` WRITE;
INSERT INTO `GENEL_DEPO_GIRIS` VALUES (65,'00000D-ITM','00002N-GRP','00000Q-BRM','000004-UBR','000000-GDR',5,'12345','2007-01-09','0');
UNLOCK TABLES;
/*!40000 ALTER TABLE `GENEL_DEPO_GIRIS` ENABLE KEYS */;

--
-- Table structure for table `GENEL_DEPO_HARCAMA`
--

DROP TABLE IF EXISTS `GENEL_DEPO_HARCAMA`;
CREATE TABLE `GENEL_DEPO_HARCAMA` (
  `GDepoHarcamaNo` int(11) NOT NULL auto_increment,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `TalepEdenGrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '000000-GRP',
  `TalepEdenBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '000000-BRM',
  `TalepEdenUstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL default '000000-UBR',
  `RafNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Miktar` int(10) NOT NULL,
  `HarcamaTarihi` date NOT NULL,
  `Aciklama` varchar(200) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`GDepoHarcamaNo`,`TalepEdenGrupNo`),
  KEY `UrunNo` (`UrunNo`),
  KEY `TalepEdenGrupNo` (`TalepEdenGrupNo`),
  KEY `TalepEdenBirimNo` (`TalepEdenBirimNo`),
  KEY `TalepEdenUstBirimNo` (`TalepEdenUstBirimNo`),
  KEY `RafNo` (`RafNo`),
  CONSTRAINT `genel_depo_harcama_fk` FOREIGN KEY (`TalepEdenGrupNo`) REFERENCES `GRUP` (`GrupNo`),
  CONSTRAINT `genel_depo_Harcama_ibfk_1` FOREIGN KEY (`UrunNo`) REFERENCES `URUN` (`UrunNo`),
  CONSTRAINT `genel_depo_Harcama_ibfk_2` FOREIGN KEY (`TalepEdenBirimNo`) REFERENCES `BIRIM` (`BirimNo`),
  CONSTRAINT `genel_depo_Harcama_ibfk_3` FOREIGN KEY (`TalepEdenUstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`),
  CONSTRAINT `genel_depo_Harcama_ibfk_4` FOREIGN KEY (`RafNo`) REFERENCES `GENEL_DEPO_RAF` (`RafNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `GENEL_DEPO_HARCAMA`
--


/*!40000 ALTER TABLE `GENEL_DEPO_HARCAMA` DISABLE KEYS */;
LOCK TABLES `GENEL_DEPO_HARCAMA` WRITE;
INSERT INTO `GENEL_DEPO_HARCAMA` VALUES (105,'00000D-ITM','00002N-GRP','00000Q-BRM','000004-UBR','000000-GDR',5,'2007-01-12','ok');
UNLOCK TABLES;
/*!40000 ALTER TABLE `GENEL_DEPO_HARCAMA` ENABLE KEYS */;

--
-- Table structure for table `GENEL_DEPO_RAF`
--

DROP TABLE IF EXISTS `GENEL_DEPO_RAF`;
CREATE TABLE `GENEL_DEPO_RAF` (
  `RafNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aciklama` varchar(30) character set utf8 collate utf8_turkish_ci default NULL,
  `bosmu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`RafNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `GENEL_DEPO_RAF`
--


/*!40000 ALTER TABLE `GENEL_DEPO_RAF` DISABLE KEYS */;
LOCK TABLES `GENEL_DEPO_RAF` WRITE;
INSERT INTO `GENEL_DEPO_RAF` VALUES ('000000-GDR',NULL,'1'),('000001-GDR',NULL,'1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `GENEL_DEPO_RAF` ENABLE KEYS */;

--
-- Table structure for table `GENEL_DEPO_URUN_MIKTAR`
--

DROP TABLE IF EXISTS `GENEL_DEPO_URUN_MIKTAR`;
CREATE TABLE `GENEL_DEPO_URUN_MIKTAR` (
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AltLimit` int(11) NOT NULL,
  `Mevcut` int(11) NOT NULL,
  PRIMARY KEY  (`UrunNo`),
  CONSTRAINT `genel_depo_urun_miktar_ibfk_1` FOREIGN KEY (`UrunNo`) REFERENCES `URUN` (`UrunNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `GENEL_DEPO_URUN_MIKTAR`
--


/*!40000 ALTER TABLE `GENEL_DEPO_URUN_MIKTAR` DISABLE KEYS */;
LOCK TABLES `GENEL_DEPO_URUN_MIKTAR` WRITE;
INSERT INTO `GENEL_DEPO_URUN_MIKTAR` VALUES ('00000D-ITM',4,0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `GENEL_DEPO_URUN_MIKTAR` ENABLE KEYS */;

--
-- Table structure for table `GRUP`
--

DROP TABLE IF EXISTS `GRUP`;
CREATE TABLE `GRUP` (
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GrupAdi` varchar(150) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GrupTipi` enum('Bolum','Fakulte','Idari','Destek') NOT NULL default 'Bolum',
  `BirimNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`GrupNo`),
  UNIQUE KEY `GrupAdi` (`GrupAdi`),
  KEY `BirimNo` (`BirimNo`),
  CONSTRAINT `GRUP_fk` FOREIGN KEY (`BirimNo`) REFERENCES `BIRIM` (`BirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `GRUP`
--


/*!40000 ALTER TABLE `GRUP` DISABLE KEYS */;
LOCK TABLES `GRUP` WRITE;
INSERT INTO `GRUP` VALUES ('000000-GRP','Genel Depo','Idari','000000-BRM','1'),('000001-GRP','İdari ve Mali İşler Daire Başkanlığı','Idari','000001-BRM','1'),('000002-GRP','Bütçe Daire Başkanlığı','Destek','000001-BRM','1'),('000003-GRP','Ayniyat','Destek','000001-BRM','1'),('000004-GRP','Bütçe Koordinatörlüğü','Destek','000001-BRM','1'),('000005-GRP','Satınalma Şube Müdürlüğü','Destek','000001-BRM','1'),('000006-GRP','Tahakkuk Şube','Destek','000001-BRM','1'),('000007-GRP','Rektrlük','Idari','000002-BRM','1'),('000020-GRP','Eğitim Fakültesi ','Fakulte','000003-BRM','1'),('000021-GRP','Bilgisayar ve Öğretim Teknolojileri Eğitimi','Bolum','000004-BRM','1'),('000022-GRP','Eğitim Bilimleri','Bolum','000005-BRM','1'),('000023-GRP','İlk Öğretim ','Bolum','000006-BRM','1'),('000024-GRP','Orta Öğretim Fen ve Matematik Alanları Eğitimi','Bolum','000007-BRM','1'),('000025-GRP','Yabancı Diller Eğitimi ','Bolum','000008-BRM','1'),('000026-GRP','Fen-Edebiyat Fakültesi','Fakulte','000009-BRM','1'),('000027-GRP','Batı Dilleri ve Edebiyatı','Bolum','00000A-BRM','1'),('000028-GRP','Çeviribilim ','Bolum','00000B-BRM','1'),('000029-GRP','Felsefe','Bolum','00000C-BRM','1'),('00002A-GRP','Fizik','Bolum','00000D-BRM','1'),('00002B-GRP','Kimya ','Bolum','00000E-BRM','1'),('00002C-GRP','Matematik','Bolum','00000F-BRM','1'),('00002D-GRP','Moleküler Biyoloji ve Genetik ','Bolum','00000G-BRM','1'),('00002E-GRP','Psikoloji ','Bolum','00000H-BRM','1'),('00002F-GRP','Sosyoloji ','Bolum','00000I-BRM','1'),('00002G-GRP','Tarih','Bolum','00000J-BRM','1'),('00002H-GRP','Türk Dili ve Edebiyatı','Bolum','00000K-BRM','1'),('00002I-GRP','İktisadi ve İdari Bilimler Fakültesi ','Fakulte','00000L-BRM','1'),('00002J-GRP','İktisat ','Bolum','00000M-BRM','1'),('00002K-GRP','İşletme ','Bolum','00000N-BRM','1'),('00002L-GRP','Siyaset Bilimi ve Uluslararası İlişkiler ','Bolum','00000O-BRM','1'),('00002M-GRP','Mühendislik Fakültesi ','Fakulte','00000P-BRM','1'),('00002N-GRP','Bilgisayar Mühendisliği','Bolum','00000Q-BRM','1'),('00002O-GRP','Elektrik-Elektronik Mühendisliği','Bolum','00000R-BRM','1'),('00002P-GRP','Endüstri Mühendisliği','Bolum','00000S-BRM','1'),('00002Q-GRP','İnşaat Mühendisliği','Bolum','00000T-BRM','1'),('00002R-GRP','Kimya Mühendisliği','Bolum','00000U-BRM','1'),('00002S-GRP','Makina Mühendisliği','Bolum','00000V-BRM','1'),('00002T-GRP','Uygulamalı Bilimler Yüksekokulu','Fakulte','00000W-BRM','1'),('00002U-GRP','Turizm İşletmeciliği ','Bolum','00000X-BRM','1'),('00002V-GRP','Uluslararası Ticaret ','Bolum','00000Y-BRM','1'),('00002W-GRP','Yönetim Bilişim Sistemleri ','Bolum','00000Z-BRM','1'),('00002X-GRP','Yabancı Diller Yüksekokulu ','Fakulte','000010-BRM','1'),('00002Y-GRP','Almanca Fransızca İspanyolca Birimi','Bolum','000011-BRM','1'),('00002Z-GRP','İleri İngilizce ','Bolum','000012-BRM','1'),('000030-GRP','İngilizce Hazırlık','Bolum','000013-BRM','1'),('000031-GRP','Atatürk İlkeleri ve İnkilâp Tarihi Enstitüsü','Fakulte','000014-BRM','1'),('000032-GRP','Biyo-Medikal Mhendisligi Enstitüsü','Fakulte','000015-BRM','1'),('000033-GRP','Çevre Bilimleri Enstitüsü','Fakulte','000016-BRM','1'),('000034-GRP','Fen Bilimleri Enstitüsü','Fakulte','000017-BRM','1'),('000035-GRP','Bilgisayar Mühendisliği (M.S., Ph.D.) ','Bolum','000018-BRM','1'),('000036-GRP','Elektrik- Elektronik Mühendisliği (M.S., Ph.D.) ','Bolum','000019-BRM','1'),('000037-GRP','Endüstri Mühendisliği (M.S., Ph.D.) ','Bolum','00001A-BRM','1'),('000038-GRP','Finans Mühendisliği (M.S.) ','Bolum','00001B-BRM','1'),('000039-GRP','Fizik (M.S., Ph.D.) ','Bolum','00001C-BRM','1'),('00003A-GRP','Hesaplamalı Bilim ve Mühendislik Yüksek Lisans Anabilim Dalı (M.S.) ','Bolum','00001D-BRM','1'),('00003B-GRP','İnşaat Mühendisliği (M.S., Ph.D.) ','Bolum','00001E-BRM','1'),('00003C-GRP','Kimya (M.S., Ph.D.) ','Bolum','00001F-BRM','1'),('00003D-GRP','Kimya Mühendisliği (M.S., Ph.D.) ','Bolum','00001G-BRM','1'),('00003E-GRP','Makina Mühendisliği (M.S., Ph.D.) ','Bolum','00001H-BRM','1'),('00003F-GRP','Matematik (M.S., Ph.D.) ','Bolum','00001I-BRM','1'),('00003G-GRP','Moleküler Biyoloji ve Genetik (M.S., Ph.D.) ','Bolum','00001J-BRM','1'),('00003H-GRP','Mühendislik ve Teknoloji Yönetimi (M.S.) ','Bolum','00001K-BRM','1'),('00003I-GRP','Nükleer Mühendislik (M.S., Ph.D.) ','Bolum','00001L-BRM','1'),('00003J-GRP','Ortaöğretim Fen ve Matematik Alanları Eğitimi (M.S., Ph.D.) ','Bolum','00001M-BRM','1'),('00003K-GRP','Otomotiv Mühendisliği Yüksek Lisans Programı','Bolum','00001N-BRM','1'),('00003L-GRP','Sistem ve Kontrol Mühendisliği (M.S.) ','Bolum','00001O-BRM','1'),('00003M-GRP','Tıbbi Sistemler ve Bilişim Tezsiz Yüksek Lisans Programı (M.S.) ','Bolum','00001P-BRM','1'),('00003N-GRP','Yazılım Mühendisliği Tezsiz Yüksek Lisans Programı (M.S.) ','Bolum','00001Q-BRM','1'),('00003O-GRP','Kandilli Rasathanesi ve Deprem Araştırma Enstitüsü','Fakulte','00001R-BRM','1'),('00003P-GRP','Deprem Mühendisliği','Bolum','00001S-BRM','1'),('00003Q-GRP','Jeodezi ','Bolum','00001T-BRM','1'),('00003R-GRP','Jeofizik ','Bolum','00001U-BRM','1'),('00003S-GRP','Sosyal Bilimler Enstitüsü','Fakulte','00001V-BRM','1'),('00003T-GRP','Avrupa Çalışmaları (M.A.) ','Bolum','00001W-BRM','1'),('00003U-GRP','Bilişsel Bilim (M.A.) ','Bolum','00001X-BRM','1'),('00003V-GRP','Çeviribilim (Ph.D .) ','Bolum','00001Y-BRM','1'),('00003W-GRP','Dilbilim (M.A.,Ph.D.) ','Bolum','00001Z-BRM','1'),('00003X-GRP','Eğitim Bilimleri (M.A., Ph. D.) ','Bolum','000020-BRM','1'),('00003Y-GRP','Eleştiri ve Kültür Araştırmaları (M.A.) ','Bolum','000021-BRM','1'),('00003Z-GRP','Ekonomi ve Finans Tezsiz Yüksek Lisans Programı (M.A.) ','Bolum','000022-BRM','1'),('000040-GRP','Executive MBA Programı- İşletme Bölümü','Bolum','000023-BRM','1'),('000041-GRP','Felsefe (M.A.) ','Bolum','000024-BRM','1'),('000042-GRP','İktisat (M.A., Ph.D.) ','Bolum','000025-BRM','1'),('000043-GRP','İngiliz Dili ve Edebiyatı (M.A.,Ph.D.) ','Bolum','000026-BRM','1'),('000044-GRP','İşletme (M.A.,Ph. D.) ','Bolum','000027-BRM','1'),('000045-GRP','İşletme Bilişim Sistemleri Programı (M.A.) ','Bolum','000028-BRM','1'),('000046-GRP','Konferans Çevirmenliği Tezsiz Yüksek Lisans Programı (M.A.) ','Bolum','000029-BRM','1'),('000047-GRP','Psikoloji (M.A.) ','Bolum','00002A-BRM','1'),('000048-GRP','Siyaset Bilimi ve Uluslararası İlişkiler (M.A., Ph.D.) ','Bolum','00002B-BRM','1'),('000049-GRP','Sosyoloji (M.A.) ','Bolum','00002C-BRM','1'),('00004A-GRP','Tarih (M.A., Ph.D.) ','Bolum','00002D-BRM','1'),('00004B-GRP','Türk Dili ve Edebiyatı (M.A., Ph.D.) ','Bolum','00002E-BRM','1'),('00004C-GRP','Yabancı Diller Eğitimi (M.A., Ph.D.) ','Bolum','00002F-BRM','1'),('00004D-GRP','Yazılı Çeviri Yüksek Lisans Programı (M.A.) ','Bolum','00002G-BRM','1'),('00004E-GRP','Yönetim Bilişim Sistemleri Yüksek Lisans Programı','Bolum','00002H-BRM','1'),('00004F-GRP','Otelcilik Meslek Yüksekokulu','Fakulte','00002I-BRM','1'),('00004G-GRP','Turizm İşletmeciliği (İkinci Öğretim) ','Bolum','00002J-BRM','1'),('00004H-GRP','Diğer Birimler','Fakulte','00002K-BRM','1'),('00004I-GRP','Beden Eğitimi ','Bolum','00002L-BRM','1'),('00004J-GRP','Güzel Sanatlar','Bolum','00002M-BRM','1'),('00004K-GRP','Genel Sekreterlik','Idari','00002N-BRM','1'),('00004L-GRP','Arşiv Şube Müdürlüğü','Destek','00002N-BRM','1'),('00004M-GRP','Bakım Onarım Şube Müdürlüğü','Destek','00002N-BRM','1'),('00004N-GRP','İletişim Şube Müdürlüğü','Destek','00002N-BRM','1'),('00004O-GRP','Koruma ve Güvenlik Şube Müdürlüğü','Destek','00002N-BRM','1'),('00004P-GRP','Özel Kalem Şube Müdürlüğü','Destek','00002N-BRM','1'),('00004Q-GRP','Yazı İşleri Şube Müdürlüğü','Destek','00002N-BRM','1'),('00004R-GRP','Bilgi İşlem ve Yayım Daire Başkanlığı','Idari','00002O-BRM','1'),('00004S-GRP','Bilgi İşlem Merkezi Müdürlüğü','Destek','00002O-BRM','1'),('00004T-GRP','Matbaa Şube Müdürlüğü','Destek','00002O-BRM','1'),('00004U-GRP','Öğrenci İşleri Daire Başkanlığı','Idari','00002P-BRM','1'),('00004V-GRP','Kayt İşleri Şube Müdürlüğü','Destek','00002P-BRM','1'),('00004W-GRP','Öğrenci İşleri Şube Müdürlüğü','Destek','00002P-BRM','1'),('00004X-GRP','Personel Daire Başkanlığı','Idari','00002Q-BRM','1'),('00004Y-GRP','Hesap İşleri Şube Müdürlüğü','Destek','00002Q-BRM','1'),('00004Z-GRP','Sağlık İşleri Şube Müdürlüğü','Destek','00002Q-BRM','1'),('000050-GRP','Sağlık Kültür Spor Daire Başkanlığı','Idari','00002R-BRM','1'),('000051-GRP','Etüt Merkezi Sorumlulugu ','Destek','00002R-BRM','1'),('000052-GRP','I. Erkek Yurdu Müdürlüğü','Destek','00002R-BRM','1'),('000053-GRP','I. Kız Yurdu Müdürlüğü','Destek','00002R-BRM','1'),('000054-GRP','II. Erkek Yurdu Müdürlüğü','Destek','00002R-BRM','1'),('000055-GRP','II. Kız Yurdu Müdürlüğü','Destek','00002R-BRM','1'),('000056-GRP','Kilyos Yurdu Müdürlüğü','Destek','00002R-BRM','1'),('000057-GRP','Mediko Sosyal Şube Müdürlüğü','Destek','00002R-BRM','1'),('000058-GRP','Müze Müdürlüğü','Destek','00002R-BRM','1'),('000059-GRP','Sosyal Tesisler Şube Müdürlüğü','Destek','00002R-BRM','1'),('00005A-GRP','Süperdorm Müdürlüğü','Destek','00002R-BRM','1'),('00005B-GRP','Uçaksavar Yurt Müdürlüğü','Destek','00002R-BRM','1'),('00005C-GRP','Yemekhane Şube Müdürlüğü','Destek','00002R-BRM','1'),('00005D-GRP','Yurtlar Şube Müdürlüğü','Destek','00002R-BRM','1'),('00005E-GRP','Yapı İşleri Teknik Daire Başkanlığı','Idari','00002S-BRM','1'),('00005F-GRP','Arazi Değerlendirme Şube Mdürlüğü','Destek','00002S-BRM','1'),('00005G-GRP','Yapı İşleri Şube Müdürlüğü','Destek','00002S-BRM','1'),('00005H-GRP','Yüksek Lisans Program Koordinatörleri','Idari','00002T-BRM','1'),('00005I-GRP','Avrupa Çalışmaları Yüksek Lisans Programı','Destek','00002T-BRM','1'),('00005J-GRP','Ekonomi ve Finans Mühendisliği İdari Koordinatörlüğü','Destek','00002T-BRM','1'),('00005K-GRP','ETM ve Finans Mühendisliği İdari Koordinatörlüğü','Destek','00002T-BRM','1'),('00005L-GRP','İşletme Tezsiz Yüksek Lisans Programı İdari Koordinatörlüğü','Destek','00002T-BRM','1'),('00005M-GRP','Merkezler','Idari','00002U-BRM','1'),('00005N-GRP','Afet Yönetimi Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005O-GRP','Arkeometri Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005P-GRP','Avrupa Çalışmaları Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005Q-GRP','Disiplinlerarasi Toplum Araştırmaları Uygulamave Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005R-GRP','Görme Engelliler Teknoloji Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005S-GRP','İleri Teknolojiler AR-GE Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005T-GRP','İnsani Gelişme Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005U-GRP','Krade Belbaşı Nükleer Denemeleri İzleme Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005V-GRP','Makro Ekonomi ve Uygulamalı Ekonometri Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005W-GRP','Mekatronik Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005X-GRP','Polimer Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005Y-GRP','Psikoloji Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('00005Z-GRP','Turizm İşletmeciliği Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('000060-GRP','BÜREM Müdürlüğü','Destek','00002U-BRM','1'),('000061-GRP','İktisadi Tasarım Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('000062-GRP','Krade İznik Deprem Zararlarının Azaltılması ve Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('000063-GRP','Dil Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('000064-GRP','Eğitim Teknolojisi Uygulama ve Araştırma Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('000065-GRP','Uzaktan Eğitim Merkezi (BÜUZEM) Müdürlüğü','Destek','00002U-BRM','1'),('000066-GRP','Yaşam Boyu Eğitim Merkezi (BÜREM) Müdürlüğü','Destek','00002U-BRM','1'),('000067-GRP','Krade Ulusal Deprem İzleme Merkezi Müdürlüğü','Destek','00002U-BRM','1'),('000068-GRP','Okul Öncesi Öğretmenliği Programı Uygulama Birimi Müdürlüğü ','Destek','00002U-BRM','1'),('000069-GRP','BÜKOSGEP Teknoloji Geliştirme Merkezi Müdürlüğü ','Destek','00002U-BRM','1'),('00006A-GRP','Mithat Alan Film Merkezi ','Destek','00002U-BRM','1'),('00006B-GRP','Çevre Bilimleri Enstitüsü (BTS) ','Fakulte','00002V-BRM','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `GRUP` ENABLE KEYS */;

--
-- Table structure for table `IDARI_UST_BIRIM`
--

DROP TABLE IF EXISTS `IDARI_UST_BIRIM`;
CREATE TABLE `IDARI_UST_BIRIM` (
  `IdariUstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IdariUstBirimAdi` varchar(150) character set utf8 collate utf8_turkish_ci NOT NULL,
  PRIMARY KEY  (`IdariUstBirimNo`),
  UNIQUE KEY `IdariUstBirimNo` (`IdariUstBirimNo`),
  CONSTRAINT `idari_ust_birim_fk1` FOREIGN KEY (`IdariUstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `IDARI_UST_BIRIM`
--


/*!40000 ALTER TABLE `IDARI_UST_BIRIM` DISABLE KEYS */;
LOCK TABLES `IDARI_UST_BIRIM` WRITE;
INSERT INTO `IDARI_UST_BIRIM` VALUES ('000000-UBR','Bütçe Daire Başkanlığı'),('00000E-UBR','Diğer Birimler'),('00000F-UBR','Muhtarliyet');
UNLOCK TABLES;
/*!40000 ALTER TABLE `IDARI_UST_BIRIM` ENABLE KEYS */;

--
-- Table structure for table `IHALE`
--

DROP TABLE IF EXISTS `IHALE`;
CREATE TABLE `IHALE` (
  `IhaleNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IhaleKayitNo` varchar(50) character set utf8 collate utf8_turkish_ci default NULL,
  `IhaleAdi` varchar(50) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IhaleUrunTipi` varchar(50) character set utf8 collate utf8_turkish_ci default NULL,
  `IhaleAltTipi` varchar(50) character set utf8 collate utf8_turkish_ci default NULL,
  `IhaleTarihi` date default NULL,
  `BeklenenMaliyet` decimal(12,2) default NULL,
  `KazananTeklifNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  `SayfaNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `Durum` int(10) unsigned default '0',
  `YatirimProjeNo` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `ButceTertibi` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `AvansSartlari` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `IhaleUsulu` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `IlanSekliAdedi` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `OyidSatisBedeli` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `BakanlarKuruluKarari` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`IhaleNo`),
  KEY `KazananTeklifNo` (`KazananTeklifNo`),
  KEY `SayfaNo` (`SayfaNo`),
  KEY `KayitNo` (`IhaleKayitNo`),
  CONSTRAINT `IHALE_ibfk_1` FOREIGN KEY (`KazananTeklifNo`) REFERENCES `IHALE_TEKLIF` (`TeklifNo`),
  CONSTRAINT `IHALE_ibfk_2` FOREIGN KEY (`SayfaNo`) REFERENCES `SAYFA` (`SayfaNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `IHALE`
--


/*!40000 ALTER TABLE `IHALE` DISABLE KEYS */;
LOCK TABLES `IHALE` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `IHALE` ENABLE KEYS */;

--
-- Table structure for table `IHALE_TEKLIF`
--

DROP TABLE IF EXISTS `IHALE_TEKLIF`;
CREATE TABLE `IHALE_TEKLIF` (
  `TeklifNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IhaleNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FirmaAdi` varchar(50) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FirmaTel` varchar(14) character set utf8 collate utf8_turkish_ci default NULL,
  `FirmaAdres` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `FirmaTanimi` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `TeklifFiyati` decimal(11,2) NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`TeklifNo`),
  KEY `IHALE_TEKLIF_fk` (`IhaleNo`),
  CONSTRAINT `IHALE_TEKLIF_fk` FOREIGN KEY (`IhaleNo`) REFERENCES `IHALE` (`IhaleNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `IHALE_TEKLIF`
--


/*!40000 ALTER TABLE `IHALE_TEKLIF` DISABLE KEYS */;
LOCK TABLES `IHALE_TEKLIF` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `IHALE_TEKLIF` ENABLE KEYS */;

--
-- Table structure for table `ISTEK`
--

DROP TABLE IF EXISTS `ISTEK`;
CREATE TABLE `ISTEK` (
  `IstekNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Miktar` decimal(11,0) default NULL,
  `TahminiFiyat` decimal(11,0) default NULL,
  `Aciklama` text character set utf8 collate utf8_turkish_ci,
  `Statu` enum('0','1') NOT NULL default '1',
  `ButceTahminiFiyat` decimal(11,2) default NULL,
  PRIMARY KEY  (`IstekNo`),
  KEY `IstekFisiNo` (`IstekFisiNo`),
  KEY `UrunNo` (`UrunNo`),
  CONSTRAINT `ISTEK_fk` FOREIGN KEY (`IstekFisiNo`) REFERENCES `ISTEK_FISI` (`IstekFisiNo`),
  CONSTRAINT `ISTEK_fk2` FOREIGN KEY (`UrunNo`) REFERENCES `URUN` (`UrunNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ISTEK`
--


/*!40000 ALTER TABLE `ISTEK` DISABLE KEYS */;
LOCK TABLES `ISTEK` WRITE;
INSERT INTO `ISTEK` VALUES ('00001G-REQ','00001G-RFM','00000D-ITM','5','7','defteryok','1','7.00'),('00001H-REQ','00001H-RFM','000001-ITM','1','10','kalem','1','10.00'),('00001I-REQ','00001I-RFM','00000D-ITM','2','10','gerekli','1','10.00'),('00001J-REQ','00001J-RFM','000007-ITM','2','2','CD','1','2.00'),('00001K-REQ','00001K-RFM','000007-ITM','3','4','cd','1','4.00'),('00001L-REQ','00001L-RFM','000001-ITM','5','6','kalem','1','6.00'),('00001M-REQ','00001M-RFM','00000D-ITM','10','1','defter','1','1.00'),('00001N-REQ','00001N-RFM','000006-ITM','5','2','Disket','1','2.00'),('00001O-REQ','00001O-RFM','00000D-ITM','5','7','defterbitti','1',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `ISTEK` ENABLE KEYS */;

--
-- Table structure for table `ISTEK_FISI`
--

DROP TABLE IF EXISTS `ISTEK_FISI`;
CREATE TABLE `ISTEK_FISI` (
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GercekFiyat` decimal(11,2) default NULL,
  `Isteyen` varchar(50) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Dahili` char(1) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KalemNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GecmisNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `IstekFisiKodu` varchar(30) character set utf8 collate utf8_turkish_ci default NULL,
  `OlusturmaTarihi` datetime NOT NULL,
  `Olusturan` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1','2') NOT NULL default '1' COMMENT '0:silindi 1:yasayan 2:alinmis bitmis:D\r\n',
  `Locked` enum('0','1') NOT NULL default '0',
  `IhaleNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `FaturaNo` char(20) character set utf8 collate utf8_turkish_ci default NULL,
  `FaturaTarihi` date default NULL,
  `SaticiFirma` char(30) character set utf8 collate utf8_turkish_ci default NULL,
  `PiyasaFiyati` decimal(11,2) default NULL,
  `ButceSiraNo` varchar(15) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aktarildi` varchar(1) character set utf8 collate utf8_turkish_ci default '0',
  `isteyenGrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL COMMENT 'istegi ilk yapan birimin grup numarasi',
  PRIMARY KEY  (`IstekFisiNo`),
  KEY `KalemNo` (`KalemNo`),
  KEY `SayfaNo` (`SayfaNo`),
  KEY `GrupNo` (`GrupNo`),
  KEY `ISTEK_FISI_fk` (`IhaleNo`),
  CONSTRAINT `ISTEK_FISI_fk1` FOREIGN KEY (`KalemNo`) REFERENCES `KALEM` (`KalemNo`),
  CONSTRAINT `ISTEK_FISI_fk2` FOREIGN KEY (`SayfaNo`) REFERENCES `SAYFA` (`SayfaNo`),
  CONSTRAINT `ISTEK_FISI_fk3` FOREIGN KEY (`GrupNo`) REFERENCES `GRUP` (`GrupNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ISTEK_FISI`
--


/*!40000 ALTER TABLE `ISTEK_FISI` DISABLE KEYS */;
LOCK TABLES `ISTEK_FISI` WRITE;
INSERT INTO `ISTEK_FISI` VALUES ('00001G-RFM',NULL,'Emin Senay','1','00001C-ITC','000004-GRP','00000M-PAG','0000FA-HTR','Defter0042','2007-01-09 02:38:30','000001-USR','2','0',NULL,'12345','2007-01-09','ayticaret',NULL,'000','1','00002N-GRP'),('00001H-RFM',NULL,'ozan','1','00001C-ITC','000007-GRP','00000D-PAG','0000E7-HTR','kalem0043','2007-01-09 08:45:24','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001I-RFM',NULL,'ozan','1','00001C-ITC','000007-GRP','00000D-PAG','0000ED-HTR','Defter0044','2007-01-09 09:01:30','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001J-RFM',NULL,'Ozan','1','00001C-ITC','000007-GRP','00000D-PAG','0000EJ-HTR','CD0045','2007-01-09 09:14:46','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001K-RFM',NULL,'Oktay','1','00001C-ITC','000007-GRP','00000D-PAG','0000F0-HTR','CD0046','2007-01-09 09:27:52','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001L-RFM',NULL,'Oktay','1','00001C-ITC','000007-GRP','00000D-PAG','0000ER-HTR','Kalem0047','2007-01-09 09:36:05','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001M-RFM',NULL,'Oktay','1','00001C-ITC','000007-GRP','00000D-PAG','0000F1-HTR','Defter0048','2007-01-09 09:43:25','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001N-RFM',NULL,'Oktay','1','00001C-ITC','000007-GRP','00000D-PAG','0000F7-HTR','Bilgisayar0049','2007-01-09 10:15:39','000004-USR','1','0',NULL,NULL,NULL,NULL,NULL,'000','0','00002N-GRP'),('00001O-RFM',NULL,'Emin Senay','1','00001C-ITC','00002N-GRP','000002-PAG','0000F9-HTR','Defter10050','2007-01-12 10:03:54','000001-USR','1','0',NULL,NULL,NULL,NULL,NULL,'','0','00002N-GRP');
UNLOCK TABLES;
/*!40000 ALTER TABLE `ISTEK_FISI` ENABLE KEYS */;

--
-- Table structure for table `ISTEK_FISI_IMZA`
--

DROP TABLE IF EXISTS `ISTEK_FISI_IMZA`;
CREATE TABLE `ISTEK_FISI_IMZA` (
  `KullaniciNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IstekFisiNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL COMMENT 'bu sadece istek fisi no degil ayniyat no da olabilir.',
  `ImzaTarihi` bigint(20) NOT NULL,
  `ImzaFormati` char(100) character set utf8 collate utf8_turkish_ci default NULL,
  `Imza` char(100) character set utf8 collate utf8_turkish_ci default NULL,
  `IstekFisiImzaNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GecmisNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`IstekFisiImzaNo`),
  KEY `KullaniciNo` (`KullaniciNo`),
  KEY `IstekFisiImzaNo` (`IstekFisiImzaNo`),
  KEY `IstekFisiNo` (`IstekFisiNo`),
  KEY `GecmisNo` (`GecmisNo`),
  CONSTRAINT `ISTEK_FISI_IMZA_fk` FOREIGN KEY (`KullaniciNo`) REFERENCES `KULLANICI` (`KullaniciNo`),
  CONSTRAINT `ISTEK_FISI_IMZA_fk1` FOREIGN KEY (`GecmisNo`) REFERENCES `GECMIS` (`GecmisNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ISTEK_FISI_IMZA`
--


/*!40000 ALTER TABLE `ISTEK_FISI_IMZA` DISABLE KEYS */;
LOCK TABLES `ISTEK_FISI_IMZA` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `ISTEK_FISI_IMZA` ENABLE KEYS */;

--
-- Table structure for table `ISTEK_FISI_SAYAC`
--

DROP TABLE IF EXISTS `ISTEK_FISI_SAYAC`;
CREATE TABLE `ISTEK_FISI_SAYAC` (
  `Suffix` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `NextSeed` char(4) character set utf8 collate utf8_turkish_ci default NULL,
  `TimeStamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Description` tinytext character set utf8 collate utf8_turkish_ci,
  KEY `Suffix` (`Suffix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ISTEK_FISI_SAYAC`
--


/*!40000 ALTER TABLE `ISTEK_FISI_SAYAC` DISABLE KEYS */;
LOCK TABLES `ISTEK_FISI_SAYAC` WRITE;
INSERT INTO `ISTEK_FISI_SAYAC` VALUES ('000001-GRP','0000','2005-12-30 03:06:58','000001-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000002-GRP','0000','2005-12-30 03:06:58','000002-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000003-GRP','0000','2005-12-30 03:06:58','000003-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000004-GRP','0000','2005-12-30 03:06:58','000004-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000005-GRP','0000','2005-12-30 03:06:58','000005-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000006-GRP','0000','2005-12-30 03:06:58','000006-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000007-GRP','0000','2005-12-30 03:06:58','000007-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000020-GRP','0000','2005-12-30 03:29:33','000020-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000021-GRP','0000','2005-12-30 03:29:33','000021-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000022-GRP','0000','2005-12-30 03:29:33','000022-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000023-GRP','0000','2005-12-30 03:29:33','000023-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000024-GRP','0000','2005-12-30 03:29:33','000024-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000025-GRP','0000','2005-12-30 03:29:34','000025-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000026-GRP','0000','2005-12-30 03:29:34','000026-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000027-GRP','0000','2005-12-30 03:29:34','000027-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000028-GRP','0000','2005-12-30 03:29:34','000028-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000029-GRP','0000','2005-12-30 03:29:34','000029-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002A-GRP','0000','2005-12-30 03:29:34','00002A-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002B-GRP','0000','2005-12-30 03:29:35','00002B-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002C-GRP','0000','2005-12-30 03:29:35','00002C-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002D-GRP','0000','2005-12-30 03:29:35','00002D-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002E-GRP','0000','2005-12-30 03:29:35','00002E-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002F-GRP','0000','2005-12-30 03:29:35','00002F-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002G-GRP','0000','2005-12-30 03:29:35','00002G-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002H-GRP','0000','2005-12-30 03:29:36','00002H-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002I-GRP','0000','2005-12-30 03:29:36','00002I-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002J-GRP','0000','2005-12-30 03:29:36','00002J-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002K-GRP','0000','2005-12-30 03:29:36','00002K-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002L-GRP','0000','2005-12-30 03:29:37','00002L-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002M-GRP','0000','2005-12-30 03:29:37','00002M-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002N-GRP','0051','2007-01-12 08:03:54','00002N-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002O-GRP','0000','2005-12-30 03:29:37','00002O-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002P-GRP','0000','2005-12-30 03:29:37','00002P-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002Q-GRP','0000','2005-12-30 03:29:37','00002Q-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002R-GRP','0000','2005-12-30 03:29:37','00002R-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002S-GRP','0000','2005-12-30 03:29:38','00002S-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002T-GRP','0000','2005-12-30 03:29:38','00002T-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002U-GRP','0000','2005-12-30 03:29:38','00002U-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002V-GRP','0000','2005-12-30 03:29:38','00002V-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002W-GRP','0000','2005-12-30 03:29:39','00002W-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002X-GRP','0000','2005-12-30 03:29:39','00002X-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002Y-GRP','0000','2005-12-30 03:29:39','00002Y-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00002Z-GRP','0000','2005-12-30 03:29:39','00002Z-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000030-GRP','0000','2005-12-30 03:29:39','000030-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000031-GRP','0000','2005-12-30 03:29:40','000031-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000032-GRP','0000','2005-12-30 03:29:40','000032-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000033-GRP','0000','2005-12-30 03:29:40','000033-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000034-GRP','0000','2005-12-30 03:29:40','000034-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000035-GRP','0000','2005-12-30 03:29:40','000035-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000036-GRP','0000','2005-12-30 03:29:40','000036-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000037-GRP','0000','2005-12-30 03:29:40','000037-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000038-GRP','0000','2005-12-30 03:29:41','000038-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000039-GRP','0000','2005-12-30 03:29:41','000039-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003A-GRP','0000','2005-12-30 03:29:41','00003A-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003B-GRP','0000','2005-12-30 03:29:41','00003B-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003C-GRP','0000','2005-12-30 03:29:42','00003C-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003D-GRP','0000','2005-12-30 03:29:42','00003D-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003E-GRP','0000','2005-12-30 03:29:42','00003E-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003F-GRP','0000','2005-12-30 03:29:42','00003F-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003G-GRP','0000','2005-12-30 03:29:42','00003G-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003H-GRP','0000','2005-12-30 03:29:43','00003H-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003I-GRP','0000','2005-12-30 03:29:43','00003I-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003J-GRP','0000','2005-12-30 03:29:43','00003J-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003K-GRP','0000','2005-12-30 03:29:43','00003K-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003L-GRP','0000','2005-12-30 03:29:43','00003L-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003M-GRP','0000','2005-12-30 03:29:43','00003M-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003N-GRP','0000','2005-12-30 03:29:43','00003N-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003O-GRP','0000','2005-12-30 03:29:44','00003O-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003P-GRP','0000','2005-12-30 03:29:44','00003P-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003Q-GRP','0000','2005-12-30 03:29:44','00003Q-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003R-GRP','0000','2005-12-30 03:29:44','00003R-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003S-GRP','0000','2005-12-30 03:29:44','00003S-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003T-GRP','0000','2005-12-30 03:29:44','00003T-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003U-GRP','0000','2005-12-30 03:29:45','00003U-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003V-GRP','0000','2005-12-30 03:29:45','00003V-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003W-GRP','0000','2005-12-30 03:29:45','00003W-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003X-GRP','0000','2005-12-30 03:29:45','00003X-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003Y-GRP','0000','2005-12-30 03:29:46','00003Y-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00003Z-GRP','0000','2005-12-30 03:29:46','00003Z-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000040-GRP','0000','2005-12-30 03:29:46','000040-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000041-GRP','0000','2005-12-30 03:29:46','000041-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000042-GRP','0000','2005-12-30 03:29:46','000042-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000043-GRP','0000','2005-12-30 03:29:47','000043-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000044-GRP','0000','2005-12-30 03:29:47','000044-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000045-GRP','0000','2005-12-30 03:29:47','000045-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000046-GRP','0000','2005-12-30 03:29:47','000046-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000047-GRP','0000','2005-12-30 03:29:47','000047-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000048-GRP','0000','2005-12-30 03:29:47','000048-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000049-GRP','0000','2005-12-30 03:29:48','000049-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004A-GRP','0000','2005-12-30 03:29:48','00004A-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004B-GRP','0000','2005-12-30 03:29:48','00004B-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004C-GRP','0000','2005-12-30 03:29:48','00004C-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004D-GRP','0000','2005-12-30 03:29:49','00004D-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004E-GRP','0000','2005-12-30 03:29:49','00004E-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004F-GRP','0000','2005-12-30 03:29:49','00004F-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004G-GRP','0000','2005-12-30 03:29:49','00004G-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004H-GRP','0000','2005-12-30 03:29:49','00004H-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004I-GRP','0000','2005-12-30 03:29:49','00004I-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004J-GRP','0000','2005-12-30 03:29:50','00004J-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004K-GRP','0000','2005-12-30 03:31:49','00004K-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004L-GRP','0000','2005-12-30 03:31:49','00004L-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004M-GRP','0000','2005-12-30 03:31:49','00004M-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004N-GRP','0000','2005-12-30 03:31:50','00004N-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004O-GRP','0000','2005-12-30 03:31:50','00004O-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004P-GRP','0000','2005-12-30 03:31:50','00004P-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004Q-GRP','0000','2005-12-30 03:31:51','00004Q-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004R-GRP','0000','2005-12-30 03:31:51','00004R-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004S-GRP','0002','2006-12-28 16:29:50','00004S-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004T-GRP','0000','2005-12-30 03:31:51','00004T-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004U-GRP','0000','2005-12-30 03:31:51','00004U-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004V-GRP','0000','2005-12-30 03:31:51','00004V-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004W-GRP','0000','2005-12-30 03:31:51','00004W-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004X-GRP','0000','2005-12-30 03:31:51','00004X-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004Y-GRP','0000','2005-12-30 03:31:52','00004Y-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00004Z-GRP','0000','2005-12-30 03:31:52','00004Z-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000050-GRP','0000','2005-12-30 03:31:52','000050-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000051-GRP','0000','2005-12-30 03:31:52','000051-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000052-GRP','0000','2005-12-30 03:31:52','000052-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000053-GRP','0000','2005-12-30 03:31:52','000053-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000054-GRP','0000','2005-12-30 03:31:52','000054-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000055-GRP','0000','2005-12-30 03:31:53','000055-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000056-GRP','0000','2005-12-30 03:31:53','000056-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000057-GRP','0000','2005-12-30 03:31:53','000057-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000058-GRP','0000','2005-12-30 03:31:53','000058-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000059-GRP','0000','2005-12-30 03:31:53','000059-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005A-GRP','0000','2005-12-30 03:31:54','00005A-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005B-GRP','0000','2005-12-30 03:31:54','00005B-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005C-GRP','0000','2005-12-30 03:31:54','00005C-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005D-GRP','0000','2005-12-30 03:31:54','00005D-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005E-GRP','0000','2005-12-30 03:31:55','00005E-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005F-GRP','0000','2005-12-30 03:31:55','00005F-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005G-GRP','0000','2005-12-30 03:31:55','00005G-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005H-GRP','0000','2005-12-30 03:31:55','00005H-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005I-GRP','0000','2005-12-30 03:31:55','00005I-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005J-GRP','0000','2005-12-30 03:31:56','00005J-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005K-GRP','0000','2005-12-30 03:31:56','00005K-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005L-GRP','0000','2005-12-30 03:31:56','00005L-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005M-GRP','0000','2005-12-30 03:31:56','00005M-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005N-GRP','0000','2005-12-30 03:31:56','00005N-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005O-GRP','0000','2005-12-30 03:31:56','00005O-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005P-GRP','0000','2005-12-30 03:31:56','00005P-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005Q-GRP','0000','2005-12-30 03:31:57','00005Q-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005R-GRP','0000','2005-12-30 03:31:57','00005R-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005S-GRP','0000','2005-12-30 03:31:57','00005S-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005T-GRP','0000','2005-12-30 03:31:57','00005T-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005U-GRP','0000','2005-12-30 03:31:58','00005U-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005V-GRP','0000','2005-12-30 03:31:58','00005V-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005W-GRP','0000','2005-12-30 03:31:58','00005W-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005X-GRP','0000','2005-12-30 03:31:58','00005X-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005Y-GRP','0000','2005-12-30 03:31:58','00005Y-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00005Z-GRP','0000','2005-12-30 03:31:58','00005Z-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000060-GRP','0000','2005-12-30 03:31:59','000060-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000061-GRP','0000','2005-12-30 03:31:59','000061-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000062-GRP','0000','2005-12-30 03:31:59','000062-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000063-GRP','0000','2005-12-30 03:31:59','000063-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000064-GRP','0000','2005-12-30 03:31:59','000064-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000065-GRP','0000','2005-12-30 03:32:00','000065-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000066-GRP','0000','2005-12-30 03:32:00','000066-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000067-GRP','0000','2005-12-30 03:32:00','000067-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000068-GRP','0000','2005-12-30 03:32:00','000068-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('000069-GRP','0000','2005-12-30 03:32:00','000069-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu'),('00006A-GRP','0000','2005-12-30 03:32:00','00006A-GRP Nolu yeni acilan grup icin otomatik olarak olusturuldu');
UNLOCK TABLES;
/*!40000 ALTER TABLE `ISTEK_FISI_SAYAC` ENABLE KEYS */;

--
-- Table structure for table `ISTEK_TEKLIF`
--

DROP TABLE IF EXISTS `ISTEK_TEKLIF`;
CREATE TABLE `ISTEK_TEKLIF` (
  `IstekTeklifNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `IstekNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FirmaAdi` varchar(50) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FirmaTel` varchar(14) character set utf8 collate utf8_turkish_ci default NULL,
  `FirmaAdres` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `FirmaTanimi` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `TeklifFiyati` decimal(11,2) NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  `Uygundur` int(1) NOT NULL default '0',
  PRIMARY KEY  (`IstekTeklifNo`),
  UNIQUE KEY `IstekTeklifNo` (`IstekTeklifNo`),
  KEY `IstekNo` (`IstekNo`),
  CONSTRAINT `ISTEK_TEKLIF_ibfk_1` FOREIGN KEY (`IstekNo`) REFERENCES `ISTEK` (`IstekNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ISTEK_TEKLIF`
--


/*!40000 ALTER TABLE `ISTEK_TEKLIF` DISABLE KEYS */;
LOCK TABLES `ISTEK_TEKLIF` WRITE;
INSERT INTO `ISTEK_TEKLIF` VALUES ('00000X-ITK','00001G-REQ','Ayticaret','','babasehir','','34.00','1',1),('00000Y-ITK','00001G-REQ','sayticaret','','dedekoy','','36.00','1',0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `ISTEK_TEKLIF` ENABLE KEYS */;

--
-- Table structure for table `KALEM`
--

DROP TABLE IF EXISTS `KALEM`;
CREATE TABLE `KALEM` (
  `KalemNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AnaKalemNo` char(10) character set utf8 collate utf8_turkish_ci default NULL,
  `KalemAdi` varchar(80) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KalemKodu` char(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`KalemNo`),
  KEY `AnaKalemNo` (`AnaKalemNo`),
  CONSTRAINT `KALEM_fk` FOREIGN KEY (`AnaKalemNo`) REFERENCES `ANA_KALEM` (`AnaKalemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `KALEM`
--


/*!40000 ALTER TABLE `KALEM` DISABLE KEYS */;
LOCK TABLES `KALEM` WRITE;
INSERT INTO `KALEM` VALUES ('000001-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personel İşaretleri','01.2.1.01','1'),('000002-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personel İşaretleri','01.2.1.02','1'),('000003-ITC','000002-AKL','Akademik Sözleşmeli Personelin İşaretleri','01.2.1.03','1'),('000004-ITC','000002-AKL','Yabancı Uyruklu Sözleşmeli Personelin İşaretleri','01.2.1.04','1'),('000005-ITC','000002-AKL','Sözleşmeli Sanatçıların İşaretleri','01.2.1.05','1'),('000006-ITC','000002-AKL','Diğer Sözleşmeli Personel İşaretleri','01.2.1.90','1'),('000007-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personel Zam ve Tazminatı','01.2.2.01','1'),('000008-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personel Zam ve Tazminatı','01.2.2.02','1'),('000009-ITC','000002-AKL','Akademik Sözleşmeli Personelin Zam ve Tazminatı','01.2.2.03','1'),('00000A-ITC','000002-AKL','Yabancı Uyruklu Sözleşmeli Personelin Zam ve Tazminatı','01.2.2.04','1'),('00000B-ITC','000002-AKL','Sözleşmeli Sanatçıların Zam ve Tazminatı','01.2.2.05','1'),('00000C-ITC','000002-AKL','Diğer Sözleşmeli Personel Zam ve Tazminatı','01.2.2.90','1'),('00000D-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personel Seçenekleri','01.2.3.01','1'),('00000E-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personel Seçenekleri','01.2.3.02','1'),('00000F-ITC','000002-AKL','Akademik Sözleşmeli Personelin Seçenekleri','01.2.3.03','1'),('00000G-ITC','000002-AKL','Yabancı Uyruklu Sözleşmeli Personelin Seçenekleri','01.2.3.04','1'),('00000H-ITC','000002-AKL','Sözleşmeli Sanatçıların Seçenekleri','01.2.3.05','1'),('00000I-ITC','000002-AKL','Diğer Sözleşmeli Personel Seçenekleri','01.2.3.06','1'),('00000J-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personel Sosyal Hakları','01.2.4.01','1'),('00000K-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personel Sosyal Hakları','01.2.4.02','1'),('00000L-ITC','000002-AKL','Akademik Sözleşmeli Personelin Sosyal Hakları','01.2.4.03','1'),('00000M-ITC','000002-AKL','Yabancı Uyruklu Sözleşmeli Personelin Sosyal Hakları','01.2.4.04','1'),('00000N-ITC','000002-AKL','Sözleşmeli Sanatçıların Sosyal Hakları','01.2.4.05','1'),('00000O-ITC','000002-AKL','Diger Sözleşmeli Personel Sosyal Hakları','01.2.4.06','1'),('00000P-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personelin Ek Çalışma Karşılıkları','01.2.5.01','1'),('00000Q-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personelin Ek Çalışma Karşılıkları','01.2.5.02','1'),('00000R-ITC','000002-AKL','Akademik Sözleşmeli Personelin Ek Çalışma Karşılıkları','01.2.5.03','1'),('00000S-ITC','000002-AKL','Yabancı Uyruklu Sözleşmeli Personelin Ek Çalışma Karşılıkları','01.2.5.04','1'),('00000T-ITC','000002-AKL','Sözleşmeli Sanatçıların Ek Çalışma Karşılıkları','01.2.5.05','1'),('00000U-ITC','000002-AKL','Diğer Sözleşmeli Personel Ek Çalışma Karşılıkları','01.2.5.90','1'),('00000V-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personelin dül ve İkramiyeleri','01.2.6.01','1'),('00000W-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personelin Ödül ve İkramiyeleri','01.2.6.02','1'),('00000X-ITC','000002-AKL','Akademik Sözleşmeli Personelin Ödül ve İkramiyeleri','01.2.6.03','1'),('00000Y-ITC','000002-AKL','Yabancı Uyruklu Sözleşmeli Personelin Ödül ve İkramiyeleri','01.2.6.04','1'),('00000Z-ITC','000002-AKL','Sözleşmeli Sanatçıların Ödül ve İkramiyeleri','01.2.6.05','1'),('000010-ITC','000002-AKL','Diger Sözleşmeli Personelin Ödül ve İkramiyeleri','01.2.6.90','1'),('000011-ITC','000002-AKL','657 S.K. 4/B Sözleşmeli Personelin Diğer Giderleri','01.2.9.01','1'),('000012-ITC','000002-AKL','Kadro Karşılığı Sözleşmeli Personelin Diğer Giderleri','01.2.9.02','1'),('000013-ITC','000002-AKL','Akademik Sözleşmeli Personelin Diğer Giderleri','01.2.9.03','1'),('000014-ITC','000002-AKL','Yabanci Uyruklu Sözleşmeli Personelin Diğer Giderleri','01.2.9.04','1'),('000015-ITC','000002-AKL','Sözleşmeli Sanatçıların Diğer Giderleri','01.2.9.05','1'),('000016-ITC','000002-AKL','Diğer Sözleşmeli Personelin Diğer Giderleri','01.2.9.90','1'),('000017-ITC','000003-AKL','Yurtdışı Öğrenimde Ödenen Aylıklar','01.5.1.05','1'),('000018-ITC','000004-AKL','Emekli Sandığına','02.1.1.01','1'),('000019-ITC','000005-AKL','Emekli Sandığına','02.2.1.01','1'),('00001A-ITC','000005-AKL','Sosyal Sigortalar Kurumuna','02.2.2.01','1'),('00001B-ITC','000005-AKL','Diğer Sigorta Kurumlarına','02.2.9.01','1'),('00001C-ITC','000006-AKL','Kırtasiye Alımları','03.2.1.01','1'),('00001D-ITC','000006-AKL','Büro Malzemesi Alımları','03.2.1.02','1'),('00001E-ITC','000006-AKL','Periyodik Yayın Alımları','03.2.1.03','1'),('00001F-ITC','000006-AKL','Diğer Yayın Alımları','03.2.1.04','1'),('00001G-ITC','000006-AKL','Baskı ve Cilt Giderleri','03.2.1.05','1'),('00001H-ITC','000006-AKL','Diğer Kırtasiye ve Büro Malzemesi Alımları','03.2.1.90','1'),('00001I-ITC','000006-AKL','Su Alımları','03.2.2.01','1'),('00001J-ITC','000006-AKL','Temizlik Malzemesi Alımları','03.2.2.02','1'),('00001K-ITC','000006-AKL','Yakacak Alımları','03.2.3.01','1'),('00001L-ITC','000006-AKL','Akaryakıt ve Yağ Alımları','03.2.3.02','1'),('00001M-ITC','000006-AKL','Elektrik Alımları','03.2.3.03','1'),('00001N-ITC','000006-AKL','Diğer Enerji Alımları','03.2.3.90','1'),('00001O-ITC','000006-AKL','Yem Alımları','03.2.4.03','1'),('00001P-ITC','000006-AKL','Giyecek Alımları (Kişisel kuşam ve donanım dahil)','03.2.5.01','1'),('00001Q-ITC','000006-AKL','Spor Malzemeleri Alımları','03.2.5.02','1'),('00001R-ITC','000006-AKL','Diğer Giyim ve Kuşam Alımları','03.2.5.90','1'),('00001S-ITC','000006-AKL','Laboratuvar Malzemesi ile Kimyevi ve Temrinlik Malzeme Alımları','03.2.6.01','1'),('00001T-ITC','000006-AKL','Tıbbi Malzeme ve İlaç Alımları','03.2.6.02','1'),('00001U-ITC','000006-AKL','Zirai Malzeme ve İlaç Alımları','03.2.6.03','1'),('00001V-ITC','000006-AKL','Canlı Hayvan Alım, Bakım ve Diğer Giderleri','03.2.6.04','1'),('00001W-ITC','000006-AKL','Diğer Özel Malzeme Alımları','03.2.6.90','1'),('00001X-ITC','000006-AKL','Bahçe Malzemesi Alımları ile Yapım ve Bakım Giderleri','03.2.9.01','1'),('00001Y-ITC','000006-AKL','Diger Tüketim Mal ve Malzemesi Alımları','03.2.9.90','1'),('00001Z-ITC','000007-AKL','Yurtiçi Geçici Görev Yollukları','03.3.1.01','1'),('000020-ITC','000007-AKL','Yurtiçi Tedavi Yollukları','03.3.1.02','1'),('000021-ITC','000007-AKL','Yurtiçi Sürekli Görev Yollukları','03.3.2.01','1'),('000022-ITC','000007-AKL','Yurtdışı Geçici Görev Yollukları','03.3.3.01','1'),('000023-ITC','000007-AKL','Yurtdışı Tedavi Yollukları','03.3.3.02','1'),('000024-ITC','000007-AKL','Yurtdışı Sürekli Görev Yollukları','03.3.4.01','1'),('000025-ITC','000007-AKL','Seyyar Görev Tazminatları','03.3.5.01','1'),('000026-ITC','000007-AKL','Profesör, Uzman ve Memur Mübadele Giderleri','03.3.6.01','1'),('000027-ITC','000007-AKL','Öğrenci Mübadele Giderleri','03.3.6.02','1'),('000028-ITC','000008-AKL','Mahkeme Harç ve Giderleri','03.4.2.04','1'),('000029-ITC','000008-AKL','Diğer Vergi, Resim ve Harçlar ve Benzeri Giderler','03.4.3.90','1'),('00002A-ITC','000008-AKL','Arkeolojik Kazı Giderleri','03.4.4.01','1'),('00002B-ITC','000008-AKL','Restorasyon ve Yenileme Giderleri','03.4.4.02','1'),('00002C-ITC','000008-AKL','Kültür Varlıkları Alımı','03.4.4.03','1'),('00002D-ITC','000008-AKL','Sergi Giderleri','03.4.4.04','1'),('00002E-ITC','000008-AKL','Kültür Varlıklarının Korunmasına İlişkin Diğer Giderler','03.4.4.90','1'),('00002F-ITC','000009-AKL','Etüt-Proje Bilirkişi Ekspertiz Giderleri','03.5.1.01','1'),('00002G-ITC','000009-AKL','Araştırma ve Geliştirme Giderleri','03.5.1.02','1'),('00002H-ITC','000009-AKL','Bilgisayar Hizmeti Alımlari (Yazılım ve Donanım Alımlari Hariç)','03.5.1.03','1'),('00002I-ITC','000009-AKL','Müteahhitlik Hizmetleri (Temizlik Hizmet İhaleleri Dahil)','03.5.1.04','1'),('00002J-ITC','000009-AKL','Harita Yapım ve Alım Giderleri','03.5.1.05','1'),('00002K-ITC','000009-AKL','Enformasyon ve Raporlama Giderleri','03.5.1.06','1'),('00002L-ITC','000009-AKL','Danışma Yönetim ve İşletim Giderleri','03.5.1.07','1'),('00002M-ITC','000009-AKL','Diğer Müşavir Firma ve Kişilere Ödemeler','03.5.1.90','1'),('00002N-ITC','000009-AKL','Posta ve Telgraf Giderleri','03.5.2.01','1'),('00002O-ITC','000009-AKL','Telefon Abonelik ve Kullanim Ücretleri','03.5.2.02','1'),('00002P-ITC','000009-AKL','Bilgiye Abonelik Giderleri (İnternet abonelik ücretleri dahil)','03.5.2.03','1'),('00002Q-ITC','000009-AKL','Haberleşme Cihazları Ruhsat ve Kullanım Giderleri','03.5.2.04','1'),('00002R-ITC','000009-AKL','Uydu Haberleşme Giderleri','03.5.2.05','1'),('00002S-ITC','000009-AKL','Hat Kira Giderleri','03.5.2.06','1'),('00002T-ITC','000009-AKL','Diğer Haberleşme Giderleri','03.5.2.90','1'),('00002U-ITC','000009-AKL','Yolcu Taşıma Giderleri','03.5.3.02','1'),('00002V-ITC','000009-AKL','Yük Taşıma Giderleri','03.5.3.03','1'),('00002W-ITC','000009-AKL','Geçi Ücretleri','03.5.3.04','1'),('00002X-ITC','000009-AKL','Diğer Taşıma Giderleri','03.5.3.90','1'),('00002Y-ITC','000009-AKL','İlan Giderleri','03.5.4.01','1'),('00002Z-ITC','000009-AKL','Sigorta Giderleri','03.5.4.02','1'),('000030-ITC','000009-AKL','Dayanıklı Mal ve Malzeme Kiralamasi Giderleri','03.5.5.01','1'),('000031-ITC','000009-AKL','Taşıt Kiralaması Giderleri','03.5.5.02','1'),('000032-ITC','000009-AKL','İş Makinası Kiralaması Giderleri','03.5.5.03','1'),('000033-ITC','000009-AKL','Hizmet Binası Kiralama Giderleri','03.5.5.05','1'),('000034-ITC','000009-AKL','Arsa ve Arazi Kiralaması Giderleri','03.5.5.07','1'),('000035-ITC','000009-AKL','Bilgisayar ve Bilgisayar Sistemleri ve Yazılımları Kiralaması','03.5.5.10','1'),('000036-ITC','000009-AKL','Diğer Kiralama Giderleri','03.5.5.90','1'),('000037-ITC','000009-AKL','Yurtiçi Staj ve Öğrenim Giderleri','03.5.9.01','1'),('000038-ITC','000009-AKL','Yurtdışı Staj ve Öğrenim Giderleri','03.5.9.02','1'),('000039-ITC','000009-AKL','Kurslara Katılma Giderleri','03.5.9.03','1'),('00003A-ITC','000009-AKL','Öğretim Üyesi Yetiştirme Projesi Giderleri','03.5.9.04','1'),('00003B-ITC','000009-AKL','Diğer Hizmet Alımları','03.5.9.90','1'),('00003C-ITC','00000A-AKL','Temsil, Ağırlama, Tören, Fuar, Organizasyon Giderleri','03.6.1.01','1'),('00003D-ITC','00000A-AKL','Tanıtma, Ağırlama, Tören, Fuar, Organizasyon Giderleri','03.6.2.01','1'),('00003E-ITC','00000B-AKL','Büro ve İşyeri Mal ve Malzeme Alımları','03.7.1.01','1'),('00003F-ITC','00000B-AKL','Büro ve İşyeri Makina ve Teçhizat Alımları','03.7.1.02','1'),('00003G-ITC','00000B-AKL','Avadanlık ve Yedek Parça Alımları','03.7.1.03','1'),('00003H-ITC','00000B-AKL','Yangından Korunma Malzemeleri Alımları','03.7.1.04','1'),('00003I-ITC','00000B-AKL','Diğer Dayanıklı Mal ve Malzeme Alımları','03.7.1.90','1'),('00003J-ITC','00000B-AKL','Bilgisayar Yazılım Alımları ve Yapımları','03.7.2.01','1'),('00003K-ITC','00000B-AKL','Fikri Hak Alımları','03.7.2.02','1'),('00003L-ITC','00000B-AKL','Diğer Gayri Maddi Hak Alımları','03.7.2.90','1'),('00003M-ITC','00000B-AKL','Tefrisat Bakım ve Onarim Giderleri','03.7.3.01','1'),('00003N-ITC','00000B-AKL','Makine Teçhizat Bakım ve Onarım Giderleri','03.7.3.02','1'),('00003O-ITC','00000B-AKL','Taşıt Bakım ve Onarım Giderleri','03.7.3.03','1'),('00003P-ITC','00000B-AKL','İş Makinası Onarım Giderleri','03.7.3.04','1'),('00003Q-ITC','00000B-AKL','Diğer Bakım ve Onarım Giderleri','03.7.3.90','1'),('00003R-ITC','00000C-AKL','Büro Bakım ve Onarım Giderleri','03.8.1.01','1'),('00003S-ITC','00000C-AKL','Okul Bakım ve Onarım Giderleri','03.8.1.02','1'),('00003T-ITC','00000C-AKL','Diğer Hizmet Binası Bakım ve Onarım Giderleri','03.8.1.90','1'),('00003U-ITC','00000C-AKL','Lojman Bakım ve Onarımı Giderleri','03.8.2.01','1'),('00003V-ITC','00000C-AKL','Sosyal Tesis Bakım ve Onarım Giderleri','03.8.3.01','1'),('00003W-ITC','00000C-AKL','Diğer Taşınmaz Yapım, Bakım ve Onarım Giderleri','03.8.9.01','1'),('00003X-ITC','00000D-AKL','Kamu Personeli Tedavi ve Sağlık Malzemesi Giderleri','03.9.1.01','1'),('00003Y-ITC','00000D-AKL','Kamu Personeli İlaç Giderleri','03.9.2.01','1'),('00003Z-ITC','00000D-AKL','Cenaze Giderleri','03.9.3.01','1'),('000040-ITC','00000G-AKL','Memurların Öğle Yemeğine Yardım','05.3.1.05','1'),('000041-ITC','00000H-AKL','Sağlık Amaçlı Transferler','05.4.3.01','1'),('000042-ITC','00000I-AKL','Uluslararası Kuruluşlara Üyelik Aidati Ödemeleri','05.6.2.01','1'),('000043-ITC','00000J-AKL','Büro Mefruşatı Alımları','06.1.1.01','1'),('000044-ITC','00000J-AKL','Okul Mefruşatı Alımları','06.1.1.03','1'),('000045-ITC','00000J-AKL','Diğer Mefruşat Alımları','06.1.1.90','1'),('000046-ITC','00000J-AKL','Büro Makinaları Alımları','06.1.2.01','1'),('000047-ITC','00000J-AKL','Bilgisayar Alımları','06.1.2.02','1'),('000048-ITC','00000J-AKL','Tıbbi Cihaz Alımları','06.1.2.03','1'),('000049-ITC','00000J-AKL','Laboratuar Cihazı Alımları','06.1.2.04','1'),('00004A-ITC','00000J-AKL','İşyeri Makina Teçhiizat Alımları','06.1.2.05','1'),('00004B-ITC','00000J-AKL','Diğer Makina Teçhizat Alımları','06.1.2.90','1'),('00004C-ITC','00000J-AKL','Tamir Bakım Aleti Alımları','06.1.3.01','1'),('00004D-ITC','00000J-AKL','Atölye Gereçleri Alımları','06.1.3.02','1'),('00004E-ITC','00000J-AKL','Tıbbi Gereç Alımları','06.1.3.03','1'),('00004F-ITC','00000J-AKL','Laboratuar Gereçleri Alımları','06.1.3.04','1'),('00004G-ITC','00000J-AKL','Zirai Gereç Alımları','06.1.3.05','1'),('00004H-ITC','00000J-AKL','Diğer Avadanlık Alımları','06.1.3.90','1'),('00004I-ITC','00000J-AKL','Basılı Yayın Alımları','06.1.6.01','1'),('00004J-ITC','00000J-AKL','El Yazması Alımları','06.1.6.02','1'),('00004K-ITC','00000J-AKL','Optik Yayın Alımları','06.1.6.03','1'),('00004L-ITC','00000J-AKL','Görüntülü Yayin Alımları','06.1.6.04','1'),('00004M-ITC','00000J-AKL','Diğer Yayın Alımları','06.1.6.90','1'),('00004N-ITC','00000J-AKL','Arkeolojik Kazı Giderleri','06.1.7.01','1'),('00004O-ITC','00000J-AKL','Tablo-Heykel Alım ve Onarımları','06.1.7.02','1'),('00004P-ITC','00000J-AKL','Eski Eser Alım ve Onarımları','06.1.7.03','1'),('00004Q-ITC','00000J-AKL','Diğer Kültür Varlığı Alımları ve Korunması Giderleri','06.1.7.90','1'),('00004R-ITC','00000K-AKL','Bilgisayar Yazılımı Alımları','06.3.1.01','1'),('00004S-ITC','00000K-AKL','Harita Alımları','06.3.2.01','1'),('00004T-ITC','00000K-AKL','Plan Proje Alımları','06.3.2.02','1'),('00004U-ITC','00000K-AKL','Lisans Alımları','06.3.3.01','1'),('00004V-ITC','00000K-AKL','Patent Alımları','06.3.4.01','1'),('00004W-ITC','00000K-AKL','Diğer Fikri Hak Alımları','06.3.9.01','1'),('00004X-ITC','00000L-AKL','Hizmet Binası','06.5.7.01','1'),('00004Y-ITC','00000N-AKL','Hizmet Binası','06.7.7.01','1'),('00004Z-ITC','00000O-AKL','Yurtiçi Geçici Görev Yollukları','06.9.2.01','1'),('000050-ITC','00000O-AKL','Yurtdışı Geçici Görev Yollukları','06.9.2.03','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `KALEM` ENABLE KEYS */;

--
-- Table structure for table `KULLANICI`
--

DROP TABLE IF EXISTS `KULLANICI`;
CREATE TABLE `KULLANICI` (
  `KullaniciNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KullaniciAdi` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KullaniciSifresi` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Ad` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Soyad` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Email` varchar(30) character set utf8 collate utf8_turkish_ci default NULL,
  `TelNo` varchar(20) character set utf8 collate utf8_turkish_ci default NULL,
  `SifreHatasi` int(11) default NULL,
  `PozisyonNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GrupNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  `OzelAnahtarKullaniyor` enum('0','1') NOT NULL default '0',
  `AciklamaGoster` enum('0','1') NOT NULL default '1',
  `IpAdresi` varchar(15) character set utf8 collate utf8_turkish_ci default NULL,
  PRIMARY KEY  (`KullaniciNo`),
  UNIQUE KEY `KullaniciAdi` (`KullaniciAdi`),
  KEY `PozisyonNo` (`PozisyonNo`),
  KEY `GrupNo` (`GrupNo`),
  CONSTRAINT `KULLANICI_fk` FOREIGN KEY (`PozisyonNo`) REFERENCES `POZISYON` (`PozisyonNo`),
  CONSTRAINT `KULLANICI_fk1` FOREIGN KEY (`GrupNo`) REFERENCES `GRUP` (`GrupNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `KULLANICI`
--


/*!40000 ALTER TABLE `KULLANICI` DISABLE KEYS */;
LOCK TABLES `KULLANICI` WRITE;
INSERT INTO `KULLANICI` VALUES ('000001-USR','akademikpersonel','2707','Arda','Yurdakul','omerbll@gmail.com','021205466',0,'000001-POS','00002N-GRP','1','0','1',NULL),('000002-USR','idaripersonel','2050','Levent','Polat','omerbll@gmail.com','0212458785',0,'000002-POS','00004S-GRP','1','1','1',NULL),('000003-USR','bbaskan','5839','Cem','Ersoy','omerbll@gmail.com','053312545',0,'000003-POS','00002N-GRP','1','1','1',NULL),('000004-USR','bsekreter','8692','Mücella','Efe','omerbll@gmail.com','02125455',0,'000004-POS','00002N-GRP','1','0','1',NULL),('000005-USR','muhdekan','5474','Ali Rıza','Kaylan','omerbll@gmail.com','021245845',0,'000005-POS','00002M-GRP','1','1','1',NULL),('000006-USR','idarimudur','2225','Sibel','Moyano','omerbll@gmail.com','02125465',0,'000006-POS','00004S-GRP','1','1','1',NULL),('000007-USR','genelsekreter','1882','Nuray','Işık','omerbll@gmail.com','0212554554',0,'000007-POS','00004K-GRP','1','1','1',NULL),('000008-USR','dairebaskani','5575','Hüseyin','Akın','omerbll@gmail.com','0125458844',0,'000008-POS','00004R-GRP','1','1','1',NULL),('000009-USR','sasihaleyon','7473','Orhan','Pamuk','aykut@boun.edu.tr','012132154',0,'000009-POS','000005-GRP','1','1','1',NULL),('00000A-USR','sasrapor','8466','Aykut','Soner','aykut@boun.edu.tr','021231321',0,'00000A-POS','000005-GRP','1','1','1',NULL),('00000B-USR','dogrudansas','4749','Aykut','Demirkol','aykut@boun.edu.tr','01211544',0,'00000B-POS','000005-GRP','1','1','1',NULL),('00000C-USR','sasyoneticisi','6123','Bülent','İşi','aykut@boun.edu.tr','01245654',0,'00000C-POS','000005-GRP','1','1','1',NULL),('00000D-USR','butcebas','3970','Oktay','Işık','zeldal@boun.edu.tr','0212121',0,'00000D-POS','000002-GRP','1','1','1',NULL),('00000E-USR','butcesek','1546','Leyla','Taşdemir','zeldal@boun.edu.tr','01244554',0,'00000E-POS','000002-GRP','1','1','1',NULL),('00000F-USR','ambarsefi','9752','Feyza','Değer','betul.ceran@boun.edu.tr','01245654',0,'00000F-POS','000003-GRP','1','1','1',NULL),('00000G-USR','aynsaymani','5940','Adnan','Aydın','betul.ceran@boun.edu.tr','012154654',0,'00000G-POS','000003-GRP','1','1','1',NULL),('00000H-USR','ayngorevlisi','2328','Abdurrahman','Arif','betul.ceran@boun.edu.tr','0124554455',0,'00000H-POS','000003-GRP','1','1','1',NULL),('00000I-USR','rektoryar','2910','Gülen','Aktaş','betul.ceran@boun.edu.tr','01232132',0,'00000I-POS','000007-GRP','1','1','1',NULL),('00000J-USR','btsakademikpersonel','1111','Arda','Yurdakul','omerbll@gmail.com','021205466',0,'000001-POS','00006B-GRP','1','1','1',NULL),('00000K-USR','btsbbaskan','3333','Cem','Ersoy','omerbll@gmail.com','053312545',0,'000003-POS','00006B-GRP','1','1','1',NULL),('00000L-USR','cevrebsekreter','4444','M','Efe','omerbll@gmail.com','02125455',0,'000004-POS','00006B-GRP','1','0','1',NULL),('00000M-USR','btsdekan','5555','Ali Riza','Kaylan','omerbll@gmail.com','021245845',0,'000005-POS','00006B-GRP','1','1','1',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `KULLANICI` ENABLE KEYS */;

--
-- Table structure for table `KULLANICI_IMZA_ANAHTARI`
--

DROP TABLE IF EXISTS `KULLANICI_IMZA_ANAHTARI`;
CREATE TABLE `KULLANICI_IMZA_ANAHTARI` (
  `ImzaAnahtari` text character set utf8 collate utf8_turkish_ci NOT NULL,
  `KullaniciNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aktif` enum('0','1') default '1',
  `AcildigiTarih` bigint(20) NOT NULL,
  `KaldirildigiTarih` bigint(20) default NULL,
  KEY `KullaniciNo` (`KullaniciNo`),
  CONSTRAINT `KULLANICI_IMZA_ANAHTARI_fk` FOREIGN KEY (`KullaniciNo`) REFERENCES `KULLANICI` (`KullaniciNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `KULLANICI_IMZA_ANAHTARI`
--


/*!40000 ALTER TABLE `KULLANICI_IMZA_ANAHTARI` DISABLE KEYS */;
LOCK TABLES `KULLANICI_IMZA_ANAHTARI` WRITE;
INSERT INTO `KULLANICI_IMZA_ANAHTARI` VALUES ('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAOUwXxvrMggmRsN+w1DyT4UTr+dp4SfSPgH7hBwHUMFIjr/ioShJCPJwJalensgR7OVUxnFopcafitK3KKliwxvZ5F2ipsF3ZQc/MHTQ+1/UJrzJ8EGsRr8F+YOLzKitH9bBnVI/q7dmqkM8GeryneBcBeFUfgpazS6A7dbaZeHJ','000002-USR','1',1135907116138,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAaCQFYwV8en5Uv2U4b6QSWgRzBQuIWaL5Oxqfq+lXZ4/m3pNmjX6tDlJcpf8uptqwC2HoyG9+gG8+j/sqXvVmJWVi20iqfEk5S8Zow4RMQ4WX5swyuGRh8hr9aV+618mP8LBW7zeySe59QMa8fa9i7FbKyx99sMuxp8mWipAoQHw=','000003-USR','1',1135907205236,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAUdcK0SSYjojJXIWYqHT8452XO/wm5bgiLLcitBMl47u18QfjjXP+0RgJEaS1XjUWLjrNJ6N7EXsowkhHh+LUAOoS9XV67vl6TfWJeaICTgnTR7tOPFfno79Q5VH1kSlTaU5mOFPK3bRvn8t2vhvcnxl9btzBwpveGIlDGNW8GjU=','000005-USR','1',1135907369242,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAOLIr9tKFNa9/P5H3YEiND89+eAdqn7Ku0Njam+bbpeLCr9+znXcCNQ99nyKgTR4Ph3VaBoixy2qj1g92X75x2jr5bmCgJfdzXTMMW/eBMyx0dYzFHLjQQcLz+IIR0JgZzegNFLKpYgAbD0Hdqmi6oO4YChnJVkKmadHIveCH90H','000006-USR','1',1135907535903,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAGNBdlk/Ki5cuAFnaceEGD3cfbcoYJz/uR2qlNeMrt/i2ntgPn+V3c0/hE/VZC/7sETI9apx6NJOrBSHBtX+/CuHd4kP8JofBGGHJmWKi85QUFyb736gCoh9V+F/QFxlt20D3qPPYAp16UuFc6rXaIbjz0AlewJ3/Tmt12CnZ8Ug=','000007-USR','1',1135907619916,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAPpnalnFkvKpXbhQlsf/kZ166JAkt2itH5d/fugPMRv86wJKMFCmFY/sfdQAg2t7h5n5+pk6gGR2UtMrJwWF521Tgr3TdE7JaLM83VDjz0+jVhb8Vlbcs0mJ7LXS1JFBegkMz2upZD5gV6d47IN2Q0kksUxMyrZtu3LSonUQFPyz','000008-USR','1',1135907845799,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAIF2i8z7MnZT7NizU7igOfUd7+U0aFSodLTnD6BsDmOda//ZLQHxOyqZxeKciSM9jax0N3iY4LJ7kS83T5keC2nexKtsSw2z262GOlK6kKzpvJ8wgtABVHUgf+XVRYBUB787/j7Q3L65P4xgk1LuxREqNvdgIztUmvlWNKdkiHFi','000009-USR','1',1135907994665,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAIx9xvNIqkR5xo6fujv+ZJQX9vPr2nOS/gB4uCeHje2XimibaB3algBPj5uw4Ax5SiikUw5GVFM4K8BuIUZgzn1NRz12oS9TVZr7VDkKr5oqRFV/WKRDVbyxVQhXy/xF5nLlbiwiSeM2lFVir6T/odrRyztTRcDN0ikmWq9u2P+W','00000A-USR','1',1135908141642,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAMBx2ZiDf/XdF/u+d7i+eMM0OuUiymA/MSJG5cHITVNFxqbsvoF5I2BC6jTd8rIdk+qy7msxHdnDId8kHAxgQii1qCfRELGCPXDEjsYvTu1biejUnTIq7HAvgEZh6fmhv6sVTeGe2/gKu3XBei5dkkyXM5zvEzZ2WpTuySfI7J1K','00000B-USR','1',1135908248267,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAVffbQ/5KvCi++klYPE9tqWc0pAavJlnLkiEeEEjt5IYodJczE9H0+VBr28ReMyNdI1N+sbAACkcOUlBrB70EweSv1F21BRpCTlQDLsX9deJI/a6PAfrOjjz1rCUUmgSEEsCX1t6A7K2cEMa82GJYMVjU0IlSfMp2fdBqtVkPrRI=','00000C-USR','1',1135908388853,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAZo4rhyJIcyLEtzn29+7ytlNDitOET/64nA1J5705Fa8WDG0bjEz/NdmbFCcz/fnEKZknKz2DNyrftFU2pzmUHADmi/egXtPcsGPVafnehx04fwZhJai1L3yis3FadOjo2shKoQMQYvTpQjXTZtlX9429Pvaowyffu/2LI3PrqP8=','00000D-USR','1',1135908496015,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAEVFecrKPg5eu/5FkwhjGzhoVFbw2Wyutmi500uchf9zOP8QSBaeuApdMC6Vcf9JDnVzXiTDZ5iIRrCE98Pqp2DqtOPl5Us5VJD/fGQ9oHuSX+CoW39syaSubOJRTx+9O15RZ8cZ8MWMnD1/MJOWg8tCLi08fnhhsk4lkTefkCis=','00000E-USR','1',1135908566208,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAJKTMlAQml2hKUqgyLLZOXPdPSx5dgQeglqHJxoegdpXUFr/MupUBBGzl3yf2NRJfZ2af2ZXIpwAJXW5M2BRxkUCY1y1EvLWMhvppWn1tGX1OF8LrEwJiLwTwMiayUFGWjg3VzkR9dl7DAu6s2g2Ie3at4g6VWnP9oJVEjtlC0I+','00000F-USR','1',1135908720384,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAIO11GpjcGnHuHqUB0+bxHGU4ZLNp26b91ms1d6UI3+b4e21xEr7pWGSL3zpDyrEBSRBxs0bM5yMlehwg8aSqroRTsTVDr1M+sygB1Asp4+BdurNVV2PydpOptDQCoWNb7vEDempo2RJsZ8UdMq91f78N049gNDf0OqPNRMlT34M','00000G-USR','1',1135908800890,NULL),('MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAQAFXPjI9EAWKcLF/5dXJJ02BagH3DKxOlnXX0Uumu/RKgRLPgEad1JIvBVEMGbaLSs3Xjv7kVBqPQ+am+u0DpddMPr0i0W/1JgMOgthUPdBbWtpvojWqUZMLSwViki8208KXX3Dn4W+1t+q9CRmH9EsbTeBRCoIEjAAGm2um5Xg=','00000H-USR','1',1135908921868,NULL),('MIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAMlHCTLM34qRcssuexCSY+IslX0/aVOTnbMsRxk/b5mmat1v9/hvuycmKTXjSmLM4LlNrAo/4mX6iQcRwPdl8SvYHBAkL3GNujqb6T/Dm4/DMDaMAauacPQzw5873waY4XVJiPAngvPKw/cFg51OGx/6JejN9Z/Buv12Zy+Lx/SG','00000I-USR','1',1135909039776,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `KULLANICI_IMZA_ANAHTARI` ENABLE KEYS */;

--
-- Table structure for table `KULLANICI_SAYFA_YETKISI_MN`
--

DROP TABLE IF EXISTS `KULLANICI_SAYFA_YETKISI_MN`;
CREATE TABLE `KULLANICI_SAYFA_YETKISI_MN` (
  `KullaniciNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`SayfaNo`,`KullaniciNo`),
  KEY `KullaniciNo` (`KullaniciNo`),
  KEY `SayfaNo` (`SayfaNo`),
  CONSTRAINT `KULLANICI_SAYFA_YETKISI_MN_fk` FOREIGN KEY (`KullaniciNo`) REFERENCES `KULLANICI` (`KullaniciNo`),
  CONSTRAINT `KULLANICI_SAYFA_YETKISI_MN_fk1` FOREIGN KEY (`SayfaNo`) REFERENCES `SAYFA` (`SayfaNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `KULLANICI_SAYFA_YETKISI_MN`
--


/*!40000 ALTER TABLE `KULLANICI_SAYFA_YETKISI_MN` DISABLE KEYS */;
LOCK TABLES `KULLANICI_SAYFA_YETKISI_MN` WRITE;
INSERT INTO `KULLANICI_SAYFA_YETKISI_MN` VALUES ('000005-USR','000001-PAG','1'),('00000M-USR','000001-PAG','1'),('000003-USR','000002-PAG','1'),('00000K-USR','000002-PAG','1'),('000004-USR','000003-PAG','1'),('00000L-USR','000003-PAG','1'),('00000D-USR','000004-PAG','1'),('00000D-USR','000005-PAG','1'),('00000D-USR','000006-PAG','1'),('00000E-USR','000007-PAG','1'),('00000C-USR','000008-PAG','1'),('000009-USR','000009-PAG','1'),('00000C-USR','000009-PAG','1'),('000005-USR','00000C-PAG','1'),('00000M-USR','00000C-PAG','1'),('00000I-USR','00000D-PAG','1'),('000001-USR','00000F-PAG','1'),('000002-USR','00000F-PAG','1'),('000003-USR','00000F-PAG','1'),('000004-USR','00000F-PAG','1'),('000006-USR','00000F-PAG','1'),('00000J-USR','00000F-PAG','1'),('00000K-USR','00000F-PAG','1'),('00000L-USR','00000F-PAG','1'),('000006-USR','00000H-PAG','1'),('000007-USR','00000I-PAG','1'),('000008-USR','00000I-PAG','1'),('000005-USR','00000J-PAG','1'),('00000D-USR','00000J-PAG','1'),('00000M-USR','00000J-PAG','1'),('00000D-USR','00000K-PAG','1'),('00000D-USR','00000L-PAG','1'),('00000D-USR','00000M-PAG','1'),('00000F-USR','00000N-PAG','1'),('00000G-USR','00000N-PAG','1'),('00000H-USR','00000N-PAG','1'),('000001-USR','00000O-PAG','1'),('000002-USR','00000O-PAG','1'),('000003-USR','00000O-PAG','1'),('000004-USR','00000O-PAG','1'),('000006-USR','00000O-PAG','1'),('00000F-USR','00000O-PAG','1'),('00000G-USR','00000O-PAG','1'),('00000H-USR','00000O-PAG','1'),('00000J-USR','00000O-PAG','1'),('00000K-USR','00000O-PAG','1'),('00000L-USR','00000O-PAG','1'),('00000G-USR','00000Q-PAG','1'),('00000I-USR','00000R-PAG','1'),('00000C-USR','00000S-PAG','1'),('00000A-USR','00000T-PAG','1'),('00000C-USR','00000T-PAG','1'),('00000B-USR','00000U-PAG','1'),('00000C-USR','00000U-PAG','1'),('00000B-USR','00000V-PAG','1'),('00000C-USR','00000V-PAG','1'),('00000I-USR','00000X-PAG','1'),('00000I-USR','00000Y-PAG','1'),('000001-USR','00000Z-PAG','1'),('000002-USR','00000Z-PAG','1'),('000003-USR','00000Z-PAG','1'),('000004-USR','00000Z-PAG','1'),('000006-USR','00000Z-PAG','1'),('00000J-USR','00000Z-PAG','1'),('00000K-USR','00000Z-PAG','1'),('00000L-USR','00000Z-PAG','1'),('00000D-USR','BTS003-PAG','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `KULLANICI_SAYFA_YETKISI_MN` ENABLE KEYS */;

--
-- Table structure for table `KURUMSAL`
--

DROP TABLE IF EXISTS `KURUMSAL`;
CREATE TABLE `KURUMSAL` (
  `KurumsalNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KurumsalKod` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aciklama` varchar(30) character set utf8 collate utf8_turkish_ci default NULL,
  `Statu` enum('0','1','2') NOT NULL default '1',
  PRIMARY KEY  (`KurumsalNo`),
  KEY `KurumsalKod` (`KurumsalKod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `KURUMSAL`
--


/*!40000 ALTER TABLE `KURUMSAL` DISABLE KEYS */;
LOCK TABLES `KURUMSAL` WRITE;
INSERT INTO `KURUMSAL` VALUES ('000000-KRM','DEFAULT','DEFAULT KURUMSAL KOD','2'),('000001-KRM','97.08.42.42','Fen Edebiyat Fakültesi','1'),('000002-KRM','97.08.43.43','Mühendislik Fakütesi','1'),('000003-KRM','97.08.52.51','Eğitim Fakültesi','1'),('000004-KRM','97.08.53.52','İktisadi İdari Birimler Fakült','1'),('000005-KRM','97.08.56.52','Yabancı Diller Yüksek Okulu','1'),('000006-KRM','97.08.56.57','Uygulamalı Bilimler Yüksek Oku','1'),('000007-KRM','97.08.57.50','Meslek Yüksek Okulu','1'),('000008-KRM','97.08.40.46','Kandilli Rasathanesi Deprem Ar','1'),('000009-KRM','97.08.48.44','Fen Bilimleri Merkezleri/Depre','1'),('00000A-KRM','97.08.40.40','Fen Bilimleri Enstitüsü','1'),('00000B-KRM','97.08.41.41','Biyo-Medikal Mühendisligi Enst','1'),('00000C-KRM','97.08.50.50','Atatürk İlkeleri ve Inkilâp Ta','1'),('00000D-KRM','97.08.50.54','Sosyal Bilimler Enstitüsü','1'),('00000E-KRM','97.08.50.59','Çevre Bilimleri Enstitüsü','1'),('00000F-KRM','97.08.00.02','Genel Kalem','1'),('00000G-KRM','97.08.02.02','Genel Sekreterlik','1'),('00000H-KRM','97.08.02.02','Kamu Düzeni ve Güvenlik Hizmet','1'),('00000I-KRM','97.08.02.03','Savunma Uzmanlığı','1'),('00000J-KRM','97.08.02.04','İdari ve Mali İşler Daire Başk','1'),('00000K-KRM','97.08.02.05','Personel Daire Başkanlığı','1'),('00000L-KRM','97.08.02.07','Kütüphane ve Dökümantasyon Dai','1'),('00000M-KRM','97.08.02.07','Yayın ve Yayım Hizmetleri Müdü','1'),('00000N-KRM','97.08.02.09','Sağlık Kültür ve Spor Daire Ba','1'),('00000O-KRM','97.08.02.10','Bilgi İşlem Daire Başkanlığı','1'),('00000P-KRM','97.08.02.11','Yapı İşleri Teknik Daire Başka','1'),('00000Q-KRM','97.08.02.13','Öğrenci İşleri Daire Başkanlığ','1'),('00000R-KRM','97.08.2.24','Hukuk Müşavirliği','1'),('00000S-KRM','97.08.60.56','Eğitim Hizmetleri Güzel Sanatl','1'),('00000T-KRM','97.08.02.04','Eğitim Hizmetleri','1'),('00000U-KRM','97.08.48.49','Diğer Merkezler','1'),('00000V-KRM','97.08.60.55','Sosyal Merkezler','1'),('00000Y-KRM','38.08.50.59','Çevre Bilimleri Enstitüsü BTS','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `KURUMSAL` ENABLE KEYS */;

--
-- Table structure for table `LOG`
--

DROP TABLE IF EXISTS `LOG`;
CREATE TABLE `LOG` (
  `SpAdi` varchar(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `GelenParametreler` text character set utf8 collate utf8_turkish_ci,
  `KullaniciIp` varchar(20) character set utf8 collate utf8_turkish_ci default NULL,
  `OlusturmaTarihi` datetime NOT NULL,
  `Olusturan` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  KEY `Olusturan` (`Olusturan`),
  CONSTRAINT `LOG_fk` FOREIGN KEY (`Olusturan`) REFERENCES `KULLANICI` (`KullaniciNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `LOG`
--


/*!40000 ALTER TABLE `LOG` DISABLE KEYS */;
LOCK TABLES `LOG` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `LOG` ENABLE KEYS */;

--
-- Table structure for table `POZISYON`
--

DROP TABLE IF EXISTS `POZISYON`;
CREATE TABLE `POZISYON` (
  `PozisyonNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `PozisyonAdi` varchar(70) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`PozisyonNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `POZISYON`
--


/*!40000 ALTER TABLE `POZISYON` DISABLE KEYS */;
LOCK TABLES `POZISYON` WRITE;
INSERT INTO `POZISYON` VALUES ('000001-POS','Akademik Personel','1'),('000002-POS','İdari Personel','1'),('000003-POS','Bölüm Başkanı','1'),('000004-POS','Bölüm Sekreteri','1'),('000005-POS','Dekan','1'),('000006-POS','İdari Birim Müdürü','1'),('000007-POS','Genel Sekreter','1'),('000008-POS','Daire Başkanı','1'),('000009-POS','SAS İhale Yöneticisi','1'),('00000A-POS','SAS Rapor Yöneticisi','1'),('00000B-POS','Doğrudan Satın Alma Sorumlusu','1'),('00000C-POS','SAS Yöneticisi','1'),('00000D-POS','Bütçe Başkanı','1'),('00000E-POS','Bütçe Sekreteri','1'),('00000F-POS','Ambar Sefi','1'),('00000G-POS','Ayniyat Saymani','1'),('00000H-POS','Ayniyat Görevlisi','1'),('00000I-POS','Rektör Yardımcısı','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `POZISYON` ENABLE KEYS */;

--
-- Table structure for table `POZISYON_SAYFA_YETKISI_MN`
--

DROP TABLE IF EXISTS `POZISYON_SAYFA_YETKISI_MN`;
CREATE TABLE `POZISYON_SAYFA_YETKISI_MN` (
  `PozisyonNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`PozisyonNo`,`SayfaNo`),
  KEY `PozisyonNo` (`PozisyonNo`),
  KEY `SayfaNo` (`SayfaNo`),
  CONSTRAINT `POZISYON_SAYFA_RIGHT_MN_fk` FOREIGN KEY (`PozisyonNo`) REFERENCES `POZISYON` (`PozisyonNo`),
  CONSTRAINT `POZISYON_SAYFA_RIGHT_MN_fk1` FOREIGN KEY (`SayfaNo`) REFERENCES `SAYFA` (`SayfaNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `POZISYON_SAYFA_YETKISI_MN`
--


/*!40000 ALTER TABLE `POZISYON_SAYFA_YETKISI_MN` DISABLE KEYS */;
LOCK TABLES `POZISYON_SAYFA_YETKISI_MN` WRITE;
INSERT INTO `POZISYON_SAYFA_YETKISI_MN` VALUES ('000001-POS','00000F-PAG','1'),('000001-POS','00000O-PAG','1'),('000001-POS','00000Z-PAG','1'),('000002-POS','00000F-PAG','1'),('000002-POS','00000O-PAG','1'),('000002-POS','00000Z-PAG','1'),('000003-POS','000002-PAG','1'),('000003-POS','00000F-PAG','1'),('000003-POS','00000O-PAG','1'),('000003-POS','00000Z-PAG','1'),('000003-POS','STS002-PAG','1'),('000003-POS','STS014-PAG','1'),('000004-POS','000003-PAG','1'),('000004-POS','00000F-PAG','1'),('000004-POS','00000O-PAG','1'),('000004-POS','00000Z-PAG','1'),('000004-POS','BTS006-PAG','1'),('000004-POS','STS002-PAG','1'),('000004-POS','STS005-PAG','1'),('000004-POS','STS007-PAG','1'),('000004-POS','STS010-PAG','1'),('000004-POS','STS011-PAG','1'),('000004-POS','STS014-PAG','1'),('000005-POS','000001-PAG','1'),('000005-POS','00000C-PAG','1'),('000005-POS','00000J-PAG','1'),('000005-POS','STS015-PAG','1'),('000005-POS','STS016-PAG','1'),('000006-POS','00000F-PAG','1'),('000006-POS','00000H-PAG','1'),('000006-POS','00000O-PAG','1'),('000006-POS','00000Z-PAG','1'),('000007-POS','00000I-PAG','1'),('000008-POS','00000I-PAG','1'),('000009-POS','000009-PAG','1'),('00000A-POS','00000T-PAG','1'),('00000B-POS','00000U-PAG','1'),('00000B-POS','00000V-PAG','1'),('00000C-POS','000008-PAG','1'),('00000C-POS','000009-PAG','1'),('00000C-POS','00000S-PAG','1'),('00000C-POS','00000T-PAG','1'),('00000C-POS','00000U-PAG','1'),('00000C-POS','00000V-PAG','1'),('00000D-POS','000004-PAG','1'),('00000D-POS','000005-PAG','1'),('00000D-POS','000006-PAG','1'),('00000D-POS','00000J-PAG','1'),('00000D-POS','00000K-PAG','1'),('00000D-POS','00000L-PAG','1'),('00000D-POS','00000M-PAG','1'),('00000D-POS','BTS001-PAG','1'),('00000D-POS','BTS002-PAG','1'),('00000D-POS','BTS003-PAG','1'),('00000D-POS','BTS004-PAG','1'),('00000D-POS','BTS006-PAG','1'),('00000D-POS','BTS007-PAG','1'),('00000D-POS','BTS008-PAG','1'),('00000D-POS','BTS009-PAG','1'),('00000D-POS','BTS010-PAG','1'),('00000D-POS','BTS011-PAG','1'),('00000E-POS','000007-PAG','1'),('00000E-POS','BTS001-PAG','1'),('00000E-POS','BTS002-PAG','1'),('00000E-POS','BTS003-PAG','1'),('00000E-POS','BTS004-PAG','1'),('00000E-POS','BTS006-PAG','1'),('00000E-POS','BTS007-PAG','1'),('00000E-POS','BTS008-PAG','1'),('00000E-POS','BTS009-PAG','1'),('00000E-POS','BTS010-PAG','1'),('00000E-POS','BTS011-PAG','1'),('00000F-POS','00000N-PAG','1'),('00000F-POS','00000O-PAG','1'),('00000F-POS','STS002-PAG','1'),('00000F-POS','STS005-PAG','1'),('00000F-POS','STS007-PAG','1'),('00000F-POS','STS010-PAG','1'),('00000F-POS','STS011-PAG','1'),('00000F-POS','STS013-PAG','1'),('00000F-POS','STS014-PAG','1'),('00000G-POS','00000N-PAG','1'),('00000G-POS','00000O-PAG','1'),('00000G-POS','00000Q-PAG','1'),('00000H-POS','00000N-PAG','1'),('00000H-POS','00000O-PAG','1'),('00000I-POS','00000D-PAG','1'),('00000I-POS','00000R-PAG','1'),('00000I-POS','00000X-PAG','1'),('00000I-POS','00000Y-PAG','1'),('00000I-POS','STS001-PAG','1'),('00000I-POS','STS003-PAG','1'),('00000I-POS','STS017-PAG','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `POZISYON_SAYFA_YETKISI_MN` ENABLE KEYS */;

--
-- Table structure for table `SAYFA`
--

DROP TABLE IF EXISTS `SAYFA`;
CREATE TABLE `SAYFA` (
  `SayfaNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaAdi` varchar(40) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaKodu` varchar(50) character set utf8 collate utf8_turkish_ci NOT NULL,
  `SayfaAmaci` int(11) default NULL,
  `Aciklama` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`SayfaNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `SAYFA`
--


/*!40000 ALTER TABLE `SAYFA` DISABLE KEYS */;
LOCK TABLES `SAYFA` WRITE;
INSERT INTO `SAYFA` VALUES ('000001-PAG','Dekanın Sayfası','../dek/dek1.jsp',0,'Bölümlerin başkanlarından gelen istekler gelir.','1'),('000002-PAG','Bölüm Başkanı','../bol/bol1.jsp',0,'İstek için bölüm satın alma sorumlusu bütçe seçer.Burada bütçe onaylayip Dekanlığa gönderilir.','1'),('000003-PAG','Bölüm Satınalma Sorumlusu','../bol/sekreter.jsp',0,'Satınalma sorumlusu bölüm için bütçe seçer.','1'),('000004-PAG','Bütçe Kod Yönetim','../but/butukfs.jsp',1,'Üst Birimlerin kullanabilecekleri bütçe tiplerinin atanması','1'),('000005-PAG','Bütçe Dağılımı Yönetimi','../but/butbds.jsp',1,'Fakltelere Bütçe dağılımı yapılması','1'),('000006-PAG','Bütçe Başkanı Onayı','../but/but3.jsp',0,'Bütçe Başkanının onay sayfası','1'),('000007-PAG','Bütçe Sekreteri Onayı','../but/but2.jsp',0,'Bütçe sekreterinin onay sayfası','1'),('000008-PAG','Satın Alma','../sat/sat1.jsp',0,'İstek fişi görüntülenir, kendi yorumunu girebilir, ve isteği onaylayacaksa ihale veya doğrudan','1'),('000009-PAG','İhale Yönetimi','../sat/sat2.jsp',1,'Yeni açılmış ihaleler, teklif alınacak ihalaler veya sonuçlanmış ihaleler ayrıntılarının görüntülene','1'),('00000A-PAG','Yeni İhale Oluştur','../sat/sat3.jsp',0,'Yeni ihale gerekli fieldler doldurularak oluşturulur.','1'),('00000B-PAG','Bölüm İşlemleri','bolIs1',0,NULL,'1'),('00000C-PAG','Dekanlık İşlemleri','.../dek/dek1.jsp',0,NULL,'1'),('00000D-PAG','Rektörlük İşlemleri','../rek/rek1.jsp',0,NULL,'1'),('00000E-PAG','Silindi Sayfası','silindi.jsp',0,NULL,'1'),('00000F-PAG','İstek Takip','../istekTakip/istekTakip.jsp',1,'Her kullanıcı kendi yaptığı istek gecmişine ve şu anki durumuna buradan ulaşabilir.','1'),('00000G-PAG','Dekanlık Satın Alma Sorumlusu','../dek/sekreter.jsp',0,'Dekanlık satın alma sorumlusunda bekleyen isteklerin sıralandığı sayfa.','1'),('00000H-PAG','İdari Birim','../support/sup1.jsp',0,'İdari birimlerde isteğin ilk onaylandığı sayfa. Bir birimin müdür yardımcısı için.','1'),('00000I-PAG','İdari Birim Daire Başkanı','../support/supmud1.jsp',0,NULL,'1'),('00000J-PAG','Birimlere Bütçe Atanması','../but/butust.jsp',1,'Üst Birimlerin Birimlere bütçe dağılımı yapması için','1'),('00000K-PAG','Kurumsal Kod Yönetimi','../but/butuks.jsp',1,'Üst Birimlere Kurumsal Kod atanması','1'),('00000L-PAG','Bütçe Başkanı Onayı','../but/but4.jsp',0,'Bütçe Başkanının Onay Sayfası','1'),('00000M-PAG','Harcama Onay Sayfası','../but/but1.jsp',0,'Alımı yapılan bir isteğin harcamasının onaylanması','1'),('00000N-PAG','Fatura Bilgileri','../ayn/ayn1.jsp',0,NULL,'1'),('00000O-PAG','Bekleyen Muayene Raporları','../ayn/ayn2giris.jsp',1,NULL,'1'),('00000P-PAG','Muayene Raporu ve İhracat Pusulası Onayı','../ayn/ayn2.jsp ',0,NULL,'1'),('00000Q-PAG','Ayniyat Tesellüm Makbuzu','../ayn/ayn3.jsp',0,NULL,'1'),('00000R-PAG','Doğrudan Alımlar','../rek/rek3.jsp',0,'Rektör','1'),('00000S-PAG','Tesellüm Sayfası Onay Sayfası','../sat/sat15.jsp',0,'Aynıyattan gelen Tesellüm makbuzu onaylanır.','1'),('00000T-PAG','İhale Rapor Ekranı','../sat/sat14.jsp',1,'Bu sayfaya 3,6,12 aylık sürelerde firmaların aldıkları ihaleler görüntülenebilir.','1'),('00000U-PAG','Doğrudan Alım 2','../sat/sat11.jsp',0,'Rektörlükten gelen istek fişi görüntülenir, kullanıcı kendi yorumunu girebilir, ve isteği onaylar ay','1'),('00000V-PAG','Doğrudan Alım 1','../sat/sat10.jsp',0,'Satışın doğrudan alım seçeneğinden gelen istek fişi görüntülenir, kullanıcı tahmini fiyatı ve kendi ','1'),('00000W-PAG','Teklif Yönetimi','../sat/sat6.jsp',0,'Silinecek','1'),('00000X-PAG','Teklif Almış İhaleler ','../onayBekleyenler/rek5.jsp',1,NULL,'1'),('00000Y-PAG','Onay Bekleyen İhaleler ','../onayBekleyenler/rek4.jsp',1,NULL,'1'),('00000Z-PAG','Yeni İstek Fişi','../yeniIstek/istekfisia.jsp',1,'İstek oluşturması gereken kişiiler için. Üst düzey kullanıcılar giremesin.','1'),('000010-PAG','Satın Alma İçin Dummy Sayfa','../sat/satx',0,'Satın almanın dummy sayfası, gereksiz bişi.','1'),('BTS001-PAG','Bütçe Ekle','../BTS/addBudget.jsp',1,'addBudget.jsp','1'),('BTS002-PAG','AppropDetails.jsp','../BTS/AppropDetails.jsp',0,'AppropDetails.jsp','1'),('BTS003-PAG','Ödenek Ekle','../BTS/approprationOperations.jsp',1,'approprationOperations.jsp','1'),('BTS004-PAG','Hata','../BTS/error.jsp',0,'error.jsp','1'),('BTS006-PAG','Defter Ayrıntı','../BTS/nonAcedemicNormalBudget.jsp',1,'nonAcedemicNormalBudget.jsp','1'),('BTS007-PAG','nonAcedemicWagerBudget.jsp','../BTS/nonAcedemicWagerBudget.jsp',0,'nonAcedemicWagerBudget.jsp','1'),('BTS008-PAG','Ödenek Detayı','../BTS/OdenekDetay.jsp',0,'OdenekDetay.jsp','1'),('BTS009-PAG','Arayüz Şablonu','../BTS/template gui.jsp',0,'template gui.jsp','1'),('BTS010-PAG','Transfer','../BTS/transfer.jsp',1,'transfer.jsp','1'),('BTS011-PAG','Bütçe Güncelleme','../BTS/updateBudget.jsp',1,'updateBudget.jsp','1'),('STS001-PAG','Depo Sorgulama','../STS/rektorSorguGiris.jsp',1,'Rektör Depolardaki mallari sorgularken genel depo mu bolüm deposu mu buradan seçecek.','1'),('STS002-PAG','Depo Sorgulama','../STS/depoSorgu.jsp',1,'Depo sorumluları buradan depolar hakkında sorgulama yapabilecek.','1'),('STS003-PAG','Depo Sorgulama','../STS/depoSorgu.jsp',0,'Rektöre yaptığı seçime göre bölüm ya da genel depoları hakkında sorgulama yapması buradan sağlanacak','1'),('STS004-PAG','Depo Sorgulama Sonuç','../STS/depoSorguAction.jsp',0,'Depo Sorgu Sayfasının sonucu','1'),('STS005-PAG','Depo Çıkış','../STS/DepoCikis.jsp',1,'Depo sorumluları depodan çıkışı bu sayfadan yapıyor.','1'),('STS006-PAG','Depo Çıkış Sonuç Sayfası','../STS/DepoCikisAction.jsp',0,'Depo çıkış sayfası burada işleme konuluyor.','1'),('STS007-PAG','Alt Limit Belirleme','../STS/AltLimit.jsp',1,'Ürunlere ait alt limit burada belirleniyor. Ürun bu limitin altına indiğinde uyarı veriliyor.','1'),('STS008-PAG','Alt Limit Belirleme Sonuç','../STS/AltLimitAction.jsp',0,'Alt limit belirleme sayfasının sonucu burada işleniyor.','1'),('STS009-PAG','Alt Limit Hata','../STS/AltLimitHata.jsp',0,'Alt limit belirlemeyle ilgili hatalar burada görünüyor','1'),('STS010-PAG','Alt Limit Uyarı','../STS/AltLimitUyari.jsp',1,'Alt limitlerle ilgili butun uyarılar bu sayfada görülebilir','1'),('STS011-PAG','Ürün Gönderim','../STS/UrunGonderim.jsp',1,'Depolar Arası Ürün Gönderimi bu sayfada yapılır','1'),('STS012-PAG','Ürün Gönderim Sonuç','../STS/UrunGonderimAction.jsp',0,'Depolar Arası Ürün Gönderimi sonuç sayfası','1'),('STS013-PAG','Depo Ürün Giriş','../STS/StokGiris.jsp',1,'Depoya Onaylanan İstek Fişlerinden gelen ürünleri atar','1'),('STS014-PAG','Depo Ürün Listesi','../STS/DepoGoster.jsp',1,'Depodaki Urunleri Gormek Icin','1'),('STS015-PAG','Depo Ürün Listesi','../STS/dekanListelemeGiris.jsp',1,'Dekan depolardaki kalan ürünleri görmek istediğinde hangi bölüm deposu olduğunu buradan seçecek.','1'),('STS016-PAG','Depo Sorgulama','../STS/dekanSorguGiris.jsp',1,'Dekan depolarda sorgulama yapmak istediğinde ilgili bölüm deposunu bu sayfadan seçecek','1'),('STS017-PAG','Depo Ürün Listesi','../STS/rektorListelemeGiris.jsp',1,'Dekan depolardaki kalan ürünleri görmek istediğinde genel depo mu bölüm deposu mu buradan seçecek.','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `SAYFA` ENABLE KEYS */;

--
-- Table structure for table `SISTEM_BILGILERI`
--

DROP TABLE IF EXISTS `SISTEM_BILGILERI`;
CREATE TABLE `SISTEM_BILGILERI` (
  `ParametreAdi` varchar(100) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Degeri` varchar(100) character set utf8 collate utf8_turkish_ci default NULL,
  UNIQUE KEY `ParametreAdi` (`ParametreAdi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `SISTEM_BILGILERI`
--


/*!40000 ALTER TABLE `SISTEM_BILGILERI` DISABLE KEYS */;
LOCK TABLES `SISTEM_BILGILERI` WRITE;
INSERT INTO `SISTEM_BILGILERI` VALUES ('akademik','1'),('anaKalem','1'),('baslat','1'),('fonksiyonel','1'),('giris','satinalma.boun.edu.tr'),('idari','1'),('kurumsal','1'),('smtp','localhost'),('webmaster','saswebmaster@boun.edu.tr');
UNLOCK TABLES;
/*!40000 ALTER TABLE `SISTEM_BILGILERI` ENABLE KEYS */;

--
-- Table structure for table `SYS_ROW_ID`
--

DROP TABLE IF EXISTS `SYS_ROW_ID`;
CREATE TABLE `SYS_ROW_ID` (
  `Suffix` char(3) character set utf8 collate utf8_turkish_ci default NULL,
  `NextSeed` char(6) character set utf8 collate utf8_turkish_ci default NULL,
  `TimeStamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Description` tinytext character set utf8 collate utf8_turkish_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `SYS_ROW_ID`
--


/*!40000 ALTER TABLE `SYS_ROW_ID` DISABLE KEYS */;
LOCK TABLES `SYS_ROW_ID` WRITE;
INSERT INTO `SYS_ROW_ID` VALUES ('GRP','00006B','2005-12-30 03:32:00','GRUP'),('USR','00000J','2005-12-30 04:17:03','KULLANICI'),('ITC','000051','2005-12-30 03:26:44','KALEM'),('HTR','0000FB','2007-01-12 08:05:00','GECMIS'),('ITM','00005J','2005-12-30 03:26:42','URUN'),('PAG','000010','2005-12-30 03:06:58','SAYFA'),('POS','00000J','2005-12-30 03:06:58','POZISYON'),('REQ','00001P','2007-01-12 08:03:54','ISTEK'),('RFM','00001P','2007-01-12 08:03:54','ISTEK_FISI'),('IHT','000001','2005-12-30 03:06:58','IHALE_TEKLIF'),('IHL','000001','2005-12-30 03:06:58','IHALE'),('UBD','000006','2007-01-08 10:42:08','UST_BIRIM_BUTCE_DAGILIM'),('UBR','00000F','2005-12-30 03:29:49','UST_BIRIM'),('UBB','000004','2006-12-21 17:18:16','UST_BIRIM_BUTCE'),('BRM','00002V','2005-12-30 03:31:56','BIRIM'),('BBL','00002C','2007-01-12 08:04:24','BUTCE_BLOKE'),('BDG','00001A','2007-01-08 10:42:08','BUTCE_DAGILIM'),('FNK','00003L','2005-12-30 03:28:00','FONKSIYONEL'),('AKL','00000P','2005-12-30 03:26:44','ANA_KALEM'),('UBK','000009','2007-01-07 11:01:19','UST_BIRIM_KURUMSAL'),('KRM','00000W','2005-12-30 03:28:38','KURUMSAL'),('FMD','000001','2005-12-30 03:06:58','FATURA_MADDESI'),('IPN','000001','2005-12-30 03:06:58','IHRACAT_PUSULASI'),('TMN','000001','2005-12-30 03:06:58','TESELLUM_MAKBUZU'),('AYN','00000P','2007-01-09 00:43:51','AYNIYAT_BILGILERI'),('FAK','00000N','2007-01-09 00:43:51','FATURA_KALEMLERI'),('IFI','000001','2005-12-30 03:06:58','ISTEK_FISI_IMZA'),('ITK','00000Z','2007-01-09 00:41:46','ISTEK_TEKLIF');
UNLOCK TABLES;
/*!40000 ALTER TABLE `SYS_ROW_ID` ENABLE KEYS */;

--
-- Table structure for table `URUN`
--

DROP TABLE IF EXISTS `URUN`;
CREATE TABLE `URUN` (
  `UrunNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UrunAdi` varchar(100) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KalemNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Aciklama` text character set utf8 collate utf8_turkish_ci,
  `UrunKodu` char(20) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`UrunNo`),
  KEY `KalemNo` (`KalemNo`),
  CONSTRAINT `URUN_fk` FOREIGN KEY (`KalemNo`) REFERENCES `KALEM` (`KalemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `URUN`
--


/*!40000 ALTER TABLE `URUN` DISABLE KEYS */;
LOCK TABLES `URUN` WRITE;
INSERT INTO `URUN` VALUES ('000001-ITM','Kalem','00001C-ITC','Açıklama','03.2.1.01.01','1'),('000002-ITM','Silgi','00001C-ITC','Açıklama','03.2.1.01.02','1'),('000003-ITM','Zımba Teli','00001C-ITC','Açıklama','03.2.1.01.03','1'),('000004-ITM','Toplu İğne','00001C-ITC','Açıklama','03.2.1.01.04','1'),('000005-ITM','Ataç','00001C-ITC','Açıklama','03.2.1.01.05','1'),('000006-ITM','Disket','00001C-ITC','Açıklama','03.2.1.01.06','1'),('000007-ITM','CD','00001C-ITC','Açıklama','03.2.1.01.07','1'),('000008-ITM','Toner','00001C-ITC','Açıklama','03.2.1.01.08','1'),('000009-ITM','Mürekkep','00001C-ITC','Açıklama','03.2.1.01.09','1'),('00000A-ITM','Klasör','00001C-ITC','Açıklama','03.2.1.01.10','1'),('00000B-ITM','Dosya','00001C-ITC','Açıklama','03.2.1.01.11','1'),('00000C-ITM','Basılı Kağıt','00001C-ITC','Açıklama','03.2.1.01.12','1'),('00000D-ITM','Defter','00001C-ITC','Açıklama','03.2.1.01.13','1'),('00000E-ITM','Cetvel','00001D-ITC','Açıklama','03.2.1.02.01','1'),('00000F-ITM','Makas','00001D-ITC','Açıklama','03.2.1.02.02','1'),('00000G-ITM','Kalem Açacağı','00001D-ITC','Açıklama','03.2.1.02.03','1'),('00000H-ITM','Delgeç','00001D-ITC','Açıklama','03.2.1.02.04','1'),('00000I-ITM','Zımba','00001D-ITC','Açıklama','03.2.1.02.05','1'),('00000J-ITM','Gazete','00001E-ITC','Açıklama','03.2.1.03.01','1'),('00000K-ITM','Resmi Gazete','00001E-ITC','Açıklama','03.2.1.03.02','1'),('00000L-ITM','Dergi','00001E-ITC','Açıklama','03.2.1.03.03','1'),('00000M-ITM','Bülten','00001E-ITC','Açıklama','03.2.1.03.04','1'),('00000N-ITM','Kitap','00001F-ITC','Açıklama','03.2.1.04.01','1'),('00000O-ITM','Ansiklopedi','00001F-ITC','Açıklama','03.2.1.04.02','1'),('00000P-ITM','Broşür','00001F-ITC','Açıklama','03.2.1.04.03','1'),('00000Q-ITM','Gazete','00001G-ITC','Açıklama','03.2.1.05.01','1'),('00000R-ITM','Dergi','00001G-ITC','Açıklama','03.2.1.05.02','1'),('00000S-ITM','Bülten','00001G-ITC','Açıklama','03.2.1.05.03','1'),('00000T-ITM','Kitap','00001G-ITC','Açıklama','03.2.1.05.04','1'),('00000U-ITM','Broşür','00001G-ITC','Açıklama','03.2.1.05.05','1'),('00000V-ITM','Afiş','00001G-ITC','Açıklama','03.2.1.05.06','1'),('00000W-ITM','Diş Macunu','00001J-ITC','Açıklama','03.2.2.02.01','1'),('00000X-ITM','Diş Fırçası','00001J-ITC','Açıklama','03.2.2.02.02','1'),('00000Y-ITM','Kova','00001J-ITC','Açıklama','03.2.2.02.03','1'),('00000Z-ITM','Fır','00001J-ITC','Açıklama','03.2.2.02.04','1'),('000010-ITM','Paspas','00001J-ITC','Açıklama','03.2.2.02.05','1'),('000011-ITM','Odun','00001K-ITC','Açıklama','03.2.3.01.01','1'),('000012-ITM','ra','00001K-ITC','Açıklama','03.2.3.01.02','1'),('000013-ITM','Kir','00001K-ITC','Açıklama','03.2.3.01.03','1'),('000014-ITM','Kalorifer Yakıtı','00001K-ITC','Açıklama','03.2.3.01.04','1'),('000015-ITM','Doğalgaz','00001K-ITC','Açıklama','03.2.3.01.05','1'),('000016-ITM','Tüp Gaz','00001K-ITC','Açıklama','03.2.3.01.06','1'),('000017-ITM','Akaryakıtlar','00001L-ITC','Açıklama','03.2.3.02.01','1'),('000018-ITM','Madeni Yağlar','00001L-ITC','Açıklama','03.2.3.02.02','1'),('000019-ITM','Antifriz','00001L-ITC','Açıklama','03.2.3.02.03','1'),('00001A-ITM','Aydınlatma','00001M-ITC','Açıklama','03.2.3.03.01','1'),('00001B-ITM','Isıtma','00001M-ITC','Açıklama','03.2.3.02.02','1'),('00001C-ITM','Soğutma','00001M-ITC','Açıklama','03.2.3.02.03','1'),('00001D-ITM','Havalandırma','00001M-ITC','Açıklama','03.2.3.02.04','1'),('00001E-ITM','İliştirici Kuvvet','00001M-ITC','Açıklama','03.2.3.02.05','1'),('00001F-ITM','Jeotermal Enerji','00001N-ITC','Açıklama','03.2.3.90.01','1'),('00001G-ITM','Nükleer Enerji','00001N-ITC','Açıklama','03.2.3.90.02','1'),('00001H-ITM','Giyim-Kuşam','00001P-ITC','Açıklama','03.2.5.01.01','1'),('00001I-ITM','Giyim-Kuşam (Mehter,Bando,vb.)','00001P-ITC','Açıklama','03.2.5.01.02','1'),('00001J-ITM','Doktor raporu ile belirlenen gorevlerde kullanılacak giyecek ve koruyucu malzemeler','00001P-ITC','Açıklama','03.2.5.01.03','1'),('00001K-ITM','Giyim Eşyaları','00001Q-ITC','Açıklama','03.2.5.02.01','1'),('00001L-ITM','Mal ve Malzeme','00001Q-ITC','Açıklama','03.2.5.01.02','1'),('00001M-ITM','Sarf Malzemeleri','00001S-ITC','Açıklama','03.2.6.01.01','1'),('00001N-ITM','Deney Tüpleri','00001S-ITC','Açıklama','03.2.6.01.02','1'),('00001O-ITM','Kimyevi ve Temrinlik Malzeme','00001S-ITC','Açıklama','03.2.6.01.03','1'),('00001P-ITM','Bayrak','00001W-ITC','Açıklama','03.2.6.90.01','1'),('00001Q-ITM','Flama','00001W-ITC','Açıklama','03.2.6.90.02','1'),('00001R-ITM','Sancak','00001W-ITC','Açıklama','03.2.6.90.03','1'),('00001S-ITM','dir','00001W-ITC','Açıklama','03.2.6.90.04','1'),('00001T-ITM','Soğuk İklim Malzemeleri','00001W-ITC','Açıklama','03.2.6.90.05','1'),('00001U-ITM','Kürek','00001X-ITC','Açıklama','03.2.9.01.01','1'),('00001V-ITM','Makas','00001X-ITC','Açıklama','03.2.9.01.02','1'),('00001W-ITM','Tırmık','00001X-ITC','Açıklama','03.2.9.01.03','1'),('00001X-ITM','Islama Pompası','00001X-ITC','Açıklama','03.2.9.01.04','1'),('00001Y-ITM','Fide','00001X-ITC','Açıklama','03.2.9.01.05','1'),('00001Z-ITM','Fidan','00001X-ITC','Açıklama','03.2.9.01.06','1'),('000020-ITM','Tohum','00001X-ITC','Açıklama','03.2.9.01.07','1'),('000021-ITM','Gübre','00001X-ITC','Açıklama','03.2.9.01.08','1'),('000022-ITM','Ampul','00001Y-ITC','Açıklama','03.2.9.90.01','1'),('000023-ITM','Kablo','00001Y-ITC','Açıklama','03.2.9.90.02','1'),('000024-ITM','Fiş','00001Y-ITC','Açıklama','03.2.9.90.03','1'),('000025-ITM','Duy','00001Y-ITC','Açıklama','03.2.9.90.04','1'),('000026-ITM','Priz','00001Y-ITC','Açıklama','03.2.9.90.05','1'),('000027-ITM','Kapı Kolu','00001Y-ITC','Açıklama','03.2.9.90.06','1'),('000028-ITM','Teleks Bobini','00001Y-ITC','Açıklama','03.2.9.90.07','1'),('000029-ITM','Teleks Şeridi','00001Y-ITC','Açıklama','03.2.9.90.08','1'),('00002A-ITM','Ambalaj Malzemesi','00001Y-ITC','Açıklama','03.2.9.90.09','1'),('00002B-ITM','Lehim','00001Y-ITC','Açıklama','03.2.9.90.10','1'),('00002C-ITM','Lehim Pastası','00001Y-ITC','Açıklama','03.2.9.90.11','1'),('00002D-ITM','Noter Harcı','000029-ITC','Açıklama','03.4.3.90.01','1'),('00002E-ITM','Belediye İslenen Altyapı Tesislerine Katılma Payı','000029-ITC','Açıklama','03.4.3.90.02','1'),('00002F-ITM','Eğitime Katkı Payı','000029-ITC','Açıklama','03.4.3.90.03','1'),('00002G-ITM','Vergi','000029-ITC','Açıklama','03.4.3.90.04','1'),('00002H-ITM','Resim','000029-ITC','Açıklama','03.4.3.90.05','1'),('00002I-ITM','Harç','000029-ITC','Açıklama','03.4.3.90.06','1'),('00002J-ITM','Ara','00002A-ITC','Açıklama','03.4.4.01.01','1'),('00002K-ITM','Malzeme','00002A-ITC','Açıklama','03.4.4.01.02','1'),('00002L-ITM','Ekipman','00002A-ITC','Açıklama','03.4.4.01.03','1'),('00002M-ITM','Proje','00002A-ITC','Açıklama','03.4.4.01.04','1'),('00002N-ITM','Müşavirlik','00002A-ITC','Açıklama','03.4.4.01.05','1'),('00002O-ITM','Yarışma Sonucunda Ödenen Bedeller','00002F-ITC','Açıklama','03.5.1.01.01','1'),('00002P-ITM','Proje Bedelleri','00002F-ITC','Açıklama','03.5.1.01.02','1'),('00002Q-ITM','Bilirkişi ve Ekspertiz İşaretleri','00002F-ITC','Açıklama','03.5.1.01.03','1'),('00002R-ITM','Diğer Bie Giderleri','00002F-ITC','Açıklama','03.5.1.01.04','1'),('00002S-ITM','Laboratuvar Tahlil Giderleri','00002F-ITC','Açıklama','03.5.1.01.05','1'),('00002T-ITM','Araştırma','00002G-ITC','Açıklama','03.5.1.02.01','1'),('00002U-ITM','İnceleme','00002G-ITC','Açıklama','03.5.1.02.02','1'),('00002V-ITM','Ett-Proje Hizmetlerinin Gerektirdiği Giderler','00002G-ITC','Açıklama','03.5.1.02.03','1'),('00002W-ITM','Yazılım','00002H-ITC','Açıklama','03.5.1.03.01','1'),('00002X-ITM','Donanım','00002H-ITC','Açıklama','03.5.1.03.02','1'),('00002Y-ITM','İşletme','00002H-ITC','Açıklama','03.5.1.03.03','1'),('00002Z-ITM','Temizleme','00002I-ITC','Açıklama','03.5.1.04.01','1'),('000030-ITM','Asansör','00002I-ITC','Açıklama','03.5.1.04.02','1'),('000031-ITM','Kalorifer','00002I-ITC','Açıklama','03.5.1.04.03','1'),('000032-ITM','Dayanıklı Mal Kirası','000030-ITC','Açıklama','03.5.5.01.01','1'),('000033-ITM','Malzeme Kirası','000030-ITC','Açıklama','03.5.5.01.02','1'),('000034-ITM','Alet-edavat Kirası','000030-ITC','Açıklama','03.5.5.01.03','1'),('000035-ITM','Makina Kirası','000030-ITC','Açıklama','03.5.5.01.04','1'),('000036-ITM','Teçhizat Kirası','000030-ITC','Açıklama','03.5.5.01.05','1'),('000037-ITM','Dozer Kirası','000032-ITC','Açıklama','03.5.5.03.01','1'),('000038-ITM','Kepçe Kirası','000032-ITC','Açıklama','03.5.5.03.02','1'),('000039-ITM','Ekskavator Kirası','000032-ITC','Açıklama','03.5.5.03.03','1'),('00003A-ITM','Traktör Kirası','000032-ITC','Açıklama','03.5.5.03.04','1'),('00003B-ITM','Büro Masası','00003E-ITC','Açıklama','03.7.1.01.01','1'),('00003C-ITM','Diğer Koltuk','00003E-ITC','Açıklama','03.7.1.01.02','1'),('00003D-ITM','Sandalye','00003E-ITC','Açıklama','03.7.1.01.03','1'),('00003E-ITM','Sehpa','00003E-ITC','Açıklama','03.7.1.01.04','1'),('00003F-ITM','Etajer','00003E-ITC','Açıklama','03.7.1.01.05','1'),('00003G-ITM','Ktüphane','00003E-ITC','Açıklama','03.7.1.01.06','1'),('00003H-ITM','Dosya Dolabı','00003E-ITC','Açıklama','03.7.1.01.07','1'),('00003I-ITM','Karteks Dolabı','00003E-ITC','Açıklama','03.7.1.01.08','1'),('00003J-ITM','Misafir Koltuğu','00003E-ITC','Açıklama','03.7.1.01.09','1'),('00003K-ITM','Bilgisayar Masası','00003E-ITC','Açıklama','03.7.1.01.10','1'),('00003L-ITM','Okul Sırası','00003E-ITC','Açıklama','03.7.1.01.11','1'),('00003M-ITM','Ilık Kasa','00003E-ITC','Açıklama','03.7.1.01.12','1'),('00003N-ITM','Perde','00003E-ITC','Açıklama','03.7.1.01.13','1'),('00003O-ITM','Masa Kalemi','00003E-ITC','Açıklama','03.7.1.01.14','1'),('00003P-ITM','İp Kutusu','00003E-ITC','Açıklama','03.7.1.01.15','1'),('00003Q-ITM','Mühür','00003E-ITC','Açıklama','03.7.1.01.16','1'),('00003R-ITM','Daktilo','00003F-ITC','Açıklama','03.7.1.02.01','1'),('00003S-ITM','Hesap Makinası','00003F-ITC','Açıklama','03.7.1.02.02','1'),('00003T-ITM','Bilgisayar','00003F-ITC','Açıklama','03.7.1.02.03','1'),('00003U-ITM','Telefon','00003F-ITC','Açıklama','03.7.1.02.04','1'),('00003V-ITM','Yazı Makinası','00003F-ITC','Açıklama','03.7.1.02.05','1'),('00003W-ITM','Fotokopi Makinası','00003F-ITC','Açıklama','03.7.1.02.06','1'),('00003X-ITM','Klima','00003F-ITC','Açıklama','03.7.1.02.07','1'),('00003Y-ITM','Baski Makinası','00003F-ITC','Açıklama','03.7.1.02.08','1'),('00003Z-ITM','Evrak Imha Makinası','00003F-ITC','Açıklama','03.7.1.02.09','1'),('000040-ITM','Laminat Cihazi ve Aparatları','00003F-ITC','Açıklama','03.7.1.02.10','1'),('000041-ITM','Kriko','00003G-ITC','Açıklama','03.7.1.03.01','1'),('000042-ITM','Çekme Halatı','00003G-ITC','Açıklama','03.7.1.03.02','1'),('000043-ITM','Pense','00003G-ITC','Açıklama','03.7.1.03.03','1'),('000044-ITM','Tornavida','00003G-ITC','Açıklama','03.7.1.03.04','1'),('000045-ITM','Matkap','00003G-ITC','Açıklama','03.7.1.03.05','1'),('000046-ITM','Yangın Sondürme Tüpü','00003H-ITC','Açıklama','03.7.1.04.01','1'),('000047-ITM','Yangın Sondürme Cihazı','00003H-ITC','Açıklama','03.7.1.04.02','1'),('000048-ITM','Yangın İkaz Sistemi Kurulması','00003H-ITC','Açıklama','03.7.1.04.03','1'),('000049-ITM','İtfaiye Eri Elbisesi','00003H-ITC','Açıklama','03.7.1.04.04','1'),('00004A-ITM','Müstemilatı','00003H-ITC','Açıklama','03.7.1.04.05','1'),('00004B-ITM','Yangınla Mücadele Sistemi','00003H-ITC','Açıklama','03.7.1.04.06','1'),('00004C-ITM','Alarm Sistemi','00003I-ITC','Açıklama','03.7.1.90.01','1'),('00004D-ITM','Elektrik Sayacı','00003I-ITC','Açıklama','03.7.1.90.02','1'),('00004E-ITM','Kompanzasyon Sistemi','00003I-ITC','Açıklama','03.7.1.90.03','1'),('00004F-ITM','Su Sayacı','00003I-ITC','Açıklama','03.7.1.90.04','1'),('00004G-ITM','Bekçi Kontrol Saati','00003I-ITC','Açıklama','03.7.1.90.05','1'),('00004H-ITM','Dikiş Makinası','00003I-ITC','Açıklama','03.7.1.90.06','1'),('00004I-ITM','Elektrik Süpürgesi','00003I-ITC','Açıklama','03.7.1.90.07','1'),('00004J-ITM','Bulaşık Yıkama Makinası','00003I-ITC','Açıklama','03.7.1.90.08','1'),('00004K-ITM','Camaşır Makinası','00003I-ITC','Açıklama','03.7.1.90.09','1'),('00004L-ITM','Buzdolabı','00003I-ITC','Açıklama','03.7.1.90.10','1'),('00004M-ITM','Soba','00003I-ITC','Açıklama','03.7.1.90.11','1'),('00004N-ITM','Sebze Doğrama Makinası','00003I-ITC','Açıklama','03.7.1.90.12','1'),('00004O-ITM','Kıyma Makinası','00003I-ITC','Açıklama','03.7.1.90.13','1'),('00004P-ITM','Hamur Yoğurma Makinası','00003I-ITC','Açıklama','03.7.1.90.14','1'),('00004Q-ITM','Buharlı Yemek Kazanı','00003I-ITC','Açıklama','03.7.1.90.15','1'),('00004R-ITM','Ilık Yemek Kazanı','00003I-ITC','Açıklama','03.7.1.90.16','1'),('00004S-ITM','Satır','00003I-ITC','Açıklama','03.7.1.90.17','1'),('00004T-ITM','Kepçe','00003I-ITC','Açıklama','03.7.1.90.18','1'),('00004U-ITM','Kevgir','00003I-ITC','Açıklama','03.7.1.90.19','1'),('00004V-ITM','Su Bardağı','00003I-ITC','Açıklama','03.7.1.90.20','1'),('00004W-ITM','Yemek Çatalı','00003I-ITC','Açıklama','03.7.1.90.21','1'),('00004X-ITM','Yemek Sepeti','00003I-ITC','Açıklama','03.7.1.90.22','1'),('00004Y-ITM','Self Servis Tabağı','00003I-ITC','Açıklama','03.7.1.90.23','1'),('00004Z-ITM','Yemek Masası','00003I-ITC','Açıklama','03.7.1.90.24','1'),('000050-ITM','Yemek Sandalyesi','00003I-ITC','Açıklama','03.7.1.90.25','1'),('000051-ITM','Sürahi','00003I-ITC','Açıklama','03.7.1.90.26','1'),('000052-ITM','Bakraç','00003I-ITC','Açıklama','03.7.1.90.27','1'),('000053-ITM','Su Soğutucusu','00003I-ITC','Açıklama','03.7.1.90.28','1'),('000054-ITM','Tuzluk','00003I-ITC','Açıklama','03.7.1.90.29','1'),('000055-ITM','Biberlik','00003I-ITC','Açıklama','03.7.1.90.30','1'),('000056-ITM','Battaniye','00003I-ITC','Açıklama','03.7.1.90.31','1'),('000057-ITM','Nevresim','00003I-ITC','Açıklama','03.7.1.90.32','1'),('000058-ITM','Karyola','00003I-ITC','Açıklama','03.7.1.90.33','1'),('000059-ITM','Yorgan','00003I-ITC','Açıklama','03.7.1.90.34','1'),('00005A-ITM','Yastık','00003I-ITC','Açıklama','03.7.1.90.35','1'),('00005B-ITM','Yatak','00003I-ITC','Açıklama','03.7.1.90.36','1'),('00005C-ITM','Calışma Masası Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.01','1'),('00005D-ITM','Calışma Koltuğu Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.02','1'),('00005E-ITM','Sandalye Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.03','1'),('00005F-ITM','Etejer Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.04','1'),('00005G-ITM','Sehpa Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.05','1'),('00005H-ITM','Kütüphane Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.06','1'),('00005I-ITM','Dolap Bakım ve Onarımı','00003M-ITC','Açıklama','03.7.3.01.07','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `URUN` ENABLE KEYS */;

--
-- Table structure for table `UST_BIRIM`
--

DROP TABLE IF EXISTS `UST_BIRIM`;
CREATE TABLE `UST_BIRIM` (
  `UstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimAdi` varchar(150) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`UstBirimNo`),
  UNIQUE KEY `UstBirimNo` (`UstBirimNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UST_BIRIM`
--


/*!40000 ALTER TABLE `UST_BIRIM` DISABLE KEYS */;
LOCK TABLES `UST_BIRIM` WRITE;
INSERT INTO `UST_BIRIM` VALUES ('000000-UBR','Bütçe Daire Başkanlığı','1'),('000001-UBR','Eğitim Fakültesi ','1'),('000002-UBR','Fen-Edebiyat Fakültesi','1'),('000003-UBR','İktisadi ve İdari Bilimler Fakültesi ','1'),('000004-UBR','Mühendislik Fakültesi ','1'),('000005-UBR','Uygulamalı Bilimler Yüksekokulu','1'),('000006-UBR','Yabancı Diller Yüksekokulu ','1'),('000007-UBR','Atatürk İlkeleri ve İnkîlap Tarihi Enstitüsü','1'),('000008-UBR','Biyo-Medikal Mühendisligi Enstitüsü ','1'),('000009-UBR','Çevre Bilimleri Enstitüsü','1'),('00000A-UBR','Fen Bilimleri Enstitüsü ','1'),('00000B-UBR','Kandilli Rasathanesi ve Deprem Araştırma Enstitüsü ','1'),('00000C-UBR','Sosyal Bilimler Enstitüsü ','1'),('00000D-UBR','Otelcilik Meslek Yüksekokulu','1'),('00000E-UBR','Diğer Birimler','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `UST_BIRIM` ENABLE KEYS */;

--
-- Table structure for table `UST_BIRIM_BUTCE`
--

DROP TABLE IF EXISTS `UST_BIRIM_BUTCE`;
CREATE TABLE `UST_BIRIM_BUTCE` (
  `UstBirimButceNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimKurumsalNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `FonksiyonelNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `Tanimlama` char(30) character set utf8 collate utf8_turkish_ci default NULL,
  `Statu` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`UstBirimButceNo`),
  KEY `FonksiyonelNo` (`FonksiyonelNo`),
  KEY `UstBirimKurumsalNo` (`UstBirimKurumsalNo`),
  CONSTRAINT `UST_BIRIM_BUTCE_fk` FOREIGN KEY (`FonksiyonelNo`) REFERENCES `FONKSIYONEL` (`FonksiyonelNo`),
  CONSTRAINT `UST_BIRIM_BUTCE_fk1` FOREIGN KEY (`UstBirimKurumsalNo`) REFERENCES `UST_BIRIM_KURUMSAL` (`UstBirimKurumsalNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UST_BIRIM_BUTCE`
--


/*!40000 ALTER TABLE `UST_BIRIM_BUTCE` DISABLE KEYS */;
LOCK TABLES `UST_BIRIM_BUTCE` WRITE;
INSERT INTO `UST_BIRIM_BUTCE` VALUES ('000001-UBB','000001-UBK','00000P-FNK','yeni','1'),('000002-UBB','000002-UBK','00000P-FNK','deneme1','1'),('000003-UBB','000002-UBK','00000T-FNK','tanım','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `UST_BIRIM_BUTCE` ENABLE KEYS */;

--
-- Table structure for table `UST_BIRIM_BUTCE_DAGILIM`
--

DROP TABLE IF EXISTS `UST_BIRIM_BUTCE_DAGILIM`;
CREATE TABLE `UST_BIRIM_BUTCE_DAGILIM` (
  `UstBirimButceDagilimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimButceNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `AnaKalemNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `ToplamButce` decimal(11,2) NOT NULL,
  `AtanmamisMiktar` decimal(11,2) default NULL,
  `Statu` enum('0','1','2') NOT NULL default '1',
  PRIMARY KEY  (`UstBirimButceDagilimNo`),
  KEY `BirimButceNo` (`UstBirimButceNo`),
  KEY `AnaKalemNo` (`AnaKalemNo`),
  CONSTRAINT `UST_BIRIM_BUTCE_DAGILIM_fk` FOREIGN KEY (`UstBirimButceNo`) REFERENCES `UST_BIRIM_BUTCE` (`UstBirimButceNo`),
  CONSTRAINT `UST_BIRIM_BUTCE_DAGILIM_fk1` FOREIGN KEY (`AnaKalemNo`) REFERENCES `ANA_KALEM` (`AnaKalemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UST_BIRIM_BUTCE_DAGILIM`
--


/*!40000 ALTER TABLE `UST_BIRIM_BUTCE_DAGILIM` DISABLE KEYS */;
LOCK TABLES `UST_BIRIM_BUTCE_DAGILIM` WRITE;
INSERT INTO `UST_BIRIM_BUTCE_DAGILIM` VALUES ('000001-UBD','000001-UBB','00000J-AKL','5000.00','5000.00','1'),('000002-UBD','000002-UBB','000006-AKL','5000.00','5000.00','1'),('000003-UBD','000003-UBB','00000D-AKL','0.00','0.00','0'),('000004-UBD','000003-UBB','00000C-AKL','280.00','280.00','1'),('000005-UBD','000003-UBB','00000O-AKL','300.00','300.00','1');
UNLOCK TABLES;
/*!40000 ALTER TABLE `UST_BIRIM_BUTCE_DAGILIM` ENABLE KEYS */;

--
-- Table structure for table `UST_BIRIM_KURUMSAL`
--

DROP TABLE IF EXISTS `UST_BIRIM_KURUMSAL`;
CREATE TABLE `UST_BIRIM_KURUMSAL` (
  `UstBirimKurumsalNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `UstBirimNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  `KurumsalNo` char(10) character set utf8 collate utf8_turkish_ci NOT NULL,
  PRIMARY KEY  (`UstBirimKurumsalNo`),
  KEY `UstBirimNo` (`UstBirimNo`),
  KEY `KurumsalNo` (`KurumsalNo`),
  CONSTRAINT `UST_BIRIM_KURUMSAL_fk1` FOREIGN KEY (`UstBirimNo`) REFERENCES `UST_BIRIM` (`UstBirimNo`),
  CONSTRAINT `UST_BIRIM_KURUMSAL_fk2` FOREIGN KEY (`KurumsalNo`) REFERENCES `KURUMSAL` (`KurumsalNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UST_BIRIM_KURUMSAL`
--


/*!40000 ALTER TABLE `UST_BIRIM_KURUMSAL` DISABLE KEYS */;
LOCK TABLES `UST_BIRIM_KURUMSAL` WRITE;
INSERT INTO `UST_BIRIM_KURUMSAL` VALUES ('000001-UBK','000004-UBR','00000N-KRM'),('000002-UBK','000004-UBR','000002-KRM'),('000004-UBK','000009-UBR','00000Q-KRM'),('000008-UBK','000004-UBR','00000B-KRM');
UNLOCK TABLES;
/*!40000 ALTER TABLE `UST_BIRIM_KURUMSAL` ENABLE KEYS */;

--
-- Dumping routines for database 'SAS_DB'
--
DELIMITER ;;
/*!50003 DROP PROCEDURE IF EXISTS `AciklamaGosterGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AciklamaGosterGuncelle_sp`(KullaniciNoIn CHAR(10), DegeriIn CHAR(1))
BEGIN
     UPDATE
           KULLANICI
     SET
        KULLANICI.AciklamaGoster = DegeriIn
     WHERE
          KULLANICI.KullaniciNo = KullaniciNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AddStockBD_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AddStockBD_sp`(IN grup_no CHAR(10), IN urun_no CHAR(10), IN pmiktar INT)
BEGIN
if not exists (
select
  *
from
  `BIRIM_DEPO_URUN_MIKTAR`
where
  `GrupNo` = grup_no and `UrunNo` = urun_no
)
then
INSERT INTO  `BIRIM_DEPO_URUN_MIKTAR` ( `GrupNo`,`BirimNo`, `UstBirimNo`, `UrunNo`, `AltLimit`,`Mevcut`)
VALUES (grup_no,
(SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = grup_no),
(SELECT `BIRIM`.`UstBirimNo` FROM `BIRIM`, `GRUP` WHERE `GRUP`.`GrupNo` = grup_no AND `GRUP`.`BirimNo` = `BIRIM`.`BirimNo`),
urun_no , 0,pmiktar );
elseif(1=1)
then
 update `BIRIM_DEPO_URUN_MIKTAR` 
set `Mevcut` = `Mevcut` + pmiktar
where `GrupNo` = grup_no and `UrunNo` = urun_no;
END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AddStockGD_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AddStockGD_sp`(IN urun_no CHAR(10), IN pmiktar INT)
BEGIN
if not exists (
select
  *
from
  `GENEL_DEPO_URUN_MIKTAR`
where
   `UrunNo` = urun_no
)
then
INSERT INTO  `GENEL_DEPO_URUN_MIKTAR` ( `UrunNo`, `AltLimit`,`Mevcut`)
VALUES (urun_no , 0,pmiktar );
elseif(1=1)
then
 update `GENEL_DEPO_URUN_MIKTAR`
set `Mevcut` = `Mevcut` + pmiktar
where `UrunNo` = urun_no;
END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AkademikDepoSorgusuKontrol_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AkademikDepoSorgusuKontrol_sp`(IN talepedengrupno CHAR(10),IN urun_no CHAR(10),
IN arrivalfromdate DATE, IN arrivaltodate DATE, IN departurefromdate DATE, IN departuretodate DATE)
BEGIN

IF(urun_no != '-111111111' AND departuretodate != '5000-00-00')
THEN

SELECT  DISTINCT U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDH.Miktar AS KullanilanMiktar,
BDG.FaturaTarihi AS FaturaTarihi, BDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U,BIRIM_DEPO_GIRIS BDG,BIRIM_DEPO_HARCAMA BDH, GRUP G, BIRIM_DEPO_URUN_MIKTAR BUM

WHERE  
U.UrunNo = urun_no
AND G.GrupNo =  talepedengrupno
AND BDG.FaturaTarihi <= arrivaltodate 
AND BDG.FaturaTarihi >= arrivalfromdate
AND BDH.HarcamaTarihi >= departurefromdate 
AND BDH.HarcamaTarihi <= departuretodate

AND BDG.UrunNo = BDH.UrunNo
AND BDG.UrunNo = U.UrunNo
AND BDG.GrupNo = BDH.GrupNo
AND BUM.UrunNo = U.UrunNo
AND BUM.GrupNo = G.GrupNo 
AND BUM.Mevcut > 0 ;


ELSEIF(urun_no != '-111111111' AND departuretodate = '5000-00-00')
THEN

SELECT DISTINCT  U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDH.Miktar AS KullanilanMiktar,
BDG.FaturaTarihi AS FaturaTarihi, BDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, BIRIM_DEPO_GIRIS BDG, BIRIM_DEPO_HARCAMA BDH, GRUP G

WHERE 
G.GrupNo = talepedengrupno
AND U.UrunNo = urun_no
AND BDG.FaturaTarihi <= arrivaltodate 
AND BDG.FaturaTarihi >= arrivalfromdate


AND BDG.GrupNo= talepedengrupno
AND BDG.UrunNo = U.UrunNo
AND BDG.UrunNo = BDH.UrunNo
AND BDG.GrupNo = BDH.GrupNo;



ELSEIF(urun_no = '-111111111' AND departuretodate != '5000-00-00')
THEN

SELECT  DISTINCT U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDH.Miktar AS KullanilanMiktar,
BDG.FaturaTarihi AS FaturaTarihi, BDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U,BIRIM_DEPO_GIRIS BDG,BIRIM_DEPO_HARCAMA BDH, GRUP G, BIRIM_DEPO_URUN_MIKTAR BUM

WHERE 
G.GrupNo = talepedengrupno
AND BDG.FaturaTarihi <= arrivaltodate 
AND BDG.FaturaTarihi >= arrivalfromdate
AND BDH.HarcamaTarihi >= departurefromdate 
AND BDH.HarcamaTarihi <= departuretodate
AND BDG.GrupNo= G.GrupNo
AND BDG.UrunNo = U.UrunNo
AND BDG.UrunNo = BDH.UrunNo
AND BDG.GrupNo = BDH.GrupNo
AND BUM.UrunNo = U.UrunNo
AND BUM.GrupNo = G.GrupNo 
AND BUM.Mevcut > 0 ;

ELSEIF(urun_no = '-111111111' AND departuretodate = '5000-00-00')
THEN

SELECT  DISTINCT U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDH.Miktar AS KullanilanMiktar,
BDG.FaturaTarihi AS FaturaTarihi, BDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U,BIRIM_DEPO_GIRIS BDG,BIRIM_DEPO_HARCAMA BDH, GRUP G, BIRIM_DEPO_URUN_MIKTAR BUM

WHERE 
G.GrupNo = talepedengrupno
AND BDG.FaturaTarihi <= arrivaltodate 
AND BDG.FaturaTarihi >= arrivalfromdate

AND BDG.GrupNo= G.GrupNo
AND BDG.UrunNo = U.UrunNo
AND BDG.UrunNo = BDH.UrunNo
AND BDG.GrupNo = BDH.GrupNo
AND BUM.UrunNo = U.UrunNo
AND BUM.GrupNo = G.GrupNo 
AND BUM.Mevcut > 0;



END IF;


END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AkademikDepoSorgusu_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AkademikDepoSorgusu_sp`(IN talepedengrupno CHAR(10),IN urun_no CHAR(10),
IN arrivalfromdate DATE, IN arrivaltodate DATE, IN departurefromdate DATE, IN departuretodate DATE)
BEGIN
SELECT U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDH.Miktar AS KullanilanMiktar,
BDG.FaturaTarihi AS FaturaTarihi, BDH.HarcamaTarihi AS CikisTarihi 
FROM URUN U,BIRIM_DEPO_GIRIS BDG,BIRIM_DEPO_HARCAMA BDH, GRUP G
WHERE EXISTS(SELECT *
FROM BIRIM_DEPO_GIRIS
WHERE FaturaTarihi <= arrivaltodate AND FaturaTarihi >= arrivalfromdate)
AND EXISTS
(SELECT *
FROM BIRIM_DEPO_HARCAMA
WHERE HarcamaTarihi >= departurefromdate AND HarcamaTarihi >= departuretodate)
AND BDG.UrunNo = urun_no
AND BDG.UrunNo = BDH.UrunNo
AND BDG.GrupNo = talepedengrupno
AND BDG.GrupNo = BDH.GrupNo
AND BDG.UrunNo = U.UrunNo
AND BDG.GrupNo= G.GrupNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AktarilmamisUrunleriAl_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AktarilmamisUrunleriAl_sp`()
BEGIN
select
  I.UrunNo
  , I_F.IstekFisiNo
  , U.UrunAdi
  , I_F.isteyenGrupNo as TalepEdenGrupNo
  , G.GrupAdi
  , G.BirimNo as TalepEdenBirimNo
  , U_B.UstBirimNo as TalepEdenUstBirimNo
  , '000000-GDR' as RafNo
  , Miktar
  , FaturaNo
  , FaturaTarihi
from
  ISTEK_FISI I_F,
  ISTEK I,
  AYNIYAT_BILGILERI A_B,
  KULLANICI K,
  GRUP G,
  UST_BIRIM U_B,
  BIRIM B,
  URUN U
where
  I_F.IstekFisiNo = I.IstekFisiNo
  and A_B.IstekFisiNo = I_F.IstekFisiNo
  and I_F.Olusturan = K.KullaniciNo
  and G.GrupNo = K.GrupNo
  and U_B.UStBirimNo = B.UstBirimNo
  and G.BirimNo = B.BirimNo
  and U.UrunNo = I.UrunNo
  and I_F.Statu = '2'
  and I_F.Aktarildi = '0';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AktarilmamisUrunuAktar_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AktarilmamisUrunuAktar_sp`(IN IstekFisiNoIn char(10))
BEGIN

insert into GENEL_DEPO_GIRIS ( `UrunNo` ,  `TalepEdenGrupNo`,  `TalepEdenBirimNo`, `TalepEdenUstBirimNo` , `RafNo` , `Miktar` , `FaturaNo` , `FaturaTarihi`)
select
  I.UrunNo
  , I_F.isteyenGrupNo as TalepEdenGrupNo
  , G.BirimNo as TalepEdenBirimNo
  , U_B.UstBirimNo as TalepEdenUstBirimNo
  , '000000-GDR' as RafNo
  , Miktar
  , FaturaNo
  , FaturaTarihi
from
  ISTEK_FISI I_F,
  ISTEK I,
  AYNIYAT_BILGILERI A_B,
  KULLANICI K,
  GRUP G,
  UST_BIRIM U_B,
  BIRIM B,
  URUN U
where
  I_F.IstekFisiNo = I.IstekFisiNo
  and A_B.IstekFisiNo = I_F.IstekFisiNo
  and I_F.Olusturan = K.KullaniciNo
  and G.GrupNo = K.GrupNo
  and U_B.UStBirimNo = B.UstBirimNo
  and G.BirimNo = B.BirimNo
  and U.UrunNo = I.UrunNo
  and I_F.IstekFisiNo=IstekFisiNoIn;

IF (1=1) THEN
insert into GENEL_DEPO_HARCAMA(`UrunNo` , `TalepEdenGrupNo`, `TalepEdenBirimNo`, `TalepEdenUstBirimNo`, `RafNo`, `Miktar`, `HarcamaTarihi`)
select
  I.UrunNo
  , I_F.isteyenGrupNo as TalepEdenGrupNo
  , G.BirimNo as TalepEdenBirimNo
  , U_B.UstBirimNo as TalepEdenUstBirimNo
  , '000000-GDR' as RafNo
  , -1000
  ,'5000-00-00' AS HarcamaTarihi

from
  ISTEK_FISI I_F,
  ISTEK I,
  AYNIYAT_BILGILERI A_B,
  KULLANICI K,
  GRUP G,
  UST_BIRIM U_B,
  BIRIM B,
  URUN U
where
  I_F.IstekFisiNo = I.IstekFisiNo
  and A_B.IstekFisiNo = I_F.IstekFisiNo
  and I_F.Olusturan = K.KullaniciNo
  and G.GrupNo = K.GrupNo
  and U_B.UStBirimNo = B.UstBirimNo
  and G.BirimNo = B.BirimNo
  and U.UrunNo = I.UrunNo
  and I_F.IstekFisiNo=IstekFisiNoIn;

END IF;






END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AnaKalemEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AnaKalemEkle_sp`(AnaKalemAdiIn VARCHAR(80), AnaKalemKoduIn CHAR(10))
    COMMENT 'DENEME'
BEGIN
     DECLARE AnaKalemNo char(10);
     call GetNextId_sp('AKL',AnaKalemNo);
     INSERT INTO
            ANA_KALEM (AnaKalemNo, AnaKalemAdi, AnaKalemKodu)
     VALUES
           (AnaKalemNo, AnaKalemAdiIn, AnaKalemKoduIn) ;
     SELECT AnaKalemNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AnaKalemGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AnaKalemGoster_sp`(AnaKalemNoIn CHAR(10))
BEGIN
  SELECT
      *
  FROM
      ANA_KALEM
  WHERE
      ANA_KALEM.AnaKalemNo LIKE CONCAT( '%' , COALESCE(AnaKalemNoIn,'') , '%')
      AND ANA_KALEM.Statu = '1'
  ORDER BY ANA_KALEM.AnaKalemAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AnaKaleminButcesiniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AnaKaleminButcesiniGoster_sp`(UstBirimNoIn CHAR(10), FonksiyonelNoIn CHAR(10), AnaKalemNoIn CHAR(10), KurumsalNoIn CHAR(10))
BEGIN
     SELECT
           UST_BIRIM_BUTCE_DAGILIM.*,
           KURUMSAL.KurumsalKod,
           KURUMSAL.Aciklama,
           FONKSIYONEL.FonksiyonelKodu,
           FONKSIYONEL.FonksiyonelAdi,
           ANA_KALEM.AnaKalemKodu,
           ANA_KALEM.AnaKalemAdi
     FROM
         UST_BIRIM_BUTCE_DAGILIM
            JOIN
         UST_BIRIM_BUTCE  ON UST_BIRIM_BUTCE.UstBirimButceNo = UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo
            JOIN
         UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
            JOIN
         KURUMSAL ON KURUMSAL.KurumsalNo = UST_BIRIM_KURUMSAL.KurumsalNo
            JOIN
         FONKSIYONEL ON FONKSIYONEL.FonksiyonelNo = UST_BIRIM_BUTCE.FonksiyonelNo
            JOIN
         ANA_KALEM ON ANA_KALEM.AnaKalemNo = UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo
     WHERE
          UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
          AND FONKSIYONEL.FonksiyonelNo LIKE CONCAT( '%' , COALESCE(FonksiyonelNoIn,'') , '%')
          AND ANA_KALEM.AnaKalemNo LIKE CONCAT( '%' , COALESCE(AnaKalemNoIn,'') , '%')
          AND KURUMSAL.KurumsalNo LIKE CONCAT( '%' , COALESCE(KurumsalNoIn,'') , '%')
          AND ANA_KALEM.Statu = '1'
          AND FONKSIYONEL.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AnaKaleminKalemleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AnaKaleminKalemleriniGoster_sp`(AnaKalemNoIn CHAR(10))
BEGIN
     SELECT *
     FROM KALEM
     WHERE KALEM.AnaKalemNo = AnaKalemNoIn
     AND KALEM.Statu='1'
     ORDER BY KALEM.KalemAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AyniyatBilgileriEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AyniyatBilgileriEkle_sp`(IstekFisiNoIn CHAR(10), PusulaDuzenlemeTarihiIn DATE, ButceTipiIn CHAR(10), CiltIn INTEGER(11), Uye1NoIn CHAR(10), Uye2NoIn CHAR(10), Uye3NoIn CHAR(10), Uye4NoIn CHAR(10), ToplamFaturaTutariIn DECIMAL(11,2))
BEGIN
     DECLARE  AyniyatBilgileriNo    char(10);
     DECLARE  D_varakNo             INTEGER(11);
     DECLARE  D_talepMuzekkeresiNo  INTEGER(11);
     DECLARE  D_muayeneRaporuNo     INTEGER(11);
     call GetNextId_sp('AYN',AyniyatBilgileriNo);
     SET D_varakNo            = (SELECT MAX(VarakNo)            FROM AYNIYAT_BILGILERI);
     SET D_talepMuzekkeresiNo = (SELECT MAX(TalepMuzekkeresiNo) FROM AYNIYAT_BILGILERI);
     SET D_muayeneRaporuNo    = (SELECT MAX(MuayeneRaporuNo)    FROM AYNIYAT_BILGILERI);
     SET D_varakNo            = (COALESCE(D_varakNo,1));
     SET D_talepMuzekkeresiNo = (COALESCE(D_talepMuzekkeresiNo,1));
     SET D_muayeneRaporuNo    = (COALESCE(D_muayeneRaporuNo,1));
     INSERT INTO
            AYNIYAT_BILGILERI (
            AyniyatBilgileriNo,
            IstekFisiNo,
            PusulaDuzenlemeTarihi,
            ButceTipi,
            Cilt,
            Uye1No,
            Uye2No,
            Uye3No,
            Uye4No,
            VarakNo,
            TalepMuzekkeresiNo,
            MuayeneRaporuNo,
            ToplamFaturaTutari)
     VALUES
           (AyniyatBilgileriNo,
            IstekFisiNoIn,
            PusulaDuzenlemeTarihiIn,
            ButceTipiIn,
            CiltIn,
            Uye1NoIn,
            Uye2NoIn,
            Uye3NoIn,
            Uye4NoIn,
            D_varakNo+1,
            D_talepMuzekkeresiNo+1,
            D_muayeneRaporuNo+1,
            ToplamFaturaTutariIn) ;
     SELECT AyniyatBilgileriNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AyniyatBilgileriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AyniyatBilgileriGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
SELECT *
FROM AYNIYAT_BILGILERI
WHERE AYNIYAT_BILGILERI.IstekFisiNo = IstekFisiNoIn
AND AYNIYAT_BILGILERI.Statu = '1' ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AyniyatBilgileriImzala_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AyniyatBilgileriImzala_sp`(IstekFisiNo CHAR(10), UyeNo INTEGER, ImzaTarihi DATE, ImzaTipiIn CHAR(1))
BEGIN
     CASE UyeNo
     WHEN '1' THEN
          UPDATE AYNIYAT_BILGILERI
         SET AYNIYAT_BILGILERI.Uye1Imzaladi=ImzaTipiIn,
             AYNIYAT_BILGILERI.Uye1ImzaTarihi= ImzaTarihi
         WHERE AYNIYAT_BILGILERI.IstekFisiNo=IstekFisiNo;
     WHEN '2' THEN
          UPDATE AYNIYAT_BILGILERI
         SET AYNIYAT_BILGILERI.Uye2Imzaladi=ImzaTipiIn,
             AYNIYAT_BILGILERI.Uye2ImzaTarihi= ImzaTarihi
         WHERE AYNIYAT_BILGILERI.IstekFisiNo=IstekFisiNo;
     WHEN '3' THEN
         UPDATE AYNIYAT_BILGILERI
         SET AYNIYAT_BILGILERI.Uye3Imzaladi=ImzaTipiIn,
             AYNIYAT_BILGILERI.Uye3ImzaTarihi= ImzaTarihi
         WHERE AYNIYAT_BILGILERI.IstekFisiNo=IstekFisiNo;
     WHEN '4' THEN
          UPDATE AYNIYAT_BILGILERI
         SET AYNIYAT_BILGILERI.Uye4Imzaladi=ImzaTipiIn,
             AYNIYAT_BILGILERI.Uye4ImzaTarihi= ImzaTarihi
         WHERE AYNIYAT_BILGILERI.IstekFisiNo=IstekFisiNo;
 END CASE;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AyniyatImzalariSifirla_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AyniyatImzalariSifirla_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     UPDATE
           AYNIYAT_BILGILERI
     SET
           AYNIYAT_BILGILERI.Uye1Imzaladi = '0',
           AYNIYAT_BILGILERI.Uye2Imzaladi = '0',
           AYNIYAT_BILGILERI.Uye2Imzaladi = '0',
           AYNIYAT_BILGILERI.Uye2Imzaladi = '0',
           AYNIYAT_BILGILERI.Uye1ImzaTarihi = NULL,
           AYNIYAT_BILGILERI.Uye2ImzaTarihi = NULL,
           AYNIYAT_BILGILERI.Uye3ImzaTarihi = NULL,
           AYNIYAT_BILGILERI.Uye4ImzaTarihi = NULL
     WHERE
          AYNIYAT_BILGILERI.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AyniyatIstekFisiGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AyniyatIstekFisiGuncelle_sp`(IstekFisiNo CHAR(10), FaturaNo CHAR(20), FaturaTarihi DATE, SaticiFirma CHAR(30))
BEGIN
     UPDATE ISTEK_FISI
     SET ISTEK_FISI.FaturaNo=FaturaNo,
         ISTEK_FISI.FaturaTarihi=FaturaTarihi,
         ISTEK_FISI.SaticiFirma=SaticiFirma
     WHERE ISTEK_FISI.IstekFisiNo=IstekFisiNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `AyniyatMakbuzuEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `AyniyatMakbuzuEkle_sp`(IstekFisiNoIn CHAR(10), MakbuzDuzenlemeTarihiIn DATE)
BEGIN
     DECLARE  D_makbuzNo        INTEGER(11);
     DECLARE D_tuketimMalzemeNo INTEGER(11);
     DECLARE done               INT       DEFAULT 0;
     DECLARE  D_faturaKalemiNo        CHAR(10);
     DECLARE cur1 CURSOR FOR (SELECT FATURA_KALEMLERI.FaturaKalemiNo FROM FATURA_KALEMLERI WHERE FATURA_KALEMLERI.IstekFisiNo=IstekFisiNoIn AND FATURA_KALEMLERI.Statu = '1' AND FATURA_KALEMLERI.TuketimMalzemeNo = 0);
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
     SET D_makbuzNo = (SELECT MAX(MakbuzNo)  FROM AYNIYAT_BILGILERI);
     SET D_tuketimMalzemeNo = (SELECT MAX(TuketimMalzemeNo)  FROM FATURA_KALEMLERI);
     SET D_makbuzNo = (COALESCE(D_makbuzNo,1));
     SET D_tuketimMalzemeNo = (COALESCE(D_tuketimMalzemeNo,1));
     UPDATE AYNIYAT_BILGILERI
     SET
        AYNIYAT_BILGILERI.MakbuzDuzenlemeTarihi = MakbuzDuzenlemeTarihiIn,
        AYNIYAT_BILGILERI.MakbuzNo              = D_makbuzNo+1
     WHERE
        AYNIYAT_BILGILERI.IstekFisiNo = IstekFisiNoIn
        AND AYNIYAT_BILGILERI.Statu = '1';
     OPEN cur1;
     REPEAT
           FETCH cur1 INTO D_faturaKalemiNo;
           IF NOT done THEN
           SET D_tuketimMalzemeNo=(D_tuketimMalzemeNo+1);
                  UPDATE FATURA_KALEMLERI
                  SET FATURA_KALEMLERI.TuketimMalzemeNo=D_tuketimMalzemeNo
                  WHERE FATURA_KALEMLERI.FaturaKalemiNo = D_faturaKalemiNo;
           END IF;
     UNTIL done END REPEAT;
  CLOSE cur1;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BDGirisSorgusu_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BDGirisSorgusu_sp`(IN pgrupno CHAR(10), IN purunno CHAR(10), IN arrivalfromdate DATE, IN arrivaltodate DATE)
BEGIN

IF ( purunno != '-111111111')
THEN 
SELECT  U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDG.FaturaTarihi AS AlimTarihi

FROM URUN U, BIRIM_DEPO_GIRIS BDG, GRUP G

WHERE  
U.UrunNo = purunno
AND G.GrupNo = pgrupno
AND BDG.GrupNo = G.GrupNo
AND BDG.UrunNo = U.UrunNo
AND BDG.FaturaTarihi <= arrivaltodate 
AND BDG.FaturaTarihi >= arrivalfromdate;

ELSEIF ( purunno = '-111111111')
THEN 
SELECT  U.UrunAdi AS UrunIsmi, BDG.Miktar AS AlinanMiktar, BDG.FaturaTarihi AS AlimTarihi

FROM URUN U, BIRIM_DEPO_GIRIS BDG, GRUP G

WHERE  

G.GrupNo = pgrupno
AND BDG.UrunNo = U.UrunNo
AND BDG.GrupNo = G.GrupNo
AND BDG.FaturaTarihi <= arrivaltodate 
AND BDG.FaturaTarihi >= arrivalfromdate;

END IF;


END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BDHarcamaSorgusu_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BDHarcamaSorgusu_sp`(IN pgrupno CHAR(10), IN purunno CHAR(10), IN departurefromdate DATE, IN departuretodate DATE)
BEGIN

IF ( purunno != '-111111111' AND departurefromdate != '5000-00-00')
THEN
SELECT  U.UrunAdi AS UrunIsmi, BDH.Miktar AS HarcananMiktar, BDH.HarcamaTarihi AS HarcamaTarihi

FROM URUN U, BIRIM_DEPO_HARCAMA BDH, GRUP G

WHERE 
U.UrunNo = purunno
AND G.GrupNo = pgrupno
AND BDH.GrupNo = G.GrupNo
AND BDH.UrunNo = U.UrunNo
AND BDH.HarcamaTarihi <= departuretodate
AND BDH.HarcamaTarihi >= departurefromdate;

ELSEIF ( purunno != '-111111111' AND departurefromdate =  '5000-00-00')
THEN
SELECT  U.UrunAdi AS UrunIsmi, BDH.Miktar AS HarcananMiktar, BDH.HarcamaTarihi AS HarcamaTarihi

FROM URUN U, BIRIM_DEPO_HARCAMA BDH, GRUP G

WHERE 
U.UrunNo = purunno
AND G.GrupNo = pgrupno
AND BDH.GrupNo = G.GrupNo
AND BDH.UrunNo = U.UrunNo ;

ELSEIF ( purunno = '-111111111' AND departurefromdate !=  '5000-00-00')
THEN
SELECT DISTINCT U.UrunAdi AS UrunIsmi, BDH.Miktar AS HarcananMiktar, BDH.HarcamaTarihi AS HarcamaTarihi

FROM URUN U, BIRIM_DEPO_HARCAMA BDH, GRUP G

WHERE 
G.GrupNo = pgrupno
AND BDH.GrupNo = G.GrupNo
AND BDH.UrunNo = U.UrunNo
AND BDH.HarcamaTarihi <= departuretodate
AND BDH.HarcamaTarihi >= departurefromdate ;

ELSEIF ( purunno = '-111111111'AND departurefromdate = '5000-00-00')
THEN
SELECT  U.UrunAdi AS UrunIsmi, BDH.Miktar AS HarcananMiktar, BDH.HarcamaTarihi AS HarcamaTarihi

FROM URUN U, BIRIM_DEPO_HARCAMA BDH, GRUP G

WHERE 
G.GrupNo = pgrupno
AND BDH.GrupNo = G.GrupNo
AND BDH.UrunNo = U.UrunNo ;

END IF;


END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BirimDepoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BirimDepoGoster_sp`(IN grup_no CHAR(10))
BEGIN
  SELECT * from BIRIM_DEPO_URUN_MIKTAR , URUN
  WHERE URUN.UrunNo = BIRIM_DEPO_URUN_MIKTAR.UrunNo
  AND BIRIM_DEPO_URUN_MIKTAR.GrupNo = grup_no
  AND BIRIM_DEPO_URUN_MIKTAR.Mevcut > 0
  ORDER BY URUN.UrunAdi;
						
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BirimDepoMevcut_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BirimDepoMevcut_sp`(IN pgrupadi CHAR(10))
BEGIN
SELECT U.`UrunAdi`, D.`Mevcut` 
FROM `GRUP`  G, `BIRIM_DEPO_URUN_MIKTAR`  B, `URUN`  U 
WHERE G.`GrupNo` = B.`GrupNo` AND B.`UrunNo` = U.`UrunNo` 
AND B.`GrupNo` = pgrupadi AND D.`Mevcut` > 0; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BirimEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BirimEkle_sp`(BirimAdiIn VARCHAR(75), UstBirimNoIn CHAR(10))
BEGIN
  
  call GetNextId_sp('BRM',BirimNo);
  INSERT INTO
            BIRIM (BirimNo, BirimAdi, UstBirimNo)
  VALUES
           (BirimNo, BirimAdiIn , UstBirimNoIn);
  
  call YeniBiriminButceleriniEkle_sp(BirimNo);
  
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BirimGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BirimGuncelle_sp`(BirimAdiIn VARCHAR(45), BirimNoIn CHAR(10))
BEGIN
     DECLARE D_EskiBirimAdiIn VARCHAR(45);
     SET D_EskiBirimAdiIn = (SELECT BirimAdi FROM BIRIM WHERE BIRIM.BirimNo = BirimNoIn);
     UPDATE BIRIM
     SET
            BIRIM.BirimAdi = BirimAdiIn
     WHERE
            BIRIM.BirimNo = BirimNoIn
            AND BIRIM.`Statu` = '1';
     call GrupGuncelle_sp(D_EskiBirimAdiIn,BirimAdiIn);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BirimleriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BirimleriGoster_sp`(BirimNoIn CHAR(10))
BEGIN
     SELECT
           *
     FROM
         BIRIM
     WHERE
          BIRIM.BirimNo LIKE CONCAT( '%' , COALESCE(BirimNoIn,'') , '%')
	      AND BIRIM.Statu = '1'
     ORDER BY BIRIM.BirimAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `BirimSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `BirimSil_sp`(BirimNoIn CHAR(10))
BEGIN
     DECLARE D_BirimAdiIn VARCHAR(45);
     SET D_BirimAdiIn = (SELECT BirimAdi FROM BIRIM WHERE BIRIM.BirimNo=BirimNoIn);
     UPDATE
           BIRIM
     SET
           BIRIM.Statu = '0'
     WHERE
           BIRIM.BirimNo = BirimNoIn;
     call GrupSil_sp(D_BirimAdiIn);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceBlokeEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceBlokeEkle_sp`(IstekFisiNoIn CHAR(10), ButceDagilimNoIn CHAR(10), MiktarIn DECIMAL(11,2))
BEGIN
  DECLARE ButceBlokeNoTemp   CHAR(10);
  DECLARE MevcutTutarTemp    DECIMAL(11,2);
  DECLARE ButceAtanmisTemp   CHAR(1);
  DECLARE DefultButceTemp    CHAR(1);
  START TRANSACTION;
  SELECT
        BUTCE_DAGILIM.DefaultButce
  INTO
      DefultButceTemp
  FROM
      BUTCE_DAGILIM
  WHERE
       BUTCE_DAGILIM.ButceDagilimNo = ButceDagilimNoIn;
  IF DefultButceTemp = '1'
  THEN  
         SET ButceBlokeNoTemp = (
          SELECT BUTCE_BLOKE.ButceBlokeNo
          FROM BUTCE_BLOKE
          WHERE BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn
                AND  BUTCE_BLOKE.Statu = '1');
          CALL ButceBlokeKaldir_sp(IstekFisiNoIn);
          
         CALL GetNextId_sp('BBL',ButceBlokeNoTemp);
         INSERT INTO BUTCE_BLOKE ( ButceBlokeNo, IstekFisiNo, ButceDagilimNo, Miktar)
         VALUES
         (ButceBlokeNoTemp, IstekFisiNoIn, ButceDagilimNoIn,MiktarIn);
	 SELECT 1 result;
	 COMMIT;
  ELSE   
      SET ButceBlokeNoTemp = (
          SELECT BUTCE_BLOKE.ButceBlokeNo
          FROM BUTCE_BLOKE
          WHERE BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn
                AND  BUTCE_BLOKE.Statu = '1');
          CALL ButceBlokeKaldir_sp(IstekFisiNoIn);
          SELECT BUTCE_DAGILIM.KalanButce - BUTCE_DAGILIM.BlokeEdilmis AS MevcutTutar,BUTCE_DAGILIM.ButceAtanmis
          INTO   MevcutTutarTemp            ,ButceAtanmisTemp
          FROM BUTCE_DAGILIM
          WHERE BUTCE_DAGILIM.ButceDagilimNo =  ButceDagilimNoIn;
          
          IF ButceAtanmisTemp = '1'
          THEN
              IF MevcutTutarTemp >= MiktarIn
              THEN
                  CALL GetNextId_sp('BBL',ButceBlokeNoTemp);
                  INSERT INTO BUTCE_BLOKE ( ButceBlokeNo, IstekFisiNo, ButceDagilimNo, Miktar)
                  VALUES
                  (ButceBlokeNoTemp, IstekFisiNoIn, ButceDagilimNoIn,MiktarIn);
                  CALL ButceDagilimBlokeDuzenle_sp(ButceDagilimNoIn);
                  SELECT 1 result;
                  COMMIT;
             ELSE
                 SELECT -1 result;
                 ROLLBACK;
             END IF;
          ELSE
              SELECT -2 result;
              ROLLBACK;
          END IF;
  END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceBlokeKaldir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceBlokeKaldir_sp`(IstekFisiNoIn CHAR(10))
BEGIN
   DECLARE ButceDagilimNoTemp   CHAR(10);
   DECLARE ButceBlokeNoTemp   CHAR(10);
   SET ButceBlokeNoTemp  = (select BUTCE_BLOKE.ButceBlokeNo from BUTCE_BLOKE where BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn AND BUTCE_BLOKE.Statu = '1');
   IF ButceBlokeNoTemp IS NOT NULL
   THEN
     SET ButceDagilimNoTemp = (
         SELECT BUTCE_BLOKE.ButceDagilimNo
         FROM BUTCE_BLOKE
         WHERE BUTCE_BLOKE.ButceBlokeNo = ButceBlokeNoTemp
               AND BUTCE_BLOKE.Statu = '1');
     UPDATE
           BUTCE_BLOKE
     SET
        BUTCE_BLOKE.Statu = '0'
     WHERE
          BUTCE_BLOKE.ButceBlokeNo = ButceBlokeNoTemp;
	
	 call ButceDagilimBlokeDuzenle_sp(ButceDagilimNoTemp);
  END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceDagilimaButceEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceDagilimaButceEkle_sp`(AnaKalemNoIn CHAR(10), FonksiyonelNoIn CHAR(10), KurumsalNoIn CHAR(10), BirimNoIn CHAR(10), ButceIn DECIMAL(11,2))
BEGIN
     DECLARE D_ButceDagilimNo CHAR(10);
     SET D_ButceDagilimNo = NULL;
     SELECT
           BUTCE_DAGILIM.ButceDagilimNo
     INTO
           D_ButceDagilimNo
     FROM
         BUTCE_DAGILIM
     WHERE
          BUTCE_DAGILIM.BirimNo = BirimNoIn
          AND BUTCE_DAGILIM.AnaKalemNo = AnaKalemNoIn
          AND BUTCE_DAGILIM.FonksiyonelNo = FonksiyonelNoIn
          AND BUTCE_DAGILIM.KurumsalNo = KurumsalNoIn;
     IF (D_ButceDagilimNo IS NOT NULL)
     THEN
        UPDATE
           BUTCE_DAGILIM
        SET
           BUTCE_DAGILIM.ToplamButce = ButceIn,
           BUTCE_DAGILIM.KalanButce  = ButceIn,
           BUTCE_DAGILIM.ButceAtanmis='1'
        WHERE
           BUTCE_DAGILIM.ButceDagilimNo = D_ButceDagilimNo;
        SELECT 'TAMAMLANDI' AS operationStatus;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceDagilimBlokeDuzenle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceDagilimBlokeDuzenle_sp`(ButceDagilimNoIn CHAR(10))
BEGIN
     
         UPDATE BUTCE_DAGILIM
         SET BlokeEdilmis = (
                           SELECT SUM(BUTCE_BLOKE.Miktar)
                           FROM BUTCE_BLOKE
                           WHERE BUTCE_BLOKE.ButceDagilimNo = BUTCE_DAGILIM.ButceDagilimNo
                                 AND BUTCE_BLOKE.Statu = '1'
                         )
         WHERE
              BUTCE_DAGILIM.ButceDagilimNo LIKE CONCAT( '%' , COALESCE(ButceDagilimNo,'') , '%')
              AND BUTCE_DAGILIM.DefaultButce = '0';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceDagilimGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceDagilimGoster_sp`(BirimNoIn CHAR(10))
BEGIN
    SELECT
           BUTCE_DAGILIM.ButceDagilimNo,
           BUTCE_DAGILIM.ButceAtanmis,
           BUTCE_DAGILIM.Statu,
           KURUMSAL.KurumsalKod,
           KURUMSAL.KurumsalNo,
           FONKSIYONEL.FonksiyonelKodu,
           FONKSIYONEL.FonksiyonelAdi,
           FONKSIYONEL.FonksiyonelNo,
           ANA_KALEM.AnaKalemNo,
           ANA_KALEM.AnaKalemKodu,
           ANA_KALEM.AnaKalemAdi,
           BUTCE_DAGILIM.KalanButce - BUTCE_DAGILIM.BlokeEdilmis AS MevcutTutar,
           BUTCE_DAGILIM.BlokeEdilmis                            AS BlokeliTutar,
           UST_BIRIM_BUTCE_DAGILIM.AtanmamisMiktar               AS ToplamTutar,
           UST_BIRIM_BUTCE.*
     FROM
         BUTCE_DAGILIM
             JOIN
         KURUMSAL    ON KURUMSAL.KurumsalNo = BUTCE_DAGILIM.KurumsalNo AND KURUMSAL.Statu = '1'
             JOIN
         FONKSIYONEL ON FONKSIYONEL.FonksiyonelNo = BUTCE_DAGILIM.FonksiyonelNo AND FONKSIYONEL.Statu = '1'
             JOIN
         BIRIM       ON BIRIM.BirimNo = BUTCE_DAGILIM.BirimNo
             JOIN
         UST_BIRIM   ON UST_BIRIM.UstBirimNo = BIRIM.UstBirimNo
             JOIN
         UST_BIRIM_KURUMSAL  ON UST_BIRIM_KURUMSAL.UstBirimNo = UST_BIRIM.UstBirimNo AND UST_BIRIM_KURUMSAL.KurumsalNo = KURUMSAL.KurumsalNo
             JOIN
         UST_BIRIM_BUTCE     ON UST_BIRIM_BUTCE.UstBirimKurumsalNo = UST_BIRIM_KURUMSAL.UstBirimKurumsalNo AND UST_BIRIM_BUTCE.FonksiyonelNo = FONKSIYONEL.FonksiyonelNo
             JOIN
         UST_BIRIM_BUTCE_DAGILIM ON UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo = UST_BIRIM_BUTCE.UstBirimButceNo AND UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo = BUTCE_DAGILIM.AnaKalemNo
             JOIN
         ANA_KALEM    ON ANA_KALEM.AnaKalemNo = BUTCE_DAGILIM.AnaKalemNo AND ANA_KALEM.Statu = '1'
     WHERE
          BUTCE_DAGILIM.BirimNo = BirimNoIn
          AND BUTCE_DAGILIM.Statu <> '0';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceDagilimGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceDagilimGuncelle_sp`(ButceDagilimNoIn CHAR(10), TutarIn DECIMAL(11,2), ButceAtanmisIn CHAR(1))
BEGIN
     DECLARE D_UstBirimButceDagilimNo CHAR(10);
     DECLARE D_ButceAtanmis           CHAR(1);
     DECLARE D_AtanmamisMiktar        DECIMAL(11,2);
     DECLARE D_BlokeliTutar           DECIMAL(11,2);
     SELECT
           UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo,
           UST_BIRIM_BUTCE_DAGILIM.AtanmamisMiktar,
           BUTCE_DAGILIM.BlokeEdilmis,
           BUTCE_DAGILIM.ButceAtanmis
     INTO
         D_UstBirimButceDagilimNo,
         D_AtanmamisMiktar,
         D_BlokeliTutar,
         D_ButceAtanmis
     FROM
         BUTCE_DAGILIM
             JOIN
         BIRIM               ON  BIRIM.BirimNo = BUTCE_DAGILIM.BirimNo
             JOIN
         UST_BIRIM_KURUMSAL  ON UST_BIRIM_KURUMSAL.UstBirimNo = BIRIM.UstBirimNo AND UST_BIRIM_KURUMSAL.KurumsalNo = BUTCE_DAGILIM.KurumsalNo
             JOIN
         UST_BIRIM_BUTCE     ON UST_BIRIM_BUTCE.UstBirimKurumsalNo = UST_BIRIM_KURUMSAL.UstBirimKurumsalNo AND UST_BIRIM_BUTCE.FonksiyonelNo = BUTCE_DAGILIM.FonksiyonelNo
             JOIN
         UST_BIRIM_BUTCE_DAGILIM  ON UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo = UST_BIRIM_BUTCE.UstBirimButceNo AND UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo = BUTCE_DAGILIM.AnaKalemNo
     WHERE
         BUTCE_DAGILIM.ButceDagilimNo = ButceDagilimNoIn
         AND BUTCE_DAGILIM.Statu <> '0';
     IF (D_AtanmamisMiktar IS NULL)
     THEN
         SELECT '-1' AS result;
     ELSEIF (D_AtanmamisMiktar + TutarIn < 0)
     THEN
         SELECT '-2' AS result;
     
     ELSE
             UPDATE
                   BUTCE_DAGILIM
             SET
                BUTCE_DAGILIM.KalanButce   = BUTCE_DAGILIM.KalanButce + TutarIn,
                BUTCE_DAGILIM.ToplamButce  = BUTCE_DAGILIM.ToplamButce + TutarIn,
                BUTCE_DAGILIM.ButceAtanmis = ButceAtanmisIn
             WHERE
                  BUTCE_DAGILIM.ButceDagilimNo = ButceDagilimNoIn;
             UPDATE
                   UST_BIRIM_BUTCE_DAGILIM
             SET
                UST_BIRIM_BUTCE_DAGILIM.AtanmamisMiktar = D_AtanmamisMiktar - TutarIn,
                UST_BIRIM_BUTCE_DAGILIM.ToplamButce     = UST_BIRIM_BUTCE_DAGILIM.ToplamButce - TutarIn
             WHERE
                  UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo = D_UstBirimButceDagilimNo;
             SELECT '1' AS result;
      END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceDagilimStatuDegistir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceDagilimStatuDegistir_sp`(UstBirimNoIn CHAR(10), FonksiyonelNoIn CHAR(10), KurumsalNoIn CHAR(10), AnaKalemNoIn CHAR(10), StatuIn CHAR(10), OUT result CHAR(2))
BEGIN
     DECLARE done             INT       DEFAULT 0;
     DECLARE D_BirimNo        CHAR(10);
     DECLARE D_ButceDagilimNo CHAR(10);
     DECLARE D_ButceBlokeNo   CHAR(10);
     DECLARE cur1 CURSOR FOR SELECT BirimNo FROM BIRIM WHERE BIRIM.UstBirimNo = UstBirimNoIn AND BIRIM.Statu = '1';
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
     START TRANSACTION;
     OPEN cur1;
     REPEAT
           FETCH cur1 INTO D_BirimNo;
           IF StatuIn = '0'
           THEN
               IF NOT done THEN
                  SELECT
                        BUTCE_DAGILIM.ButceDagilimNo
                  INTO
                      D_ButceDagilimNo
                  FROM
                      BUTCE_DAGILIM
                  WHERE
                       BUTCE_DAGILIM.BirimNo = D_BirimNo
                       AND BUTCE_DAGILIM.FonksiyonelNo = FonksiyonelNoIn
                       AND BUTCE_DAGILIM.KurumsalNo = KurumsalNoIn
                       AND BUTCE_DAGILIM.AnaKalemNo = AnaKalemNoIn;
                  IF D_ButceDagilimNo IS NOT NULL
                  THEN
                      SELECT
                            BUTCE_BLOKE.ButceBlokeNo
                      INTO
                          D_ButceBlokeNo
                      FROM
                          BUTCE_BLOKE
                      WHERE
                           BUTCE_BLOKE.ButceDagilimNo = D_ButceDagilimNo
                           AND BUTCE_BLOKE.Statu = '1';
                      IF D_ButceBlokeNo IS NOT NULL
                      THEN
                          SET result = '-1';
                          SET done = 1;
                      ELSE
                          UPDATE
                                BUTCE_DAGILIM
                          SET
                             BUTCE_DAGILIM.Statu = '0'
                          WHERE
                               BUTCE_DAGILIM.ButceDagilimNo = D_ButceDagilimNo;
                          SET result = '1';
                      END IF;
                  END IF;
               END IF;
           ELSE
               SELECT
                        BUTCE_DAGILIM.ButceDagilimNo
                  INTO
                      D_ButceDagilimNo
                  FROM
                      BUTCE_DAGILIM
                  WHERE
                       BUTCE_DAGILIM.BirimNo = D_BirimNo
                       AND BUTCE_DAGILIM.FonksiyonelNo = FonksiyonelNoIn
                       AND BUTCE_DAGILIM.KurumsalNo = KurumsalNoIn
                       AND BUTCE_DAGILIM.AnaKalemNo = AnaKalemNoIn;
               IF D_ButceDagilimNo IS NOT NULL
               THEN
                   UPDATE
                         BUTCE_DAGILIM
                   SET
                      BUTCE_DAGILIM.Statu = StatuIn
                   WHERE
                        BUTCE_DAGILIM.ButceDagilimNo = D_ButceDagilimNo;
                   SET result = '1';
               END IF;
           END IF;
     UNTIL done END REPEAT;
  CLOSE cur1;
  IF result = '1'
  THEN
      COMMIT;
  ELSE
      ROLLBACK;
  END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButceSiraNoGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButceSiraNoGuncelle_sp`(IstekFisiNoIn CHAR(10), ButceSiraNoIn VARCHAR(15))
BEGIN
     UPDATE
           ISTEK_FISI
     SET
        ISTEK_FISI.ButceSiraNo = ButceSiraNoIn
     WHERE
          ISTEK_FISI.IstekFisiNo = IstekFisiNoIn
          AND ISTEK_FISI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ButunIstekFisleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ButunIstekFisleriniGoster_sp`()
BEGIN
  SELECT
      *
  FROM
      ISTEK_FISI
  WHERE
      ISTEK_FISI.Statu = '1'
  ORDER BY ISTEK_FISI.OlusturmaTarihi DESC;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `DefaultButceGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `DefaultButceGoster_sp`(BirimNoIn CHAR(10))
BEGIN
     SELECT
           BUTCE_DAGILIM.ButceDagilimNo
     FROM
         BUTCE_DAGILIM
     WHERE
          BUTCE_DAGILIM.BirimNo = BirimNoIn
          AND BUTCE_DAGILIM.DefaultButce = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `DepoCikisDDC_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `DepoCikisDDC_sp`(IN departman_no  CHAR(10), 
IN urun_no CHAR(10) , IN miktar INT,IN paciklama VARCHAR(200))
BEGIN

IF EXISTS (SELECT * FROM BIRIM_DEPO_HARCAMA WHERE GrupNo = departman_no AND UrunNo = urun_no AND Miktar = -1000)
THEN
UPDATE  `BIRIM_DEPO_HARCAMA` 

SET Miktar = miktar,  Aciklama = paciklama 

WHERE GrupNo = departman_no AND UrunNo = urun_no;

ELSEIF(1=1)
THEN
INSERT INTO BIRIM_DEPO_HARCAMA(UrunNo, GrupNo , UstBirimNo, Miktar, HarcamaTarihi, Aciklama)
VALUES(urun_no, departman_no, 
(SELECT UstBirimNo FROM BIRIM, GRUP WHERE GrupNo = departman_no AND GRUP.BirimNo = BIRIM.BirimNo),
 miktar, CURDATE(), paciklama);

END IF;

END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `DepoCikisGDCtoBDG_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `DepoCikisGDCtoBDG_sp`(IN grno CHAR(10), IN urun_no CHAR(10), IN pmiktar INT, IN rafNumarasi CHAR(10), IN paciklama VARCHAR(200))
BEGIN


IF EXISTS(SELECT * FROM GENEL_DEPO_HARCAMA WHERE TalepEdenGrupNo = grno AND UrunNo = urun_no AND Miktar = -1000)
THEN
UPDATE GENEL_DEPO_HARCAMA
SET Miktar = pmiktar , RafNo = rafNumarasi ,Aciklama = paciklama ,HarcamaTarihi = CURDATE()
WHERE UrunNo = urun_no AND TalepEdenGrupNo = grno ;

ELSEIF(1=1)
THEN
INSERT INTO GENEL_DEPO_HARCAMA(UrunNo, TalepEdenGrupNo, TalepEdenBirimNo, TalepEdenUstBirimNo, RafNo, Miktar, HarcamaTarihi, Aciklama)
VALUES(urun_no, grno, 
(SELECT BirimNo FROM GRUP WHERE GrupNo = grno),
(SELECT UstBirimNo FROM BIRIM, GRUP WHERE GrupNo = grno AND GRUP.BirimNo = BIRIM.BirimNo),
rafnumarasi, pmiktar, CURDATE(), paciklama);

END IF;

END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `DepoCikisGDC_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `DepoCikisGDC_sp`(IN urun_no CHAR(10), IN miktar INT, IN rafNumarasi CHAR(10), IN paciklama VARCHAR(200))
BEGIN

IF EXISTS (SELECT * FROM GENEL_DEPO_HARCAMA WHERE UrunNo = urun_no AND  Miktar = -1000)
THEN
UPDATE `GENEL_DEPO_HARCAMA` 
SET Miktar = miktar, RafNo = rafNumarasi,HarcamaTarihi = CURDATE(), Aciklama = paciklama
WHERE UrunNo = urun_no ;

ELSEIF(1=1)
THEN
INSERT INTO GENEL_DEPO_HARCAMA(UrunNo,  RafNo, Miktar, HarcamaTarihi, Aciklama)
VALUES(urun_no,rafnumarasi, miktar, CURDATE(), paciklama);

END IF;


END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `DepoGirisDDC_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `DepoGirisDDC_sp`(IN pgrupno CHAR(10), IN purunno CHAR(10),IN pmiktar INT,
IN paciklama VARCHAR(200))
BEGIN
INSERT INTO `BIRIM_DEPO_GIRIS`(GrupNo,BirimNo,UstBirimNo,UrunNo,Miktar,FaturaTarihi,Aciklama)
VALUES(pgrupno,
(SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = pgrupno),
(SELECT `UstBirimNo` FROM BIRIM  WHERE `BirimNo` = (SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = pgrupno) ),
purunno,pmiktar,CURDATE(),paciklama);

IF (1=1) 
THEN

INSERT INTO BIRIM_DEPO_HARCAMA(GrupNo, UstBirimNo, BirimNo, UrunNo, Miktar, HarcamaTarihi)
VALUES(pgrupno, 
(SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = pgrupno),
(SELECT `UstBirimNo` FROM BIRIM  WHERE `BirimNo` = (SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = pgrupno) ),
purunno, -1000, '5000-00-00');

END IF;


END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `DestekUstGrupGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `DestekUstGrupGoster_sp`(GrupNoIn CHAR(10))
BEGIN
 CALL UstGrupGoster_sp(GrupNoIn);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FaturaKalemiGir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FaturaKalemiGir_sp`(IstekFisiNoIn CHAR(10), NeviIn VARCHAR(30), MiktarIn CHAR(10), BirimFiyatIn CHAR(15), KDVOraniIn CHAR(10), AmbDefSayfNoIn CHAR(10), YevmDefSayfNoIn CHAR(10), OlcuBirimiIn CHAR(10))
BEGIN
     DECLARE FaturaKalemiNo char(10);
     call GetNextId_sp('FAK',FaturaKalemiNo);
     INSERT INTO
            `FATURA_KALEMLERI` ( FaturaKalemiNo, IstekFisiNo, Nevi, Miktar, BirimFiyat, KDVOrani, AmbarDefteriSayfaNo, YevmiyeDefteriSayfaNo, OlcuBirimi)
     VALUES
           (FaturaKalemiNo, IstekFisiNoIn, NeviIn, MiktarIn, BirimFiyatIn, KDVOraniIn, AmbDefSayfNoIn, YevmDefSayfNoIn, OlcuBirimiIn ) ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FaturaKalemleriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FaturaKalemleriGoster_sp`(IstekfisiNoIn CHAR(10))
BEGIN
SELECT *
FROM FATURA_KALEMLERI
WHERE FATURA_KALEMLERI.IstekFisiNo = IstekFisiNoIn
AND FATURA_KALEMLERI.Statu = '1' ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FirmaninGirdigiIhalelerDokumu_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FirmaninGirdigiIhalelerDokumu_sp`(FirmaAdiIn VARCHAR(50))
BEGIN
SELECT IHALE.*,
       IHALE_TEKLIF.*,
       KAZANAN.FirmaAdi AS KazananFirma,
       KAZANAN.TeklifFiyati AS KazananTeklifFiyati
FROM IHALE, IHALE_TEKLIF, IHALE_TEKLIF AS KAZANAN
WHERE IHALE_TEKLIF.FirmaAdi = FirmaAdiIn AND
      IHALE.IhaleNo = IHALE_TEKLIF.IhaleNo AND
      IHALE.KazananTeklifNo = KAZANAN.TeklifNo AND
      IHALE.Statu = '1' AND
      IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FonksiyonelEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FonksiyonelEkle_sp`(FonksiyonelKoduIn VARCHAR(20), FonksiyonelAdiIn VARCHAR(45))
BEGIN
     DECLARE FonksiyonelNo char(10);
     call GetNextId_sp('FNK',FonksiyonelNo);
     INSERT INTO
            `FONKSIYONEL` ( FonksiyonelNo, FonksiyonelKodu, FonksiyonelAdi, Statu)
     VALUES
           (FonksiyonelNo, FonksiyonelKoduIn, FonksiyonelAdiIn, "1") ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FonksiyonelGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FonksiyonelGoster_sp`(FonksiyonelNoIn CHAR(10))
BEGIN
     SELECT *
     FROM FONKSIYONEL
     WHERE FONKSIYONEL.Statu = '1'
     AND FONKSIYONEL.FonksiyonelNo LIKE CONCAT( '%' , COALESCE(FonksiyonelNoIn,'') , '%')
     ORDER BY FONKSIYONEL.FonksiyonelAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FonksiyonelGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FonksiyonelGuncelle_sp`(FonksiyonelKoduIn VARCHAR(20), FonksiyonelNoIn CHAR(10), FonksiyonelAdiIn VARCHAR(150))
BEGIN
     UPDATE FONKSIYONEL
     SET
        FONKSIYONEL.FonksiyonelKodu = FonksiyonelKoduIn,
        FONKSIYONEL.FonksiyonelAdi = FonksiyonelAdiIn
     WHERE
        FONKSIYONEL.FonksiyonelNo = FonksiyonelNoIn
        AND FONKSIYONEL.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `FonksiyonelSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `FonksiyonelSil_sp`(FonksiyonelNoIn CHAR(10))
BEGIN
    UPDATE
         FONKSIYONEL
    SET
         FONKSIYONEL.Statu='0'
    WHERE
         FONKSIYONEL.FonksiyonelNo=FonksiyonelNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GDepoRafGetir_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GDepoRafGetir_sp`()
BEGIN
  SELECT RafNo
  FROM GENEL_DEPO_RAF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GDGirisSorgusu_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GDGirisSorgusu_sp`(IN purunno CHAR(10), IN arrivaltodate DATE, IN arrivalfromdate DATE)
BEGIN

IF(purunno != '-111111111')
THEN
SELECT U.UrunAdi AS UrunIsmi, GDG.FaturaTarihi AS AlimTarihi, GDG.Miktar AS AlimMiktari
FROM URUN U, GENEL_DEPO_GIRIS GDG
WHERE 
U.UrunNo = purunno
AND GDG.UrunNo = U.UrunNo
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate;

ELSEIF(purunno = '-111111111')
THEN 

SELECT U.UrunAdi AS UrunIsmi, GDG.FaturaTarihi AS AlimTarihi, GDG.Miktar AS AlimMiktari
FROM URUN U, GENEL_DEPO_GIRIS GDG

WHERE 

GDG.UrunNo = U.UrunNo
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate;

END IF;


END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GDHarcamaSorgusu_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GDHarcamaSorgusu_sp`(IN
purunno CHAR(10),IN talepedengrupno CHAR(10) ,IN departuretodate DATE,
IN departurefromdate DATE)
BEGIN

IF(purunno != '-111111111' AND talepedengrupno != '-111111111'  AND
departuretodate != '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HArcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
U.UrunNo = purunno
AND G.GrupNo = talepedengrupno
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo
AND GDH.HarcamaTarihi <= departuretodate
AND GDH.HarcamaTarihi >= departurefromdate;

ELSEIF(purunno != '-111111111' AND talepedengrupno != '-111111111'
AND departuretodate = '5000-00-00')
THEN

SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HArcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
U.UrunNo = purunno
AND G.GrupNo = talepedengrupno
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo ;

ELSEIF( purunno = '-111111111' AND talepedengrupno != '-111111111'
AND departuretodate != '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HarcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
G.GrupNo = talepedengrupno
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo
AND GDH.HarcamaTarihi <= departuretodate
AND GDH.HarcamaTarihi >= departurefromdate;

ELSEIF(purunno = '-111111111' AND talepedengrupno != '-111111111'  AND
departuretodate = '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HarcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
G.GrupNo = talepedengrupno
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo;


ELSEIF(purunno != '-111111111' AND talepedengrupno = '-111111111'  AND
departuretodate != '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HArcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
U.UrunNo = purunno
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo
AND GDH.HarcamaTarihi <= departuretodate
AND GDH.HarcamaTarihi >= departurefromdate;

ELSEIF(purunno != '-111111111' AND talepedengrupno = '-111111111'  AND
departuretodate = '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HArcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
U.UrunNo = purunno
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo;

ELSEIF(purunno = '-111111111' AND talepedengrupno = '-111111111'  AND
departuretodate != '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HArcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo
AND GDH.HarcamaTarihi <= departuretodate
AND GDH.HarcamaTarihi >= departurefromdate;

ELSEIF(purunno = '-111111111' AND talepedengrupno = '-111111111'  AND
departuretodate = '5000-00-00')
THEN
SELECT U.UrunAdi AS UrunIsmi, G.GrupAdi AS BirimAdi ,
GDH.HarcamaTarihi AS HarcamaTarihi, GDH.Miktar AS HArcamaMiktari
FROM URUN U, GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE
GDH.TalepEdenGrupNo = G.GrupNo
AND GDH.UrunNo = U.UrunNo ;

END IF;




END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GecmisGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GecmisGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
 SELECT
       GECMIS.*,
       ISTEK_FISI.IstekFisiKodu,
       ISTEK_FISI.Isteyen,
       KULLANICI.Ad,
       KULLANICI.Soyad,
       KULLANICI.KullaniciAdi,
       KULLANICI.KullaniciNo,
       SAYFA.SayfaAdi,SAYFA.SayfaKodu,
       GRUP.GrupAdi
 FROM GECMIS
 JOIN ISTEK_FISI ON ISTEK_FISI.IstekFisiNo = GECMIS.IstekFisiNo
 JOIN KULLANICI ON  KULLANICI.KullaniciNo = GECMIS.KullaniciNo
 JOIN SAYFA ON SAYFA.SayfaNo = GECMIS.SayfaNo
 JOIN GRUP ON GRUP.GrupNo = GECMIS.GrupNo
 WHERE GECMIS.IstekFisiNo = IstekFisiNoIn
 ORDER by GECMIS.OlusturmaTarihi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GenelDepoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GenelDepoGoster_sp`()
BEGIN
  SELECT * from GENEL_DEPO_URUN_MIKTAR , URUN
  WHERE URUN.UrunNo = GENEL_DEPO_URUN_MIKTAR.UrunNo
  AND  GENEL_DEPO_URUN_MIKTAR.Mevcut > 0
  ORDER BY URUN.UrunAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GenelDepoHarcama_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GenelDepoHarcama_sp`(IN urun_no CHAR(10), IN pmiktar INT, IN prafno CHAR(10), IN paciklama varchar(200) )
BEGIN
INSERT INTO `GENEL_DEPO_HARCAMA`(`UrunNo`, `RafNo`, `Miktar`, `HarcamaTarihi`,`Aciklama`)
VALUES(urun_no, prafno, pmiktar, CURDATE(), paciklama);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GenelDepoMevcut_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GenelDepoMevcut_sp`()
BEGIN
SELECT U.`UrunAdi`, D.`Mevcut` 
FROM  `GENEL_DEPO_URUN_MIKTAR` D, `URUN` U 
WHERE  D.`UrunNo` = U.`UrunNo` AND  D.`Mevcut` > 0; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GenelDepoSorgusuKontrol_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GenelDepoSorgusuKontrol_sp`(IN talepedengrupno CHAR(10), IN urun_no CHAR(10),
IN arrivalfromdate DATE, IN arrivaltodate DATE, IN departurefromdate DATE, IN departuretodate DATE)
BEGIN

IF (urun_no != '-111111111' AND talepedengrupno != '-111111111' AND departuretodate != '5000-00-00') 
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE
U.UrunNo = urun_no
AND G.GrupNo = talepedengrupno
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate
AND GDH.HarcamaTarihi >= departurefromdate 
AND GDH.HarcamaTarihi <= departuretodate

AND GDG.UrunNo = U.UrunNo
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo;




ELSEIF (urun_no != '-111111111' AND talepedengrupno != '-111111111'  AND departuretodate = '5000-00-00') 
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE 
U.UrunNo = urun_no
AND G.GrupNo = talepedengrupno
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate

AND GDG.UrunNo = U.UrunNo
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo;


ELSEIF (urun_no = '-111111111' AND talepedengrupno != '-111111111'  AND departuretodate != '5000-00-00')
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE
G.GrupNo = talepedengrupno
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate
AND GDH.HarcamaTarihi >= departurefromdate 
AND GDH.HarcamaTarihi <= departuretodate

AND GDG.UrunNo = U.UrunNo 
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo ;




ELSEIF (urun_no =  '-111111111' AND talepedengrupno != '-111111111'  AND departuretodate = '5000-00-00')
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE 

G.GrupNo = talepedengrupno
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate

AND GDG.UrunNo = U.UrunNo 
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo ;



ELSEIF (urun_no != '-111111111' AND talepedengrupno = '-111111111'  AND departuretodate != '5000-00-00')
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE
U.UrunNo = urun_no
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate
AND GDH.HarcamaTarihi >= departurefromdate 
AND GDH.HarcamaTarihi <= departuretodate

AND GDG.UrunNo = U.UrunNo 
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo ; 


ELSEIF (urun_no != '-111111111' AND talepedengrupno = '-111111111'  AND departuretodate = '5000-00-00')
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE 
U.UrunNo = urun_no
AND GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate

AND GDG.UrunNo = U.UrunNo 
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo;



ELSEIF (urun_no = '-111111111' AND talepedengrupno = '-111111111' AND departuretodate != '5000-00-00') 
THEN 

SELECT DISTINCT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE 
GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate
AND GDH.HarcamaTarihi >= departurefromdate 
AND GDH.HarcamaTarihi <= departuretodate

AND GDG.UrunNo = U.UrunNo 
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo ;


ELSEIF (urun_no = '-111111111' AND talepedengrupno = '-111111111' AND  departuretodate = '5000-00-00') 
THEN 

SELECT DISTINCT  U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi ,GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 

FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G

WHERE
GDG.FaturaTarihi <= arrivaltodate 
AND GDG.FaturaTarihi >= arrivalfromdate

AND GDG.UrunNo = U.UrunNo 
AND GDH.TalepEdenGrupNo = G.GrupNo
AND GDG.UrunNo = GDH.UrunNo;

END IF;




END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GenelDepoSorgusu_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GenelDepoSorgusu_sp`(IN talepedengrupno CHAR(10),IN urun_no CHAR(10),
IN arrivalfromdate DATE, IN arrivaltodate DATE, IN departurefromdate DATE, IN departuretodate DATE)
BEGIN
SELECT U.`UrunAdi` AS UrunIsmi, G.`GrupAdi` AS BirimIsmi, GDG.Miktar AS AlinanMiktar, GDH.Miktar AS KullanilanMiktar,
GDG.FaturaTarihi AS FaturaTarihi, GDH.HarcamaTarihi AS CikisTarihi 
FROM URUN U, GENEL_DEPO_GIRIS GDG,GENEL_DEPO_HARCAMA GDH, GRUP G
WHERE EXISTS(SELECT *
FROM GENEL_DEPO_GIRIS
WHERE FaturaTarihi <= arrivaltodate AND FaturaTarihi >= arrivalfromdate)
AND EXISTS
(SELECT *
FROM GENEL_DEPO_HARCAMA
WHERE HarcamaTarihi >= departurefromdate AND HarcamaTarihi >= departuretodate)
AND GDG.UrunNo = urun_no 
AND GDG.UrunNo = GDH.UrunNo
AND GDG.TalepEdenGrupNo = talepedengrupno
AND GDG.TalepEdenGrupNo = GDH.TalepEdenGrupNo
AND GDG.UrunNo = U.UrunNo
AND GDG.TalepEdenGrupNo= G.GrupNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GercekFiyatOnayla_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GercekFiyatOnayla_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     
     DECLARE D_ButceDagilimNo     CHAR(10);
     DECLARE D_ToplamFaturaTutari DECIMAL(11,2);
     SELECT
           AYNIYAT_BILGILERI.ToplamFaturaTutari
     INTO
         D_ToplamFaturaTutari
     FROM
         AYNIYAT_BILGILERI
     WHERE
          AYNIYAT_BILGILERI.IstekFisiNo = IstekFisiNoIn
          AND AYNIYAT_BILGILERI.Statu = '1';
     IF D_ToplamFaturaTutari IS NOT NULL
     THEN
         SELECT
               BUTCE_DAGILIM.ButceDagilimNo
         INTO
             D_ButceDagilimNo
         FROM
             BUTCE_BLOKE
                 JOIN
             BUTCE_DAGILIM ON BUTCE_DAGILIM.ButceDagilimNo = BUTCE_BLOKE.ButceDagilimNo
         WHERE
              BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn
              AND BUTCE_BLOKE.Statu = '1';
         IF D_ButceDagilimNo IS NOT NULL
         THEN
             CALL ButceBlokeKaldir_sp(IstekFisiNoIn);
             UPDATE
                   BUTCE_DAGILIM
             SET
                BUTCE_DAGILIM.KalanButce = BUTCE_DAGILIM.KalanButce - D_ToplamFaturaTutari
             WHERE
                  BUTCE_DAGILIM.ButceDagilimNo = D_ButceDagilimNo;
             
             SELECT '1' AS result;
         ELSE
             SELECT '-1' AS result;
         END IF;
     ELSE
         SELECT '-2' AS result;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAdLimit_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAdLimit_sp`(IN departman_no  CHAR(10), IN urun_no CHAR(10))
BEGIN
SELECT `AltLimit` 
FROM `BIRIM_DEPO_URUN_MIKTAR`
WHERE  `GrupNo` = departman_no  AND `UrunNo` = urun_no;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllBirimAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAllBirimAdi_sp`()
SELECT `BirimAdi`
FROM BIRIM */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllBirimNoVeAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAllBirimNoVeAdi_sp`()
BEGIN
SELECT `BirimNo`,`BirimAdi`
FROM BIRIM ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllGrupAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAllGrupAdi_sp`()
BEGIN
SELECT `GrupAdi`
FROM `GRUP` ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `getAllGrupNoVeBirimAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `getAllGrupNoVeBirimAdi_sp`()
select G.GrupNo, B.BirimAdi from GRUP G, BIRIM B WHERE G.BirimNo = B.BirimNo */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `getAllGrupNoVeGrupAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `getAllGrupNoVeGrupAdi_sp`()
SELECT G.GrupNo, G.GrupAdi FROM GRUP G */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUrunAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAllUrunAdi_sp`()
SELECT UrunAdi
FROM URUN */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUrunNoVeAdi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAllUrunNoVeAdi_sp`()
BEGIN
SELECT `UrunNo`,`UrunAdi`
FROM `URUN`;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUrunNo_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetAllUrunNo_sp`()
BEGIN
SELECT `UrunNo`
FROM `URUN`;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetBdKalanID_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetBdKalanID_sp`(IN grup_no CHAR(10), IN urun_no CHAR(10), OUT kalan INT)
BEGIN
SELECT `Mevcut`
FROM  BIRIM_DEPO_URUN_MIKTAR
WHERE  `GrupNo` = grup_no AND 
`UrunNo` = urun_no;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetBdKalan_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetBdKalan_sp`(IN departman_no CHAR(10), IN urun_no CHAR(10))
BEGIN
SELECT `Mevcut`
FROM  `BIRIM_DEPO_URUN_MIKTAR`
WHERE  `GrupNo` = departman_no AND `UrunNo` = urun_no ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetBirimNo_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetBirimNo_sp`(IN departmanadi VARCHAR(150), OUT birimno CHAR(10))
SELECT `BirimNo`
FROM BIRIM 
WHERE `BirimAdi` = departmanadi */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetDepartments_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetDepartments_sp`()
BEGIN
SELECT `BirimNo`,`BirimAdi`
FROM  `BIRIM` 
WHERE `UstBirimNo` IN (SELECT `AkademikUstBirimNo` FROM `AKADEMIK_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `getDepForDekan_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `getDepForDekan_sp`(IN p_grupno CHAR(10))
BEGIN

SELECT G.GrupNo , G.GrupAdi
FROM GRUP G, BIRIM B
WHERE B.UstBirimNo IN 
(SELECT U.UstBirimNo 
FROM GRUP G, BIRIM B, UST_BIRIM U 
WHERE U.UstBirimNo = B.UstBirimNo AND G.GrupNo = p_grupno AND G.BirimNo = B.BirimNo)
AND G.BirimNo = B.BirimNo ;

END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `getDepNamesForDekan_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `getDepNamesForDekan_sp`(IN p_grupno CHAR(10))
BEGIN

SELECT G.GrupAdi
FROM GRUP G, BIRIM B
WHERE B.UstBirimNo IN 
(SELECT U.UstBirimNo 
FROM GRUP G, BIRIM B, UST_BIRIM U 
WHERE U.UstBirimNo = B.UstBirimNo AND G.GrupNo = p_grupno AND G.BirimNo = B.BirimNo)
AND G.BirimNo = B.BirimNo ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `getDepNoForDekan_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `getDepNoForDekan_sp`(IN p_grupno CHAR(10))
BEGIN

SELECT G.GrupNo
FROM GRUP G, BIRIM B
WHERE B.UstBirimNo IN 
(SELECT U.UstBirimNo 
FROM GRUP G, BIRIM B, UST_BIRIM U 
WHERE U.UstBirimNo = B.UstBirimNo AND G.GrupNo = p_grupno AND G.BirimNo = B.BirimNo)
AND G.BirimNo = B.BirimNo ;

END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetExistingItemsAD_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetExistingItemsAD_sp`(IN departman_no CHAR(10) )
BEGIN
SELECT U.`UrunNo`,U.`UrunAdi` 
FROM `BIRIM_DEPO_URUN_MIKTAR` B, `URUN` U
WHERE `mevcut` > 0 AND B.`GrupNo` = departman_no 
AND U.`UrunNo`= B.`UrunNo`;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetExistingItemsGD_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetExistingItemsGD_sp`()
BEGIN
SELECT `GENEL_DEPO_URUN_MIKTAR`.`UrunNo`,`URUN`.`UrunAdi`
FROM GENEL_DEPO_URUN_MIKTAR
INNER JOIN `URUN`
ON `GENEL_DEPO_URUN_MIKTAR`.`UrunNo` = `URUN`.`UrunNo`
WHERE
Mevcut > 0;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetGdKalanID_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetGdKalanID_sp`(IN urun_no CHAR(10), OUT kalan INT)
BEGIN
SELECT `Mevcut`
FROM  GENEL_DEPO_URUN_MIKTAR
WHERE `UrunNo` = urun_no;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetGdKalan_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetGdKalan_sp`(IN urun_no CHAR(10))
BEGIN
SELECT `Mevcut`
FROM  `GENEL_DEPO_URUN_MIKTAR`
WHERE `UrunNo` = urun_no ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetGdLimit_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetGdLimit_sp`(IN urun_no CHAR(10))
BEGIN
SELECT `AltLimit` 
FROM `GENEL_DEPO_URUN_MIKTAR`
WHERE  `UrunNo` = urun_no ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetGroupName_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetGroupName_sp`(IN grNo CHAR(10))
BEGIN
SELECT `GrupAdi`
FROM GRUP
WHERE `GrupNo` = grNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `getGroupNoByBirimIsmi_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `getGroupNoByBirimIsmi_sp`(IN departman_adi VARCHAR(100))
select G.GrupNo
from GRUP G, BIRIM B
WHERE G.BirimNo = B.BirimNo and B.BirimAdi = departman_adi */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetGroups_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetGroups_sp`()
BEGIN
SELECT `GrupNo`,`GrupAdi`
FROM `GRUP` ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetGrupNo_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetGrupNo_sp`(IN grup_adi VARCHAR(150))
BEGIN
SELECT `GrupNo`
FROM `GRUP`
WHERE `GrupAdi` = grup_adi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetNextId_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetNextId_sp`(suffix CHAR(3), OUT Id CHAR(10))
BEGIN
     DECLARE EskiRef char(6);
     DECLARE dizi1 char(36) DEFAULT '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
     DECLARE i1,i2,i3,i4,i5,i6 INT;
     Set EskiRef = (SELECT T.NextSeed from SYS_ROW_ID  as T WHERE T.Suffix = suffix);
     set          i1 = LOCATE(SUBSTRING(EskiRef,1,1),dizi1),
	        	  i2 = LOCATE(SUBSTRING(EskiRef,2,1),dizi1),
		          i3 = LOCATE(SUBSTRING(EskiRef,3,1),dizi1),
	        	  i4 = LOCATE(SUBSTRING(EskiRef,4,1),dizi1),
		          i5 = LOCATE(SUBSTRING(EskiRef,5,1),dizi1),
	        	  i6 = LOCATE(SUBSTRING(EskiRef,6,1),dizi1);
		IF i6 < 36 THEN set i6 = i6 + 1;
		ELSE
		     set i6 = 1;
		     IF i5 < 36 THEN set i5 = i5 + 1;
		     ELSE
	        	   set i5 = 1;
                	   IF i4 < 36 THEN set i4 = i4 + 1;
			   ELSE
		        	set i4 = 1;
		                IF i3 < 36 THEN set i3 = i3 + 1;
	                        ELSE
	        	       	  set i3 = 1;
			                IF i2 < 36 THEN set i2 = i2 + 1;
		                        ELSE
	        		       	  set i2 = 1;
				                IF i1 < 36 THEN set i1 = i1 + 1;
		        	                ELSE
		        		       	    set i1 = 1;
	
			                        END IF;
	
		                        END IF;
	                        END IF;
				
	                     END IF;
		       END IF;
		  END IF;
		set id = CONCAT( SUBSTRING(dizi1, i1, 1) , SUBSTRING(dizi1, i2, 1) , SUBSTRING(dizi1, i3, 1) ,  SUBSTRING(dizi1, i4, 1) , SUBSTRING(dizi1, i5, 1) , SUBSTRING(dizi1, i6, 1)) ;
		UPDATE SYS_ROW_ID SET NextSeed = id WHERE SYS_ROW_ID.Suffix = suffix;
        set Id = CONCAT( EskiRef , '-' , suffix);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetNextIstekFisiSayac_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetNextIstekFisiSayac_sp`(suffix CHAR(10), OUT sayac CHAR(4))
BEGIN
     DECLARE EskiRef char(4);
     DECLARE dizi1 char(10) DEFAULT '0123456789';
     DECLARE i1,i2,i3,i4 INT;
     DECLARE id char(4);
     Set EskiRef = (SELECT T.NextSeed from ISTEK_FISI_SAYAC  as T WHERE T.Suffix = suffix);
     set          i1 = LOCATE(SUBSTRING(EskiRef,1,1),dizi1),
	        	  i2 = LOCATE(SUBSTRING(EskiRef,2,1),dizi1),
		          i3 = LOCATE(SUBSTRING(EskiRef,3,1),dizi1),
	        	  i4 = LOCATE(SUBSTRING(EskiRef,4,1),dizi1);
		IF i4 < 10 THEN set i4 = i4 + 1;
		ELSE
		     set i4 = 1;
		     IF i3 < 10 THEN set i3 = i3 + 1;
		     ELSE
		           set i3 = 1;
	        	   IF i2 < 10 THEN set i2 = i2 + 1;
		           ELSE
	        		       	  set i2 = 1;
				                IF i1 < 10 THEN set i1 = i1 + 1;
		        	                ELSE
		        		       	    set i1 = 1;	
		                        END IF;
                    END IF;
		       END IF;
         END IF;
		set id = CONCAT( SUBSTRING(dizi1, i1, 1) , SUBSTRING(dizi1, i2, 1) , SUBSTRING(dizi1, i3, 1) ,  SUBSTRING(dizi1, i4, 1) ) ;
		UPDATE ISTEK_FISI_SAYAC SET NextSeed = id WHERE ISTEK_FISI_SAYAC.Suffix = suffix;
        set sayac = EskiRef;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetUnits_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetUnits_sp`()
BEGIN
SELECT `BirimNo`, `BirimAdi` FROM `BIRIM` WHERE `UstBirimNo` IN (SELECT `IdariUstBirimNo` FROM `IDARI_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetUrunName_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetUrunName_sp`(IN purunNo char(10))
BEGIN
SELECT UrunAdi
	FROM URUN
	WHERE UrunNo = purunNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GetUrunNo_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GetUrunNo_sp`(IN purunadi VARCHAR(100))
SELECT `UrunNo` FROM URUN where `UrunAdi` = purunadi */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GrubaGoreKullaniciGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GrubaGoreKullaniciGoster_sp`(GrupNoIn CHAR(10))
BEGIN
SELECT
             KULLANICI.KullaniciNo
           , KULLANICI.KullaniciAdi
           , KULLANICI.KullaniciSifresi
           , KULLANICI.Ad
           , KULLANICI.Soyad
           , KULLANICI.Email
           , KULLANICI.TelNo
           , KULLANICI.SifreHatasi
           , KULLANICI.PozisyonNo
           , KULLANICI.GrupNo
FROM KULLANICI
WHERE KULLANICI.`GrupNo` = GrupNoIn
      AND KULLANICI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GrupEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GrupEkle_sp`(GrupAdiIn VARCHAR(150), GrupTipiIn CHAR(7), UstGrupNoIn CHAR(10))
BEGIN
  DECLARE D_ButceDagilimNo char(10); 
  DECLARE GrupNo     char(10);
  DECLARE BirimNo    char(10);
  DECLARE UstBirimNo char(10);
START TRANSACTION;
  IF (GrupTipiIn='Bolum')
     THEN
         SET UstBirimNo = (
             SELECT BIRIM.UstBirimNo
             FROM GRUP
                   JOIN
             BIRIM ON BIRIM.BirimNo = GRUP.BirimNo
             WHERE GRUP.GrupNo = UstGrupNoIn);
         call BirimEkle_sp(GrupAdiIn ,UstBirimNo,BirimNo);
  ELSEIF (GrupTipiIn='Fakulte')
     THEN
         call UstBirimEkle_sp(GrupAdiIn,UstBirimNo);
         call BirimEkle_sp(GrupAdiIn,UstBirimNo,BirimNo);
  ELSEIF (GrupTipiIn='Idari')
     THEN
         SET UstBirimNo = '000000-UBR';
         call BirimEkle_sp(GrupAdiIn ,UstBirimNo,BirimNo);
         
         call GetNextId_sp('BDG', D_ButceDagilimNo);
         INSERT INTO BUTCE_DAGILIM
         VALUES
         (D_ButceDagilimNo,'000000-FNK',BirimNo,'000000-AKL','000000-KRM',0,0,0,'1','1','1');
  ELSEIF (GrupTipiIn='Destek')
     THEN
         SET BirimNo = (
             SELECT GRUP.BirimNo
             FROM GRUP
             WHERE GRUP.GrupNo = UstGrupNoIn);
  END IF;
  call GetNextId_sp('GRP',GrupNo);
  INSERT INTO
        GRUP (GrupNo, GrupAdi, GrupTipi, BirimNo)
  VALUES
        (GrupNo, GrupAdiIn ,GrupTipiIn, BirimNo);
  INSERT INTO
         ISTEK_FISI_SAYAC(Suffix,NextSeed,Description)
  VALUES
        (GrupNo,'0000',CONCAT(GrupNo,' Nolu yeni acilan grup icin',' otomatik olarak olusturuldu'));
  SELECT GrupNo AS GrupNo , BirimNo AS BirimNo , UstBirimNo AS UstBirimNo;
  COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GrupGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GrupGoster_sp`(GrupNoIn CHAR(10))
BEGIN
  SELECT
	GRUP.*,
	BIRIM.BirimAdi,
	UST_BIRIM.UstBirimNo,
	UST_BIRIM.UstBirimAdi
  FROM
	GRUP
        LEFT JOIN
    BIRIM ON GRUP.BirimNo = BIRIM.BirimNo
        LEFT JOIN
    UST_BIRIM ON BIRIM.UstBirimNo = UST_BIRIM.UstBirimNo
    where GRUP.GrupNo LIKE CONCAT( '%' , COALESCE(GrupNoIn,'') , '%')
    AND GRUP.Statu = '1'
  ORDER BY GRUP.GrupAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GrupGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GrupGuncelle_sp`(GrupNoIn CHAR(10), YeniGrupAdiIn VARCHAR(150))
BEGIN
 UPDATE GRUP
 SET
   GRUP.GrupAdi = YeniGrupAdiIn
 WHERE
   GRUP.GrupNo = GrupNoIn
   AND GRUP.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `GrupSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `GrupSil_sp`(GrupAdiIn VARCHAR(50))
BEGIN
    UPDATE
         GRUP
    SET
         GRUP.Statu='0'
    WHERE
         GRUP.`GrupAdi` = GrupAdiIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleBeklenenMaliyetiGuncelleSat5_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleBeklenenMaliyetiGuncelleSat5_sp`(IhaleNoIn CHAR(10), IhaleBeklenenMaliyetIn DECIMAL(12,0))
BEGIN
UPDATE IHALE
 SET
   IHALE.`BeklenenMaliyet` = IhaleBeklenenMaliyetIn
 WHERE
   IHALE.`IhaleNo` = IhaleNoIn
   AND IHALE.`Statu` = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleEkle_sp`(IhaleAdiIn VARCHAR(50), SayfaNoIn CHAR(10), YatirimProjeNoIn VARCHAR(100), ButceTertibiIn VARCHAR(100), AvansSartlariIn VARCHAR(100), IhaleUsuluIn VARCHAR(100), IlanSekliAdediIn VARCHAR(100), OyidSatisBedeliIn VARCHAR(100), BakanlarKuruluKarariIn VARCHAR(100))
BEGIN
     DECLARE IhaleNoTemp char(10);
     call GetNextId_sp('IHL',IhaleNoTemp);
     INSERT INTO
            IHALE (IhaleNo, IhaleAdi,SayfaNo,YatirimProjeNo,ButceTertibi,  AvansSartlari,   IhaleUsulu,   IlanSekliAdedi,   OyidSatisBedeli,   BakanlarKuruluKarari ,Durum)
     VALUES
           (IhaleNoTemp,IhaleAdiIn,SayfaNoIn,YatirimProjeNoIn,ButceTertibiIn,  AvansSartlariIn,   IhaleUsuluIn,   IlanSekliAdediIn,   OyidSatisBedeliIn,   BakanlarKuruluKarariIn ,'1');
     SELECT IhaleNoTemp;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleGosterDurumaGore_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleGosterDurumaGore_sp`(IhaleDurumIn INTEGER(10))
BEGIN
     SELECT *
     FROM IHALE
     WHERE IHALE.Durum = IhaleDurumIn AND
           IHALE.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleGoster_sp`(IhaleNoIn VARCHAR(50))
BEGIN
SELECT *
FROM IHALE
WHERE IHALE.IhaleNo = IhaleNoIn
      AND IHALE.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleGuncelle_sp`(IhaleNoIn CHAR(10), IhaleTarihiIn DATE, IhaleKayitNoIn VARCHAR(50), IhaleUrunTipiIn VARCHAR(50), IhaleAltTipiIn VARCHAR(50), IhaleKazananTeklifNoIn CHAR(10), IhaleDurumIn INTEGER(10))
BEGIN
UPDATE IHALE
 SET
    IHALE.IhaleTarihi = IhaleTarihiIn,
    IHALE.IhaleKayitNo = IhaleKayitNoIn,
    IHALE.IhaleUrunTipi = IhaleUrunTipiIn,
    IHALE.IhaleAltTipi = IhaleAltTipiIn,
    IHALE.KazananTeklifNo = IhaleKazananTeklifNoIn,
    IHALE.Durum = IhaleDurumIn
 WHERE
   IHALE.`IhaleNo` = IhaleNoIn
   AND IHALE.`Statu` = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleTeklifVerenFirmalariGosterSat14_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleTeklifVerenFirmalariGosterSat14_sp`(FirmaAdiIn VARCHAR(50))
BEGIN
SELECT IHALE.IhaleAdi
     , IHALE.IhaleTarihi
     , IHALE.IhaleUrunTipi
     , IHALE.KazananTeklifNo
     , IHALE.IhaleNo
     , IHALE.IhaleKayitNo
  FROM IHALE
     , IHALE_TEKLIF
 WHERE IHALE_TEKLIF.FirmaAdi= FirmaAdiIn
   AND IHALE.IhaleNo=IHALE_TEKLIF.IhaleNo
   AND IHALE.Statu= '1'
   AND IHALE_TEKLIF.Statu= '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleTumFirmalar_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleTumFirmalar_sp`()
BEGIN
SELECT DISTINCT IHALE_TEKLIF.FirmaAdi
FROM IHALE_TEKLIF
WHERE IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IhaleyiKazananiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IhaleyiKazananiGoster_sp`(IhaleNoIn CHAR(10))
BEGIN
SELECT IHALE_TEKLIF.FirmaAdi,
       IHALE_TEKLIF.TeklifFiyati
FROM IHALE,IHALE_TEKLIF
WHERE IHALE.IhaleNo = IhaleNoIn AND
      IHALE.KazananTeklifNo = IHALE_TEKLIF.TeklifNo AND
      IHALE.Statu = '1' AND
      IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ImzaAnahtariBilgileriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ImzaAnahtariBilgileriniGoster_sp`(KullaniciNoIn CHAR(10))
BEGIN
     DECLARE D_OzelAnahtaKullaniyor CHAR(1);
     DECLARE D_AciklamaGoster CHAR(1);
     DECLARE D_Aktif CHAR(1);
     SELECT
           KULLANICI.OzelAnahtarKullaniyor,
           KULLANICI.AciklamaGoster
     INTO
         D_OzelAnahtaKullaniyor,
         D_AciklamaGoster
     FROM
         KULLANICI
     WHERE
          KULLANICI.KullaniciNo = KullaniciNoIn;
     IF (SELECT  MAX(Aktif) FROM KULLANICI_IMZA_ANAHTARI WHERE KULLANICI_IMZA_ANAHTARI.KullaniciNo = KullaniciNoIn) > 0
     THEN
         SELECT
           KULLANICI_IMZA_ANAHTARI.ImzaAnahtari,
           D_OzelAnahtaKullaniyor  AS OzelAnahtaKullaniyor,
           D_AciklamaGoster        AS AciklamaGoster
         FROM
             KULLANICI_IMZA_ANAHTARI
         WHERE
              KULLANICI_IMZA_ANAHTARI.KullaniciNo = KullaniciNoIn
              AND KULLANICI_IMZA_ANAHTARI.Aktif = '1';
     ELSE
         SELECT
           NULL                    AS ImzaAnahtari,
           D_OzelAnahtaKullaniyor  AS OzelAnahtaKullaniyor,
           D_AciklamaGoster        AS AciklamaGoster;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstegeUygunTeklifGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstegeUygunTeklifGoster_sp`(IstekNoIn CHAR(10))
BEGIN
SELECT *
FROM ISTEK_TEKLIF
WHERE ISTEK_TEKLIF.IstekNo = IstekNoIn
AND ISTEK_TEKLIF.Uygundur = '1'
AND ISTEK_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekAktar_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekAktar_sp`(IstekFisiNoIn CHAR(10), GrupNo CHAR(10), SayfaKodu VARCHAR(30), KullaniciNoIn CHAR(10), AciklamaIn TEXT, OnayIn ENUM('0','1'))
BEGIN
     DECLARE D_GrupNo CHAR(10);
     DECLARE D_SayfaNo CHAR(30);
     DECLARE D_GecmisNo CHAR(10);
     DECLARE D_SonrakiGecmisNo CHAR(10);
     DECLARE SayfaNoTemp CHAR(10);
     set SayfaNoTemp =  (select SAYFA.SayfaNo  FROM SAYFA  WHERE SAYFA.SayfaKodu = SayfaKodu);
     set D_GecmisNo  =  (select ISTEK_FISI.GecmisNo FROM ISTEK_FISI WHERE ISTEK_FISI.IstekFisiNo = IstekFisiNoIn);
     call GetNextId_sp('HTR',D_SonrakiGecmisNo);
     UPDATE
           ISTEK_FISI
     SET
        ISTEK_FISI.SayfaNo = SayfaNoTemp  ,
        ISTEK_FISI.GrupNo = GrupNo,
        ISTEK_FISI.GecmisNo = D_SonrakiGecmisNo
     WHERE
          ISTEK_FISI.IstekFisiNo = IstekFisiNoIn
     AND
        ISTEK_FISI.Statu = '1';
     INSERT INTO
     GECMIS
           (GecmisNo, Aciklama, IstekFisiNo, KullaniciNo, SayfaNo, GrupNo, OncekiGecmisNo, OlusturmaTarihi)
     VALUES
           (D_SonrakiGecmisNo, AciklamaIn, IstekFisiNoIn, KullaniciNoIn, SayfaNoTemp, GrupNo, D_GecmisNo, NOW());
     SELECT D_SonrakiGecmisNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekButceTahminiFiyatGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekButceTahminiFiyatGuncelle_sp`(IstekNoIn CHAR(10), ButceTahminiFiyatIn DECIMAL(11,2))
BEGIN
     DECLARE D_IstekFisiNo CHAR(10);
     DECLARE D_ButceDagilimNo CHAR(10);
     DECLARE D_ButceTahminiFiyat DECIMAL(11,2);
     DECLARE D_BlokeMiktar DECIMAL(11,2);
     SELECT
           ISTEK_FISI.IstekFisiNo,
           ISTEK.ButceTahminiFiyat
     INTO
           D_IstekFisiNo,
           D_ButceTahminiFiyat
     FROM
         ISTEK_FISI
             JOIN
         ISTEK  ON ISTEK.IstekFisiNo = ISTEK_FISI.IstekFisiNo
     WHERE
          ISTEK.IstekNo = IstekNoIn
          AND ISTEK.Statu = '1'
          AND ISTEK_FISI.Statu = '1';
     IF D_IstekFisiNo IS NOT NULL
     THEN
         UPDATE
               ISTEK
         SET
               ISTEK.ButceTahminiFiyat = ButceTahminiFiyatIn
         WHERE
               ISTEK.IstekNo = IstekNoIn
               AND ISTEK.Statu = '1';
         SELECT '1' AS result;
     ELSE
         SELECT '-1' AS result;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekEkle_sp`(IstekFisiNoIn CHAR(10), UrunNoIn CHAR(10), MiktarIn DECIMAL(11,0), TahminiFiyatIn DECIMAL(11,0), AciklamaIn TEXT)
BEGIN
     DECLARE IstekNo char(10);
     call GetNextId_sp('REQ',IstekNo);
     INSERT INTO
            ISTEK (IstekNo, IstekFisiNo, UrunNo, Miktar,TahminiFiyat,Aciklama)
     VALUES
           (IstekNo, IstekFisiNoIn, UrunNoIn, MiktarIn, TahminiFiyatIn, AciklamaIn) ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiBloke_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiBloke_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     DECLARE D_ButceTahminiFiyat CHAR(10);
     DECLARE D_ButceDagilimNo CHAR(10);
     SELECT
           SUM(ISTEK.ButceTahminiFiyat)
     INTO
         D_ButceTahminiFiyat
     FROM
         ISTEK
            JOIN
         ISTEK_FISI ON ISTEK_FISI.IstekFisiNo = ISTEK.IstekFisiNo
     WHERE
          ISTEK_FISI.IstekFisiNo = IstekFisiNoIn
          AND ISTEK_FISI.Statu = '1'
          AND ISTEK.Statu = '1';
     SELECT
           BUTCE_BLOKE.ButceDagilimNo
     INTO
           D_ButceDagilimNo
     FROM
           BUTCE_BLOKE
     WHERE
          BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn
          AND BUTCE_BLOKE.Statu = '1';
    CALL ButceBlokeKaldir_sp(IstekFisiNoIn);
    CALL ButceBlokeEkle_sp(IstekFisiNoIn, D_ButceDagilimNo, D_ButceTahminiFiyat);
    SELECT '-1' as result;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiEkle_sp`(IsteyenIn CHAR(10), DahiliIn CHAR(1), KalemNoIn CHAR(10), GrupNoIn CHAR(10), SayfaKoduIn VARCHAR(30), IstekFisiKoduIn CHAR(26), KullaniciNoIn CHAR(10))
BEGIN
    DECLARE sonrakiNo,sonrakiGecmisNo char(10);
    DECLARE FisinSayfaNosu char(10);
    DECLARE IstekFisiSayac char(4);
    DECLARE IstekFisiKoduSayacOut char(30);
    CALL GetNextId_sp('RFM',sonrakiNo);
    CALL GetNextId_sp('HTR',sonrakiGecmisNo);
    CALL GetNextIstekFisiSayac_sp(GrupNoIn,IstekFisiSayac);
    set FisinSayfaNosu = (SELECT SAYFA.SayfaNo FROM SAYFA WHERE SAYFA.SayfaKodu = SayfaKoduIn);
    set IstekFisiKoduSayacOut = CONCAT(IstekFisiKoduIn,IstekFisiSayac);
    INSERT INTO ISTEK_FISI
    (
        IstekFisiNo,
        Isteyen,
        Dahili,
        KalemNo,
        GrupNo,
        SayfaNo,
        GecmisNo,
        IstekFisiKodu,
        OlusturmaTarihi,
        Olusturan,
        isteyenGrupNo
    )

VALUES
    (
        sonrakiNo,
        IsteyenIn,
        DahiliIn,
        KalemNoIn,
        GrupNoIn,
        FisinSayfaNosu,
        sonrakiGecmisNo,
        IstekFisiKoduSayacOut,
        NOW(),
        KullaniciNoIn,
        GrupNoIn
    );
    INSERT INTO GECMIS
    (
        GecmisNo,
        IstekFisiNo,
        KullaniciNo,
        GrupNo,
        SayfaNo,
        OncekiGecmisNo,
        OlusturmaTarihi,
        Aciklama
    )

VALUES
    (
        sonrakiGecmisNo,
        sonrakiNo,
        KullaniciNoIn,
        GrupNoIn,
        FisinSayfaNosu,
        NULL,
        NOW(),
        'Istek fiþi olusturuldu.'
    );

    SELECT IstekFisiKoduSayacOut ,sonrakiNo, sonrakiGecmisNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
   SELECT
         ISTEK.*,
         ISTEK_FISI.*,
         URUN.UrunKodu,
         URUN.UrunAdi,
         KALEM.KalemAdi,
         KALEM.KalemKodu,
         ANA_KALEM.AnaKalemAdi,
         ANA_KALEM.AnaKalemKodu,
         ANA_KALEM.AnaKalemNo,
         SAYFA.SayfaKodu,
         SAYFA.SayfaAdi,
         GRUP.GrupAdi,
         BUTCE_BLOKE.Miktar AS ButceBlokeMiktar,
         BUTCE_DAGILIM.ButceDagilimNo,
         BUTCE_DAGILIM.DefaultButce,
         BUTCE_DAGILIM.KalanButce - BUTCE_DAGILIM.BlokeEdilmis AS MevcutTutar,
         KURUMSAL.KurumsalKod,
         KURUMSAL.KurumsalNo,
         KURUMSAL.Aciklama,
         FONKSIYONEL.FonksiyonelAdi,
         FONKSIYONEL.FonksiyonelKodu,
         FONKSIYONEL.FonksiyonelNo
     FROM
         ISTEK_FISI
             JOIN
         ISTEK  ON ISTEK_FISI.IstekFisiNo = ISTEK.IstekFisiNo
             JOIN
         URUN ON URUN.UrunNo = ISTEK.UrunNo
             JOIN
         KALEM ON KALEM.KalemNo = ISTEK_FISI.KalemNo
             JOIN
         ANA_KALEM ON KALEM.AnaKalemNo = ANA_KALEM.AnaKalemNo
             JOIN
         SAYFA ON SAYFA.SayfaNo = ISTEK_FISI.SayfaNo
             JOIN
         GRUP ON GRUP.GrupNo = ISTEK_FISI.GrupNo
             LEFT JOIN
         BUTCE_BLOKE ON BUTCE_BLOKE.IstekFisiNo = ISTEK_FISI.IstekFisiNo AND BUTCE_BLOKE.Statu = '1'
             LEFT JOIN
         BUTCE_DAGILIM ON BUTCE_DAGILIM.ButceDagilimNo = BUTCE_BLOKE.ButceDagilimNo
             LEFT JOIN
         FONKSIYONEL ON FONKSIYONEL.FonksiyonelNo = BUTCE_DAGILIM.FonksiyonelNo
             LEFT JOIN
         KURUMSAL ON KURUMSAL.KurumsalNo = BUTCE_DAGILIM.KurumsalNo
     WHERE
         ISTEK_FISI.IstekFisiNo = IstekFisiNoIn
         AND ISTEK_FISI.Statu = '1'
         AND SAYFA.SayfaAmaci = '0' 
         AND ISTEK.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiImzaEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiImzaEkle_sp`(KullaniciNoIn CHAR(10), IstekFisiNoIn CHAR(10), ImzaTarihiIn BIGINT, ImzaFormatiIn CHAR(100), ImzaIn CHAR(100), GecmisNoIn CHAR(10))
BEGIN
DECLARE IstekFisiImzaNo char(10);
  call GetNextId_sp('IFI',IstekFisiImzaNo);
  INSERT INTO
            `ISTEK_FISI_IMZA` (IstekFisiImzaNo, KullaniciNo, IstekFisiNo, ImzaTarihi, ImzaFormati, Imza , GecmisNo)
  VALUES
           (IstekFisiImzaNo, KullaniciNoIn, IstekFisiNoIn, ImzaTarihiIn, ImzaFormatiIn, ImzaIn,GecmisNoIn);
  SELECT IstekFisiImzaNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiImzaGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiImzaGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
SELECT *
FROM ISTEK_FISI_IMZA
WHERE ISTEK_FISI_IMZA.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiIstekleriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiIstekleriGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
SELECT *
FROM ISTEK
WHERE ISTEK.IstekFisiNo = IstekFisiNoIn
AND ISTEK.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisinButceDagiliminiDegistir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisinButceDagiliminiDegistir_sp`(ButceDagilimNoIn CHAR(10), IstekFisiNoIn CHAR(10), MiktarIn DECIMAL(11,2))
BEGIN
     
     DECLARE D_ButceBlokeNo   CHAR(10);
     DECLARE D_ButceDagilimNo CHAR(10);
     DECLARE D_DefaultButce   CHAR(10);
     IF EXISTS (SELECT * FROM BUTCE_DAGILIM WHERE BUTCE_DAGILIM.ButceDagilimNo = ButceDagilimNoIn)
     THEN
         SELECT
               BUTCE_BLOKE.ButceBlokeNo,
               BUTCE_DAGILIM.ButceDagilimNo,
               BUTCE_DAGILIM.DefaultButce
         INTO
             D_ButceBlokeNo,
             D_ButceDagilimNo,
             D_DefaultButce
         FROM
             BUTCE_DAGILIM
                 JOIN
             BUTCE_BLOKE  ON BUTCE_BLOKE.ButceDagilimNo = BUTCE_DAGILIM.ButceDagilimNo
         WHERE
              BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn
              AND BUTCE_BLOKE.Statu = '1';
         IF D_ButceDagilimNo IS NOT NULL
         THEN
             CALL ButceBlokeKaldir_sp(IstekFisiNoIn);
             CALL ButceBlokeEkle_sp(IstekFisiNoIn, ButceDagilimNoIn, MiktarIn);
             SELECT '1' AS result;
         ELSE
             SELECT '-1' AS result;
         END IF;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisineGercekFiyatEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisineGercekFiyatEkle_sp`(IstekFisiNoIn CHAR(10), GercekFiyatIn DECIMAL(11,2))
BEGIN
     UPDATE ISTEK_FISI
     SET ISTEK_FISI.GercekFiyat = GercekFiyatIn
     WHERE ISTEK_FISI.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisininOlasiButceleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisininOlasiButceleriniGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
    SELECT
           BUTCE_DAGILIM.ButceDagilimNo,
           KURUMSAL.KurumsalKod,
           KURUMSAL.KurumsalNo,
           KURUMSAL.Aciklama,
           FONKSIYONEL.FonksiyonelKodu,
           FONKSIYONEL.FonksiyonelAdi,
           FONKSIYONEL.FonksiyonelNo,
           FONKSIYONEL.Aciklama,
           BUTCE_DAGILIM.KalanButce - BUTCE_DAGILIM.BlokeEdilmis AS MevcutTutar,
           BUTCE_DAGILIM.BlokeEdilmis                            AS BlokeliTutar
     FROM
         ISTEK_FISI
             JOIN
         KULLANICI ON KULLANICI.KullaniciNo = ISTEK_FISI.Olusturan
             JOIN
         GRUP ON GRUP.GrupNo = KULLANICI.GrupNo
             JOIN
         KALEM ON KALEM.KalemNo = ISTEK_FISI.KalemNo
             JOIN
         BUTCE_DAGILIM ON BUTCE_DAGILIM.AnaKalemNo = KALEM.AnaKalemNo AND BUTCE_DAGILIM.BirimNo = GRUP.BirimNo
             JOIN
         KURUMSAL    ON KURUMSAL.KurumsalNo = BUTCE_DAGILIM.KurumsalNo
             JOIN
         FONKSIYONEL ON FONKSIYONEL.FonksiyonelNo = BUTCE_DAGILIM.FonksiyonelNo
     WHERE
         ISTEK_FISI.IstekFisiNo = IstekFisiNoIn
         AND BUTCE_DAGILIM.Statu = '1'
         AND BUTCE_DAGILIM.ButceAtanmis = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiNoButceBlokeGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiNoButceBlokeGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
SELECT *
FROM BUTCE_BLOKE
WHERE BUTCE_BLOKE.IstekFisiNo = IstekFisiNoIn
AND BUTCE_BLOKE.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiOlusturaniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiOlusturaniGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     SELECT KULLANICI.*
     FROM ISTEK_FISI,KULLANICI
     WHERE ISTEK_FISI.IstekFisiNo=IstekFisiNoIn
           AND ISTEK_FISI.Olusturan=KULLANICI.KullaniciNo
           AND ISTEK_FISI.Statu='1'
           AND KULLANICI.Statu='1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiPiyasaFiyatiGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiPiyasaFiyatiGuncelle_sp`(IstekFisiNoIn CHAR(10), PiyasaFiyatiIn DECIMAL(11,2))
BEGIN
     UPDATE ISTEK_FISI
     SET ISTEK_FISI.PiyasaFiyati = PiyasaFiyatiIn
     WHERE ISTEK_FISI.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiSil_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     UPDATE
           ISTEK_FISI
     SET
           ISTEK_FISI.Statu = '0'
     WHERE
           ISTEK_FISI.IstekFisiNo = IstekFisiNoIn;
     UPDATE
           ISTEK
     SET
           ISTEK.Statu = '0'
     WHERE
           ISTEK.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekFisiTamamla_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekFisiTamamla_sp`(IstekFisiNoIn CHAR(10), GrupNo CHAR(10), SayfaKodu VARCHAR(30), KullaniciNoIn CHAR(10), OnayIn ENUM('0','1'))
BEGIN
     CALL IstekAktar_sp(IstekFisiNoIn, GrupNo, SayfaKodu, KullaniciNoIn,'istek fisi tamamlandi.', OnayIn);
     UPDATE
          ISTEK_FISI
     SET
          ISTEK_FISI.Statu = '2'
     WHERE
          ISTEK_FISI.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekGosterIstekFisineGore_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekGosterIstekFisineGore_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     SELECT *
     FROM ISTEK, ISTEK_FISI
     WHERE ISTEK.IstekFisiNo = IstekFisiNoIn AND
           ISTEK.IstekFisiNo = ISTEK_FISI.IstekFisiNo AND
           ISTEK_FISI.Statu = '1' AND
           ISTEK.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekTeklifEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekTeklifEkle_sp`(IstekNoIn CHAR(10), FirmaAdiIn VARCHAR(50), FirmaTelIn VARCHAR(14), FirmaAdresIn VARCHAR(100), FirmaTanimiIn VARCHAR(100), TeklifFiyatiIn DECIMAL(11,2))
BEGIN
     DECLARE IstekTeklifNo char(10);
     call GetNextId_sp('ITK',IstekTeklifNo);
     INSERT INTO
            ISTEK_TEKLIF ( IstekTeklifNo, IstekNo, FirmaAdi, FirmaTel, FirmaAdres,
            FirmaTanimi, TeklifFiyati)
     VALUES
           (IstekTeklifNo, IstekNoIn, FirmaAdiIn, FirmaTelIn, FirmaAdresIn,
            FirmaTanimiIn, TeklifFiyatiIn) ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekTeklifGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekTeklifGuncelle_sp`(IstekTeklifNoIn CHAR(10), FirmaAdiIn VARCHAR(50), FirmaAdresIn VARCHAR(100), FirmaTanimiIn VARCHAR(100), FirmaTelIn VARCHAR(14), IstekNoIn CHAR(10), TeklifFiyatiIn DECIMAL(11,2), UygundurIn INTEGER(2))
BEGIN
 UPDATE ISTEK_TEKLIF
 SET
   ISTEK_TEKLIF.FirmaAdi = FirmaAdiIn,
   ISTEK_TEKLIF.FirmaAdres = FirmaAdresIn,
   ISTEK_TEKLIF.FirmaTanimi = FirmaTanimiIn,
   ISTEK_TEKLIF.FirmaTel = FirmaTelIn,
   ISTEK_TEKLIF.IstekNo = IstekNoIn,
   ISTEK_TEKLIF.TeklifFiyati = TeklifFiyatiIn,
   ISTEK_TEKLIF.Uygundur = UygundurIn
 WHERE
   ISTEK_TEKLIF.IstekTeklifNo = IstekTeklifNoIn
   AND ISTEK_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekTeklifleriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekTeklifleriGoster_sp`(IstekNoIn CHAR(10))
BEGIN
SELECT *
FROM ISTEK_TEKLIF
WHERE ISTEK_TEKLIF.IstekNo = IstekNoIn
AND ISTEK_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `IstekTeklifSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `IstekTeklifSil_sp`(IstekTeklifNoIn CHAR(10))
BEGIN
 UPDATE ISTEK_TEKLIF
 SET
   ISTEK_TEKLIF.Statu = '0'
 WHERE
   ISTEK_TEKLIF.IstekTeklifNo = IstekTeklifNoIn
   AND ISTEK_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KalemEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KalemEkle_sp`(KalemAdiIn VARCHAR(80), KalemKoduIn CHAR(10), AnaKalemNoIn CHAR(10))
BEGIN
     DECLARE KalemNo char(10);
     call GetNextId_sp('ITC',KalemNo);
     INSERT INTO
            KALEM (KalemNo, KalemAdi, KalemKodu,AnaKalemNo)
     VALUES
           (KalemNo, KalemAdiIn, KalemKoduIn,AnaKalemNoIn) ;
     SELECT KalemNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KalemGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KalemGoster_sp`(KalemNoIn CHAR(10))
BEGIN
  SELECT
      KALEM.*,
      ANA_KALEM.AnaKalemAdi,
      ANA_KALEM.AnaKalemKodu
  FROM
      KALEM
           JOIN
      ANA_KALEM ON KALEM.AnaKalemNo = ANA_KALEM.AnaKalemNo
  WHERE
      KALEM.KalemNo LIKE CONCAT( '%' , COALESCE(KalemNoIn,'') , '%')
      AND KALEM.Statu = '1'
  ORDER BY KALEM.KalemAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KalemGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KalemGuncelle_sp`(KalemNoIn CHAR(10), KalemAdiIn VARCHAR(20), KalemKoduIn CHAR(10))
BEGIN
     UPDATE KALEM
     SET
        KalemAdi = KalemAdiIn,
        KalemKodu = KalemKoduIn
     WHERE
        KalemNo = KalemNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KalemNoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KalemNoGoster_sp`(KalemAdiIn VARCHAR(80))
BEGIN
     SELECT KALEM.KalemNo
     FROM KALEM
     WHERE KALEM.KalemAdi=KalemAdiIn
           AND KALEM.Statu='1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KalemSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KalemSil_sp`(KalemNoIn CHAR(10))
BEGIN
     UPDATE
           KALEM
     SET
           KALEM.Statu = '0'
     WHERE
           KALEM.KalemNo = KalemNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KalemUrunleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KalemUrunleriniGoster_sp`(KalemNo CHAR(10))
BEGIN
     SELECT
         *
     FROM
         URUN
     WHERE
          URUN.KalemNo = KalemNo
          AND URUN.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciAdaGoreBilgiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciAdaGoreBilgiGoster_sp`(KullaniciAdiIn VARCHAR(20), KullaniciStatu ENUM('Canli','Hepsi'))
BEGIN
 SELECT
             KULLANICI.KullaniciNo
           , KULLANICI.KullaniciAdi
           , KULLANICI.KullaniciSifresi
           , KULLANICI.Ad
           , KULLANICI.Soyad
           , KULLANICI.Email
           , KULLANICI.TelNo
           , KULLANICI.SifreHatasi
           , KULLANICI.PozisyonNo
           , KULLANICI.GrupNo
        FROM
             KULLANICI
        WHERE
             KULLANICI.KullaniciAdi = KullaniciAdiIn
             AND (KULLANICI.Statu = '1' OR (KULLANICI.Statu = '0' AND KullaniciStatu = 'Hepsi'));
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciBilgileriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciBilgileriniGoster_sp`(KullaniciNoIn CHAR(10))
BEGIN
     SELECT
	 *
     FROM
         KULLANICI,
         GRUP,
         POZISYON
     WHERE
          KULLANICI.GrupNo 		= GRUP.GrupNo
          AND KULLANICI.PozisyonNo 	= POZISYON.PozisyonNo
          AND KULLANICI.Statu 	= '1'
          AND GRUP.Statu 	= '1'
          AND POZISYON.Statu 	= '1'
	  	  AND KULLANICI.KullaniciNo LIKE CONCAT( '%' , COALESCE(KullaniciNoIn,'') , '%')
      ORDER BY KULLANICI.KullaniciAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciEkle_sp`(KullaniciAdiIn CHAR(10), KullaniciSifresiIn VARCHAR(20), AdIn VARCHAR(20), SoyadIn VARCHAR(20), EmailIn VARCHAR(30), TelNoIn VARCHAR(20), PozisyonNoIn CHAR(10), GrupNoIn CHAR(10))
BEGIN
   DECLARE KullaniciNoSonraki CHAR(10);
   IF NOT EXISTS (SELECT * FROM KULLANICI WHERE KULLANICI.KullaniciAdi = KullaniciAdiIn)
   THEN
     CALL GetNextId_sp('USR',KullaniciNoSonraki);
     INSERT INTO
            KULLANICI
                (KullaniciNo
                ,KullaniciAdi
                ,KullaniciSifresi
                ,Ad
                ,Soyad
                ,Email
                ,TelNo
                ,SifreHatasi
                ,PozisyonNo
                ,GrupNo
                )
     VALUES
                (KullaniciNoSonraki
                ,KullaniciAdiIn
                ,KullaniciSifresiIn
                ,AdIn
                ,SoyadIn
                ,EmailIn
                ,TelNoIn
                ,0
                ,PozisyonNoIn
                ,GrupNoIn
                );
     INSERT INTO KULLANICI_SAYFA_YETKISI_MN
            (KULLANICI_SAYFA_YETKISI_MN.KullaniciNo,KULLANICI_SAYFA_YETKISI_MN.SayfaNo)
            SELECT
                  KullaniciNoSonraki AS KullaniciNo,
                  POZISYON_SAYFA_YETKISI_MN.SayfaNo
            FROM
                POZISYON_SAYFA_YETKISI_MN
            WHERE
                 POZISYON_SAYFA_YETKISI_MN.PozisyonNo = PozisyonNoIn
                 AND POZISYON_SAYFA_YETKISI_MN.Statu = '1';
    SELECT KullaniciNoSonraki AS KullaniciNo;
  ELSE
    SELECT '-1' AS KullaniciNo;
  END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciGiris_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciGiris_sp`(KullaniciNameIn VARCHAR(20), KullaniciSifresiIn VARCHAR(20))
BEGIN
     DECLARE KullaniciNoOut       char(10);
     DECLARE TempKullaniciSifresi varchar(20);
     DECLARE GrupNoOut            char(10);
     DECLARE PozisyonNoOut        char(10);
     DECLARE SifreHatasiOut       int(11);
     SELECT
       KULLANICI.KullaniciNo,
       KULLANICI.KullaniciSifresi,
       KULLANICI.GrupNo,
       KULLANICI.PozisyonNo,
       KULLANICI.SifreHatasi
     INTO
       KullaniciNoOut,
       TempKullaniciSifresi,
       GrupNoOut,
       PozisyonNoOut,
       SifreHatasiOut
     FROM
       KULLANICI
     WHERE
        KULLANICI.KullaniciAdi = KullaniciNameIn
        AND KULLANICI.Statu = '1';
     IF (KullaniciNoOut IS NOT NULL)
     THEN
        IF (TempKullaniciSifresi = KullaniciSifresiIn)
        THEN
            IF SifreHatasiOut < 3
            THEN
                UPDATE
                   KULLANICI
                SET
                   KULLANICI.SifreHatasi = 0
                WHERE
                   KULLANICI.KullaniciNo = KullaniciNoOut;
            END IF;
            SELECT
                  KullaniciNoOut AS KullaniciNo,
                  GrupNoOut      AS GrupNo,
                  PozisyonNoOut  AS PozisyonNo,
                  SifreHatasiOut AS SifreHatasi;
     ELSE
         UPDATE KULLANICI
         SET
            KULLANICI.SifreHatasi = SifreHatasiOut +1
         where KULLANICI.KullaniciNo = KullaniciNoOut;
         SELECT
               NULL           AS KullaniciNo,
               NULL           AS GrupNo,
               NULL           AS PozisyonNo,
               NULL           AS SifreHatasi;
     END IF;
     ELSE
         SELECT
               NULL           AS KullaniciNo,
               NULL           AS GrupNo,
               NULL           AS PozisyonNo,
               NULL           AS SifreHatasi;
     END IF;
     COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciGoster_sp`(KullaniciNoIn CHAR(10))
BEGIN
      SELECT
             KULLANICI.KullaniciNo
           , KULLANICI.KullaniciAdi
           , KULLANICI.KullaniciSifresi
           , KULLANICI.Ad
           , KULLANICI.Soyad
           , KULLANICI.Email
           , KULLANICI.TelNo
           , KULLANICI.SifreHatasi
           , KULLANICI.PozisyonNo
           , KULLANICI.GrupNo
           , KULLANICI.IpAdresi
        FROM
             KULLANICI
        WHERE
             KULLANICI.KullaniciNo LIKE CONCAT( '%' , COALESCE(KullaniciNoIn,'') , '%')
             AND KULLANICI.Statu = '1'
             ORDER BY KULLANICI.KullaniciAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciGuncelle_sp`(KullaniciNoIn CHAR(10), GrupNoIn CHAR(10), PozisyonNoIn CHAR(10), AdIn VARCHAR(20), SoyadIn VARCHAR(20), EmailIn VARCHAR(30), TelNoIn VARCHAR(20))
BEGIN
 UPDATE KULLANICI
 SET
   KULLANICI.Ad  = AdIn,
   KULLANICI.Soyad   = SoyadIn,
   KULLANICI.Email      = EmailIn,
   KULLANICI.TelNo 	   = TelNoIn,
   KULLANICI.PozisyonNo = PozisyonNoIn,
   KULLANICI.GrupNo    = GrupNoIn
 WHERE
   KULLANICI.KullaniciNo     = KullaniciNoIn
   AND KULLANICI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciImzaAnahtariEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciImzaAnahtariEkle_sp`(ImzaAnahtariIn TEXT, KullaniciNoIn CHAR(10), AcildigiTarihIn BIGINT)
BEGIN
      UPDATE KULLANICI_IMZA_ANAHTARI
         SET KULLANICI_IMZA_ANAHTARI.Aktif='0'
           , KULLANICI_IMZA_ANAHTARI.KaldirildigiTarih=AcildigiTarihIn
       WHERE KULLANICI_IMZA_ANAHTARI.KullaniciNo=KullaniciNoIn
         AND KULLANICI_IMZA_ANAHTARI.Aktif='1';
     COMMIT;
     UPDATE KULLANICI
     SET KULLANICI.OzelAnahtarKullaniyor='1'
     WHERE KULLANICI.KullaniciNo=KullaniciNoIn;
     INSERT INTO
            KULLANICI_IMZA_ANAHTARI
                (ImzaAnahtari
                ,KullaniciNo
                ,AcildigiTarih
                )
     VALUES
                (ImzaAnahtariIn
                ,KullaniciNoIn
                ,AcildigiTarihIn
                );
     COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciImzaAnahtariGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciImzaAnahtariGoster_sp`(KullaniciNoIn CHAR(10), ImzaAnahtariTarihi BIGINT)
BEGIN
  DECLARE ANAHTAR TEXT;
  SELECT KULLANICI_IMZA_ANAHTARI.ImzaAnahtari
  INTO   ANAHTAR
  FROM KULLANICI_IMZA_ANAHTARI
  WHERE
	KULLANICI_IMZA_ANAHTARI.KullaniciNo = KullaniciNoIn AND
	KULLANICI_IMZA_ANAHTARI.AcildigiTarih <= ImzaAnahtariTarihi AND
	(KULLANICI_IMZA_ANAHTARI.KaldirildigiTarih >= ImzaAnahtariTarihi OR KULLANICI_IMZA_ANAHTARI.KaldirildigiTarih IS NULL);
	IF(ANAHTAR IS NOT NULL) THEN
	  SELECT ANAHTAR;
	ELSE
	  SELECT NULL AS ANAHTAR;
	END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciImzaAnahtariKaldir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciImzaAnahtariKaldir_sp`(KullaniciNoIn CHAR(10), KaldirildigiTarihIn BIGINT)
BEGIN
     UPDATE
           KULLANICI_IMZA_ANAHTARI
     SET
           Aktif = '0',
           KaldirildigiTarih = KaldirildigiTarihIn
     WHERE
           KullaniciNo = KullaniciNoIn
           AND KaldirildigiTarih IS NULL;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciIpAdresiPasif_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciIpAdresiPasif_sp`(KullaniciNoIn CHAR(10))
BEGIN
     UPDATE
           KULLANICI
     SEt
           KULLANICI.IpAdresi= NULL
     WHERE
           KULLANICI.KullaniciNo = KullaniciNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciIpAdresKontrol_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciIpAdresKontrol_sp`(IpAdresiIn VARCHAR(15))
BEGIN
    IF EXISTS (SELECT KULLANICI.IpAdresi
                      FROM KULLANICI
                      WHERE KULLANICI.IpAdresi=IpAdresiIn)
    THEN
         SELECT 1 result;
    ELSE
         SELECT 0 result;
    END IF ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciIpGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciIpGuncelle_sp`(KullaniciNoIn CHAR(10), IpAdresiIn VARCHAR(15))
BEGIN
     UPDATE
           KULLANICI
     SET
           KULLANICI.IpAdresi=IpAdresiIn
     WHERE
           KULLANICI.KullaniciNo=KullaniciNoIn
           AND KULLANICI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciIstekFisi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciIstekFisi_sp`(KullaniciNoIn CHAR(10))
BEGIN
   SELECT
            ISTEK_FISI.IstekFisiNo
          , ISTEK_FISI.Isteyen
          , ISTEK_FISI.KalemNo
          , KALEM.KalemKodu
          , KALEM.KalemAdi
          , ISTEK_FISI.SayfaNo
          , SAYFA.SayfaKodu
          , SAYFA.SayfaAdi
          , ISTEK_FISI.IstekFisiKodu
          , ISTEK_FISI.OlusturmaTarihi
          , ISTEK_FISI.Olusturan
          , CREATER.Ad
          , CREATER.Soyad
       FROM KULLANICI
          , ISTEK_FISI
          , KULLANICI_SAYFA_YETKISI_MN
          , KALEM
          , SAYFA
          , KULLANICI AS CREATER
      WHERE KULLANICI.KullaniciNo = KullaniciNoIn
        AND KULLANICI.GrupNo = ISTEK_FISI.GrupNo
        AND KULLANICI.KullaniciNo = KULLANICI_SAYFA_YETKISI_MN.KullaniciNo
        AND KULLANICI_SAYFA_YETKISI_MN.SayfaNo = ISTEK_FISI.SayfaNo
        AND SAYFA.SayfaNo = KULLANICI_SAYFA_YETKISI_MN.SayfaNo
        AND KALEM.KalemNo = ISTEK_FISI.KalemNo
        AND CREATER.KullaniciNo = ISTEK_FISI.Olusturan
        AND KULLANICI.Statu = '1'
        AND ISTEK_FISI.Statu = '1'
        AND KULLANICI_SAYFA_YETKISI_MN.Statu = '1'
        AND KALEM.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciIstekTakip_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciIstekTakip_sp`(KullaniciNoIn CHAR(10))
BEGIN
SELECT ISTEK_FISI.*
FROM   ISTEK_FISI
WHERE  ISTEK_FISI.Olusturan=KullaniciNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciSayfalariGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciSayfalariGoster_sp`(KullaniciNoIn CHAR(10))
BEGIN
     SELECT
         KULLANICI_SAYFA_YETKISI_MN.SayfaNo, SAYFA.SayfaAdi
     FROM KULLANICI_SAYFA_YETKISI_MN, SAYFA
     WHERE
          KULLANICI_SAYFA_YETKISI_MN.KullaniciNo=KullaniciNoIn
          AND KULLANICI_SAYFA_YETKISI_MN.SayfaNo=SAYFA.SayfaNo
          AND KULLANICI_SAYFA_YETKISI_MN.Statu='1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciSifreGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciSifreGuncelle_sp`(KullaniciNoIn CHAR(10), YeniSifreIn VARCHAR(20))
BEGIN
     UPDATE KULLANICI
     SET KULLANICI.KullaniciSifresi = YeniSifreIn
     WHERE KULLANICI.KullaniciNo = KullaniciNoIn
           AND KULLANICI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciSil_sp`(KullaniciNoIn CHAR(10))
BEGIN
     UPDATE
        KULLANICI
     SET
        KULLANICI.Statu = '0'
     WHERE
        KULLANICI.KullaniciNo = KullaniciNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciYetkileriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciYetkileriniGoster_sp`(KullaniciNoIn CHAR(10), PozisyonNoIn CHAR(10))
BEGIN
    SELECT
    DISTINCT SAYFA.SayfaNo,
    SAYFA.SayfaAdi,
    SAYFA.SayfaKodu,
    SAYFA.SayfaAmaci
    FROM
        KULLANICI,
        SAYFA,
        KULLANICI_SAYFA_YETKISI_MN,
        POZISYON_SAYFA_YETKISI_MN
    WHERE
         KULLANICI.KullaniciNo     = KULLANICI_SAYFA_YETKISI_MN.KullaniciNo
         AND POZISYON_SAYFA_YETKISI_MN.PozisyonNo = KULLANICI.PozisyonNo
         AND (POZISYON_SAYFA_YETKISI_MN.SayfaNo = SAYFA.SayfaNo
         OR KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SAYFA.SayfaNo)
         AND KULLANICI.Statu     = '1'
         AND SAYFA.Statu     = '1'
         AND KULLANICI.KullaniciNo LIKE CONCAT( '%' ,
COALESCE(KullaniciNoIn,'') , '%')
         AND KULLANICI.PozisyonNo LIKE CONCAT( '%' ,
COALESCE(PozisyonNoIn,'') , '%')
    ORDER BY SAYFA.SayfaAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciYetkileriniSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciYetkileriniSil_sp`(KullaniciNoIn CHAR(10))
BEGIN
     UPDATE KULLANICI_SAYFA_YETKISI_MN
     SET KULLANICI_SAYFA_YETKISI_MN.Statu = '0'
     WHERE KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciYetkisiEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciYetkisiEkle_sp`(KullaniciNoIn CHAR(10), SayfaNoIn CHAR(10))
    COMMENT 'Kullanıcıya sayfa yetkisi veriyor.'
BEGIN
     DECLARE SayfaNoTemp    CHAR(10);
     SET SayfaNoTemp =
         (
           SELECT SAYFA.SayfaNo
           FROM SAYFA
           WHERE SAYFA.SayfaNo = SayfaNoIn
         );
     IF SayfaNoTemp IS NULL
     THEN
         SELECT 0;
     ELSE
        IF EXISTS(SELECT * from KULLANICI_SAYFA_YETKISI_MN where KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SayfaNoTemp AND KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn)
        THEN
           UPDATE KULLANICI_SAYFA_YETKISI_MN
           SET KULLANICI_SAYFA_YETKISI_MN.Statu = '1'
           WHERE KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SayfaNoTemp
           AND KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn;
          SELECT 1;
        ELSE
          INSERT INTO KULLANICI_SAYFA_YETKISI_MN
          (
             KULLANICI_SAYFA_YETKISI_MN.KullaniciNo,
             KULLANICI_SAYFA_YETKISI_MN.SayfaNo
          )
          VALUES
          (
             KullaniciNoIn,
             SayfaNoTemp
          );
          SELECT 1;
        END IF;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciYetkisiKaldir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciYetkisiKaldir_sp`(KullaniciNoIn CHAR(10), SayfaKoduIn VARCHAR(50))
    COMMENT 'Kulanıcının sayfaya yetkisini kısıtlıyor'
BEGIN
     DECLARE SayfaNoTemp    CHAR(10);
     SET SayfaNoTemp =
         (
           SELECT SAYFA.SayfaNo
           FROM SAYFA
           WHERE SAYFA.SayfaKodu = SayfaKoduIn
         );
     IF SayfaNoTemp IS NULL
     THEN
         SELECT -1;
     ELSE
        IF EXISTS(SELECT * from KULLANICI_SAYFA_YETKISI_MN where KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SayfaNoTemp AND KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn AND KULLANICI_SAYFA_YETKISI_MN.Statu = '1')
        THEN
           UPDATE KULLANICI_SAYFA_YETKISI_MN
           SET KULLANICI_SAYFA_YETKISI_MN.Statu = '0'
           WHERE KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SayfaNoTemp
           AND KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn;
          SELECT 1;
        ELSE
          SELECT 0;
        END IF;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KullaniciYetkisiOlmayanSayfalariGoster` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KullaniciYetkisiOlmayanSayfalariGoster`(KullaniciNoIn CHAR(10))
BEGIN
     SELECT
           SAYFA.*
     FROM
         SAYFA
     WHERE
          NOT EXISTS (
              SELECT DISTINCT
                  KULLANICI_SAYFA_YETKISI_MN.SayfaNo
              FROM
                  KULLANICI_SAYFA_YETKISI_MN
              WHERE
                   KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SAYFA.SayfaNo
                   AND KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn
                   AND KULLANICI_SAYFA_YETKISI_MN.Statu = '1'
          )
     ORDER BY SAYFA.SayfaKodu;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KurumsalEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KurumsalEkle_sp`(KurumsalKodIn VARCHAR(20), AciklamaIn CHAR(30))
BEGIN
DECLARE KurumsalNo char(10);
  call GetNextId_sp('KRM',KurumsalNo);
  INSERT INTO
            KURUMSAL (KurumsalNo, KurumsalKod, Aciklama)
  VALUES
           (KurumsalNo, KurumsalKodIn , AciklamaIn);
  SELECT KurumsalNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KurumsalGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KurumsalGoster_sp`(KurumsalNoIn CHAR(10))
BEGIN
     SELECT
         KURUMSAL.*
     FROM
         KURUMSAL
     WHERE
         KURUMSAL.KurumsalNo LIKE CONCAT( '%' , COALESCE(KurumsalNoIn,'') , '%')
         AND KURUMSAL.Statu = '1'
     ORDER BY KURUMSAL.KurumsalKod;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KurumsalGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KurumsalGuncelle_sp`(KurumsalNoIn CHAR(10), KurumsalKodIn VARCHAR(20), AciklamaIn CHAR(30))
BEGIN
  UPDATE KURUMSAL
  SET    KURUMSAL.KurumsalKod = KurumsalKodIn
        ,KURUMSAL.Aciklama    = AciklamaIn
  WHERE  KURUMSAL.KurumsalNo  = KurumsalNoIn;
  COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `KurumsalSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `KurumsalSil_sp`(KurumsalNoIn CHAR(10))
BEGIN
     IF EXISTS (SELECT *
         FROM UST_BIRIM_KURUMSAL
         WHERE UST_BIRIM_KURUMSAL.KurumsalNo=KurumsalNoIn)
         THEN SELECT '0' AS RESULT;
     ELSE
         DELETE
         FROM  KURUMSAL
         WHERE KURUMSAL.KurumsalNo=KurumsalNoIn;
     SELECT '1' AS RESULT;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `LimitiAsanUrunSayisiAD_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `LimitiAsanUrunSayisiAD_sp`()
BEGIN
SELECT count(*) FROM BIRIM_DEPO_URUN_MIKTAR where AltLimit > Mevcut;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `LimitiAsanUrunSayisiGD_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `LimitiAsanUrunSayisiGD_sp`()
BEGIN
SELECT count(*) FROM GENEL_DEPO_URUN_MIKTAR where AltLimit > Mevcut;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `LimitUrunAD_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `LimitUrunAD_sp`(IN inGrup CHAR(10))
BEGIN
SELECT U.UrunAdi, G.UrunNo, G.Mevcut, G.AltLimit
FROM BIRIM_DEPO_URUN_MIKTAR AS G
LEFT JOIN
URUN AS U
ON U.UrunNo = G.UrunNo
WHERE AltLimit > Mevcut AND GrupNo= `inGrup`;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `LimitUrunGD_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `LimitUrunGD_sp`()
BEGIN
SELECT U.UrunAdi, G.UrunNo, G.Mevcut, G.AltLimit
FROM GENEL_DEPO_URUN_MIKTAR AS G, URUN AS U
WHERE AltLimit > Mevcut  AND U.UrunNo=G.UrunNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ListPendingItems_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ListPendingItems_sp`()
SELECT *
FROM BEKLEYEN_URUNLER */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `OzelAnahtarKullaniyorGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `OzelAnahtarKullaniyorGuncelle_sp`(KullaniciNoIn CHAR(10), DeaktivasyonTarihiIn BIGINT)
BEGIN
      UPDATE KULLANICI_IMZA_ANAHTARI
         SET KULLANICI_IMZA_ANAHTARI.Aktif='0'
           , KULLANICI_IMZA_ANAHTARI.KaldirildigiTarih=DeaktivasyonTarihiIn
       WHERE KULLANICI_IMZA_ANAHTARI.KullaniciNo=KullaniciNoIn
         AND KULLANICI_IMZA_ANAHTARI.Aktif='1';
     COMMIT;
     UPDATE
           KULLANICI
     SET
        KULLANICI.OzelAnahtarKullaniyor = '0'
     WHERE
        KULLANICI.KullaniciNo = KullaniciNoIn;
     COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonaGoreKullaniciGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonaGoreKullaniciGoster_sp`(PozisyonAdiIn VARCHAR(20))
BEGIN
SELECT
             KULLANICI.KullaniciNo
           , KULLANICI.KullaniciAdi
           , KULLANICI.KullaniciSifresi
           , KULLANICI.Ad
           , KULLANICI.Soyad
           , KULLANICI.Email
           , KULLANICI.TelNo
           , KULLANICI.SifreHatasi
           , KULLANICI.PozisyonNo
           , KULLANICI.GrupNo
FROM KULLANICI, POZISYON
WHERE POZISYON.PozisyonAdi = PozisyonAdiIn
      AND KULLANICI.`PozisyonNo`= POZISYON.`PozisyonNo`
      AND KULLANICI.Statu = '1'
      AND `POZISYON`.`Statu` = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonaSayfaYetkisiEkle` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonaSayfaYetkisiEkle`(pozisyonNoIn CHAR(10), sayfaNoIn CHAR(10))
BEGIN
     IF NOT EXISTS (SELECT * FROM POZISYON_SAYFA_YETKISI_MN WHERE POZISYON_SAYFA_YETKISI_MN.PozisyonNo = pozisyonNoIn AND POZISYON_SAYFA_YETKISI_MN.SayfaNo = sayfaNoIn)
     THEN
         INSERT INTO
                POZISYON_SAYFA_YETKISI_MN (PozisyonNo, SayfaNo, Statu)
         VALUES
                (pozisyonNoIn, sayfaNoIn, '1');
     ELSE
         UPDATE
               POZISYON_SAYFA_YETKISI_MN
         SET
            POZISYON_SAYFA_YETKISI_MN.Statu = '1'
         WHERE
              POZISYON_SAYFA_YETKISI_MN.PozisyonNo  = pozisyonNoIn
              AND POZISYON_SAYFA_YETKISI_MN.SayfaNo = sayfaNoIn;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonEkle_sp`(PozisyonAdiIn VARCHAR(70))
BEGIN
     DECLARE PozisyonNo CHAR(10);
     call GetNextId_sp('POS',PozisyonNo);
     INSERT INTO
            POZISYON (PozisyonNo, PozisyonAdi)
     VALUES
           (PozisyonNo, PozisyonAdiIn) ;
     COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonGoster_sp`(PozisyonNoIn CHAR(10))
BEGIN
      SELECT
            POZISYON.PozisyonNo
           ,POZISYON.PozisyonAdi
        FROM
            POZISYON
        WHERE
            POZISYON.PozisyonNo LIKE CONCAT( '%' , COALESCE(PozisyonNoIn,'') , '%')
            AND POZISYON.Statu = '1'
        ORDER BY POZISYON.PozisyonAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonGuncelle_sp`(PozisyonNoIn CHAR(10), PozisyonAdiIn VARCHAR(70))
BEGIN
UPDATE POZISYON
     SET
        POZISYON.PozisyonAdi = PozisyonAdiIn
     WHERE
        POZISYON.PozisyonNo = PozisyonNoIn
        AND POZISYON.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonSayfaYetkisiSil` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonSayfaYetkisiSil`(pozisyonNoIn CHAR(10), sayfaNoIn CHAR(10))
BEGIN
     IF EXISTS (SELECT * FROM POZISYON_SAYFA_YETKISI_MN WHERE POZISYON_SAYFA_YETKISI_MN.PozisyonNo = pozisyonNoIn AND POZISYON_SAYFA_YETKISI_MN.SayfaNo = sayfaNoIn)
     THEN
         UPDATE
               POZISYON_SAYFA_YETKISI_MN
         SET
            POZISYON_SAYFA_YETKISI_MN.Statu = '0'
         WHERE
              POZISYON_SAYFA_YETKISI_MN.PozisyonNo  = pozisyonNoIn
              AND POZISYON_SAYFA_YETKISI_MN.SayfaNo = sayfaNoIn;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonSil_sp`(PozisyonNoIn CHAR(10))
BEGIN
     UPDATE POZISYON_SAYFA_YETKISI_MN
     SET POZISYON_SAYFA_YETKISI_MN.Statu = '0'
     WHERE POZISYON_SAYFA_YETKISI_MN.PozisyonNo = PozisyonNoIn;
     UPDATE POZISYON
     SET POZISYON.Statu = '0'
     WHERE POZISYON.PozisyonNo = PozisyonNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonunYetkisiOlanSayfalariGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonunYetkisiOlanSayfalariGoster_sp`(pozisyonNoIn CHAR(10))
BEGIN
     SELECT
           SAYFA.*
     FROM
         SAYFA
              JOIN
         POZISYON_SAYFA_YETKISI_MN ON POZISYON_SAYFA_YETKISI_MN.SayfaNo = SAYFA.SayfaNo
     WHERE
          POZISYON_SAYFA_YETKISI_MN.PozisyonNo = pozisyonNoIn
          AND POZISYON_SAYFA_YETKISI_MN.Statu = '1'
     ORDER BY SAYFA.SayfaKodu;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonunYetkisiOlmayanSayfalariGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonunYetkisiOlmayanSayfalariGoster_sp`(pozisyonNoIn CHAR(10))
BEGIN
     SELECT
           SAYFA.*
     FROM
         SAYFA
     WHERE
          NOT EXISTS (
              SELECT DISTINCT
                  POZISYON_SAYFA_YETKISI_MN.SayfaNo
              FROM
                  POZISYON_SAYFA_YETKISI_MN
              WHERE
                   POZISYON_SAYFA_YETKISI_MN.SayfaNo = SAYFA.SayfaNo
                   AND POZISYON_SAYFA_YETKISI_MN.PozisyonNo = pozisyonNoIn
                   AND POZISYON_SAYFA_YETKISI_MN.Statu = '1'
          )
     ORDER BY SAYFA.SayfaKodu;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `PozisyonYetkileriniSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `PozisyonYetkileriniSil_sp`(PozisyonNoIn CHAR(10))
BEGIN
     UPDATE POZISYON_SAYFA_YETKISI_MN
     SET POZISYON_SAYFA_YETKISI_MN.Statu = '0'
     WHERE POZISYON_SAYFA_YETKISI_MN.PozisyonNo = PozisyonNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat12IhaleDurumGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat12IhaleDurumGoster_sp`(DurumIn INTEGER(10))
BEGIN
SELECT *
FROM IHALE
WHERE IHALE.Durum = DurumIn
AND IHALE.Statu = '1' ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat13IhaleNoGoreIstekFisiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat13IhaleNoGoreIstekFisiGoster_sp`(IhaleNoIn CHAR(10))
BEGIN
SELECT *
FROM ISTEK_FISI
WHERE ISTEK_FISI.IhaleNo = IhaleNoIn
AND ISTEK_FISI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SAT14_IhaleGosterFirmaTariheGore_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SAT14_IhaleGosterFirmaTariheGore_sp`(FirmaAdiIn VARCHAR(50), IlkTarihIn DATE, SonTarihIn DATE)
BEGIN
SELECT IHALE_TEKLIF.FirmaAdi,
       IHALE_TEKLIF.FirmaTanimi,
       IHALE_TEKLIF.TeklifNo,
       IHALE_TEKLIF.TeklifFiyati,
       IHALE.IhaleTarihi
FROM IHALE, IHALE_TEKLIF
WHERE IHALE_TEKLIF.FirmaAdi LIKE CONCAT('%' ,FirmaAdiIn, '%' ) AND
      IHALE.IhaleNo = IHALE_TEKLIF.IhaleNo AND
      IHALE.IhaleTarihi > IlkTarihIn AND
      IHALE.IhaleTarihi <= SonTarihIn AND
      IHALE.Statu = '1' AND
      IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat1BilgiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat1BilgiGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
     SELECT K.KUllaniciAdi, I.OlusturmaTarihi, G.Aciklama
     FROM GECMIS G, ISTEK_FISI I, KULLANICI K
     WHERE I.IstekFisiNo=IstekFisiNoIn
           AND G.IstekFisiNo=I.IstekFisiNo
           AND K.KullaniciNo=G.KullaniciNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat2DurumGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat2DurumGoster_sp`(DurumIn INTEGER(10))
BEGIN
     SELECT DISTINCT IhaleAdi,IhaleNo
     FROM IHALE WHERE Durum=DurumIn
     AND IHALE.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat5IhaleSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat5IhaleSil_sp`(IhaleNoIn CHAR(10))
BEGIN
     UPDATE IHALE
     SET IHALE.Statu='0'
     WHERE IhaleNo=IhaleNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat5IstekFisi_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat5IstekFisi_sp`(IhaleNoIn CHAR(10), SayfaNoIn CHAR(10))
BEGIN
     SELECT *
     FROM ISTEK_FISI
     WHERE IhaleNo=IhaleNoIn
     AND SayfaNo=SayfaNoIn
     AND ISTEK_FISI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SAT5_IhaleDurumunu2Yap_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SAT5_IhaleDurumunu2Yap_sp`(IhaleNoIn CHAR(10))
BEGIN
UPDATE IHALE
SET IHALE.Durum = 2
WHERE IHALE.IhaleNo = IhaleNoIn AND
      IHALE.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SAT5_IhaleDurumunuGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SAT5_IhaleDurumunuGuncelle_sp`(IhaleNoIn CHAR(10), IhaleDurumIn INTEGER(10))
BEGIN
UPDATE IHALE
SET IHALE.Durum = IhaleDurumIn
WHERE IHALE.IhaleNo = IhaleNoIn AND
      IHALE.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SAT5_IstekFisineIhaleAta_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SAT5_IstekFisineIhaleAta_sp`(IstekFisiNoIn CHAR(10), IhaleNoIn CHAR(10))
BEGIN
     UPDATE ISTEK_FISI
     SET ISTEK_FISI.IhaleNo = IhaleNoIn
     WHERE ISTEK_FISI.IstekFisiNo = IstekFisiNoIn AND
           ISTEK_FISI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SAT5_SayfaNoluIhaleNosuzIstekFisleri_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SAT5_SayfaNoluIhaleNosuzIstekFisleri_sp`(SayfaNoIn CHAR(10))
BEGIN
SELECT *
FROM ISTEK_FISI
WHERE ISTEK_FISI.SayfaNo = SayfaNoIn AND
      ISNULL(ISTEK_FISI.IhaleNo) AND
      ISTEK_FISI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sat8IhaleTeklif_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sat8IhaleTeklif_sp`(IhaleNoIn CHAR(10))
BEGIN
     SELECT *
     FROM IHALE_TEKLIF
     WHERE IhaleNo=IhaleNoIn
     AND IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SayfaVeGrubunIstekFisiniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SayfaVeGrubunIstekFisiniGoster_sp`(SayfaKoduIn VARCHAR(50), GrupNoIn CHAR(10))
BEGIN
   SELECT
            ISTEK_FISI.IstekFisiNo
          , ISTEK_FISI.Isteyen
          , ISTEK_FISI.KalemNo
          , KALEM.KalemKodu
          , KALEM.KalemAdi
          , ISTEK_FISI.SayfaNo
          , SAYFA.SayfaKodu
          , SAYFA.SayfaAdi
          , ISTEK_FISI.IstekFisiKodu
          , ISTEK_FISI.OlusturmaTarihi
          , ISTEK_FISI.Olusturan
          , CREATER.Ad
          , CREATER.Soyad
       FROM ISTEK_FISI
          , KALEM
          , SAYFA
          , KULLANICI AS CREATER
      WHERE ISTEK_FISI.GrupNo = GrupNoIn
        AND SAYFA.SayfaKodu = SayfaKoduIn
        AND SAYFA.SayfaNo = ISTEK_FISI.SayfaNo
        AND KALEM.KalemNo = ISTEK_FISI.KalemNo
        AND CREATER.KullaniciNo = ISTEK_FISI.Olusturan
        AND ISTEK_FISI.Statu = '1'
        AND KALEM.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SetAdLimit_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SetAdLimit_sp`(IN departman_no CHAR(10),  IN urun_no CHAR(10) , IN minimum_limit INT)
BEGIN
if not exists (
select
  *
from
  `BIRIM_DEPO_URUN_MIKTAR`
where
  `GrupNo` = departman_no and `UrunNo` = urun_no
)
then
INSERT INTO  `BIRIM_DEPO_URUN_MIKTAR` ( `GrupNo`,`BirimNo`, `UstBirimNo`, `UrunNo`, `AltLimit`)
VALUES (departman_no, 
(SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = departman_no),
(SELECT `UstBirimNo`  FROM `BIRIM` , `GRUP`   
WHERE GRUP.`GrupNo` = departman_no AND GRUP.`BirimNo` = BIRIM.`BirimNo`),
urun_no , minimum_limit );
elseif(1=1)
then
 update `BIRIM_DEPO_URUN_MIKTAR` 
set `AltLimit` = minimum_limit 
where `GrupNo` = departman_no and `UrunNo` = urun_no;
END IF; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SetGdLimit_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SetGdLimit_sp`(IN urun_no CHAR(10) , IN minimum_limit INT)
BEGIN
if not exists (
select
  *
from
  `GENEL_DEPO_URUN_MIKTAR`
where
 `UrunNo` = urun_no
)
then
INSERT INTO  `GENEL_DEPO_URUN_MIKTAR` ( `UrunNo`, `AltLimit`)
VALUES (urun_no, minimum_limit );
elseif(1=1)
then
 update `GENEL_DEPO_URUN_MIKTAR` set `AltLimit` = minimum_limit where `UrunNo` = urun_no;
END IF; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SetPendingItems_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SetPendingItems_sp`()
BEGIN
INSERT INTO BEKLEYEN_URUNLER( `FaturaNo`,`UrunNo`,`TalepEdenGrupNo`,`TalepEdenBirimNo` ,`TalepEdenUstBirimNo`,`FaturaTarihi` , `Miktar`)
SELECT ISF.`FaturaNo`, I.`UrunNo`, ISF.`GrupNo`, G.`BirimNo`,B.`UstBirimNo`, ISF.`FaturaTarihi`, `Miktar`
FROM ISTEK I, ISTEK_FISI ISF , GRUP G, BIRIM B
WHERE I.`IstekFisiNo` = ISF.`IstekFisiNo` 
AND  ISF.`Statu` = '2' 
AND ISF.GrupNo = G.GrupNo 
AND G.BirimNo = B.BirimNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SetPendingToStock_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SetPendingToStock_sp`( IN stockid char(10), IN  paramfatura CHAR(20), IN paramtalepci CHAR(10), IN raf_no CHAR(10))
BEGIN
INSERT INTO `GENEL_DEPO_GIRIS`( `UrunNo` ,  `TalepEdenGrupNo`,  `TalepEdenBirimNo` , `TalepEdenUstBirimNo` , `RafNo` , `Miktar` , `FaturaNo` , `FaturaTarihi`)
VALUES (stockid, paramtalepci, 
(SELECT `BirimNo` FROM `GRUP` WHERE `GrupNo` = paramtalepci),
(SELECT B.`UstBirimNo` FROM `BIRIM` B, `GRUP` G WHERE G.`GrupNo` = paramtalepci AND B.`BirimNo` = G.`GrupNo`), 
raf_no,
(SELECT `Miktar` FROM `BEKLEYEN_URUNLER` WHERE `FaturaNo` = paramfatura AND  `UrunNo` = stockid AND `TalepEdenGrupNo` = paramtalepci),
paramfatura,  
(SELECT `FaturaTarihi` FROM `BEKLEYEN_URUNLER` WHERE `FaturaNo` = paramfatura AND  `UrunNo` = stockid AND `TalepEdenGrupNo` = paramtalepci)
 ) ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `Sifreleme_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `Sifreleme_sp`(IN sifrelenecek VARCHAR(20))
BEGIN
SELECT MD5(sifrelenecek);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SilinmisIstekFisiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SilinmisIstekFisiGoster_sp`(IstekFisiNoIn CHAR(10))
BEGIN
  SELECT
         ISTEK.*,
         ISTEK_FISI.*,
         URUN.UrunKodu,
         URUN.UrunAdi,
         KALEM.KalemAdi,
         KALEM.KalemKodu,
         ANA_KALEM.AnaKalemAdi,
         ANA_KALEM.AnaKalemKodu,
         ANA_KALEM.AnaKalemNo,
         SAYFA.SayfaKodu,
         SAYFA.SayfaAdi,
         GRUP.GrupAdi,
         BUTCE_DAGILIM.ButceDagilimNo,
         BUTCE_DAGILIM.KalanButce - BUTCE_DAGILIM.BlokeEdilmis AS MevcutTutar,
         KURUMSAL.KurumsalKod,
         KURUMSAL.KurumsalNo,
         KURUMSAL.Aciklama,
         FONKSIYONEL.FonksiyonelAdi,
         FONKSIYONEL.FonksiyonelKodu,
         FONKSIYONEL.FonksiyonelNo
     FROM
         ISTEK_FISI
             JOIN
         ISTEK  ON ISTEK_FISI.IstekFisiNo = ISTEK.IstekFisiNo
             JOIN
         URUN ON URUN.UrunNo = ISTEK.UrunNo
             JOIN
         KALEM ON KALEM.KalemNo = ISTEK_FISI.KalemNo
             JOIN
         ANA_KALEM ON KALEM.AnaKalemNo = ANA_KALEM.AnaKalemNo
             JOIN
         SAYFA ON SAYFA.SayfaNo = ISTEK_FISI.SayfaNo
             JOIN
         GRUP ON GRUP.GrupNo = ISTEK_FISI.GrupNo
             LEFT JOIN
         BUTCE_BLOKE ON BUTCE_BLOKE.IstekFisiNo = ISTEK_FISI.IstekFisiNo AND BUTCE_BLOKE.Statu = '1'
             LEFT JOIN
         BUTCE_DAGILIM ON BUTCE_DAGILIM.ButceDagilimNo = BUTCE_BLOKE.ButceDagilimNo
             LEFT JOIN
         FONKSIYONEL ON FONKSIYONEL.FonksiyonelNo = BUTCE_DAGILIM.FonksiyonelNo
             LEFT JOIN
         KURUMSAL ON KURUMSAL.KurumsalNo = BUTCE_DAGILIM.KurumsalNo
     WHERE
         ISTEK_FISI.IstekFisiNo = IstekFisiNoIn
         AND ISTEK_FISI.Statu = '0';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SilinmisTumIstekFisleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SilinmisTumIstekFisleriniGoster_sp`()
BEGIN
SELECT
      *
  FROM
      ISTEK_FISI
  WHERE
      ISTEK_FISI.Statu = '0';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SistemBilgileriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SistemBilgileriGoster_sp`(ParametreAdiIn VARCHAR(100))
BEGIN
     SELECT SISTEM_BILGILERI.Degeri
     FROM SISTEM_BILGILERI
     where SISTEM_BILGILERI.ParametreAdi = ParametreAdiIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SistemBilgileriGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SistemBilgileriGuncelle_sp`(ParametreAdiIn VARCHAR(100), DegeriIn TINYTEXT)
BEGIN
     IF NOT (ParametreAdiIn = 'baslat')
     THEN
     UPDATE SISTEM_BILGILERI
     SET
        SISTEM_BILGILERI.Degeri = DegeriIn
     WHERE
        SISTEM_BILGILERI.ParametreAdi = ParametreAdiIn;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SistemDefaultBilgileriniGir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SistemDefaultBilgileriniGir_sp`()
BEGIN
	IF NOT EXISTS (SELECT * FROM SISTEM_BILGILERI WHERE ParametreAdi = 'baslat' AND Degeri = '1')
	THEN
	
	  INSERT INTO SYS_ROW_ID (Suffix, NextSeed, Description) VALUES
		  ('GRP','000001','GRUP'),
		  ('USR','000001','KULLANICI'),
		  ('ITC','000001','KALEM'),
		  ('HTR','000001','GECMIS'),
		  ('ITM','000001','URUN'),
		  ('PAG','000001','SAYFA'),
		  ('POS','000001','POZISYON'),
		  ('REQ','000001','ISTEK'),
		  ('RFM','000001','ISTEK_FISI'),
		  ('IHT','000001','IHALE_TEKLIF'),
		  ('IHL','000001','IHALE'),
		  ('UBD','000001','UST_BIRIM_BUTCE_DAGILIM'),
		  ('UBR','000001','UST_BIRIM'),
		  ('UBB','000001','UST_BIRIM_BUTCE'),
		  ('BRM','000001','BIRIM'),
		  ('BBL','000001','BUTCE_BLOKE'),
		  ('BDG','000001','BUTCE_DAGILIM'),
		  ('FNK','000001','FONKSIYONEL'),
		  ('AKL','000001','ANA_KALEM'),
		  ('UBK','000001','UST_BIRIM_KURUMSAL'),
		  ('KRM','000001','KURUMSAL'),
		  ('FMD','000001','FATURA_MADDESI'),
		  ('IPN','000001','IHRACAT_PUSULASI'),
		  ('TMN','000001','TESELLUM_MAKBUZU'),
		  ('AYN','000001','AYNIYAT_BILGILERI'),
		  ('FAK','000001','FATURA_KALEMLERI'),
		  ('IFI','000001','ISTEK_FISI_IMZA'),
		  ('ITK','000001','ISTEK_TEKLIF');
	COMMIT;	
	INSERT INTO
	       KURUMSAL (KURUMSAL.KurumsalNo, KURUMSAL.KurumsalKod, KURUMSAL.Aciklama, KURUMSAL.Statu)
	VALUES
	      ('000000-KRM', 'DEFAULT', 'DEFAULT KURUMSAL KOD', '2');
	
	INSERT INTO
	       FONKSIYONEL (FONKSIYONEL.FonksiyonelNo, FONKSIYONEL.FonksiyonelKodu, FONKSIYONEL.FonksiyonelAdi , FONKSIYONEL.Aciklama, FONKSIYONEL.Statu)
	VALUES
	      ('000000-FNK', 'DEFAULT', 'FONKSIYONEL', 'DEFAULT FONKSIYONEL KOD', '2');
	
	INSERT INTO
	       ANA_KALEM (ANA_KALEM.AnaKalemNo, ANA_KALEM.AnaKalemKodu, ANA_KALEM.AnaKalemAdi, ANA_KALEM.Statu)
	VALUES
	      ('000000-AKL', 'DEFAULT', 'DEFAULT ANA KALEM', '2');
	
	COMMIT;	
	INSERT INTO UST_BIRIM
	       (UST_BIRIM.UstBirimAdi,UST_BIRIM.UstBirimNo)
	VALUES
	      ('Bt? Daire Bakanl?','000000-UBR');
	
	CALL GrupEkle_sp('?ari ve Mali ?ler Daire Bakanl?','Idari','');
	CALL GrupEkle_sp('Bt? Daire Bakanl?','Destek','000001-GRP');
	CALL GrupEkle_sp('Ayniyat','Destek','000001-GRP');
	CALL GrupEkle_sp('Bt? Koordinat?l?','Destek','000001-GRP');
	
	CALL GrupEkle_sp('Satnalma ?be Mdrl?','Destek','000001-GRP');
	CALL GrupEkle_sp('Tahakkuk ?be','Destek','000001-GRP');
	CALL GrupEkle_sp('Rekt?lk','Idari','');
	
	UPDATE SYS_ROW_ID SET SYS_ROW_ID.NextSeed = '000020' WHERE SYS_ROW_ID.Suffix = 'GRP';
	COMMIT;	
	
	INSERT INTO
	       SISTEM_BILGILERI (ParametreAdi, Degeri)
	VALUES
	  ('giris','satinalma.boun.edu.tr'),
	  ('smtp','localhost'),
	  ('webmaster','saswebmaster@boun.edu.tr'),
	  ('baslat','0'),
	  ('anaKalem', '0'),
	  ('fonksiyonel', '0'),
	  ('kurumsal', '0'),
	  ('akademik', '0'),
	  ('idari', '0');
	COMMIT;	
	
	INSERT INTO SAYFA (SayfaNo, SayfaAdi, SayfaKodu, SayfaAmaci, Aciklama, Statu) VALUES
	  ('000001-PAG','Dekann Sayfas','../dek/dek1.jsp',0,'B?mlerin bakanlarndan gelen istekler g?lr.','1'),
	  ('000002-PAG','B?m Bakan','../bol/bol1.jsp',0,'Istek i?n b?m satn alma sorumlusu bt? se?r.Burada bt? onaylayip Dekanl? g?derilir.','1'),
	  ('000003-PAG','B?m Satnalma Sorumlusu','../bol/sekreter.jsp',0,'Satinalma sorumlusu b?m i?n bt? se?r.','1'),
	  ('000004-PAG','Bt? Kod Y?etim','../but/butukfs.jsp',1,'?tBirimlerin kullanabilecekleri bt? tiplerinin atanmasy','1'),
	  ('000005-PAG','Bt? Da?lm Y?etimi','../but/butbds.jsp',1,'Fakltelere Bt? da?lm yaplmas','1'),
	  ('000006-PAG','Bt? Bakan Onay','../but/but3.jsp',0,'Bt? Bakanynyn onay sayfas','1'),
	  ('000007-PAG','Bt? Sekreteri Onay','../but/but2.jsp',0,'Bt? sekreterinin onay sayfasy','1'),
	  ('000008-PAG','Satn Alma','../sat/sat1.jsp',0,'Istek fisi goruntulenir, kendi yorumunu girebilir, ve istegi onaylayacaksa ihale veya dogrudan (ihal','1'),
	  ('000009-PAG','?ale Y?etimi','../sat/sat2.jsp',1,'Yeni acilmis ihaleler, teklif alinacak ihalaler veya sonuclanmis ihaleler ayrintilarinin goruntulene','1'),
	  ('00000A-PAG','Yeni ?ale Olutur','../sat/sat3.jsp',0,'Yeni ihale gerekli fieldler doldurularak olusturulur.','1'),
	  ('00000B-PAG','B?m ?lemleri','bolIs1',0,NULL,'1'),
	  ('00000C-PAG','Dekanlik ?lemleri','.../dek/dek1.jsp',0,NULL,'1'),
	  ('00000D-PAG','Rekt?lk ?lemleri','../rek/rek1.jsp',0,NULL,'1'),
	  ('00000E-PAG','Silindi Sayfas','silindi.jsp',0,NULL,'1'),
	  ('00000F-PAG','?tek Takip','../istekTakip/istekTakip.jsp',1,'Her kullanc kendi yapt? istek gecmiine ve u anki durumuna buradan ulaabilir.','1'),
	  ('00000G-PAG','Dekanlk Satn Alma Sorumlusu','../dek/sekreter.jsp',0,'Dekanlyk satyn alma sorumlusunda bekleyen isteklerin syralandy?y sayfa.','1'),
	  ('00000H-PAG','?ari Birim','../support/sup1.jsp',0,'Ydari birimleride iste?in ilk onaylandy?y sayfa. Byr birimin mdr yardymcysy i?n.','1'),
	  ('00000I-PAG','?ari Birim Daire Baskani','../support/supmud1.jsp',0,NULL,'1'),
	  ('00000J-PAG','Birimlere Bt? Atanmas','../but/butust.jsp',1,'?t Birimlerin Birimlere dt? da?ylymy yapmasy i?n','1'),
	  ('00000K-PAG','Kurumsal Kod Y?etimi','../but/butuks.jsp',1,'?t Birimlere Kurumsal Kod atanmas','1'),
	  ('00000L-PAG','Bt? Bakan Onay','../but/but4.jsp',0,'Bt? Ba?kanyn Onay Sayfasy','1'),
	  ('00000M-PAG','Harcama Onay Sayfas','../but/but1.jsp',0,'Alymy yapylan bir iste?n harcamasnn onaylanmasy','1'),
	  ('00000N-PAG','Fatura Bilgileri','../ayn/ayn1.jsp',0,NULL,'1'),
	  ('00000O-PAG','Bekleyen Muayene Raporlar','../ayn/ayn2giris.jsp',1,NULL,'1'),
	  ('00000P-PAG','Muayene Raporu ve ?racat Pusulas Onay','../ayn/ayn2.jsp ',0,NULL,'1'),
	  ('00000Q-PAG','Ayniyat Tesellm Makbuzu','../ayn/ayn3.jsp',0,NULL,'1'),
	  ('00000R-PAG','Do?udan Almlar','../rek/rek3.jsp',0,'rektor','1'),
	  ('00000S-PAG','Tesellm Sayfas Onay Sayfas','../sat/sat15.jsp',0,'Aynyattan gelen Tesellum makbuzu onaylanir.','1'),
	  ('00000T-PAG','?ale Rapor Ekran','../sat/sat14.jsp',1,'Bu saydaya 3,6,12 aylik surelerde firmalarin aldiklari ihaleler goruntulenebilir.','1'),
	  ('00000U-PAG','Do?udan Alm 2','../sat/sat11.jsp',0,'Rektorlukten gelen istek fisi goruntulenir, kullanici kendi yorumunu girebilir, ve istegi onaylar ay','1'),
	  ('00000V-PAG','Do?udan Alm 1','../sat/sat10.jsp',0,'sat1\'in do?udan alim seceneginden gelen istek fisi goruntulenir, kullanici tahmini fiyati ve kendi ','1'),
	  ('00000W-PAG','Teklif Y?etimi','../sat/sat6.jsp',0,'silinecek','1'),
	  ('00000X-PAG','Teklif Almi ?aleler ','../onayBekleyenler/rek5.jsp',1,NULL,'1'),
	  ('00000Y-PAG','Onay Bekleyen ?aleler ','../onayBekleyenler/rek4.jsp',1,NULL,'1'),
	  ('00000Z-PAG','Yeni ?tek Fisi','../yeniIstek/istekfisia.jsp',1,'Istek olu?turmasy gereken kiiler i?n. ?t dzey kullanycylar giremesyn.','1'),
	  ('000010-PAG','Satn Alma ?in Dummy Sayfa','../sat/satx',0,'Satn almann dummy sayfas, gereksiz bisi.','1');
	COMMIT;	
	UPDATE SYS_ROW_ID SET SYS_ROW_ID.NextSeed = '000010' WHERE SYS_ROW_ID.Suffix = 'PAG';
	
	COMMIT;	
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000001-POS','Akademik Personel');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000002-POS','?ari Personel');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000003-POS','B?m Bakan');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000004-POS','B?m Sekreteri');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000005-POS','Dekan');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000006-POS','?ari Birim Mdr');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000007-POS','Genel Sekreter');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000008-POS','Daire Bakan');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('000009-POS','SAS ?ale Y?eticisi');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000A-POS','SAS Rapor Y?eticisi');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000B-POS','Do?udan Satn Alma Sorumlusu');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000C-POS','SAS Y?eticisi');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000D-POS','Bt? Bakan');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000E-POS','Bt? Sekreteri');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000F-POS','Ambar ?fi');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000G-POS','Ayniyat Sayman');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000H-POS','Ayniyat G?evlisi');
	INSERT INTO POZISYON(PozisyonNo,PozisyonAdi) VALUES ('00000I-POS','Rekt? Yardimcisi');
	COMMIT;	
	UPDATE SYS_ROW_ID SET SYS_ROW_ID.NextSeed = '00000J' WHERE SYS_ROW_ID.Suffix = 'POS';
	COMMIT;
INSERT INTO POZISYON_SAYFA_YETKISI_MN(PozisyonNo,SayfaNo) VALUES
('000001-POS','00000F-PAG'),
('000001-POS','00000O-PAG'),
('000001-POS','00000Z-PAG'),
('000002-POS','00000F-PAG'),
('000002-POS','00000O-PAG'),
('000002-POS','00000Z-PAG'),
('000003-POS','000002-PAG'),
('000003-POS','00000F-PAG'),
('000003-POS','00000O-PAG'),
('000003-POS','00000Z-PAG'),
('000004-POS','000003-PAG'),
('000004-POS','00000F-PAG'),
('000004-POS','00000O-PAG'),
('000004-POS','00000Z-PAG'),
('000005-POS','000001-PAG'),
('000005-POS','00000C-PAG'),
('000005-POS','00000J-PAG'),
('000006-POS','00000F-PAG'),
('000006-POS','00000H-PAG'),
('000006-POS','00000O-PAG'),
('000006-POS','00000Z-PAG'),
('000007-POS','00000I-PAG'),
('000008-POS','00000I-PAG'),
('000009-POS','000009-PAG'),
('00000A-POS','00000T-PAG'),
('00000B-POS','00000U-PAG'),
('00000B-POS','00000V-PAG'),
('00000C-POS','000008-PAG'),
('00000C-POS','000009-PAG'),
('00000C-POS','00000T-PAG'),
('00000C-POS','00000U-PAG'),
('00000C-POS','00000S-PAG'),
('00000C-POS','00000V-PAG'),
('00000D-POS','00000M-PAG'),
('00000D-POS','000006-PAG'),
('00000D-POS','00000L-PAG'),
('00000D-POS','000005-PAG'),
('00000D-POS','000004-PAG'),
('00000D-POS','00000J-PAG'),
('00000D-POS','00000K-PAG'),
('00000E-POS','000007-PAG'),
('00000F-POS','00000N-PAG'),
('00000F-POS','00000O-PAG'),
('00000G-POS','00000N-PAG'),
('00000G-POS','00000O-PAG'),
('00000G-POS','00000Q-PAG'),
('00000H-POS','00000N-PAG'),
('00000H-POS','00000O-PAG'),
('00000I-POS','00000Y-PAG'),
('00000I-POS','00000X-PAG'),
('00000I-POS','00000D-PAG'),
('00000I-POS','00000R-PAG');
	
	COMMIT;	
	UPDATE SISTEM_BILGILERI SET SISTEM_BILGILERI.Degeri = '1' WHERE SISTEM_BILGILERI.ParametreAdi = 'baslat';
      END IF;
	
      COMMIT;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SpendStockGDC_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SpendStockGDC_sp`(IN urun_no CHAR(10), IN miktar INT)
BEGIN 
UPDATE  `GENEL_DEPO_URUN_MIKTAR`
SET `Mevcut` = `Mevcut` - miktar 
WHERE  `UrunNo` =  urun_no ; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `SpendStock_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `SpendStock_sp`(IN departman_no  CHAR(10), IN stockID CHAR(10), IN miktar INT)
BEGIN 
UPDATE  BIRIM_DEPO_URUN_MIKTAR
SET `Mevcut` = `Mevcut` - miktar 
WHERE  `GrupNo` =  departman_no AND `UrunNo` = stockID;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TeklifEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TeklifEkle_sp`(IhaleNoIn CHAR(10), FirmaAdiIn VARCHAR(50), FirmaTelIn VARCHAR(14), FirmaAdresIn VARCHAR(100), FirmaTanimiIn VARCHAR(100), TeklifFiyatiIn DECIMAL(11,2))
BEGIN
     DECLARE TeklifNo char(10);
     call GetNextId_sp('IHT',TeklifNo);
     INSERT INTO
            IHALE_TEKLIF ( TeklifNo, IhaleNo, FirmaAdi, FirmaTel, FirmaAdres,
            FirmaTanimi, TeklifFiyati)
     VALUES
           (TeklifNo, IhaleNoIn, FirmaAdiIn, FirmaTelIn, FirmaAdresIn,
            FirmaTanimiIn, TeklifFiyatiIn) ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TeklifGosterSat8_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TeklifGosterSat8_sp`(TeklifNoIn VARCHAR(50))
BEGIN
SELECT IHALE_TEKLIF.TeklifNo ,
       IHALE_TEKLIF.IhaleNo ,
       IHALE_TEKLIF.FirmaAdi ,
       IHALE_TEKLIF.FirmaTel ,
       IHALE_TEKLIF.FirmaAdres ,
       IHALE_TEKLIF.FirmaTanimi ,
       IHALE_TEKLIF.TeklifFiyati
  FROM IHALE_TEKLIF
 WHERE IHALE_TEKLIF.TeklifNo = TeklifNoIn
   AND IHALE_TEKLIF.Statu = '1' ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TeklifGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TeklifGuncelle_sp`(TeklifNoIn CHAR(10), FirmaAdiIn VARCHAR(50), FirmaAdresIn VARCHAR(100), FirmaTanimiIn VARCHAR(100), FirmaTelIn VARCHAR(14), IhaleNoIn CHAR(10), TeklifFiyatiIn DECIMAL(12,0))
BEGIN
 UPDATE IHALE_TEKLIF
 SET
   IHALE_TEKLIF.FirmaAdi = FirmaAdiIn,
   IHALE_TEKLIF.FirmaAdres = FirmaAdresIn,
   IHALE_TEKLIF.FirmaTanimi = FirmaTanimiIn,
   IHALE_TEKLIF.FirmaTel = FirmaTelIn,
   IHALE_TEKLIF.IhaleNo = IhaleNoIn,
   IHALE_TEKLIF.TeklifFiyati = TeklifFiyatiIn
 WHERE
   IHALE_TEKLIF.TeklifNo = TeklifNoIn
   AND IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TeklifIhaleGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TeklifIhaleGoster_sp`(IhaleNoIn VARCHAR(50))
BEGIN
SELECT *
FROM IHALE_TEKLIF , IHALE
WHERE IHALE.IhaleNo = IhaleNoIn
AND IHALE_TEKLIF.IhaleNo = IHALE.IhaleNo
AND IHALE_TEKLIF.Statu = '1' ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TeklifSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TeklifSil_sp`(TeklifNoIn CHAR(10))
BEGIN
 UPDATE IHALE_TEKLIF
 SET
   IHALE_TEKLIF.Statu = '0'
 WHERE
   IHALE_TEKLIF.TeklifNo = TeklifNoIn
   AND IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TeklifTeklifFiyatiniGuncelleSat9_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TeklifTeklifFiyatiniGuncelleSat9_sp`(TeklifNoIn CHAR(10), TeklifFiyatiIn DECIMAL(12,0))
BEGIN
 UPDATE IHALE_TEKLIF
 SET
   IHALE_TEKLIF.TeklifFiyati = TeklifFiyatiIn
 WHERE
   IHALE_TEKLIF.TeklifNo = TeklifNoIn
   AND IHALE_TEKLIF.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikBirimAdiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikBirimAdiGoster_sp`()
BEGIN
SELECT `BirimAdi` 
FROM `BIRIM` 
WHERE `UstBirimNo` IN (
	SELECT `AkademikUstBirimNo` FROM `AKADEMIK_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikBirimNoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikBirimNoGoster_sp`()
BEGIN
SELECT `BirimNo` FROM `BIRIM` WHERE `UstBirimNo` IN (SELECT `AkademikUstBirimNo` FROM `AKADEMIK_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikGrupAdiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikGrupAdiGoster_sp`()
BEGIN
SELECT G.`GrupAdi` 
FROM `GRUP` G, `BIRIM` B 
WHERE G.`BirimNo` = B.`BirimNo` 
AND B.`UstBirimNo` IN (SELECT `AkademikUstBirimNo` FROM `AKADEMIK_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikGrupGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikGrupGoster_sp`()
BEGIN
SELECT G.`GrupNo`, G.`GrupAdi` 
FROM `GRUP` G, `BIRIM` B 
WHERE G.`BirimNo` = B.`BirimNo` 
AND B.`UstBirimNo` IN (SELECT `AkademikUstBirimNo` FROM `AKADEMIK_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikGrupNoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikGrupNoGoster_sp`()
BEGIN
SELECT G.`GrupNo` 
FROM `GRUP` G, `BIRIM` B 
WHERE G.`BirimNo` = B.`BirimNo` 
AND B.`UstBirimNo` IN (SELECT `AkademikUstBirimNo` FROM `AKADEMIK_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikUstBirimAdiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikUstBirimAdiGoster_sp`()
BEGIN
SELECT `AkademikUstBirimAdi`
FROM `AKADEMIK_UST_BIRIM`;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumAkademikUstBirimNoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumAkademikUstBirimNoGoster_sp`()
BEGIN
SELECT `AkademikUstBirimNo`
FROM `AKADEMIK_UST_BIRIM`;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIdariBirimAdiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIdariBirimAdiGoster_sp`()
BEGIN
SELECT `BirimAdi` 
FROM `BIRIM` 
WHERE `UstBirimNo` IN (SELECT `IdariUstBirimNo` FROM `IDARI_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIdariBirimNoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIdariBirimNoGoster_sp`()
BEGIN
SELECT `BirimNo` FROM `BIRIM` WHERE `UstBirimNo` IN (SELECT `IdariUstBirimNo` FROM `IDARI_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIdariGrupAdiGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIdariGrupAdiGoster_sp`()
BEGIN
SELECT G.`GrupAdi` 
FROM `GRUP` G, `BIRIM` B 
WHERE G.`BirimNo` = B.`BirimNo` AND 
B.`UstBirimNo` IN (SELECT `IdariUstBirimNo` FROM `IDARI_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIdariGrupGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIdariGrupGoster_sp`()
BEGIN
SELECT G.`GrupNo`, G.`GrupAdi` 
FROM `GRUP` G, `BIRIM` B 
WHERE G.`BirimNo` = B.`BirimNo` 
AND B.`UstBirimNo` IN (SELECT `IdariUstBirimNo` FROM `IDARI_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIdariGrupNoGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIdariGrupNoGoster_sp`()
BEGIN
SELECT G.`GrupNo` 
FROM `GRUP` G, `BIRIM` B 
WHERE G.`BirimNo` = B.`BirimNo` AND 
B.`UstBirimNo` IN (SELECT `IdariUstBirimNo` FROM `IDARI_UST_BIRIM`);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIstekFisleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIstekFisleriniGoster_sp`()
BEGIN
     SELECT
      *
      FROM
      ISTEK_FISI
      WHERE
      ISTEK_FISI.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `TumIstekFisleri_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `TumIstekFisleri_sp`(IN KullaniciNoIn CHAR(10))
BEGIN
SELECT
ISTEK_FISI.IstekFisiNo
          , ISTEK_FISI.Isteyen
          , ISTEK_FISI.KalemNo
          , KALEM.KalemKodu
          , KALEM.KalemAdi
          , ISTEK_FISI.SayfaNo
          , SAYFA.SayfaKodu
          , SAYFA.SayfaAdi
          , ISTEK_FISI.IstekFisiKodu
          , ISTEK_FISI.OlusturmaTarihi
          , ISTEK_FISI.Olusturan
          , CREATER.Ad
          , CREATER.Soyad
       FROM
           ISTEK_FISI
          , KALEM
          , KULLANICI_SAYFA_YETKISI_MN
          , SAYFA
          , KULLANICI AS CREATER
      WHERE
      KALEM.KalemNo = ISTEK_FISI.KalemNo
        AND CREATER.KullaniciNo = ISTEK_FISI.Olusturan
        AND ISTEK_FISI.SayfaNo = SAYFA.SayfaNo
        AND KULLANICI_SAYFA_YETKISI_MN.SayfaNo = SAYFA.SayfaNo
        AND KULLANICI_SAYFA_YETKISI_MN.KullaniciNo = KullaniciNoIn
        AND ISTEK_FISI.Statu = '1'
        AND KALEM.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UrunAktarildi_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UrunAktarildi_sp`(IN IstekFisiNoIn CHAR(10))
BEGIN
update ISTEK_FISI set Aktarildi = 1 where IstekFisiNo = IstekFisiNoIn      ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UrunAktar_sp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UrunAktar_sp`( IN UrunNoIn char(10), IN GrupNoIn char(10),IN BirimNoIn char(10),IN  UstBirimNoIn CHAR(10), IN RafNoIn CHAR(10), IN MiktarIn CHAR(10), IN FaturaNoIn CHAR(10), IN FaturaTarihiIn CHAR(10))
BEGIN
INSERT INTO `GENEL_DEPO_GIRIS`( `UrunNo` ,  `TalepEdenGrupNo`,  `TalepEdenBirimNo` , `TalepEdenUstBirimNo` , `RafNo` , `Miktar` , `FaturaNo` , `FaturaTarihi`)
VALUES (UrunNoIn, GrupNoIn, BirimNoIn, UstBirimNoIn, RafNoIn, MiktarIn, FaturaNoIn, FaturaTarihiIn) ;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UrunEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UrunEkle_sp`(UrunAdiIn VARCHAR(100), KalemNoIn CHAR(10), AciklamaIn TEXT, UrunKoduIn CHAR(20))
BEGIN
  DECLARE UrunNo char(10);
  call GetNextId_sp('ITM',UrunNo);
  INSERT INTO
            URUN (UrunNo, UrunAdi, KalemNo, Aciklama, UrunKodu)
  VALUES
           (UrunNo, UrunAdiIn, KalemNoIn, AciklamaIn, UrunKoduIn);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UrunGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UrunGoster_sp`(UrunNoIn CHAR(10))
BEGIN
  SELECT
      *
  FROM
      URUN
           JOIN
      KALEM ON URUN.KalemNo = KALEM.KalemNo AND KALEM.Statu = '1'
  WHERE
       URUN.UrunNo LIKE CONCAT( '%' , COALESCE(UrunNoIn,'') , '%')
       AND URUN.Statu = '1'
  ORDER BY URUN.UrunAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UrunGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UrunGuncelle_sp`(UrunNo CHAR(10), UrunAdi VARCHAR(100), KalemNo CHAR(10), Aciklama TEXT, UrunKodu CHAR(20))
BEGIN
  UPDATE
     URUN
  SET
     URUN.UrunAdi = UrunAdi,
     URUN.KalemNo = KalemNo,
     URUN.Aciklama = Aciklama,
     URUN.UrunKodu = UrunKodu
  WHERE
     URUN.UrunNo = UrunNo
     AND URUN.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UrunSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UrunSil_sp`(UrunNo CHAR(10))
BEGIN
   UPDATE
       URUN
   SET
       URUN.Statu = '0'
   WHERE
       URUN.UrunNo = UrunNo;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceDagilimaButceEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceDagilimaButceEkle_sp`(AnaKalemNoIn CHAR(10), FonksiyonelNoIn CHAR(10), KurumsalNoIn CHAR(10), UstBirimNoIn CHAR(10), ButceIn INTEGER(11))
BEGIN
     DECLARE D_UstBirimButceDagilimNo CHAR(10);
     DECLARE D_UstBirimButceNo        CHAR(10);
     SET D_UstBirimButceDagilimNo = NULL;
     SET D_UstBirimButceNo        = NULL;
     SELECT
           UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo
     INTO
           D_UstBirimButceDagilimNo
     FROM
         UST_BIRIM_BUTCE_DAGILIM
             JOIN
         UST_BIRIM_BUTCE  ON UST_BIRIM_BUTCE.UstBirimButceNo = UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo
             JOIN
         UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
     WHERE
          UST_BIRIM_BUTCE.FonksiyonelNo = FonksiyonelNoIn
          AND UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
          AND UST_BIRIM_KURUMSAL.KurumsalNo = KurumsalNoIn
          AND UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo = AnaKalemNoIn ;
     IF (D_UstBirimButceDagilimNo IS NOT NULL)
     THEN
         UPDATE
               UST_BIRIM_BUTCE_DAGILIM
         SET
            UST_BIRIM_BUTCE_DAGILIM.ToplamButce = ButceIn
         WHERE
            UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo = D_UstBirimButceDagilimNo;
         SELECT 'Tamamlandi' AS operationStatus;
     ELSE
         IF NOT EXISTS (SELECT * FROM ANA_KALEM WHERE ANA_KALEM.AnaKalemNo = AnaKalemNoIn)
         THEN
             SELECT 'Ana Kalem Kodu Hatali' AS ERROR;
         ELSE
             SELECT
                   UST_BIRIM_BUTCE.UstBirimButceNo
             INTO
                 D_UstBirimButceNo
             FROM
                 UST_BIRIM_BUTCE
                     JOIN
                 UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
             WHERE
                  UST_BIRIM_BUTCE.FonksiyonelNo = FonksiyonelNoIn
                  AND UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
                  AND UST_BIRIM_KURUMSAL.KurumsalNo = KurumsalNoIn;
             IF (D_UstBirimButceNo IS NULL)
             THEN
                 SELECT 'Ust Birimin Bu Fonksiyonelde Butçesi Yok' AS ERROR;
             ELSE
                 call GetNextId_sp( 'UBD',D_UstBirimButceDagilimNo);
                 INSERT INTO
                        UST_BIRIM_BUTCE_DAGILIM
                        (UstBirimButceDagilimNo, UstBirimButceNo, AnaKalemNo, ToplamButce)
                 VALUES
                       (D_UstBirimButceDagilimNo, D_UstBirimButceNo, AnaKalemNoIn, ButceIn);
                 call UstBiriminBirimlerineButceEkle_sp(UstBirimNoIn, AnaKalemNoIn, FonksiyonelNoIn, KurumsalNoIn);
                 SELECT 'Tamamlandi' AS operationStatus;
             END IF;
         END IF;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceDagilimaEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceDagilimaEkle_sp`(UstBirimButceNoIn CHAR(10), AnaKalemNoIn CHAR(10), TutarIn DECIMAL(11,2))
BEGIN
     DECLARE D_UstBirimButceDagilimNo CHAR(10);
     DECLARE D_UstBirimButceNo        CHAR(10);
     DECLARE D_FonksiyonelNo          CHAR(10);
     DECLARE D_KurumsalNo             CHAR(10);
     DECLARE D_UstBirimNo             CHAR(10);
     SET D_UstBirimButceDagilimNo = NULL;
     SET D_UstBirimButceNo        = NULL;
     SELECT
           UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo
     INTO
           D_UstBirimButceDagilimNo
     FROM
         UST_BIRIM_BUTCE_DAGILIM
     WHERE
          UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo = UstBirimButceNoIn
          AND UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo  = AnaKalemNoIn;
     IF (D_UstBirimButceDagilimNo IS NULL)
     THEN
         SELECT
           UST_BIRIM_BUTCE.UstBirimButceNo,
           UST_BIRIM_BUTCE.FonksiyonelNo,
           UST_BIRIM_KURUMSAL.KurumsalNo,
           UST_BIRIM_KURUMSAL.UstBirimNo
         INTO
           D_UstBirimButceNo,
           D_FonksiyonelNo,
           D_KurumsalNo,
           D_UstBirimNo
         FROM
             UST_BIRIM_BUTCE
                  JOIN
             UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
         WHERE
             UST_BIRIM_BUTCE.UstBirimButceNo = UstBirimButceNoIn;
         call GetNextId_sp('UBD',D_UstBirimButceDagilimNo);
         INSERT INTO
                UST_BIRIM_BUTCE_DAGILIM
                (UstBirimButceDagilimNo, UstBirimButceNo, AnaKalemNo, ToplamButce, AtanmamisMiktar)
         VALUES
               (D_UstBirimButceDagilimNo, UstBirimButceNoIn, AnaKalemNoIn, TutarIn, TutarIn);
         call UstBiriminBirimlerineButceEkle_sp(D_UstBirimNo ,AnaKalemNoIn, D_FonksiyonelNo, D_KurumsalNo);
         SELECT '1' AS result;
     ELSE
         SELECT '0' AS result;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceDagilimGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceDagilimGoster_sp`(UstBirimNoIn CHAR(10))
BEGIN
     SELECT
           UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo,
           KURUMSAL.KurumsalKod,
           KURUMSAL.KurumsalNo,
           FONKSIYONEL.FonksiyonelKodu,
           FONKSIYONEL.FonksiyonelNo,
           FONKSIYONEL.FonksiyonelAdi,
           ANA_KALEM.AnaKalemKodu,
           ANA_KALEM.AnaKalemNo,
           ANA_KALEM.AnaKalemAdi,
           UST_BIRIM_BUTCE.Tanimlama,
           UST_BIRIM_BUTCE_DAGILIM.ToplamButce,
           UST_BIRIM_BUTCE_DAGILIM.AtanmamisMiktar,
           UST_BIRIM_BUTCE_DAGILIM.Statu
     FROM
         UST_BIRIM_BUTCE_DAGILIM
             JOIN
         UST_BIRIM_BUTCE     ON UST_BIRIM_BUTCE.UstBirimButceNo = UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo
             JOIN
         UST_BIRIM_KURUMSAL  ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo =  UST_BIRIM_BUTCE.UstBirimKurumsalNo
             JOIN
         KURUMSAL            ON KURUMSAL.KurumsalNo = UST_BIRIM_KURUMSAL.KurumsalNo
             JOIN
         FONKSIYONEL         ON FONKSIYONEL.FonksiyonelNo = UST_BIRIM_BUTCE.FonksiyonelNo
            JOIN
         ANA_KALEM           ON ANA_KALEM.AnaKalemNo = UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo
     WHERE
          UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
          AND UST_BIRIM_BUTCE_DAGILIM.Statu <> '0';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceDagilimGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceDagilimGuncelle_sp`(UstBirimButceDagilimNoIn CHAR(10), TutarIn DECIMAL(11,2))
BEGIN
     DECLARE D_AtanmamisMiktar DECIMAL(11,2);
     SELECT
         UST_BIRIM_BUTCE_DAGILIM.AtanmamisMiktar
     INTO
         D_AtanmamisMiktar
     FROM
         UST_BIRIM_BUTCE_DAGILIM
     WHERE
          UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo = UstBirimButceDagilimNoIn;
     IF(D_AtanmamisMiktar IS NOT NULL)
     THEN
         IF D_AtanmamisMiktar + TutarIn < 0
         THEN
             SELECT '0' AS result;
         ELSE
             UPDATE
                   UST_BIRIM_BUTCE_DAGILIM
             SET
                UST_BIRIM_BUTCE_DAGILIM.AtanmamisMiktar = D_AtanmamisMiktar + TutarIn,
                UST_BIRIM_BUTCE_DAGILIM.ToplamButce = UST_BIRIM_BUTCE_DAGILIM.ToplamButce + TutarIn
             WHERE
                   UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo = UstBirimButceDagilimNoIn;
             SELECT '1' AS result;
         END IF;
     ELSE
         SELECT '-1' AS result;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceDagilimStatuDegistir_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceDagilimStatuDegistir_sp`(UstBirimButceDagilimNoIn CHAR(10), StatuIn CHAR(1))
BEGIN
     DECLARE D_FonksiyonelNo CHAR(10);
     DECLARE D_KurumsalNo CHAR(10);
     DECLARE D_AnaKalemNo CHAR(10);
     DECLARE D_UstBirimNo CHAR(10);
     DECLARE D_Error CHAR(2);
          SELECT
               UST_BIRIM_BUTCE.FonksiyonelNo,
               UST_BIRIM_KURUMSAL.KurumsalNo,
               UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo,
               UST_BIRIM_KURUMSAL.UstBirimNo
         INTO
             D_FonksiyonelNo,
             D_KurumsalNo,
             D_AnaKalemNo,
             D_UstBirimNo
         FROM
             UST_BIRIM_BUTCE_DAGILIM
                 JOIN
             UST_BIRIM_BUTCE  ON UST_BIRIM_BUTCE.UstBirimButceNo = UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo
                 JOIN
             UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
         WHERE
              UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo = UstBirimButceDagilimNoIn;
          IF D_UstBirimNo IS NOT NULL
          THEN
              CALL ButceDagilimStatuDegistir_sp(D_UstBirimNo,D_FonksiyonelNo,D_KurumsalNo,D_AnaKalemNo, StatuIn, D_Error);
              IF D_Error = '-1'
              THEN
                  SELECT '-1' AS result;
              ELSE
                  UPDATE
                    UST_BIRIM_BUTCE_DAGILIM
                  SET
                     UST_BIRIM_BUTCE_DAGILIM.Statu = StatuIn
                  WHERE
                   UST_BIRIM_BUTCE_DAGILIM.UstBirimButceDagilimNo = UstBirimButceDagilimNoIn;
                   SELECT '1' AS result;
              END IF;
          ELSE
              SELECT '-1' AS result;
          END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceEkle_sp`(UstBirimKurumsalNoIn CHAR(10), FonksiyonelNoIn CHAR(10), TanimlamaIn CHAR(30))
BEGIN
     DECLARE D_UstBirimButceNoIn CHAR(10);
     SELECT
           UST_BIRIM_BUTCE.UstBirimButceNo
     INTO
         D_UstBirimButceNoIn
     FROM
         UST_BIRIM_BUTCE
     WHERE
          UST_BIRIM_BUTCE.UstBirimKurumsalNo = UstBirimKurumsalNoIn
          AND UST_BIRIM_BUTCE.FonksiyonelNo = FonksiyonelNoIn;
     IF (D_UstBirimButceNoIn IS NULL)
     THEN
         call GetNextId_sp('UBB',D_UstBirimButceNoIn);
         INSERT INTO
                UST_BIRIM_BUTCE
                (UstBirimButceNo, UstBirimKurumsalNo, FonksiyonelNo, Tanimlama)
         VALUES
               (D_UstBirimButceNoIn, UstBirimKurumsalNoIn, FonksiyonelNoIn, TanimlamaIn);
         SELECT '1' AS result;
      ELSE
         SELECT '0' AS result;
      END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceGoster_sp`(UstBirimNoIn CHAR(10))
BEGIN
     SELECT
           UST_BIRIM_BUTCE.*,
           FONKSIYONEL.FonksiyonelKodu,
           FONKSIYONEL.FonksiyonelAdi,
           KURUMSAL.KurumsalKod
     FROM
         UST_BIRIM_BUTCE
              JOIN
         FONKSIYONEL    ON FONKSIYONEL.FonksiyonelNo = UST_BIRIM_BUTCE.FonksiyonelNo
              JOIN
         UST_BIRIM_KURUMSAL    ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
              JOIN
         KURUMSAL              ON KURUMSAL.KurumsalNo = UST_BIRIM_KURUMSAL.KurumsalNo
     WHERE
          UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceninAnaKalemleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceninAnaKalemleriniGoster_sp`(UstBirimNoIn CHAR(10), FonksiyonelNoIn CHAR(10), KurumsalNoIn CHAR(10))
BEGIN
     SELECT
           ANA_KALEM.*
     FROM
         ANA_KALEM
             JOIN
         UST_BIRIM_BUTCE_DAGILIM ON UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo = ANA_KALEM.AnaKalemNo
             JOIN
         UST_BIRIM_BUTCE ON UST_BIRIM_BUTCE.UstBirimButceNo = UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo
             JOIN
         UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
     WHERE
          UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
          AND UST_BIRIM_KURUMSAL.KurumsalNo = KurumsalNoIn
          AND UST_BIRIM_BUTCE.FonksiyonelNo = FonksiyonelNoIn
          AND ANA_KALEM.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimButceSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimButceSil_sp`(UstBirimButceNoIn CHAR(10))
BEGIN
     DECLARE D_UstBirimButceDagilimNo CHAR(10);
     SELECT
           UstBirimButceDagilimNo
     INTO
           D_UstBirimButceDagilimNo
     FROM
         UST_BIRIM_BUTCE_DAGILIM
     WHERE
          UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo = UstBirimButceNoIn;
     IF (D_UstBirimButceDagilimNo IS NULL)
     THEN
         DELETE
         FROM
             UST_BIRIM_BUTCE
         WHERE
              UST_BIRIM_BUTCE.UstBirimButceNo = UstBirimButceNoIn;
         SELECT '1' AS result;
     ELSE
         SELECT '0' AS result;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimEkle_sp`(UstBirimAdiIn VARCHAR(150), OUT UstBirimNo CHAR(10))
BEGIN
  call GetNextId_sp('UBR',UstBirimNo);
  INSERT INTO
            UST_BIRIM (UstBirimNo, UstBirimAdi)
  VALUES
           (UstBirimNo, UstBirimAdiIn);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimGuncelle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimGuncelle_sp`(UstBirimAdiIn VARCHAR(45), UstBirimNoIn CHAR(10))
BEGIN
DECLARE D_EskiUstBirimAdiIn VARCHAR(45);
     SET D_EskiUstBirimAdiIn = (SELECT UstBirimAdi FROM UST_BIRIM WHERE UST_BIRIM.UstBirimNo = UstBirimNoIn);
     UPDATE UST_BIRIM
     SET
            UST_BIRIM.UstBirimAdi = UstBirimAdiIn
     WHERE
            UST_BIRIM.UstBirimNo = UstBirimNoIn
            AND UST_BIRIM.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBiriminBirimlerineButceEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBiriminBirimlerineButceEkle_sp`(UstBirimNoIn CHAR(10), AnaKalemNoIn CHAR(10), FonksiyonelNoIn CHAR(10), KurumsalNoIn CHAR(10))
BEGIN
     DECLARE done             INT       DEFAULT 0;
     DECLARE D_BirimNo        CHAR(10);
     DECLARE D_ButceDagilimNo CHAR(10);
     DECLARE cur1 CURSOR FOR SELECT BirimNo FROM BIRIM WHERE BIRIM.UstBirimNo = UstBirimNoIn AND BIRIM.Statu = '1';
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
     OPEN cur1;
     REPEAT
           FETCH cur1 INTO D_BirimNo;
           IF NOT done THEN
              IF NOT EXISTS (SELECT * FROM BUTCE_DAGILIM WHERE KurumsalNo = KurumsalNoIn AND FonksiyonelNo = FonksiyonelNoIn AND BirimNo = D_BirimNo AND AnaKalemNo = AnaKalemNoIn)
              THEN
                  call GetNextId_sp('BDG', D_ButceDagilimNo);
                  INSERT INTO
                         BUTCE_DAGILIM
                         (ButceDagilimNo, FonksiyonelNo, BirimNo, AnaKalemNo, KurumsalNo, ToplamButce, KalanButce, BlokeEdilmis, ButceAtanmis)
                  VALUES
                        (D_ButceDagilimNo, FonksiyonelNoIn, D_BirimNo, AnaKalemNoIn, KurumsalNoIn, 0, 0, 0, '0');
                  
              
              END IF;
           
           END IF;
     UNTIL done END REPEAT;
  CLOSE cur1;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBiriminBirimleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBiriminBirimleriniGoster_sp`(UstBirimNoIn CHAR(10))
BEGIN
     SELECT
           BIRIM.*
     FROM
         BIRIM
              JOIN
         UST_BIRIM   ON  UST_BIRIM.UstBirimNo = BIRIM.UstBirimNo
     WHERE
          UST_BIRIM.UstBirimNo = UstBirimNoIn
          AND BIRIM.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBiriminFonksiyonelleriniGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBiriminFonksiyonelleriniGoster_sp`(UstBirimNoIn CHAR(10))
BEGIN
     SELECT
           FONKSIYONEL.*
     FROM
         FONKSIYONEL
            JOIN
         UST_BIRIM_BUTCE ON UST_BIRIM_BUTCE.FonksiyonelNo = FONKSIYONEL.FonksiyonelNo
            JOIN
         UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimKurumsalNo = UST_BIRIM_BUTCE.UstBirimKurumsalNo
     WHERE
          UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
          AND FONKSIYONEL.Statu = '1';
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimKurumsalEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimKurumsalEkle_sp`(UstBirimNoIn CHAR(10), KurumsalNoIn CHAR(10))
BEGIN
     DECLARE D_UstBirimKurumsalNo CHAR(10);
     SELECT
         UstBirimKurumsalNo
     INTO
         D_UstBirimKurumsalNo
     FROM
         UST_BIRIM_KURUMSAL
     WHERE
          UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn
          AND UST_BIRIM_KURUMSAL.KurumsalNo = KurumsalNoIn;
     IF (D_UstBirimKurumsalNo IS NOT NULL)
     THEN
         SELECT '0' AS result;
     ELSE
         call GetNextId_sp('UBK',D_UstBirimKurumsalNo);
         INSERT INTO
                UST_BIRIM_KURUMSAL
                (UstBirimKurumsalNo, UstBirimNo, KurumsalNo)
         VALUES
               (D_UstBirimKurumsalNo, UstBirimNoIn, KurumsalNoIn);
         SELECT '1' result;
     END IF;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimKurumsalGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimKurumsalGoster_sp`(UstBirimNoIn CHAR(10))
BEGIN
     SELECT
           UST_BIRIM_KURUMSAL.*,
           KURUMSAL.KurumsalKod,
           KURUMSAL.Aciklama
     FROM
         UST_BIRIM_KURUMSAL
             JOIN
         KURUMSAL          ON KURUMSAL.KurumsalNo = UST_BIRIM_KURUMSAL.KurumsalNo
     WHERE
         UST_BIRIM_KURUMSAL.UstBirimNo = UstBirimNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimKurumsalSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimKurumsalSil_sp`(UstBirimKurumsalNo CHAR(10))
BEGIN
     
     IF EXISTS (SELECT * FROM UST_BIRIM_BUTCE WHERE UST_BIRIM_BUTCE.UstBirimKurumsalNo=UstBirimKurumsalNo)
     THEN SELECT '0' AS result;
     END IF;
     DELETE
     FROM  UST_BIRIM_KURUMSAL
     WHERE UST_BIRIM_KURUMSAL.UstBirimKurumsalNo=UstBirimKurumsalNo;
     
     IF EXISTS (SELECT * FROM UST_BIRIM_KURUMSAL WHERE UST_BIRIM_KURUMSAL.UstBirimKurumsalNo=UstBirimKurumsalNo)
     THEN SELECT '-1' AS result;
     END IF;
     
     SELECT '1' AS result;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimleriGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimleriGoster_sp`(UstBirimNoIn CHAR(10))
BEGIN
  SELECT
	*
  FROM
	UST_BIRIM
  WHERE
	UST_BIRIM.UstBirimNo LIKE CONCAT( '%' , COALESCE(UstBirimNoIn,'') , '%')
	AND UST_BIRIM.Statu = '1'
  ORDER BY UST_BIRIM.UstBirimAdi;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstBirimSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstBirimSil_sp`(UstBirimNoIn CHAR(10))
BEGIN
UPDATE
           UST_BIRIM
     SET
           UST_BIRIM.Statu = '0'
     WHERE
           UST_BIRIM.UstBirimNo = UstBirimNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `UstGrupGoster_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `UstGrupGoster_sp`(GrupNoIn CHAR(10))
BEGIN
	SELECT RESULT_GRUP.*,
	RESULT_GRUP.BirimNo as BirimUstBirimNo
	FROM
	    GRUP
	        JOIN
	    BIRIM ON GRUP.BirimNo = BIRIM.BirimNo
	        JOIN
        UST_BIRIM ON BIRIM.UstBirimNo = UST_BIRIM.UstBirimNo
            JOIN
        BIRIM as BIRIM_TEMP ON BIRIM_TEMP.UstBirimNo = UST_BIRIM.UstBirimNo
            JOIN
	    GRUP AS RESULT_GRUP ON BIRIM_TEMP.BirimNo = RESULT_GRUP.BirimNo
	WHERE GRUP.GrupNo = GrupNoIn
    AND GRUP.GrupTipi = 'Bolum'
    AND RESULT_GRUP.GrupTipi = 'Fakulte'	
    UNION ALL
    SELECT RESULT_GRUP.*,
	RESULT_GRUP.BirimNo as BirimUstBirimNo
	FROM
	    GRUP
	        JOIN	
	    GRUP AS RESULT_GRUP ON GRUP.BirimNo = RESULT_GRUP.BirimNo
	WHERE GRUP.GrupNo = GrupNoIn
    AND GRUP.GrupTipi = 'Destek'
    AND RESULT_GRUP.GrupTipi = 'Idari'
    UNION ALL
    SELECT RESULT_GRUP.*,
	RESULT_GRUP.BirimNo as BirimUstBirimNo
	FROM
	    GRUP
	        JOIN
	    GRUP AS RESULT_GRUP
	WHERE GRUP.GrupNo = GrupNoIn
    AND GRUP.GrupTipi = 'Idari'
    AND RESULT_GRUP.GrupNo = '000002-GRP';	
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `YeniBiriminButceleriniEkle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `YeniBiriminButceleriniEkle_sp`(BirimNoIn CHAR(10))
BEGIN
     DECLARE done             INT       DEFAULT 0;
     DECLARE D_ButceDagilimNo    CHAR(10);
     DECLARE D_KurumsalNo    CHAR(10);
     DECLARE D_FonksiyonelNo CHAR(10);
     DECLARE D_AnaKalemNo    CHAR(10);
     DECLARE cur1 CURSOR FOR
    SELECT UST_BIRIM_KURUMSAL.KurumsalNo , UST_BIRIM_BUTCE.FonksiyonelNo , UST_BIRIM_BUTCE_DAGILIM.AnaKalemNo
    FROM BIRIM
               JOIN
          UST_BIRIM_KURUMSAL ON UST_BIRIM_KURUMSAL.UstBirimNo = BIRIM.UstBirimNo
               JOIN
          UST_BIRIM_BUTCE ON UST_BIRIM_BUTCE.UstBirimKurumsalNo = UST_BIRIM_KURUMSAL.UstBirimKurumsalNo
               JOIN
          UST_BIRIM_BUTCE_DAGILIM ON UST_BIRIM_BUTCE_DAGILIM.UstBirimButceNo = UST_BIRIM_BUTCE.UstBirimButceNo
     WHERE BIRIM.BirimNo = BirimNoIn
          AND BIRIM.Statu = '1'
          AND UST_BIRIM_BUTCE.Statu = '1'
          AND UST_BIRIM_BUTCE_DAGILIM.Statu = '1';
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
     OPEN cur1;
     REPEAT
           FETCH cur1 INTO D_KurumsalNo,D_FonksiyonelNo,D_AnaKalemNo;
           IF NOT done THEN
              IF NOT EXISTS (SELECT * FROM BUTCE_DAGILIM WHERE KurumsalNo = D_KurumsalNo AND FonksiyonelNo = D_FonksiyonelNo AND BirimNo = BirimNoIn AND AnaKalemNo = D_AnaKalemNo)
              THEN
                  call GetNextId_sp('BDG', D_ButceDagilimNo);
                  INSERT INTO
                         BUTCE_DAGILIM
                         (ButceDagilimNo, FonksiyonelNo, BirimNo, AnaKalemNo, KurumsalNo, ToplamButce, KalanButce, BlokeEdilmis, ButceAtanmis)
                  VALUES
                        (D_ButceDagilimNo, D_FonksiyonelNo, BirimNoIn, D_AnaKalemNo, D_KurumsalNo, 0, 0, 0, '0');
                  
              
              END IF;
           
           END IF;
     UNTIL done END REPEAT;
  CLOSE cur1;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ZZZIstekFisiVeGecmisiniSil_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ZZZIstekFisiVeGecmisiniSil_sp`(IstekFisiNoIn CHAR(10))
BEGIN
 DELETE FROM GECMIS
 WHERE GECMIS.IstekFisiNo = IstekFisiNoIn;
 DELETE FROM ISTEK
 WHERE ISTEK.IstekFisiNo = IstekFisiNoIn;
 DELETE FROM ISTEK_FISI
 WHERE ISTEK_FISI.IstekFisiNo = IstekFisiNoIn;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `ZZZIsteksizIstekFisiTemizle_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `ZZZIsteksizIstekFisiTemizle_sp`()
BEGIN
 UPDATE ISTEK_FISI
   SET ISTEK_FISI.Statu='0'
 WHERE
 NOT EXISTS
 (
   SELECT *
     FROM ISTEK
    WHERE ISTEK_FISI.IstekFisiNo= ISTEK.IstekFisiNo
 );
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `_UpdateDummyRequestField_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `_UpdateDummyRequestField_sp`(IstekNo CHAR(10), FieldName VARCHAR(50), FieldValue VARCHAR(50))
BEGIN
     set @s = CONCAT('UPDATE ISTEK SET ISTEK.',FieldName,' = ',"'",FieldValue,"'",' WHERE ISTEK.IstekNo = ',"'",IstekNo,"'");
     PREPARE stmt FROM @s;
     EXECUTE stmt;
     DEALLOCATE PREPARE stmt;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `_UpdateDummyRequestFormField_sp` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`SASadmin`@``*/ /*!50003 PROCEDURE `_UpdateDummyRequestFormField_sp`(IstekFisiNo CHAR(10), FieldName VARCHAR(50), FieldValue VARCHAR(50))
BEGIN
     set @s = CONCAT('UPDATE ISTEK_FISI SET ISTEK_FISI.',FieldName,' = ',"'",FieldValue,"'",' WHERE ISTEK_FISI.IstekFisiNo = ',"'",IstekFisiNo,"'");
     PREPARE stmt FROM @s;
     EXECUTE stmt;
     DEALLOCATE PREPARE stmt;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
DELIMITER ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

