/*
MySQL Data Transfer
Source Host: 115.238.251.115
Source Database: grassdata
Target Host: 115.238.251.115
Target Database: grassdata
Date: 2018/3/30 10:16:11
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for applydatas
-- ----------------------------
CREATE TABLE `applydatas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coordinate` varchar(100) NOT NULL,
  `data_type` varchar(500) NOT NULL,
  `start_time` varchar(10) NOT NULL,
  `end_time` varchar(10) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` varchar(10) DEFAULT '审核中',
  `userId` int(11) DEFAULT NULL,
  `pixel` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `applydatas_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Table structure for bigdatatypes
-- ----------------------------
CREATE TABLE `bigdatatypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_type` varchar(50) DEFAULT NULL,
  `data_type_english` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Table structure for services
-- ----------------------------
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `big_data_type` varchar(50) NOT NULL,
  `small_data_type` varchar(50) NOT NULL,
  `year_` int(5) NOT NULL,
  `layer` varchar(40) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `workspace` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Table structure for smalldatatypes
-- ----------------------------
CREATE TABLE `smalldatatypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_type` varchar(50) DEFAULT NULL,
  `data_type_english` varchar(50) DEFAULT NULL,
  `big_data_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `big_data_type_id` (`big_data_type_id`),
  CONSTRAINT `smalldatatypes_ibfk_1` FOREIGN KEY (`big_data_type_id`) REFERENCES `bigdatatypes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `user_type` varchar(10) NOT NULL,
  `extras` varchar(200) DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `mobilephone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `applydatas` VALUES ('22', '116.39;39.94', '{\"weather\":[\"tempature_max\"]}', '2011', '2013', '2018-03-22 08:39:50', '2018-03-22 08:39:50', '审核中', '3', '310;113');
INSERT INTO `applydatas` VALUES ('23', '116.39;39.94', '{\"weather\":[\"tempature_min\"]}', '2005', '2011', '2018-03-22 08:59:19', '2018-03-22 08:59:19', '审核中', '3', '300;120');
INSERT INTO `applydatas` VALUES ('24', '116.47;39.90', '{\"weather\":[\"tempature_min\"]}', '2005', '2012', '2018-03-26 14:51:12', '2018-03-26 14:51:12', '审核中', '3', '521;259');
INSERT INTO `applydatas` VALUES ('25', '116.41;39.91', '{\"vegetation\":[\"ndvi\"]}', '2005', '2013', '2018-03-30 09:07:50', '2018-03-30 09:07:50', '审核中', '3', '356;232');
INSERT INTO `applydatas` VALUES ('26', '116.37;39.89', '{\"carbon\":[\"NPP\"]}', '2005', '2010', '2018-03-30 09:47:52', '2018-03-30 09:47:52', '审核中', '3', '280;168');
INSERT INTO `bigdatatypes` VALUES ('1', '气象数据', 'weather');
INSERT INTO `bigdatatypes` VALUES ('2', '土壤数据', 'soil');
INSERT INTO `bigdatatypes` VALUES ('3', '植被数据', 'vegetation');
INSERT INTO `bigdatatypes` VALUES ('4', '地形数据', 'terrain');
INSERT INTO `bigdatatypes` VALUES ('5', '固碳现状', 'carbon');
INSERT INTO `services` VALUES ('1', '气象数据', '最低温度(月)', '2005', 'tempature_min_2005', '2018-03-28 15:43:57', '2018-01-27 14:34:38', 'grassLandCoverage');
INSERT INTO `services` VALUES ('2', '气象数据', '最低温度(月)', '2006', 'tempature_min_2006', '2018-03-28 15:45:31', '2018-01-27 14:35:42', 'grassLandCoverage');
INSERT INTO `services` VALUES ('3', '气象数据', '最低温度(月)', '2007', 'tempature_min_2007', '2018-03-28 15:45:18', '2018-01-27 14:35:59', 'grassLandCoverage');
INSERT INTO `services` VALUES ('4', '气象数据', '最低温度(月)', '2008', 'tempature_min_2008', '2018-03-28 15:45:15', '2018-01-27 14:36:15', 'grassLandCoverage');
INSERT INTO `services` VALUES ('5', '气象数据', '最低温度(月)', '2009', 'tempature_min_2009', '2018-03-28 15:45:12', '2018-01-27 14:36:30', 'grassLandCoverage');
INSERT INTO `services` VALUES ('6', '气象数据', '最低温度(月)', '2010', 'tempature_min_2010', '2018-03-28 15:45:09', '2018-01-27 14:36:46', 'grassLandCoverage');
INSERT INTO `services` VALUES ('7', '气象数据', '最低温度(月)', '2011', 'tempature_min_2011', '2018-03-28 15:45:06', '2018-01-27 14:37:00', 'grassLandCoverage');
INSERT INTO `services` VALUES ('8', '气象数据', '最低温度(月)', '2012', 'tempature_min_2012', '2018-03-28 15:45:02', '2018-01-27 14:37:14', 'grassLandCoverage');
INSERT INTO `services` VALUES ('9', '气象数据', '最低温度(月)', '2013', 'tempature_min_2013', '2018-03-28 15:44:58', '2018-01-27 14:37:29', 'grassLandCoverage');
INSERT INTO `services` VALUES ('13', '气象数据', '最低温度(月)', '2004', 'tempature_min_2004', '2018-03-28 15:44:53', '2018-03-06 11:03:51', 'grassLandCoverage');
INSERT INTO `services` VALUES ('14', '气象数据', '最高温度(月)', '2005', 'tempature_max_2005', '2018-03-28 15:44:48', '2018-03-07 16:06:10', 'grassLandCoverage');
INSERT INTO `services` VALUES ('15', '气象数据', '最高温度(月)', '2006', 'tempature_max_2006', '2018-03-28 15:44:43', '2018-03-07 16:06:51', 'grassLandCoverage');
INSERT INTO `services` VALUES ('16', '气象数据', '最高温度(月)', '2007', 'tempature_max_2007', '2018-03-28 15:44:39', '2018-03-07 16:07:06', 'grassLandCoverage');
INSERT INTO `services` VALUES ('17', '气象数据', '最高温度(月)', '2008', 'tempature_max_2008', '2018-03-28 15:44:35', '2018-03-07 16:07:16', 'grassLandCoverage');
INSERT INTO `services` VALUES ('18', '气象数据', '最高温度(月)', '2009', 'tempature_max_2009', '2018-03-28 15:44:31', '2018-03-07 16:07:30', 'grassLandCoverage');
INSERT INTO `services` VALUES ('19', '气象数据', '最高温度(月)', '2010', 'tempature_max_2010', '2018-03-28 15:44:27', '2018-03-07 16:07:40', 'grassLandCoverage');
INSERT INTO `services` VALUES ('20', '气象数据', '最高温度(月)', '2011', 'tempature_max_2011', '2018-03-28 15:44:24', '2018-03-07 16:07:51', 'grassLandCoverage');
INSERT INTO `services` VALUES ('21', '气象数据', '最高温度(月)', '2012', 'tempature_max_2012', '2018-03-28 15:44:20', '2018-03-07 16:08:02', 'grassLandCoverage');
INSERT INTO `services` VALUES ('22', '气象数据', '最高温度(月)', '2013', 'tempature_max_2013', '2018-03-28 15:44:15', '2018-03-07 16:08:15', 'grassLandCoverage');
INSERT INTO `services` VALUES ('25', '植被数据', 'NDVI(月最大合成)', '2005', 'nvdi_2005', '2018-03-30 09:12:04', '2018-03-30 09:12:04', 'grassLandCoverage');
INSERT INTO `services` VALUES ('26', '植被数据', 'NDVI(月最大合成)', '2006', 'nvdi_2006', '2018-03-30 09:12:20', '2018-03-30 09:12:20', 'grassLandCoverage');
INSERT INTO `services` VALUES ('27', '植被数据', 'NDVI(月最大合成)', '2007', 'nvdi_2007', '2018-03-30 09:12:40', '2018-03-30 09:12:40', 'grassLandCoverage');
INSERT INTO `services` VALUES ('28', '植被数据', 'NDVI(月最大合成)', '2008', 'nvdi_2008', '2018-03-30 09:12:56', '2018-03-30 09:12:56', 'grassLandCoverage');
INSERT INTO `services` VALUES ('29', '植被数据', 'NDVI(月最大合成)', '2009', 'nvdi_2009', '2018-03-30 09:13:08', '2018-03-30 09:13:08', 'grassLandCoverage');
INSERT INTO `services` VALUES ('30', '植被数据', 'NDVI(月最大合成)', '2010', 'nvdi_2010', '2018-03-30 09:13:18', '2018-03-30 09:13:18', 'grassLandCoverage');
INSERT INTO `services` VALUES ('31', '植被数据', 'NDVI(月最大合成)', '2011', 'nvdi_2011', '2018-03-30 09:14:11', '2018-03-30 09:14:11', 'grassLandCoverage');
INSERT INTO `services` VALUES ('32', '植被数据', 'NDVI(月最大合成)', '2012', 'nvdi_2012', '2018-03-30 09:14:22', '2018-03-30 09:14:22', 'grassLandCoverage');
INSERT INTO `services` VALUES ('33', '植被数据', 'NDVI(月最大合成)', '2013', 'nvdi_2013', '2018-03-30 09:14:34', '2018-03-30 09:14:34', 'grassLandCoverage');
INSERT INTO `services` VALUES ('38', '固碳现状', '植被净生产力', '2005', 'NPP_2005', '2018-03-30 09:55:50', '2018-03-30 09:55:50', 'carbon');
INSERT INTO `services` VALUES ('39', '固碳现状', '植被净生产力', '2006', 'NPP_2006', '2018-03-30 09:56:01', '2018-03-30 09:56:01', 'carbon');
INSERT INTO `services` VALUES ('40', '固碳现状', '植被净生产力', '2007', 'NPP_2007', '2018-03-30 09:56:12', '2018-03-30 09:56:12', 'carbon');
INSERT INTO `services` VALUES ('41', '固碳现状', '植被净生产力', '2008', 'NPP_2008', '2018-03-30 09:56:23', '2018-03-30 09:56:23', 'carbon');
INSERT INTO `services` VALUES ('42', '固碳现状', '植被净生产力', '2009', 'NPP_2009', '2018-03-30 09:56:33', '2018-03-30 09:56:33', 'carbon');
INSERT INTO `services` VALUES ('43', '固碳现状', '植被净生产力', '2010', 'NPP_2010', '2018-03-30 09:56:44', '2018-03-30 09:56:44', 'carbon');
INSERT INTO `smalldatatypes` VALUES ('2', '最低温度(月)', 'tempature_min', '1');
INSERT INTO `smalldatatypes` VALUES ('3', '最高温度(月)', 'tempature_max', '1');
INSERT INTO `smalldatatypes` VALUES ('4', 'NDVI(月最大合成)', 'ndvi', '3');
INSERT INTO `smalldatatypes` VALUES ('5', '平均温度(月)', 'tempature_average', '1');
INSERT INTO `smalldatatypes` VALUES ('9', '叶面积指数', 'LAI', '3');
INSERT INTO `smalldatatypes` VALUES ('11', '*高程', 'altitude_*', '4');
INSERT INTO `smalldatatypes` VALUES ('12', '植被净生产力', 'NPP', '5');
INSERT INTO `smalldatatypes` VALUES ('13', '土壤有机碳储量', 'SOC', '5');
INSERT INTO `users` VALUES ('1', 'testtest1', 'testtest2', '1', null, null, null, null);
INSERT INTO `users` VALUES ('2', 'adminadmin', 'adminadmin', '0', null, null, null, null);
INSERT INTO `users` VALUES ('3', 'test1234', 'testtest', '1', null, null, null, null);
INSERT INTO `users` VALUES ('4', 'caodi', '123456', '1', null, 'caodi', 'caodi@foxmail.com', '13767225247');
