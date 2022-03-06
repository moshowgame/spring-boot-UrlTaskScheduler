-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: quartz
-- ------------------------------------------------------
-- Server version	8.0.12

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
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_cron_triggers` VALUES ('quartzScheduler','10003','DEFAULT','0 0/30 * * * ? *','Asia/Shanghai'),('quartzScheduler','10004','DEFAULT','0 0/30 * * * ? *','Asia/Shanghai'),('quartzScheduler','10005','DEFAULT','0 0/30 * * * ?','Asia/Shanghai'),('quartzScheduler','10006','DEFAULT','0 0 0/6 * * ? *','Asia/Shanghai'),('quartzScheduler','10007','DEFAULT','0 0 0/12 * * ? *','Asia/Shanghai'),('quartzScheduler','10009','DEFAULT','0 0 0/6 * * ? *','Asia/Shanghai'),('quartzScheduler','10010','DEFAULT','0 0 0/12 * * ? *','Asia/Shanghai');
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE,
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler','10003','DEFAULT','JKOrder平安好医生2.0','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010003x\0'),('quartzScheduler','10004','DEFAULT','DEMO REQUEST','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010004x\0'),('quartzScheduler','10005','DEFAULT','SYNC旧浙江','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010005x\0'),('quartzScheduler','10006','DEFAULT','中国政府采购','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010006x\0'),('quartzScheduler','10007','DEFAULT','TFS - 测试任务','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010007x\0'),('quartzScheduler','10009','DEFAULT','TFS - 抓取','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010009x\0'),('quartzScheduler','10010','DEFAULT','TFS - 分析','com.software.dev.job.UrlJob','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	requestIdt\010010x\0');
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler','STATE_ACCESS'),('clusteredScheduler','TRIGGER_ACCESS'),('quartzScheduler','TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
INSERT INTO `qrtz_scheduler_state` VALUES ('clusteredScheduler','WORKPC-MOSHOW1554709322150',1554948079154,10000);
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler','10003','DEFAULT','10003','DEFAULT',NULL,1645891200000,1645891020404,5,'PAUSED','CRON',1645801609000,0,NULL,0,''),('quartzScheduler','10004','DEFAULT','10004','DEFAULT',NULL,1645891200000,1645891020423,5,'PAUSED','CRON',1645801362000,0,NULL,0,''),('quartzScheduler','10005','DEFAULT','10005','DEFAULT',NULL,1646551800000,1646550000000,5,'WAITING','CRON',1616946650000,0,NULL,0,''),('quartzScheduler','10006','DEFAULT','10006','DEFAULT',NULL,1646517600000,1646500406063,5,'PAUSED','CRON',1646322888000,0,NULL,0,''),('quartzScheduler','10007','DEFAULT','10007','DEFAULT',NULL,1646582400000,-1,5,'WAITING','CRON',1646548988000,0,NULL,0,''),('quartzScheduler','10009','DEFAULT','10009','DEFAULT',NULL,1646560800000,1646539200000,5,'PAUSED','CRON',1646500608000,0,NULL,0,''),('quartzScheduler','10010','DEFAULT','10010','DEFAULT',NULL,1646582400000,1646539200000,5,'PAUSED','CRON',1646500612000,0,NULL,0,'');
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_token`
--

