-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.37-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema wind_monitor
--

CREATE DATABASE IF NOT EXISTS wind_monitor;
USE wind_monitor;

--
-- Definition of table `mst_city`
--

DROP TABLE IF EXISTS `mst_city`;
CREATE TABLE `mst_city` (
  `city_id` int(10) unsigned NOT NULL auto_increment,
  `city_name` varchar(45) NOT NULL,
  `state_id` int(10) unsigned default NULL,
  `station_code` varchar(10) default NULL,
  PRIMARY KEY  (`city_id`),
  KEY `Index_2` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mst_city`
--

/*!40000 ALTER TABLE `mst_city` DISABLE KEYS */;
INSERT INTO `mst_city` (`city_id`,`city_name`,`state_id`,`station_code`) VALUES 
 (1,'Visakhapatnam',1,'AN-VI-01'),
 (2,'Vijayawada',1,'AN-VI-02'),
 (3,'Naharlagun',2,'AR-NA-01'),
 (4,'Pasighat',2,'AR-PA-02'),
 (5,'Guwahati',3,'AS-GU-01'),
 (6,'Silchar',3,'AS-SI-02'),
 (7,'Patna',4,'BI-PA-01'),
 (8,'Gaya',4,'BI-PA-02'),
 (9,'Raipur',5,'CH-RA-01'),
 (10,'Bhilai Nagar',5,'CH-BH-02'),
 (11,'Marmagao',6,'GO-MA-01'),
 (12,'Panaji',6,'GO-PA-01'),
 (13,'Ahmedabad',7,'GU-AH-01'),
 (14,'Surat',7,'GU-SU-02'),
 (15,'Faridabad',8,'HA-FA-01'),
 (16,'Gurgaon',8,'HA-GU-02'),
 (17,'Shimla',9,'HI-SH-01'),
 (18,'Mandi',9,'HI-MA-01'),
 (19,'Srinagar',10,'JA-SR-01'),
 (20,'Jammu',10,'JA-JA-02'),
 (21,'Ranchi',11,'JH-RA-01'),
 (22,'Jamshedpur',11,'JH-JA-02'),
 (23,'Bengaluru',12,'KA-BE-01'),
 (24,'Mysore',12,'KA-MY-02'),
 (25,'Thiruvananthapuram',13,'KE-TH-01'),
 (26,'Kochi',13,'KE-KO-02'),
 (27,'Indore',14,'MA-IN-01'),
 (28,'Bhopal',14,'MA-BH-01'),
 (29,'Mumbai',15,'MA-MU-01'),
 (30,'Pune',15,'MA-MU-01'),
 (31,'Imphal',16,'MA-IM-01');
INSERT INTO `mst_city` (`city_id`,`city_name`,`state_id`,`station_code`) VALUES 
 (32,'Thoubal',16,'MA-TH-02'),
 (33,'Shillong',17,'ME-SH-01'),
 (34,'Tura',17,'ME-TU-02'),
 (35,'Aizawl',18,'MI-AI-01'),
 (36,'Lunglei',18,'MI-LU-02'),
 (37,'Dimapur',19,'NA-DI-01'),
 (38,'Kohima',19,'NA-KO-02'),
 (39,'Bhubaneswar',20,'OD-BH-01'),
 (40,'Cuttack',20,'OD-CU-02'),
 (41,'Ludhiana',21,'PU-LU-01'),
 (42,'Amritsar',21,'PU-AM-01'),
 (43,'Jaipur',22,'RA-JA-01'),
 (44,'Jodhpur',22,'RA-JO-02'),
 (45,'Chennai',24,'TN-CH-01'),
 (46,'Coimbatore',24,'TN-CO-02'),
 (47,'Agartala',25,'TI-AG-01'),
 (48,'Udaipur',25,'TI-UD-02'),
 (49,'Lucknow',26,'UT-LU-01'),
 (50,'Kanpur',26,'UT-KA-02'),
 (51,'Dehradun',27,'UT-DE-01'),
 (52,'Hardwar',27,'UT-HA-02'),
 (53,'Kolkata',28,'WE-KO-01'),
 (54,'Siliguri',28,'WE-SI-02'),
 (55,'Hyderabad',23,'TE-HY-01'),
 (56,'Warangal',23,'TE-WA-02'),
 (57,'Gangtok',29,'SI-GA-01'),
 (58,'Ghezing',29,'SI-GH-02');
/*!40000 ALTER TABLE `mst_city` ENABLE KEYS */;


--
-- Definition of table `mst_state`
--

DROP TABLE IF EXISTS `mst_state`;
CREATE TABLE `mst_state` (
  `state_id` int(10) unsigned NOT NULL auto_increment,
  `state_name` varchar(45) default NULL,
  PRIMARY KEY  (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mst_state`
--

/*!40000 ALTER TABLE `mst_state` DISABLE KEYS */;
INSERT INTO `mst_state` (`state_id`,`state_name`) VALUES 
 (1,'Andhra Pradesh'),
 (2,'Arunachal Pradesh'),
 (3,'Assam'),
 (4,'Bihar'),
 (5,'Chhattisgarh'),
 (6,'Goa'),
 (7,'Gujarat'),
 (8,'Haryana'),
 (9,'Himachal Pradesh'),
 (10,'Jammu and Kashmir'),
 (11,'Jharkhand'),
 (12,'Karnataka'),
 (13,'Kerala'),
 (14,'Madhya Pradesh'),
 (15,'Maharashtra'),
 (16,'Manipur'),
 (17,'Meghalaya'),
 (18,'Mizoram'),
 (19,'Nagaland'),
 (20,'Odisha(Orissa)'),
 (21,'Punjab'),
 (22,'Rajasthan'),
 (23,'Telangana'),
 (24,'Tamil Nadu'),
 (25,'Tripura'),
 (26,'Uttar Pradesh'),
 (27,'Uttarakhand'),
 (28,'West Bengal'),
 (29,'Sikkim');
/*!40000 ALTER TABLE `mst_state` ENABLE KEYS */;


--
-- Definition of table `trn_historicaldata`
--

DROP TABLE IF EXISTS `trn_historicaldata`;
CREATE TABLE `trn_historicaldata` (
  `historicaldata_id` int(10) unsigned NOT NULL auto_increment,
  `city_id` int(10) unsigned default NULL,
  `state_id` int(10) unsigned default NULL,
  `station_code` varchar(10) default NULL,
  `trn_date` date default NULL,
  `predicted_speed` int(11) default '0',
  `actual_speed` int(11) default '0',
  `vairance` int(11) default '0',
  PRIMARY KEY  (`historicaldata_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trn_historicaldata`
--

/*!40000 ALTER TABLE `trn_historicaldata` DISABLE KEYS */;
INSERT INTO `trn_historicaldata` (`historicaldata_id`,`city_id`,`state_id`,`station_code`,`trn_date`,`predicted_speed`,`actual_speed`,`vairance`) VALUES 
 (1,5,3,'AS-GU-01','2016-06-04',12,11,1),
 (2,5,3,'AS-GU-01','2016-06-05',20,6,6),
 (3,5,3,'AS-GU-01','2016-06-06',25,3,11),
 (4,5,3,'AS-GU-01','2016-06-07',8,4,4),
 (5,5,3,'AS-GU-01','2016-06-08',5,2,10),
 (6,5,3,'AS-GU-01','2016-06-09',9,2,10),
 (7,5,3,'AS-GU-01','2016-06-10',6,2,10),
 (8,5,3,'AS-GU-01','2016-06-11',8,2,10),
 (9,5,3,'AS-GU-01','2016-06-12',4,2,10),
 (10,5,3,'AS-GU-01','2016-06-13',14,2,10),
 (11,5,3,'AS-GU-01','2016-06-14',15,2,10),
 (12,5,3,'AS-GU-01','2016-06-15',12,2,10),
 (13,5,3,'AS-GU-01','2016-06-16',7,2,10),
 (14,5,3,'AS-GU-01','2016-06-17',5,2,10),
 (15,5,3,'AS-GU-01','2016-06-18',7,2,10),
 (16,5,3,'AS-GU-01','2016-06-19',8,2,10),
 (17,5,3,'AS-GU-01','2016-06-20',14,2,10),
 (18,5,3,'AS-GU-01','2016-06-21',15,2,10),
 (19,5,3,'AS-GU-01','2016-06-22',13,5,-5);
/*!40000 ALTER TABLE `trn_historicaldata` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
