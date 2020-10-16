-- -----------------------------
-- Think MySQL Data Transfer 
-- 
-- Host     : 127.0.0.1
-- Port     : 3306
-- Database : qwadmin
-- 
-- Part : #1
-- Date : 2020-09-13 01:12:17
-- -----------------------------

SET FOREIGN_KEY_CHECKS = 0;


-- -----------------------------
-- Table structure for `qw_report`
-- -----------------------------
DROP TABLE IF EXISTS `qw_report`;
CREATE TABLE `qw_report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `content` varchar(255) NOT NULL COMMENT '内容',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  `week` varchar(10) DEFAULT NULL COMMENT '时间',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注',
  `finsh` varchar(255) DEFAULT NULL COMMENT '进度',
  `year` varchar(70) DEFAULT '2020' COMMENT '学年',
  `user` varchar(50) DEFAULT NULL COMMENT '用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

