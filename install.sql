SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for __PREFIX__admin
-- ----------------------------
DROP TABLE IF EXISTS `__PREFIX__admin`;
CREATE TABLE `__PREFIX__admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) DEFAULT NULL COMMENT '登录IP',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员表';

-- ----------------------------
-- Records of __PREFIX__admin
-- ----------------------------
INSERT INTO `__PREFIX__admin` VALUES ('1', 'admin', 'Admin', '8e34d03b2f27c4dc33294f291a0cf4ae', '2f21b9', '/assets/img/avatar.png', 'admin@admin.com', '0', '1580463622', '127.0.0.1', '1492186163', '1580463622', 'fcaadc22-b60e-420c-adc9-ce377a1e2c04', 'normal');

-- ----------------------------
-- Table structure for __PREFIX__admin_log
-- ----------------------------
DROP TABLE IF EXISTS `__PREFIX__admin_log`;
CREATE TABLE `__PREFIX__admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员日志表';

-- ----------------------------
-- Records of __PREFIX__admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for __PREFIX__auth_group
-- ----------------------------
DROP TABLE IF EXISTS `__PREFIX__auth_group`;
CREATE TABLE `__PREFIX__auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分组表';

-- ----------------------------
-- Records of __PREFIX__auth_group
-- ----------------------------
INSERT INTO `__PREFIX__auth_group` VALUES ('1', '0', 'Admin group', '*', '1490883540', '149088354', 'normal');
INSERT INTO `__PREFIX__auth_group` VALUES ('2', '1', 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', '1490883540', '1505465692', 'normal');
INSERT INTO `__PREFIX__auth_group` VALUES ('3', '2', 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', '1490883540', '1502205322', 'normal');
INSERT INTO `__PREFIX__auth_group` VALUES ('4', '1', 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', '1490883540', '1502205350', 'normal');

-- ----------------------------
-- Table structure for __PREFIX__auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `__PREFIX__auth_group_access`;
CREATE TABLE `__PREFIX__auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='权限分组表';

-- ----------------------------
-- Records of __PREFIX__auth_group_access
-- ----------------------------
INSERT INTO `__PREFIX__auth_group_access` VALUES ('1', '1');
INSERT INTO `__PREFIX__auth_group_access` VALUES ('4', '1');
INSERT INTO `__PREFIX__auth_group_access` VALUES ('4', '2');

-- ----------------------------
-- Table structure for __PREFIX__auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `__PREFIX__auth_rule`;
CREATE TABLE `__PREFIX__auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `weigh` (`weigh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点表';

-- ----------------------------
-- Records of __PREFIX__auth_rule
-- ----------------------------
INSERT INTO `__PREFIX__auth_rule` VALUES ('1', 'file', '0', 'dashboard', 'Dashboard', 'fa fa-dashboard', '', 'Dashboard tips', '1', '1497429920', '1559918750', '9999', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('2', 'file', '0', 'addon', 'Addon', 'fa fa-cloud', '', 'Addon tips', '1', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('3', 'file', '1', 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '136', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('4', 'file', '1', 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '135', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('5', 'file', '1', 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '133', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('6', 'file', '1', 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '134', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('7', 'file', '1', 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '132', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('8', 'file', '2', 'addon.addon/index', 'Addon market', 'fa fa-puzzle-piece', '', 'Addon tips', '1', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('9', 'file', '2', 'addon.program/index', 'Program market', 'fa fa-rocket', '', 'Program tips', '1', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('10', 'file', '8', 'addon.addon/add', 'Add', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('11', 'file', '8', 'addon.addon/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('12', 'file', '8', 'addon.addon/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('13', 'file', '8', 'addon.addon/local', 'Local install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('14', 'file', '8', 'addon.addon/state', 'Update state', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('15', 'file', '8', 'addon.addon/install', 'Install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('16', 'file', '8', 'addon.addon/uninstall', 'Uninstall', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('17', 'file', '8', 'addon.addon/config', 'Setting', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('18', 'file', '8', 'addon.addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('19', 'file', '8', 'addon.addon/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('20', 'file', '9', 'addon.program/add', 'Add', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('21', 'file', '9', 'addon.program/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('22', 'file', '9', 'addon.program/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('23', 'file', '9', 'addon.program/local', 'Local install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('24', 'file', '9', 'addon.program/state', 'Update state', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('25', 'file', '9', 'addon.program/install', 'Install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('26', 'file', '9', 'addon.program/uninstall', 'Uninstall', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('27', 'file', '9', 'addon.program/config', 'Setting', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('28', 'file', '9', 'addon.program/refresh', 'Refresh', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('29', 'file', '9', 'addon.program/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('30', 'file', '0', 'auth', 'Auth', 'fa fa-group', '', '', '1', '1497429920', '1497430092', '999', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('31', 'file', '30', 'auth.admin', 'Admin', 'fa fa-user', '', 'Admin tips', '1', '1497429920', '1497430320', '118', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('32', 'file', '30', 'auth.adminlog', '管理员日志', 'fa fa-list-alt', '', 'Admin log tips', '1', '1497429920', '1574670901', '113', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('33', 'file', '30', 'auth.group', '角色分组', 'fa fa-group', '', 'Group tips', '1', '1497429920', '1574670773', '109', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('34', 'file', '30', 'auth.rule', '菜单规则', 'fa fa-bars', '', 'Rule tips', '1', '1497429920', '1574670754', '104', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('35', 'file', '31', 'auth.admin/index', 'View', 'fa fa-circle-o', '', 'Admin tips', '0', '1497429920', '1574397985', '117', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('36', 'file', '31', 'auth.admin/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '116', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('37', 'file', '31', 'auth.admin/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '115', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('38', 'file', '31', 'auth.admin/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '114', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('39', 'file', '32', 'auth.adminlog/index', 'View', 'fa fa-circle-o', '', 'Admin log tips', '0', '1497429920', '1497429920', '112', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('40', 'file', '32', 'auth.adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '111', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('41', 'file', '32', 'auth.adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '110', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('42', 'file', '33', 'auth.group/index', 'View', 'fa fa-circle-o', '', 'Group tips', '0', '1497429920', '1497429920', '108', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('43', 'file', '33', 'auth.group/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '107', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('44', 'file', '33', 'auth.group/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '106', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('45', 'file', '33', 'auth.group/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '105', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('46', 'file', '34', 'auth.rule/index', 'View', 'fa fa-circle-o', '', 'Rule tips', '0', '1497429920', '1497429920', '103', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('47', 'file', '34', 'auth.rule/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '102', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('48', 'file', '34', 'auth.rule/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '101', 'normal');
INSERT INTO `__PREFIX__auth_rule` VALUES ('49', 'file', '34', 'auth.rule/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '100', 'normal');