DROP TABLE IF EXISTS `sys_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_token` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT,
  `token_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`token_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_token`
--

LOCK TABLES `sys_token` WRITE;
/*!40000 ALTER TABLE `sys_token` DISABLE KEYS */;
INSERT INTO `sys_token` VALUES (1,'85f3389e-d774-4f64-a96c-d4ba61f988b8');
/*!40000 ALTER TABLE `sys_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_request`
--

DROP TABLE IF EXISTS `url_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_request` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '请求id',
  `request_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求名称',
  `request_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求方法，GET/POST',
  `request_cron` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '触发时间CRON表达式',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求url',
  `status` smallint(1) DEFAULT '0' COMMENT '启用状态',
  `request_timeout` int(11) DEFAULT NULL COMMENT '超时时间ms',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`request_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10011 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_request`
--

LOCK TABLES `url_request` WRITE;
/*!40000 ALTER TABLE `url_request` DISABLE KEYS */;
INSERT INTO `url_request` VALUES (10001,'JKOrder平安好医生xxx','POST','0 0 0/1 * * ? *','http://localhost:6767/newJkOrder',0,6000,NULL),(10003,'JKOrder平安好医生2.0','POST','0 0/30 * * * ? *','http://localhost:6767/jkOrder2',0,6000,'2022-02-21 14:52:27'),(10004,'DEMO REQUEST','POST','0 0/30 * * * ? *','http://localhost:6969/quartz/demo/request',0,NULL,'2022-02-21 14:47:12'),(10006,'中国政府采购','POST','0 0 0/6 * * ? *','http://localhost:8899/tfs/task/ccgp?token=666222XXX',0,NULL,'2022-02-24 16:12:05'),(10007,'TFS - 测试任务','POST','0 0 0/12 * * ? *','http://localhost:8899/tfs/task/test?token=666222XXX',1,NULL,'2022-02-26 15:59:45'),(10009,'TFS - 抓取','POST','0 0 0/6 * * ? *','http://localhost:8899/tfs/task/fetch?token=666222XXX',0,NULL,'2022-03-05 17:16:39'),(10010,'TFS - 分析','POST','0 0 0/12 * * ? *','http://localhost:8899/tfs/task/sync?token=666222XXX',0,NULL,'2022-03-05 17:16:09');
/*!40000 ALTER TABLE `url_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_request_token`
--

DROP TABLE IF EXISTS `url_request_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_request_token` (
  `request_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求id',
  `token_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'TOKEN请求地址',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'POST' COMMENT '请求方式',
  `param` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求参数',
  `param_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '参数方式：1form表单 2json格式/xml',
  `append_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '追加参数名称',
  `append_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '追加方式：1通过url追加 2通过form追加',
  `status` smallint(1) DEFAULT '1' COMMENT '是否启动：1启用 0禁用',
  `token_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'TOKEN表达式',
  PRIMARY KEY (`request_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_request_token`
--

LOCK TABLES `url_request_token` WRITE;
/*!40000 ALTER TABLE `url_request_token` DISABLE KEYS */;
INSERT INTO `url_request_token` VALUES ('10004','http://localhost:6969/quartz/demo/token','GET','{\"username\":\"123456\",\"password\":\"456789\"}','JSON','token','URL',1,'msg.token');
/*!40000 ALTER TABLE `url_request_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_response`
--

DROP TABLE IF EXISTS `url_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_response` (
  `response_id` varchar(50) NOT NULL COMMENT '响应id',
  `request_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求id',
  `response_time` timestamp(3) NULL DEFAULT NULL COMMENT '应答时间',
  `response_text` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '响应内容',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：0失败 1成功 9无响应',
  `request_time` timestamp(3) NULL DEFAULT NULL COMMENT '请求时间',
  `assumption_result` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '推断结果',
  PRIMARY KEY (`response_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_response`
--

LOCK TABLES `url_response` WRITE;
/*!40000 ALTER TABLE `url_response` DISABLE KEYS */;
INSERT INTO `url_response` VALUES ('1','10005','2021-03-28 15:54:40.000','{\"code\":200,\"msg\":\"操作成功\",\"data\":null,\"count\":0}',NULL,NULL,NULL),('0111ebf9-4610-4527-a418-049e73581bf1','10004','2022-02-20 07:36:58.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',NULL,NULL,NULL),('544f6d8c-d70c-43e2-8a41-72b1870b38d9','10004','2022-02-20 07:46:34.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',NULL,NULL,NULL),('ed8311b8-4a58-400a-a691-7c50f6a1f19e','10004','2022-02-20 07:49:49.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',NULL,NULL,NULL),('16dfbeeb-9b70-481e-8236-bbac0bff5bcb','10004','2022-02-20 08:30:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 08:30:00.000',NULL),('f9ad2d5b-a0f1-4d15-89d1-9912e66e6ecb','10004','2022-02-20 09:00:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 09:00:00.000',NULL),('d8ddc158-55ec-4f7c-a744-a210c3c88f65','10004','2022-02-20 09:30:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 09:30:00.000',NULL),('d8973498-86f0-48a1-97b9-ef5885b7c9fc','10004','2022-02-20 09:34:08.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 09:34:08.000',NULL),('98e96ff3-1848-44a3-8db8-49221580f653','10004','2022-02-20 10:00:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 10:00:00.000',NULL),('1ce52d7d-b98d-454d-b177-e7aa64da2240','10004','2022-02-20 10:30:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 10:30:00.000',NULL),('1abda533-e0a0-4f3a-9dc5-80fc2da83105','10004','2022-02-20 11:00:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 11:00:00.000',NULL),('ee26b1c1-e3d4-4e14-8c6d-5fc6285cac51','10004','2022-02-20 11:29:22.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 11:29:22.000',NULL),('8e207363-839e-4893-abc1-1e2d12ba64fd','10004','2022-02-20 11:30:00.000','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 11:30:00.000',NULL),('69cf8db8-c841-453c-9d4b-956ec4ae623b','10004','2022-02-20 11:30:55.642','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 11:30:55.638',NULL),('3b148b04-b5b7-4b0a-880d-fb37122adfee','10004','2022-02-20 11:33:38.270','{\"msg\":\"请求失败\",\"code\":500}',9,'2022-02-20 11:33:38.257',NULL),('fef77cdc-b021-4f8c-a921-2cd2cac315f3','10004','2022-02-20 12:00:00.102','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 12:00:00.098',NULL),('1cdd57b2-85d5-49d4-a282-362f54421cab','10004','2022-02-20 12:30:00.095','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 12:30:00.092',NULL),('d11408f0-abad-46be-8ba7-61a681be7ba7','10004','2022-02-20 13:00:00.058','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 13:00:00.054',NULL),('728f0055-0ee8-4865-ab54-de79ff45dc47','10004','2022-02-20 13:30:00.114','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 13:30:00.106',NULL),('6123f2bd-509a-43b2-963b-abf795ccb9df','10004','2022-02-20 14:00:00.071','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 14:00:00.068',NULL),('329373e0-2e8b-4b8b-8bbc-f21331cf019d','10004','2022-02-20 14:30:00.518','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-20 14:30:00.502',NULL),('1a4d23a7-2224-4b64-8c8d-c25367540d09','10004','2022-02-21 14:23:51.232','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-21 14:23:51.213',NULL),('6ce084f1-d8c0-4f43-82f5-2955a7c83f6d','10004','2022-02-21 14:30:00.060','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-21 14:30:00.056',NULL),('7ca09ced-82ae-4c31-bdf4-2414837087d4','10004','2022-02-21 15:00:00.075','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-21 15:00:00.070',NULL),('bb15c9a1-41b5-4d8e-b4bf-656b317c2c10','10004','2022-02-21 15:30:00.433','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-21 15:30:00.420',NULL),('ac02bc3b-c95c-4b49-8b2d-1d3386f28558','10004','2022-02-24 16:02:47.630','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-24 16:02:47.605',NULL),('f3ce69ad-df09-4dcc-a44a-279cae9b3b80','10006','2022-02-24 16:08:43.581','{\"code\":500,\"msg\":\"授权失败::定时任务无法启动\",\"data\":null,\"count\":0}',1,'2022-02-24 16:08:42.902',NULL),('4e8895d6-3fd4-4c5d-af71-c6285adae027','10006','2022-02-24 16:14:24.454','Connection refused: connect',9,'2022-02-24 16:12:09.266',NULL),('7e4be502-4c74-40d5-a59d-e2ed34480829','10006','2022-02-24 16:18:56.957','Connection refused: connect',9,'2022-02-24 16:18:00.616',NULL),('176c2e10-302f-4fe9-a324-2120db3560e8','10006','2022-02-25 14:52:29.150','ConnectException: Connection refused: connect',9,'2022-02-25 14:52:27.031',NULL),('f2c08640-e793-4919-bae2-35152c6b102c','10004','2022-02-25 15:02:44.951','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-25 15:02:44.937',NULL),('d166fc20-5cf1-42a7-aaa9-7b1e7b09d031','10004','2022-02-25 15:03:55.278','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-25 15:03:55.274',NULL),('452d5299-1ec0-4ffd-8660-70183088c85c','10003','2022-02-25 15:04:22.476','ConnectException: Connection refused: connect',9,'2022-02-25 15:04:20.439',NULL),('751439b7-a0d0-4ba6-a378-b42c2f7efeae','10003','2022-02-25 15:06:55.255','ConnectException: Connection refused: connect',9,'2022-02-25 15:06:53.168',NULL),('d36930e9-14d7-4856-88b8-841d31167b07','10003','2022-02-25 15:07:02.443','ConnectException: Connection refused: connect',9,'2022-02-25 15:07:00.410',NULL),('d103c128-105f-4d91-8cef-0809707cfbd7','10004','2022-02-25 15:30:00.184','{\"msg\":\"请求成功，TOKEN有效\",\"code\":0}',1,'2022-02-25 15:30:00.176',NULL),('fbf9864b-9455-4fdf-b396-afb7affe2b99','10003','2022-02-25 15:30:02.139','ConnectException: Connection refused: connect',9,'2022-02-25 15:30:00.083',NULL),('1ad06c84-2fe4-4821-b218-66b77c2a4774','10003','2022-02-25 16:00:02.141','ConnectException: Connection refused: connect',9,'2022-02-25 16:00:00.095',NULL),('172815bc-72d1-48b9-b435-0a584b89d8f6','10003','2022-02-25 16:30:02.082','ConnectException: Connection refused: connect',9,'2022-02-25 16:30:00.061',NULL),('0cf20e0f-aba2-4532-8a75-ee405cf5da1d','10003','2022-02-25 17:00:02.322','ConnectException: Connection refused: connect',9,'2022-02-25 17:00:00.228',NULL),('4fae4c3b-b294-4244-99bb-c1626575a38f','10003','2022-02-26 15:57:03.178','ConnectException: Connection refused: connect',9,'2022-02-26 15:57:00.996',NULL),('d17ef159-59a9-4b26-894b-ca80fe61e383','10007','2022-02-26 16:01:10.272','{\"code\":500,\"msg\":\"No format fit for date String [<div class=\\\"news-list__annunciate__date\\\">2022-02-25</div>] !\",\"data\":null,\"count\":0}',1,'2022-02-26 16:01:09.043',NULL),('e35544fa-479e-4386-b58e-c6f64f8e63b0','10007','2022-02-26 16:04:50.213','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 16:04:49.161',NULL),('f63b745f-43c3-472b-893e-a408fa319c29','10007','2022-02-26 16:48:11.004','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 16:47:25.184',NULL),('3f9b0fae-2e88-4f87-83fd-0ebe17d3888c','10007','2022-02-26 16:54:10.142','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 16:50:39.219',NULL),('a8c316fd-0fce-4407-8239-008d295026f3','10007','2022-02-26 17:00:08.124','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:00:06.307',NULL),('09062465-350d-428e-b20c-401a990f2fe7','10007','2022-02-26 17:01:37.554','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:00:53.521',NULL),('6c5a45d7-615d-4c30-8fc3-01a4ec4e252e','10007','2022-02-26 17:03:36.002','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:02:11.169',NULL),('ee696333-302c-4b05-9f6d-74ff8327d368','10007','2022-02-26 17:12:10.765','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:12:09.228',NULL),('17ec2bb3-831f-4929-b2e2-f20f672481dc','10007','2022-02-26 17:14:50.122','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:14:48.522',NULL),('3f09fdeb-4a5c-4d0c-a50c-c48652ac0da4','10007','2022-02-26 17:17:08.204','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:17:06.812',NULL),('62b3006e-2528-4294-82d5-c2b6fcf00ce1','10007','2022-02-26 17:18:42.348','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:18:41.182',NULL),('8668f499-e2e2-49a5-a907-fdc7d7f1bdcc','10007','2022-02-26 17:20:14.697','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:20:13.997',NULL),('61c06eac-a8a4-44c4-91b4-f48c982e56cd','10007','2022-02-26 17:22:31.261','Connection refused: connect',9,'2022-02-26 17:21:35.930',NULL),('6a828d0f-8054-48ed-994e-f7c6ed1e2957','10007','2022-02-26 17:26:33.933','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-02-26 17:23:41.401',NULL),('f041b136-a356-4f19-8f63-a20b93e31a4b','10007','2022-03-03 15:50:10.928','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-03 15:50:10.082',NULL),('23cf16ff-3d19-4abd-9c9e-e49ff5c3d155','10007','2022-03-03 15:51:59.136','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-03 15:51:58.730',NULL),('de354f3c-9da8-434b-b9af-313f2da960db','10007','2022-03-03 15:53:13.140','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-03 15:53:02.636',NULL),('c2d8d106-23ea-4aa3-b872-ce10a085d912','10006','2022-03-03 16:30:20.073','{\"code\":200,\"msg\":\"定时任务处理成功::ccgpTask\",\"data\":null,\"count\":0}',1,'2022-03-03 15:54:50.430',NULL),('74622894-b750-4134-b343-b4a6438125bd','10006','2022-03-03 17:01:11.814','Connection refused: connect',9,'2022-03-03 16:31:09.915',NULL),('764eb1e3-3ba9-4b64-8253-38484f620ae4','10006','2022-03-05 17:13:28.567','ConnectException: Connection refused: connect',9,'2022-03-05 17:13:26.454',NULL),('2b42df55-2999-4109-abb0-08c8555b142c','10010','2022-03-05 17:17:13.044','{\"code\":200,\"msg\":\"定时任务处理成功::globalSyncTask\",\"data\":null,\"count\":0}',1,'2022-03-05 17:17:10.371',NULL),('fcd47193-4c63-4799-b4fe-d7e6968daf15','10009','2022-03-05 17:48:31.900','{\"code\":200,\"msg\":\"定时任务处理成功::globalFetchTask\",\"data\":null,\"count\":0}',1,'2022-03-05 17:17:27.923',NULL),('9e983ef5-855f-49fc-aedc-8ab962a94a1b','10009','2022-03-05 22:03:48.491','{\"code\":200,\"msg\":\"定时任务处理成功::globalFetchTask\",\"data\":null,\"count\":0}',1,'2022-03-05 22:00:00.130',NULL),('e1518ce3-d3ea-432d-be9c-4e12fa69d203','10009','2022-03-06 04:04:47.239','{\"code\":200,\"msg\":\"定时任务处理成功::globalFetchTask\",\"data\":null,\"count\":0}',1,'2022-03-06 04:00:00.078',NULL),('95e8c212-53dc-4ab0-9cf3-5f511c56ec39','10010','2022-03-06 04:06:53.264','{\"code\":200,\"msg\":\"定时任务处理成功::globalSyncTask\",\"data\":null,\"count\":0}',1,'2022-03-06 04:00:00.111',NULL),('e3e37937-b75e-42bb-8747-8a0acc7ff7e7','10007','2022-03-06 06:44:46.972','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-06 06:43:11.138',NULL),('39f08047-8abd-4b07-9ac6-7b2c44227a41','10007','2022-03-06 06:45:35.197','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-06 06:45:34.100',NULL),('23b307d9-cc11-44af-93b0-a9660051b4be','10007','2022-03-06 06:48:29.518','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-06 06:48:28.978',NULL),('5eca9e01-96dc-4365-834f-5b3ae2421c75','10007','2022-03-06 06:59:47.240','{\"code\":200,\"msg\":\"定时任务处理成功::testTask\",\"data\":null,\"count\":0}',1,'2022-03-06 06:59:44.127','成功');
/*!40000 ALTER TABLE `url_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_response_assumption`
--

DROP TABLE IF EXISTS `url_response_assumption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_response_assumption` (
  `request_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `key_first` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '第一关键字',
  `value_first` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `key_second` varchar(100) DEFAULT NULL,
  `value_second` varchar(100) DEFAULT NULL,
  `key_third` varchar(100) DEFAULT NULL,
  `value_third` varchar(100) DEFAULT NULL,
  `value_else` varchar(100) DEFAULT NULL,
  `status` int(1) DEFAULT '1',
  PRIMARY KEY (`request_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='断言';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_response_assumption`
--

LOCK TABLES `url_response_assumption` WRITE;
/*!40000 ALTER TABLE `url_response_assumption` DISABLE KEYS */;
INSERT INTO `url_response_assumption` VALUES ('10001','success','成功','','','','','失败',1),('10010','定时任务处理成功','成功','','','','','失败',1),('10009','定时任务处理成功','成功','','','','','失败',1),('10007','定时任务处理成功','成功','','','','','失败',1);
/*!40000 ALTER TABLE `url_response_assumption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'quartz'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-06 15:10:46
