-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1:3306
-- 生成日期： 2020-01-04 01:21:16
-- 服务器版本： 5.7.24
-- PHP 版本： 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `qwadmin`
--

-- --------------------------------------------------------

--
-- 表的结构 `qw_article`
--

DROP TABLE IF EXISTS `qw_article`;
CREATE TABLE IF NOT EXISTS `qw_article` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL COMMENT '分类id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `seotitle` varchar(255) DEFAULT NULL COMMENT 'SEO标题',
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `description` varchar(255) NOT NULL COMMENT '摘要',
  `thumbnail` varchar(255) NOT NULL COMMENT '缩略图',
  `content` text NOT NULL COMMENT '内容',
  `t` int(10) UNSIGNED NOT NULL COMMENT '时间',
  `n` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '点击',
  PRIMARY KEY (`aid`),
  KEY `sid` (`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `qw_auth_group`
--

DROP TABLE IF EXISTS `qw_auth_group`;
CREATE TABLE IF NOT EXISTS `qw_auth_group` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_auth_group`
--

INSERT INTO `qw_auth_group` (`id`, `title`, `status`, `rules`) VALUES
(1, '超级管理员', 1, '0'),
(2, '管理员', 0, '1,66,71,70,69,68,67,2,58,60,59,61,62,3,56,4,6,5,7,8,9,10,51,52,53,57,11,54,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,36,37,38,39,40,41,42,43,44,45,46,47,63,48,49,50,55'),
(3, '普通用户', 1, '1'),
(8, '机房管理人员', 1, '66,69,68,67,48,49,50,55');

-- --------------------------------------------------------

--
-- 表的结构 `qw_auth_group_access`
--

DROP TABLE IF EXISTS `qw_auth_group_access`;
CREATE TABLE IF NOT EXISTS `qw_auth_group_access` (
  `uid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_auth_group_access`
--

INSERT INTO `qw_auth_group_access` (`uid`, `group_id`) VALUES
(1, 1),
(4, 1),
(5, 1);

-- --------------------------------------------------------

--
-- 表的结构 `qw_auth_rule`
--

DROP TABLE IF EXISTS `qw_auth_rule`;
CREATE TABLE IF NOT EXISTS `qw_auth_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `icon` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `islink` tinyint(1) NOT NULL DEFAULT '1',
  `o` int(11) NOT NULL COMMENT '排序',
  `tips` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_auth_rule`
--

INSERT INTO `qw_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `type`, `status`, `condition`, `islink`, `o`, `tips`) VALUES
(1, 0, 'Index/index', '控制台', 'menu-icon fa fa-tachometer', 1, 1, '', 1, 1, '友情提示：经常查看操作日志，发现异常以便及时追查原因。'),
(2, 0, '', '系统设置', 'menu-icon fa fa-cog', 1, 1, '', 1, 2, ''),
(3, 2, 'Setting/setting', '网站设置', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 3, '这是网站设置的提示。'),
(4, 2, 'Menu/index', '后台菜单', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 4, ''),
(5, 2, 'Menu/add', '新增菜单', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 5, ''),
(6, 4, 'Menu/edit', '编辑菜单', '', 1, 1, '', 0, 6, ''),
(7, 2, 'Menu/update', '保存菜单', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 7, ''),
(8, 2, 'Menu/del', '删除菜单', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 8, ''),
(9, 2, 'Database/backup', '数据库备份', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 9, ''),
(10, 9, 'Database/recovery', '数据库还原', '', 1, 1, '', 0, 10, ''),
(11, 2, 'Update/update', '在线升级', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 11, ''),
(12, 2, 'Update/devlog', '开发日志', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 12, ''),
(13, 0, '', '用户及组', 'menu-icon fa fa-users', 1, 1, '', 1, 13, ''),
(14, 13, 'Member/index', '用户管理', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 14, ''),
(15, 13, 'Member/add', '新增用户', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 15, ''),
(16, 13, 'Member/edit', '编辑用户', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 16, ''),
(17, 13, 'Member/update', '保存用户', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 17, ''),
(18, 13, 'Member/del', '删除用户', '', 1, 1, '', 0, 18, ''),
(19, 13, 'Group/index', '用户组管理', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 19, ''),
(20, 13, 'Group/add', '新增用户组', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 20, ''),
(21, 13, 'Group/edit', '编辑用户组', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 21, ''),
(22, 13, 'Group/update', '保存用户组', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 22, ''),
(23, 13, 'Group/del', '删除用户组', '', 1, 1, '', 0, 23, ''),
(24, 0, '', '网站内容', 'menu-icon fa fa-desktop', 1, 1, '', 1, 24, ''),
(25, 24, 'Article/index', '文章管理', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 25, '网站虽然重要，身体更重要，出去走走吧。'),
(26, 24, 'Article/add', '新增文章', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 26, ''),
(27, 24, 'Article/edit', '编辑文章', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 27, ''),
(29, 24, 'Article/update', '保存文章', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 29, ''),
(30, 24, 'Article/del', '删除文章', '', 1, 1, '', 0, 30, ''),
(31, 24, 'Category/index', '分类管理', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 31, ''),
(32, 24, 'Category/add', '新增分类', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 32, ''),
(33, 24, 'Category/edit', '编辑分类', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 33, ''),
(34, 24, 'Category/update', '保存分类', 'menu-icon fa fa-caret-right', 1, 1, '', 0, 34, ''),
(36, 24, 'Category/del', '删除分类', '', 1, 1, '', 0, 36, ''),
(37, 0, '', '其它功能', 'menu-icon fa fa-legal', 1, 1, '', 1, 37, ''),
(38, 37, 'Link/index', '友情链接', 'menu-icon fa fa-caret-right', 1, 1, '', 1, 38, ''),
(39, 37, 'Link/add', '增加链接', '', 1, 1, '', 1, 39, ''),
(40, 37, 'Link/edit', '编辑链接', '', 1, 1, '', 0, 40, ''),
(41, 37, 'Link/update', '保存链接', '', 1, 1, '', 0, 41, ''),
(42, 37, 'Link/del', '删除链接', '', 1, 1, '', 0, 42, ''),
(43, 37, 'Flash/index', '焦点图', 'menu-icon fa fa-desktop', 1, 1, '', 1, 43, ''),
(44, 37, 'Flash/add', '新增焦点图', '', 1, 1, '', 1, 44, ''),
(45, 37, 'Flash/update', '保存焦点图', '', 1, 1, '', 0, 45, ''),
(46, 37, 'Flash/edit', '编辑焦点图', '', 1, 1, '', 0, 46, ''),
(47, 37, 'Flash/del', '删除焦点图', '', 1, 1, '', 0, 47, ''),
(48, 0, 'Personal/index', '个人中心', 'menu-icon fa fa-user', 1, 1, '', 1, 48, ''),
(49, 48, 'Personal/profile', '个人资料', 'menu-icon fa fa-user', 1, 1, '', 1, 49, ''),
(50, 48, 'Logout/index', '退出', '', 1, 1, '', 1, 50, ''),
(51, 9, 'Database/export', '备份', '', 1, 1, '', 0, 51, ''),
(52, 9, 'Database/optimize', '数据优化', '', 1, 1, '', 0, 52, ''),
(53, 9, 'Database/repair', '修复表', '', 1, 1, '', 0, 53, ''),
(54, 11, 'Update/updating', '升级安装', '', 1, 1, '', 0, 54, ''),
(55, 48, 'Personal/update', '资料保存', '', 1, 1, '', 0, 55, ''),
(56, 3, 'Setting/update', '设置保存', '', 1, 1, '', 0, 56, ''),
(57, 9, 'Database/del', '备份删除', '', 1, 1, '', 0, 57, ''),
(58, 2, 'variable/index', '自定义变量', '', 1, 1, '', 1, 0, ''),
(59, 58, 'variable/add', '新增变量', '', 1, 1, '', 0, 0, ''),
(60, 58, 'variable/edit', '编辑变量', '', 1, 1, '', 0, 0, ''),
(61, 58, 'variable/update', '保存变量', '', 1, 1, '', 0, 0, ''),
(62, 58, 'variable/del', '删除变量', '', 1, 1, '', 0, 0, ''),
(63, 37, 'Facebook/add', '用户反馈', '', 1, 1, '', 1, 63, ''),
(66, 0, '', '日常管理', '', 1, 1, '', 1, 1, ''),
(67, 66, 'Check/index', 'X101(语音一室)', '', 1, 1, '', 1, 0, ''),
(68, 66, 'Xuncha/index', 'X102(电脑19室)', '', 1, 1, '', 1, 0, ''),
(69, 66, 'Xuncha/index', 'X103(电脑20室)', '', 1, 1, '', 1, 0, ''),
(70, 66, 'xuncha/index', 'X201(语音二室)', '', 1, 1, '', 1, 0, ''),
(71, 66, 'xuncha/index', 'X202(语音三室)', '', 1, 1, '', 1, 0, ''),
(72, 0, '', '综合管理', '', 1, 1, '', 1, 2, '');

-- --------------------------------------------------------

--
-- 表的结构 `qw_category`
--

DROP TABLE IF EXISTS `qw_category`;
CREATE TABLE IF NOT EXISTS `qw_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '0正常，1单页，2外链',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `seotitle` varchar(200) DEFAULT NULL COMMENT 'SEO标题',
  `keywords` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `cattemplate` varchar(100) NOT NULL,
  `contemplate` varchar(100) NOT NULL,
  `o` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `fsid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `qw_check`
--

DROP TABLE IF EXISTS `qw_check`;
CREATE TABLE IF NOT EXISTS `qw_check` (
  `id` int(50) NOT NULL,
  `time` varchar(10) NOT NULL,
  `dev` int(10) NOT NULL,
  `log` int(10) NOT NULL,
  `nature` int(10) NOT NULL,
  `weeks` char(50) NOT NULL,
  `other` char(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='巡查工作记录表';

-- --------------------------------------------------------

--
-- 表的结构 `qw_devlog`
--

DROP TABLE IF EXISTS `qw_devlog`;
CREATE TABLE IF NOT EXISTS `qw_devlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v` varchar(225) NOT NULL COMMENT '版本号',
  `y` int(4) NOT NULL COMMENT '年分',
  `t` int(10) NOT NULL COMMENT '发布日期',
  `log` text NOT NULL COMMENT '更新日志',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_devlog`
--

INSERT INTO `qw_devlog` (`id`, `v`, `y`, `t`, `log`) VALUES
(1, '1.0.0', 2016, 1440259200, 'QWADMIN第一个版本发布。'),
(2, '1.0.1', 2016, 1440259200, '修改cookie过于简单的安全风险。');

-- --------------------------------------------------------

--
-- 表的结构 `qw_flash`
--

DROP TABLE IF EXISTS `qw_flash`;
CREATE TABLE IF NOT EXISTS `qw_flash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `pic` varchar(255) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `o` (`o`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `qw_links`
--

DROP TABLE IF EXISTS `qw_links`;
CREATE TABLE IF NOT EXISTS `qw_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `o` (`o`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `qw_log`
--

DROP TABLE IF EXISTS `qw_log`;
CREATE TABLE IF NOT EXISTS `qw_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `t` int(10) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `log` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_log`
--

INSERT INTO `qw_log` (`id`, `name`, `t`, `ip`, `log`) VALUES
(1, 'admin', 1574238333, '::1', '登录失败。'),
(2, 'admin', 1574238446, '::1', '登录失败。'),
(3, 'admin', 1574238473, '::1', '登录失败。'),
(4, 'admin', 1574238583, '::1', '登录失败。'),
(5, 'admin', 1574238600, '::1', '登录失败。'),
(6, 'admintest', 1574242575, '::1', '登录失败。'),
(7, 'admintest', 1574242638, '::1', '登录失败。'),
(8, 'admintestq', 1574242663, '::1', '登录失败。'),
(9, 'admintest', 1574243406, '::1', '登录失败。'),
(10, 'admintest', 1574297036, '::1', '登录失败。'),
(11, 'admintest', 1574297092, '::1', '登录失败。'),
(12, 'admin', 1574297109, '::1', '登录失败。'),
(13, 'admin', 1574301129, '::1', '登录失败。'),
(14, 'admin', 1574301177, '::1', '登录成功。'),
(15, 'admin', 1574309129, '::1', '登录成功。'),
(16, 'admin', 1574318661, '::1', '修改网站配置。'),
(17, 'admin', 1574318825, '::1', '新增菜单，名称：机房管理'),
(18, 'admin', 1574318939, '::1', '编辑菜单，ID：66'),
(19, 'admin', 1574319922, '::1', '新增菜单，名称：X101(语音一室)'),
(20, 'admin', 1574319962, '::1', '新增菜单，名称：X102(电脑19室)'),
(21, 'admin', 1574320001, '::1', '新增菜单，名称：X103(电脑20室)'),
(22, 'admin', 1574320038, '::1', '新增菜单，名称：X201(语音二室)'),
(23, 'admin', 1574320075, '::1', '新增菜单，名称：X202(语音三室)'),
(24, 'admin', 1574320153, '::1', '新增用户组，ID：0，组名：机房管理人员'),
(25, 'admin', 1574320181, '::1', '编辑菜单，ID：71'),
(26, 'admin', 1574320202, '::1', '编辑菜单，ID：70'),
(27, 'admin', 1574320222, '::1', '编辑菜单，ID：68'),
(28, 'admin', 1574320392, '::1', '编辑会员信息，会员UID：1'),
(29, 'admin', 1574320416, '::1', '登录成功。'),
(30, 'admin', 1574323786, '::1', '编辑菜单，ID：69'),
(31, 'admin', 1574323813, '::1', '编辑菜单，ID：67'),
(32, 'admin', 1574384078, '::1', '登录成功。'),
(33, 'admin', 1574384225, '::1', '备份完成！'),
(34, 'admin', 1574410566, '::1', '编辑菜单，ID：68'),
(35, 'admin', 1574815251, '::1', '登录失败。'),
(36, 'admin', 1574815271, '::1', '登录成功。'),
(37, 'admin', 1574815441, '::1', '编辑菜单，ID：68'),
(38, 'admin', 1574816432, '::1', '编辑用户组，ID：1，组名：超级管理员'),
(39, 'admin', 1574816502, '::1', '编辑用户组，ID：2，组名：管理员'),
(40, 'admin', 1574816524, '::1', '编辑用户组，ID：2，组名：管理员'),
(41, 'admin', 1574816910, '::1', '登录成功。'),
(42, 'admin', 1574839738, '::1', '编辑用户组，ID：2，组名：管理员'),
(43, 'admin', 1574905091, '::1', '登录成功。'),
(44, 'admin', 1574905389, '::1', '编辑会员信息，会员UID：123456'),
(45, 'admin', 1574906182, '::1', '删除用户组ID：6'),
(46, 'admin', 1577674960, '::1', '登录成功。'),
(47, 'admin', 1577675018, '::1', '新增会员，会员UID：4'),
(48, 'admin', 1577675039, '::1', '新增会员，会员UID：5'),
(49, 'wangbin', 1577675187, '::1', '登录成功。'),
(50, 'admin', 1577675217, '::1', '登录成功。'),
(51, 'admin', 1577691002, '::1', '登录成功。'),
(52, 'admin', 1577956295, '::1', '登录成功。'),
(53, 'admin', 1578022914, '::1', '登录成功。'),
(54, 'admin', 1578023070, '::1', '编辑菜单，ID：66'),
(55, 'admin', 1578023104, '::1', '新增菜单，名称：综和管理'),
(56, 'admin', 1578023144, '::1', '编辑菜单，ID：72'),
(57, 'admin', 1578023229, '::1', '编辑菜单，ID：67');

-- --------------------------------------------------------

--
-- 表的结构 `qw_member`
--

DROP TABLE IF EXISTS `qw_member`;
CREATE TABLE IF NOT EXISTS `qw_member` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(225) NOT NULL,
  `head` varchar(255) NOT NULL COMMENT '头像',
  `sex` tinyint(1) NOT NULL COMMENT '0保密1男，2女',
  `birthday` int(10) NOT NULL COMMENT '生日',
  `phone` varchar(20) NOT NULL COMMENT '电话',
  `qq` varchar(20) NOT NULL COMMENT 'QQ',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `password` varchar(32) NOT NULL,
  `t` int(10) UNSIGNED NOT NULL COMMENT '注册时间',
  `identifier` varchar(32) NOT NULL,
  `token` varchar(32) NOT NULL,
  `salt` varchar(10) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_member`
--

INSERT INTO `qw_member` (`uid`, `user`, `head`, `sex`, `birthday`, `phone`, `qq`, `email`, `password`, `t`, `identifier`, `token`, `salt`) VALUES
(1, 'admin', '/Public/attached/201601/1453389194.png', 1, 689616000, '13800138000', '331349451', 'xyb911109@qq.com', '599c4d67f9bacbb3a2ac1b54ce7b58db', 1574320392, 'e49e0acbb453787323b368e9b2d8e8df', '66778c51b5bb85f8136628bad52731fa', 'fHCdM7tc6X'),
(4, 'wangbin', '', 0, -28800, '', '', '', '0fa5933c7d220e1334ba99d6f751074c', 1577675018, '6f51aa6bdb4bc1066f3866f8fb40035a', '8e5ccab534f79a84acd52fb511c8d81a', 'RMr6Ynw4X4'),
(3, 'admintest', '/Public/attached/201601/1453389194.png', 1, 689616000, '13800138000', '331349451', 'xyb911109@qq.com', '599c4d67f9bacbb3a2ac1b54ce7b58db', 1574320392, '859e9eab9073cec289ce8ccb328f63ec', 'af46eb0b91bc9fff51fb05ef87466992', 'YzST2cAPHd'),
(5, 'wangbin2', '', 0, -28800, '', '', '', '0fa5933c7d220e1334ba99d6f751074c', 1577675039, 'b33d2f31beb7dc75abbf7644c56e0e7d', '9755498248c3e87a65c267a2911153f8', 'EVX68pzcVm');

-- --------------------------------------------------------

--
-- 表的结构 `qw_setting`
--

DROP TABLE IF EXISTS `qw_setting`;
CREATE TABLE IF NOT EXISTS `qw_setting` (
  `k` varchar(100) NOT NULL COMMENT '变量',
  `v` varchar(255) NOT NULL COMMENT '值',
  `type` tinyint(1) NOT NULL COMMENT '0系统，1自定义',
  `name` varchar(255) NOT NULL COMMENT '说明',
  PRIMARY KEY (`k`),
  KEY `k` (`k`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qw_setting`
--

INSERT INTO `qw_setting` (`k`, `v`, `type`, `name`) VALUES
('sitename', '机房管理巡查信息日志系统', 0, ''),
('title', '机房管理巡查信息日志系统', 0, ''),
('keywords', '关键词', 0, ''),
('description', '网站描述', 0, ''),
('footer', '2016©恰维网络', 0, ''),
('test', '测试', 1, '测试变量');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
