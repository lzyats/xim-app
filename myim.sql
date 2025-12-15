/*
 Navicat Premium Data Transfer

 Source Server         : 德讯测试
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : localhost:3306
 Source Schema         : myim

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 12/08/2025 22:56:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat_banned
-- ----------------------------
DROP TABLE IF EXISTS `chat_banned`;
CREATE TABLE `chat_banned`  (
  `banned_id` bigint(20) NOT NULL COMMENT '封禁id',
  `banned_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封禁原因',
  `banned_time` datetime NULL DEFAULT NULL COMMENT '封禁时间',
  PRIMARY KEY (`banned_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '封禁状态' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_banned
-- ----------------------------

-- ----------------------------
-- Table structure for chat_config
-- ----------------------------
DROP TABLE IF EXISTS `chat_config`;
CREATE TABLE `chat_config`  (
  `config_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'key',
  `config_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'value',
  `remark` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_key`) USING BTREE,
  UNIQUE INDEX `idx_key`(`config_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_config
-- ----------------------------
INSERT INTO `chat_config` VALUES ('apply_friend', '50', '申请好友单日次数');
INSERT INTO `chat_config` VALUES ('apply_group', '30', '申请群组单日次数');
INSERT INTO `chat_config` VALUES ('group_level_count', '2000', '群组成员默认数量');
INSERT INTO `chat_config` VALUES ('group_name_search', 'N', '群组名称搜索开关');
INSERT INTO `chat_config` VALUES ('notice_content', '新版功能更新上线，欢迎升级体验', '系统通告');
INSERT INTO `chat_config` VALUES ('notice_status', 'Y', '系统通告开关');
INSERT INTO `chat_config` VALUES ('sys_audit', 'N', '审核开关');
INSERT INTO `chat_config` VALUES ('sys_beian', '我是备案信息', '备案信息');
INSERT INTO `chat_config` VALUES ('sys_captcha', '4321', '系统验证码');
INSERT INTO `chat_config` VALUES ('sys_cashname', '元', '货币单位');
INSERT INTO `chat_config` VALUES ('sys_cashstr', '￥', ' 货币单位');
INSERT INTO `chat_config` VALUES ('sys_hook', '', 'WebHook地址');
INSERT INTO `chat_config` VALUES ('sys_invo', '10', '推荐单个用户奖励');
INSERT INTO `chat_config` VALUES ('sys_nickname', 'XIM', '注册昵称');
INSERT INTO `chat_config` VALUES ('sys_packet', '200', '红包金额');
INSERT INTO `chat_config` VALUES ('sys_phone', '13800000000', '审核账号');
INSERT INTO `chat_config` VALUES ('sys_project', 'XIM', '系统名称');
INSERT INTO `chat_config` VALUES ('sys_recall', '15', '撤回时间');
INSERT INTO `chat_config` VALUES ('sys_screenshot', 'Y', '系统截屏');
INSERT INTO `chat_config` VALUES ('sys_share', 'https://www.baidu.com', '分享页面');
INSERT INTO `chat_config` VALUES ('sys_sign', '3', ' 签到日奖励');
INSERT INTO `chat_config` VALUES ('sys_signtoal', 'Y', ' 签到奖励入钱包');
INSERT INTO `chat_config` VALUES ('sys_watermark', '', '水印页面');
INSERT INTO `chat_config` VALUES ('user_deleted', '7', '用户注销间隔');
INSERT INTO `chat_config` VALUES ('user_hold', 'N', '用户手持开关');
INSERT INTO `chat_config` VALUES ('user_register', 'Y', '用户注册开关');
INSERT INTO `chat_config` VALUES ('user_sms', 'N', '用户短信开关');
INSERT INTO `chat_config` VALUES ('wallet_cash_auth', 'Y', '钱包提现认证开关');
INSERT INTO `chat_config` VALUES ('wallet_cash_cost', '0', '钱包提现加成金额');
INSERT INTO `chat_config` VALUES ('wallet_cash_count', '5', '钱包提现单日次数');
INSERT INTO `chat_config` VALUES ('wallet_cash_max', '5000', '钱包提现单日最大金额');
INSERT INTO `chat_config` VALUES ('wallet_cash_min', '50', '钱包提现单日最小金额');
INSERT INTO `chat_config` VALUES ('wallet_cash_rate', '0', '钱包提现手续费比率');
INSERT INTO `chat_config` VALUES ('wallet_cash_rates', '7.09', '美元汇率');
INSERT INTO `chat_config` VALUES ('wallet_cash_remark', '预计3个工作日内处理，有任何问题可随时咨询24小时在线客服！', '钱包提现提醒消息');
INSERT INTO `chat_config` VALUES ('wallet_recharge_amount', '200', '钱包充值单日总金额');
INSERT INTO `chat_config` VALUES ('wallet_recharge_android', '1,2', '钱包充值安卓开关');
INSERT INTO `chat_config` VALUES ('wallet_recharge_count', '5', '钱包充值单日次数');
INSERT INTO `chat_config` VALUES ('wallet_recharge_end', '00:00:00', '钱包充值结束时间');
INSERT INTO `chat_config` VALUES ('wallet_recharge_ios', '1,2', '钱包充值苹果开关');
INSERT INTO `chat_config` VALUES ('wallet_recharge_start', '00:00:00', '钱包充值开始时间');
INSERT INTO `chat_config` VALUES ('wallet_recharge_total', '9999', '钱包充值单日总笔数');

-- ----------------------------
-- Table structure for chat_feedback
-- ----------------------------
DROP TABLE IF EXISTS `chat_feedback`;
CREATE TABLE `chat_feedback`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提交版本',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '处理状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '建议反馈' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for chat_friend
-- ----------------------------
DROP TABLE IF EXISTS `chat_friend`;
CREATE TABLE `chat_friend`  (
  `friend_id` bigint(20) NOT NULL COMMENT '主键',
  `current_id` bigint(20) NULL DEFAULT NULL COMMENT '当前id',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '群组id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '头像',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '聊天号码',
  `remark` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `source` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源',
  `black` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '黑名单',
  `top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '置顶',
  `disturb` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '静默',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '注销0正常null注销',
  PRIMARY KEY (`friend_id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `current_id`, `deleted`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '好友表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_friend
-- ----------------------------

-- ----------------------------
-- Table structure for chat_friend_apply
-- ----------------------------
DROP TABLE IF EXISTS `chat_friend_apply`;
CREATE TABLE `chat_friend_apply`  (
  `apply_id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '用户头像',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '聊天号码',
  `reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '理由',
  `receive_id` bigint(20) NULL DEFAULT NULL COMMENT '接收id',
  `receive_remark` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收备注',
  `source` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请来源',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  PRIMARY KEY (`apply_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '好友申请' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_friend_apply
-- ----------------------------

-- ----------------------------
-- Table structure for chat_friend_inform
-- ----------------------------
DROP TABLE IF EXISTS `chat_friend_inform`;
CREATE TABLE `chat_friend_inform`  (
  `inform_id` bigint(20) NOT NULL COMMENT '主键',
  `inform_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '目标id',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '处理状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`inform_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '骚扰举报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_friend_inform
-- ----------------------------

-- ----------------------------
-- Table structure for chat_group
-- ----------------------------
DROP TABLE IF EXISTS `chat_group`;
CREATE TABLE `chat_group`  (
  `group_id` bigint(20) NOT NULL COMMENT '主键',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群名',
  `group_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群号',
  `banned` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '封禁群组',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '群组头像',
  `notice` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通知公告',
  `notice_top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '悬浮开关',
  `config_member` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '成员保护',
  `config_invite` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '允许邀请',
  `config_speak` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '全员禁言',
  `config_title` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '群组头衔',
  `config_audit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '群组审核',
  `config_media` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '发送资源',
  `config_assign` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '专属可见',
  `config_nickname` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '昵称开关',
  `config_packet` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '红包开关',
  `config_amount` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '金额开关',
  `config_scan` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '二维码',
  `config_receive` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '红包禁抢',
  `group_level` int(4) NULL DEFAULT 0 COMMENT '群组等级',
  `group_level_count` int(4) NULL DEFAULT 0 COMMENT '群组等级容量',
  `group_level_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '群组等级价格',
  `group_level_time` datetime NULL DEFAULT NULL COMMENT '群组容量时间',
  `privacy_no` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私开关',
  `privacy_scan` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私开关',
  `privacy_name` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私开关',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '注销0正常null注销',
  PRIMARY KEY (`group_id`) USING BTREE,
  UNIQUE INDEX `group_no`(`group_no`, `deleted`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天群组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group
-- ----------------------------

-- ----------------------------
-- Table structure for chat_group_apply
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_apply`;
CREATE TABLE `chat_group_apply`  (
  `apply_id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '用户头像',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '群组id',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群组名称',
  `receive_id` bigint(20) NULL DEFAULT NULL COMMENT '接收人id',
  `apply_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请状态0无1同意2拒绝3忽略',
  `apply_source` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请来源',
  `create_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  PRIMARY KEY (`apply_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '群组申请表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group_apply
-- ----------------------------

-- ----------------------------
-- Table structure for chat_group_inform
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_inform`;
CREATE TABLE `chat_group_inform`  (
  `inform_id` bigint(20) NOT NULL COMMENT '主键',
  `inform_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '目标id',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '处理状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`inform_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '骚扰举报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group_inform
-- ----------------------------

-- ----------------------------
-- Table structure for chat_group_log
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_log`;
CREATE TABLE `chat_group_log`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '群组id',
  `log_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '群组日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group_log
-- ----------------------------

-- ----------------------------
-- Table structure for chat_group_member
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_member`;
CREATE TABLE `chat_group_member`  (
  `member_id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '群组id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '聊天号码',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '头像',
  `remark` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `member_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '成员类型',
  `top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否置顶',
  `disturb` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否免打扰',
  `member_source` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '进群来源',
  `packet_white` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '禁抢白名单',
  `speak` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '禁言开关',
  `speak_time` datetime NULL DEFAULT NULL COMMENT '禁言时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '加入时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '注销0正常null注销',
  PRIMARY KEY (`member_id`) USING BTREE,
  UNIQUE INDEX `idx_group`(`user_id`, `group_id`, `deleted`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '群组成员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group_member
-- ----------------------------

-- ----------------------------
-- Table structure for chat_group_solitaire
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_solitaire`;
CREATE TABLE `chat_group_solitaire`  (
  `solitaire_id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '发起人',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '群组',
  `subject` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主题',
  `example` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '例子',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`solitaire_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成语接龙' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group_solitaire
-- ----------------------------

-- ----------------------------
-- Table structure for chat_help
-- ----------------------------
DROP TABLE IF EXISTS `chat_help`;
CREATE TABLE `chat_help`  (
  `help_id` bigint(20) NOT NULL COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '状态',
  `sort` smallint(2) NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`help_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天帮助' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_help
-- ----------------------------
INSERT INTO `chat_help` VALUES (1562386781612105731, '如何迁移/备份聊天记录', '目前版本不支持备份与恢复。', 'Y', 1);
INSERT INTO `chat_help` VALUES (1562386781612105732, '聊天记录清空后还能找回吗', '目前采用的是端对端加密传输，消息只记录在用户的终端设备上，一旦删除或撤回，就无法恢复。', 'Y', 2);
INSERT INTO `chat_help` VALUES (1562386781612105733, 'APP后台/锁屏后接收不到新消息通知', '进入手机“设置”“应用管理”找到《{}》进入权限管理赋予自启动、后台弹窗、悬浮窗、后台唤起权限/后台弹窗权限。', 'Y', 3);
INSERT INTO `chat_help` VALUES (1562386781612105734, 'APP后台总是被清理', '进入手机“设置”“应用自启动设置”找到《{}》设置“允许自启动”或者“允许后台运行”。', 'Y', 4);
INSERT INTO `chat_help` VALUES (1562386781612105735, 'APP后台/锁屏后接听不到语音/视频通话', '进入手机“设置”“应用管理”找到《{}》进入权限管理赋予自启动、悬浮窗、后台唤起权限/后台弹窗权限。', 'Y', 5);
INSERT INTO `chat_help` VALUES (1562386781612105736, '如何开启消息通知', '进入“我的”页面点击“软件设置”开启“消息声音”或“消息通知”。', 'Y', 6);
INSERT INTO `chat_help` VALUES (1562386781612105737, '怎么添加好友', '进入“消息”或“好友”页面点击右上角加号“添加好友”。', 'Y', 7);
INSERT INTO `chat_help` VALUES (1562386781612105738, '怎么同意/拒绝添加好友', '进入“好友”页面点击“验证信息”可以看到，好友申请列表，点击“忽略”或“同意”进行操作。', 'Y', 8);
INSERT INTO `chat_help` VALUES (1562386781612105739, '怎么切换账号', '进入“我的”页面点击“账号安全”点击“退出登录”进行操作。', 'Y', 9);
INSERT INTO `chat_help` VALUES (1562386781612105740, '怎么查看用户服务协议/隐私协议', '进入“我的”页面点击“软件设置”点击“服务协议”或“隐私协议”进行查看。', 'Y', 10);
INSERT INTO `chat_help` VALUES (1562386781612105741, '怎么查看我的个人信息收集情况', '进入“我的”页面点击“软件设置”点击“信息收集”进行查看。', 'Y', 11);

-- ----------------------------
-- Table structure for chat_msg
-- ----------------------------
DROP TABLE IF EXISTS `chat_msg`;
CREATE TABLE `chat_msg`  (
  `msg_id` bigint(20) NOT NULL COMMENT '消息主键',
  `sync_id` bigint(20) NULL DEFAULT NULL COMMENT '同步id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '发送人',
  `receive_id` bigint(20) NULL DEFAULT NULL COMMENT '接收人',
  `group_id` bigint(20) NULL DEFAULT NULL COMMENT '群id',
  `talk_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '聊天类型',
  `msg_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息类型',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '消息内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`msg_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_msg
-- ----------------------------

-- ----------------------------
-- Table structure for chat_notice
-- ----------------------------
DROP TABLE IF EXISTS `chat_notice`;
CREATE TABLE `chat_notice`  (
  `notice_id` bigint(20) NOT NULL COMMENT '主键',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_notice
-- ----------------------------
INSERT INTO `chat_notice` VALUES (1613477970402439169, '测试公告', '重要通知：近期诈骗犯罪案件时有发生，为防止您在经济上蒙受损失，请您接到陌生人或以熟人名义要求转账、汇款时，务必提高警惕，以防受骗', 'Y', '2023-01-01 00:00:00');
INSERT INTO `chat_notice` VALUES (1949806025207205889, '系统公告2', '系统公告2系统公告2系统公告2系统公告2', 'Y', '2025-07-29 04:15:53');

-- ----------------------------
-- Table structure for chat_number
-- ----------------------------
DROP TABLE IF EXISTS `chat_number`;
CREATE TABLE `chat_number`  (
  `chat_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '状态',
  PRIMARY KEY (`chat_no`) USING BTREE,
  UNIQUE INDEX `chat_no`(`chat_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统号码' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_number
-- ----------------------------

-- ----------------------------
-- Table structure for chat_portrait
-- ----------------------------
DROP TABLE IF EXISTS `chat_portrait`;
CREATE TABLE `chat_portrait`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '头像',
  `chat_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天头像' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_portrait
-- ----------------------------
INSERT INTO `chat_portrait` VALUES (1793574396027731910, 'http://192.168.0.1:19000/xim/att/1.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731911, 'http://192.168.0.1:19000/xim/att/2.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731912, 'http://192.168.0.1:19000/xim/att/3.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731913, 'http://192.168.0.1:19000/xim/att/4.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731914, 'http://192.168.0.1:19000/xim/att/5.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731915, 'http://192.168.0.1:19000/xim/att/6.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731916, 'http://192.168.0.1:19000/xim/att/7.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731917, 'http://192.168.0.1:19000/xim/att/8.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731918, 'http://192.168.0.1:19000/xim/att/9.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731919, 'http://192.168.0.1:19000/xim/att/10.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731920, 'http://192.168.0.1:19000/xim/att/11.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731921, 'http://192.168.0.1:19000/xim/att/12.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731922, 'http://192.168.0.1:19000/xim/att/13.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731923, 'http://192.168.0.1:19000/xim/att/14.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731924, 'http://192.168.0.1:19000/xim/att/15.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731925, 'http://192.168.0.1:19000/xim/att/16.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731970, 'http://192.168.0.1:19000/xim/btt/1.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731971, 'http://192.168.0.1:19000/xim/btt/2.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731972, 'http://192.168.0.1:19000/xim/btt/3.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731973, 'http://192.168.0.1:19000/xim/btt/4.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731974, 'http://192.168.0.1:19000/xim/btt/5.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731975, 'http://192.168.0.1:19000/xim/btt/6.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731976, 'http://192.168.0.1:19000/xim/btt/7.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731977, 'http://192.168.0.1:19000/xim/btt/8.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731978, 'http://192.168.0.1:19000/xim/btt/9.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731979, 'http://192.168.0.1:19000/xim/btt/10.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731980, 'http://192.168.0.1:19000/xim/btt/11.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731981, 'http://192.168.0.1:19000/xim/btt/12.png', '2', 'Y');

-- ----------------------------
-- Table structure for chat_resource
-- ----------------------------
DROP TABLE IF EXISTS `chat_resource`;
CREATE TABLE `chat_resource`  (
  `resource_id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '资源地址',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天资源' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_resource
-- ----------------------------

-- ----------------------------
-- Table structure for chat_robot
-- ----------------------------
DROP TABLE IF EXISTS `chat_robot`;
CREATE TABLE `chat_robot`  (
  `robot_id` bigint(20) NOT NULL COMMENT '主键',
  `secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '秘钥',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `portrait` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `menu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '菜单',
  PRIMARY KEY (`robot_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_robot
-- ----------------------------
INSERT INTO `chat_robot` VALUES (10001, '8ykc55fcq1fc21agt11qtni60hujhrxf', '在线客服', 'http://192.168.0.1:19000/xim/root/1.png', '[]');
INSERT INTO `chat_robot` VALUES (10002, 'qry41hxsjg8l4kg242z5s1u91oxll8b', '支付助手', 'http://192.168.0.1:19000/xim/root/2.png', '[]');
INSERT INTO `chat_robot` VALUES (10003, 'zgs5ibsx565wn4ccbb3hqlnozwyiktm9', 'AI助理', 'http://192.168.0.1:19000/xim/root/3.png', '[]');

-- ----------------------------
-- Table structure for chat_robot_reply
-- ----------------------------
DROP TABLE IF EXISTS `chat_robot_reply`;
CREATE TABLE `chat_robot_reply`  (
  `reply_id` bigint(20) NOT NULL COMMENT '主键',
  `robot_id` bigint(20) NULL DEFAULT NULL COMMENT '机器人',
  `reply_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `reply_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  PRIMARY KEY (`reply_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_robot_reply
-- ----------------------------

-- ----------------------------
-- Table structure for chat_robot_sub
-- ----------------------------
DROP TABLE IF EXISTS `chat_robot_sub`;
CREATE TABLE `chat_robot_sub`  (
  `sub_id` bigint(20) NOT NULL COMMENT '主键',
  `robot_id` bigint(20) NULL DEFAULT NULL COMMENT '机器人',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '置顶',
  `disturb` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '静默',
  PRIMARY KEY (`sub_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_robot_sub
-- ----------------------------

-- ----------------------------
-- Table structure for chat_sms
-- ----------------------------
DROP TABLE IF EXISTS `chat_sms`;
CREATE TABLE `chat_sms`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `mobile` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '手机号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '状态',
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '结果',
  `create_time` datetime NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_sms
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user
-- ----------------------------
DROP TABLE IF EXISTS `chat_user`;
CREATE TABLE `chat_user`  (
  `user_id` bigint(20) NOT NULL COMMENT '主键',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '聊天号码',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '头像',
  `remark` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `gender` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '性别1男2女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '介绍',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `salt` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `pass` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '密码标志',
  `auth` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '认证状态',
  `banned` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '封禁状态',
  `special` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '测试账号',
  `abnormal` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '异常账号',
  `payment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '支付密码',
  `privacy_no` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私no',
  `privacy_phone` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私手机',
  `privacy_scan` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私扫码',
  `privacy_card` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私名片',
  `privacy_group` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '隐私群组',
  `login_ios` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '苹果openId',
  `login_qq` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '球球openId',
  `login_wx` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信openId',
  `on_line` datetime NULL DEFAULT NULL COMMENT '在线时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '注册时间',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `ip_addr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '注销0正常null注销',
  `safestr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '666666' COMMENT '安全码',
  `incode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邀请码',
  `user_dep` int(2) NULL DEFAULT 0 COMMENT '用户层级',
  `user_level` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '层级关系表',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父级ID',
  `isvip` tinyint(1) NULL DEFAULT 0 COMMENT '0普通1VIP2SVIP',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `incode`(`incode`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`, `deleted`) USING BTREE,
  UNIQUE INDEX `chat_no`(`user_no`, `deleted`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_appeal
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_appeal`;
CREATE TABLE `chat_user_appeal`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户申诉' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_appeal
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_collect
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_collect`;
CREATE TABLE `chat_user_collect`  (
  `collect_id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `msg_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收藏类型',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`collect_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_collect
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_deleted
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_deleted`;
CREATE TABLE `chat_user_deleted`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '注销时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `phone`(`phone`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '注销表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_deleted
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_info
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_info`;
CREATE TABLE `chat_user_info`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `identity1` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '正面',
  `identity2` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '反面',
  `hold_card` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手持',
  `auth_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '认证原因',
  `auth_time` datetime NULL DEFAULT NULL COMMENT '认证时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_info
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_inv
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_inv`;
CREATE TABLE `chat_user_inv`  (
  `inid` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_inid` bigint(20) NOT NULL COMMENT '推荐人ID',
  `inv_usdt` double(10, 2) NULL DEFAULT 0.00 COMMENT '推荐奖励',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '推荐人聊天号码',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '推荐人手机号',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '推荐人昵称',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '注销0正常null注销',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '0未处理1已处理2其他状态',
  PRIMARY KEY (`inid`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `user_inid`) USING BTREE COMMENT '同一个只能推荐一次'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员注册邀请表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_inv
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_log
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_log`;
CREATE TABLE `chat_user_log`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `log_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_addr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备类型',
  `device_version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备版本',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for chat_user_sign
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_sign`;
CREATE TABLE `chat_user_sign`  (
  `signid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户ID（关联用户表）',
  `trade_id` bigint(20) NULL DEFAULT NULL COMMENT '交易id',
  `sign_date` date NOT NULL COMMENT '签到日期（仅记录年月日，精确到天）',
  `reward_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '签到奖励（如USDT数量）',
  `sign_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '签到类型：1-正常签到，2-补签',
  `is_valid` tinyint(1) NULL DEFAULT 1 COMMENT '是否有效：1-有效，0-无效（如取消签到）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间（精确到秒）',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`signid`) USING BTREE,
  UNIQUE INDEX `uk_user_date`(`user_id`, `sign_date`) USING BTREE COMMENT '唯一索引：防止用户同一天重复签到',
  INDEX `idx_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引：优化查询用户签到记录',
  INDEX `idx_sign_date`(`sign_date`) USING BTREE COMMENT '日期索引：优化查询某天的签到统计'
) ENGINE = InnoDB AUTO_INCREMENT = 1953060404464775171 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户按天签到记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_sign
-- ----------------------------
INSERT INTO `chat_user_sign` VALUES (1951914600954384311, 1946420132259618818, NULL, '2025-08-02', 2.00, 1, 1, '2025-08-02 11:54:40', '2025-08-03 16:51:37');
INSERT INTO `chat_user_sign` VALUES (1951914600954384313, 1946420132259618818, NULL, '2025-07-22', 2.00, 1, 1, '2025-07-27 16:52:54', '2025-08-03 16:51:37');
INSERT INTO `chat_user_sign` VALUES (1952033851451211777, 1946420132259618818, 1952033851451211778, '2025-08-03', 2.00, 1, 1, '2025-08-03 23:48:32', '2025-08-03 23:48:32');
INSERT INTO `chat_user_sign` VALUES (1952040596827385858, 1946420132259618818, 1952040596827385859, '2025-08-04', 2.00, 1, 1, '2025-08-04 00:15:20', '2025-08-04 00:15:20');
INSERT INTO `chat_user_sign` VALUES (1952150638490664961, 1939147449151004674, 1952150638490664962, '2025-08-04', 2.00, 1, 1, '2025-08-04 07:32:36', '2025-08-04 07:32:36');
INSERT INTO `chat_user_sign` VALUES (1952244842964721666, 1939140554751221761, 1952244842964721667, '2025-08-04', 2.00, 1, 1, '2025-08-04 13:46:56', '2025-08-04 13:46:56');
INSERT INTO `chat_user_sign` VALUES (1952284825570889729, 1952279326569910274, NULL, '2025-08-04', 3.00, 1, 1, '2025-08-04 16:25:49', '2025-08-04 16:25:49');
INSERT INTO `chat_user_sign` VALUES (1952516417957937154, 1939147449151004674, 1952516417957937155, '2025-08-05', 3.00, 1, 1, '2025-08-05 07:46:05', '2025-08-05 07:46:05');
INSERT INTO `chat_user_sign` VALUES (1952604640197521409, 1952603899504402434, 1952604640197521410, '2025-08-05', 3.00, 1, 1, '2025-08-05 13:36:39', '2025-08-05 13:36:39');
INSERT INTO `chat_user_sign` VALUES (1952877341176795138, 1952603899504402434, 1952877341176795139, '2025-08-06', 3.00, 1, 1, '2025-08-06 07:40:16', '2025-08-06 07:40:16');
INSERT INTO `chat_user_sign` VALUES (1952908565006053378, 1946420132259618818, 1952908565006053379, '2025-08-06', 3.00, 1, 1, '2025-08-06 09:44:20', '2025-08-06 09:44:20');
INSERT INTO `chat_user_sign` VALUES (1953026460662951938, 1952278488039825409, 1953026460662951939, '2025-08-06', 3.00, 1, 1, '2025-08-06 17:32:49', '2025-08-06 17:32:49');
INSERT INTO `chat_user_sign` VALUES (1953060404464775170, 1952279326569910274, 1953060404464775171, '2025-08-06', 3.00, 1, 1, '2025-08-06 19:47:41', '2025-08-06 19:47:41');

-- ----------------------------
-- Table structure for chat_user_token
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_token`;
CREATE TABLE `chat_user_token`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `token` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'token',
  `device` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户token' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for chat_version
-- ----------------------------
DROP TABLE IF EXISTS `chat_version`;
CREATE TABLE `chat_version`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版本',
  `device` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备',
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '地址',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `device`(`device`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统版本' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_version
-- ----------------------------
INSERT INTO `chat_version` VALUES (1561613225252913110, '1.0.0', 'android', 'https://www.baidu.com/demo.apk', '安卓最新版本1.2.0，更新了系统提现功能');
INSERT INTO `chat_version` VALUES (1561613225252913111, '1.0.0', 'ios', 'https://www.baidu.com/test', '我是苹果包');

-- ----------------------------
-- Table structure for chat_visit
-- ----------------------------
DROP TABLE IF EXISTS `chat_visit`;
CREATE TABLE `chat_visit`  (
  `visit_id` bigint(20) NOT NULL COMMENT '访问id',
  `visit_date` date NULL DEFAULT NULL COMMENT '访问时间',
  `visit_count` int(8) NULL DEFAULT 0 COMMENT '访问次数',
  PRIMARY KEY (`visit_id`) USING BTREE,
  UNIQUE INDEX `visit_date`(`visit_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户访问' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_visit
-- ----------------------------

-- ----------------------------
-- Table structure for chat_voice
-- ----------------------------
DROP TABLE IF EXISTS `chat_voice`;
CREATE TABLE `chat_voice`  (
  `msg_id` bigint(20) NOT NULL COMMENT '主键',
  `voice_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '地址',
  `voice_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文本',
  `user_id` bigint(20) NULL DEFAULT 0 COMMENT '用户',
  `create_time` datetime NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`msg_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '声音表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_voice
-- ----------------------------

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS `flyway_schema_history`;
CREATE TABLE `flyway_schema_history`  (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `script` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `checksum` int(11) NULL DEFAULT NULL,
  `installed_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`) USING BTREE,
  INDEX `flyway_schema_history_s_idx`(`success`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flyway_schema_history
-- ----------------------------
INSERT INTO `flyway_schema_history` VALUES (1, '1.0.0.01', 'chat banned', 'SQL', 'V1.0.0_01__chat_banned.sql', -696532290, 'kaolaim', '2025-06-28 23:49:04', 214, 1);
INSERT INTO `flyway_schema_history` VALUES (2, '1.0.0.02', 'chat config', 'SQL', 'V1.0.0_02__chat_config.sql', 1170283213, 'kaolaim', '2025-06-28 23:49:09', 3990, 1);
INSERT INTO `flyway_schema_history` VALUES (3, '1.0.0.03', 'chat feedback', 'SQL', 'V1.0.0_03__chat_feedback.sql', 1216134411, 'kaolaim', '2025-06-28 23:49:09', 183, 1);
INSERT INTO `flyway_schema_history` VALUES (4, '1.0.0.04', 'chat friend', 'SQL', 'V1.0.0_04__chat_friend.sql', 168262040, 'kaolaim', '2025-06-28 23:49:10', 268, 1);
INSERT INTO `flyway_schema_history` VALUES (5, '1.0.0.05', 'chat friend apply', 'SQL', 'V1.0.0_05__chat_friend_apply.sql', 53969888, 'kaolaim', '2025-06-28 23:49:11', 241, 1);
INSERT INTO `flyway_schema_history` VALUES (6, '1.0.0.06', 'chat friend inform', 'SQL', 'V1.0.0_06__chat_friend_inform.sql', 1658750223, 'kaolaim', '2025-06-28 23:49:11', 182, 1);
INSERT INTO `flyway_schema_history` VALUES (7, '1.0.0.07', 'chat group', 'SQL', 'V1.0.0_07__chat_group.sql', -1174979198, 'kaolaim', '2025-06-28 23:49:12', 185, 1);
INSERT INTO `flyway_schema_history` VALUES (8, '1.0.0.08', 'chat group apply', 'SQL', 'V1.0.0_08__chat_group_apply.sql', 2076408602, 'kaolaim', '2025-06-28 23:49:13', 217, 1);
INSERT INTO `flyway_schema_history` VALUES (9, '1.0.0.09', 'chat group inform', 'SQL', 'V1.0.0_09__chat_group_inform.sql', -396204992, 'kaolaim', '2025-06-28 23:49:13', 195, 1);
INSERT INTO `flyway_schema_history` VALUES (10, '1.0.0.10', 'chat group log', 'SQL', 'V1.0.0_10__chat_group_log.sql', 564077313, 'kaolaim', '2025-06-28 23:49:14', 187, 1);
INSERT INTO `flyway_schema_history` VALUES (11, '1.0.0.11', 'chat group member', 'SQL', 'V1.0.0_11__chat_group_member.sql', -1727677919, 'kaolaim', '2025-06-28 23:49:14', 198, 1);
INSERT INTO `flyway_schema_history` VALUES (12, '1.0.0.12', 'chat group solitaire', 'SQL', 'V1.0.0_12__chat_group_solitaire.sql', -1246279350, 'kaolaim', '2025-06-28 23:49:15', 228, 1);
INSERT INTO `flyway_schema_history` VALUES (13, '1.0.0.13', 'chat help', 'SQL', 'V1.0.0_13__chat_help.sql', 460438957, 'kaolaim', '2025-06-28 23:49:17', 1563, 1);
INSERT INTO `flyway_schema_history` VALUES (14, '1.0.0.14', 'chat msg', 'SQL', 'V1.0.0_14__chat_msg.sql', 90236541, 'kaolaim', '2025-06-28 23:49:18', 305, 1);
INSERT INTO `flyway_schema_history` VALUES (15, '1.0.0.15', 'chat notice', 'SQL', 'V1.0.0_15__chat_notice.sql', -666647298, 'kaolaim', '2025-06-28 23:49:19', 303, 1);
INSERT INTO `flyway_schema_history` VALUES (16, '1.0.0.16', 'chat number', 'SQL', 'V1.0.0_16__chat_number.sql', -199265467, 'kaolaim', '2025-06-28 23:49:19', 198, 1);
INSERT INTO `flyway_schema_history` VALUES (17, '1.0.0.17', 'chat portrait', 'SQL', 'V1.0.0_17__chat_portrait.sql', -472154714, 'kaolaim', '2025-06-28 23:49:22', 2636, 1);
INSERT INTO `flyway_schema_history` VALUES (18, '1.0.0.18', 'chat resource', 'SQL', 'V1.0.0_18__chat_resource.sql', -618609257, 'kaolaim', '2025-06-28 23:49:23', 219, 1);
INSERT INTO `flyway_schema_history` VALUES (19, '1.0.0.19', 'chat robot', 'SQL', 'V1.0.0_19__chat_robot.sql', 1984849521, 'kaolaim', '2025-06-28 23:49:24', 513, 1);
INSERT INTO `flyway_schema_history` VALUES (20, '1.0.0.20', 'chat robot reply', 'SQL', 'V1.0.0_20__chat_robot_reply.sql', 836233174, 'kaolaim', '2025-06-28 23:49:25', 278, 1);
INSERT INTO `flyway_schema_history` VALUES (21, '1.0.0.21', 'chat robot sub', 'SQL', 'V1.0.0_21__chat_robot_sub.sql', -291234311, 'kaolaim', '2025-06-28 23:49:25', 182, 1);
INSERT INTO `flyway_schema_history` VALUES (22, '1.0.0.22', 'chat sms', 'SQL', 'V1.0.0_22__chat_sms.sql', 1841683570, 'kaolaim', '2025-06-28 23:49:26', 195, 1);
INSERT INTO `flyway_schema_history` VALUES (23, '1.0.0.23', 'chat user', 'SQL', 'V1.0.0_23__chat_user.sql', -610753871, 'kaolaim', '2025-06-28 23:49:26', 200, 1);
INSERT INTO `flyway_schema_history` VALUES (24, '1.0.0.24', 'chat user appeal', 'SQL', 'V1.0.0_24__chat_user_appeal.sql', -1226138193, 'kaolaim', '2025-06-28 23:49:27', 208, 1);
INSERT INTO `flyway_schema_history` VALUES (25, '1.0.0.25', 'chat user collect', 'SQL', 'V1.0.0_25__chat_user_collect.sql', 873937222, 'kaolaim', '2025-06-28 23:49:28', 179, 1);
INSERT INTO `flyway_schema_history` VALUES (26, '1.0.0.26', 'chat user deleted', 'SQL', 'V1.0.0_26__chat_user_deleted.sql', 238012981, 'kaolaim', '2025-06-28 23:49:28', 207, 1);
INSERT INTO `flyway_schema_history` VALUES (27, '1.0.0.27', 'chat user info', 'SQL', 'V1.0.0_27__chat_user_info.sql', 486282637, 'kaolaim', '2025-06-28 23:49:29', 230, 1);
INSERT INTO `flyway_schema_history` VALUES (28, '1.0.0.28', 'chat user log', 'SQL', 'V1.0.0_28__chat_user_log.sql', -433879120, 'kaolaim', '2025-06-28 23:49:29', 190, 1);
INSERT INTO `flyway_schema_history` VALUES (29, '1.0.0.29', 'chat user token', 'SQL', 'V1.0.0_29__chat_user_token.sql', -1172333741, 'kaolaim', '2025-06-28 23:49:30', 187, 1);
INSERT INTO `flyway_schema_history` VALUES (30, '1.0.0.30', 'chat version', 'SQL', 'V1.0.0_30__chat_version.sql', 248026715, 'kaolaim', '2025-06-28 23:49:31', 456, 1);
INSERT INTO `flyway_schema_history` VALUES (31, '1.0.0.31', 'chat visit', 'SQL', 'V1.0.0_31__chat_visit.sql', 111420837, 'kaolaim', '2025-06-28 23:49:31', 197, 1);
INSERT INTO `flyway_schema_history` VALUES (32, '1.0.0.32', 'chat voice', 'SQL', 'V1.0.0_32__chat_voice.sql', -710852154, 'kaolaim', '2025-06-28 23:49:32', 219, 1);
INSERT INTO `flyway_schema_history` VALUES (33, '1.0.0.33', 'sys qrtz', 'SQL', 'V1.0.0_33__sys_qrtz.sql', -1757809918, 'kaolaim', '2025-06-28 23:49:35', 2446, 1);
INSERT INTO `flyway_schema_history` VALUES (34, '1.0.0.34', 'sys info', 'SQL', 'V1.0.0_34__sys_info.sql', -578244250, 'kaolaim', '2025-06-28 23:49:37', 1480, 1);
INSERT INTO `flyway_schema_history` VALUES (35, '1.0.0.35', 'sys menu', 'SQL', 'V1.0.0_35__sys_menu.sql', -473625500, 'kaolaim', '2025-06-28 23:49:37', 179, 1);
INSERT INTO `flyway_schema_history` VALUES (36, '1.0.0.36', 'wallet bank', 'SQL', 'V1.0.0_36__wallet_bank.sql', -1860479085, 'kaolaim', '2025-06-28 23:49:38', 205, 1);
INSERT INTO `flyway_schema_history` VALUES (37, '1.0.0.37', 'wallet cash', 'SQL', 'V1.0.0_37__wallet_cash.sql', 130012454, 'kaolaim', '2025-06-28 23:49:38', 221, 1);
INSERT INTO `flyway_schema_history` VALUES (38, '1.0.0.38', 'wallet info', 'SQL', 'V1.0.0_38__wallet_info.sql', -659731428, 'kaolaim', '2025-06-28 23:49:39', 183, 1);
INSERT INTO `flyway_schema_history` VALUES (39, '1.0.0.39', 'wallet packet', 'SQL', 'V1.0.0_39__wallet_packet.sql', 264433956, 'kaolaim', '2025-06-28 23:49:40', 266, 1);
INSERT INTO `flyway_schema_history` VALUES (40, '1.0.0.40', 'wallet recharge', 'SQL', 'V1.0.0_40__wallet_recharge.sql', -1580713155, 'kaolaim', '2025-06-28 23:49:40', 211, 1);
INSERT INTO `flyway_schema_history` VALUES (41, '1.0.0.41', 'wallet shopping', 'SQL', 'V1.0.0_41__wallet_shopping.sql', 1182573850, 'kaolaim', '2025-06-28 23:49:41', 232, 1);
INSERT INTO `flyway_schema_history` VALUES (42, '1.0.0.42', 'wallet task', 'SQL', 'V1.0.0_42__wallet_task.sql', 386962564, 'kaolaim', '2025-06-28 23:49:42', 184, 1);
INSERT INTO `flyway_schema_history` VALUES (43, '1.0.0.43', 'wallet trade', 'SQL', 'V1.0.0_43__wallet_trade.sql', -1224666004, 'kaolaim', '2025-06-28 23:49:42', 217, 1);
INSERT INTO `flyway_schema_history` VALUES (44, '1.0.0.44', 'wallet receive', 'SQL', 'V1.0.0_44__wallet_receive.sql', 1162800242, 'kaolaim', '2025-06-28 23:49:43', 189, 1);
INSERT INTO `flyway_schema_history` VALUES (45, '1.0.0.45', 'uni item', 'SQL', 'V1.0.0_45__uni_item.sql', 1087011788, 'kaolaim', '2025-06-28 23:49:44', 627, 1);
INSERT INTO `flyway_schema_history` VALUES (46, '1.0.0.46', 'sys menu', 'SQL', 'V1.0.0_46__sys_menu.sql', -27016963, 'kaolaim', '2025-06-28 23:49:45', 292, 1);
INSERT INTO `flyway_schema_history` VALUES (47, '1.0.0.47', 'wallet trade', 'SQL', 'V1.0.0_47__wallet_trade.sql', -1178486552, 'kaolaim', '2025-06-28 23:49:45', 204, 1);
INSERT INTO `flyway_schema_history` VALUES (48, '1.0.0.48', 'chat user', 'SQL', 'V1.0.0_48__chat_user.sql', -2006361063, 'kaolaim', '2025-06-28 23:49:46', 260, 1);
INSERT INTO `flyway_schema_history` VALUES (49, '1.0.0.49', 'wallet cash', 'SQL', 'V1.0.0_49__wallet_cash.sql', -1149289969, 'kaolaim', '2025-06-28 23:49:47', 187, 1);
INSERT INTO `flyway_schema_history` VALUES (50, '1.0.0.50', 'chat user', 'SQL', 'V1.0.0_50__chat_user.sql', 1662971031, 'kaolaim', '2025-06-28 23:49:47', 200, 1);
INSERT INTO `flyway_schema_history` VALUES (51, '1.0.0.51', 'chat feedback', 'SQL', 'V1.0.0_51__chat_feedback.sql', 1667972539, 'kaolaim', '2025-06-28 23:49:48', 193, 1);
INSERT INTO `flyway_schema_history` VALUES (52, '1.0.0.52', 'chat config', 'SQL', 'V1.0.0_52__chat_config.sql', 67606181, 'kaolaim', '2025-06-28 23:49:49', 480, 1);
INSERT INTO `flyway_schema_history` VALUES (53, '1.0.0.53', 'sys error', 'SQL', 'V1.0.0_53__sys_error.sql', 900652465, 'kaolaim', '2025-06-28 23:49:49', 191, 1);

-- ----------------------------
-- Table structure for friend_comments
-- ----------------------------
DROP TABLE IF EXISTS `friend_comments`;
CREATE TABLE `friend_comments`  (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `moment_id` bigint(20) NOT NULL COMMENT '关联动态ID',
  `user_id` bigint(20) NOT NULL COMMENT '评论用户ID',
  `reply_to` bigint(20) NULL DEFAULT NULL COMMENT '回复的评论ID（可为空）',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除标记',
  `source` tinyint(1) NULL DEFAULT 1 COMMENT '是否为版主回复',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `idx_moment_time`(`moment_id`, `create_time`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `reply_to`(`reply_to`) USING BTREE,
  CONSTRAINT `friend_comments_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `friend_moments` (`moment_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `friend_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `chat_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1950885495496159235 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_comments
-- ----------------------------

-- ----------------------------
-- Table structure for friend_likes
-- ----------------------------
DROP TABLE IF EXISTS `friend_likes`;
CREATE TABLE `friend_likes`  (
  `like_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `moment_id` bigint(20) NOT NULL COMMENT '关联动态ID',
  `user_id` bigint(20) NOT NULL COMMENT '点赞用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除标记',
  PRIMARY KEY (`like_id`) USING BTREE,
  UNIQUE INDEX `uniq_moment_user`(`moment_id`, `user_id`) USING BTREE,
  INDEX `idx_moment_time`(`moment_id`, `create_time`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `friend_likes_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `friend_moments` (`moment_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `friend_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `chat_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1950860407791067138 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_likes
-- ----------------------------

-- ----------------------------
-- Table structure for friend_medias
-- ----------------------------
DROP TABLE IF EXISTS `friend_medias`;
CREATE TABLE `friend_medias`  (
  `media_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '媒体资源ID',
  `moment_id` bigint(20) NOT NULL COMMENT '关联动态ID',
  `momid` bigint(20) NULL DEFAULT NULL COMMENT '事件ID',
  `url` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源URL',
  `thumbnail` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '类型：0-图片，1-视频，2-音频',
  `sort_order` tinyint(4) NULL DEFAULT 0 COMMENT '排序顺序',
  `width` smallint(6) NULL DEFAULT 0 COMMENT '宽度（图片/视频）',
  `height` smallint(6) NULL DEFAULT 0 COMMENT '高度（图片/视频）',
  `duration` int(11) NULL DEFAULT 0 COMMENT '时长（视频/音频，单位：秒）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`media_id`) USING BTREE,
  INDEX `idx_moment_sort`(`moment_id`, `sort_order`) USING BTREE,
  CONSTRAINT `friend_medias_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `friend_moments` (`moment_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1950853862168625158 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈媒体资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_medias
-- ----------------------------

-- ----------------------------
-- Table structure for friend_moments
-- ----------------------------
DROP TABLE IF EXISTS `friend_moments`;
CREATE TABLE `friend_moments`  (
  `moment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '动态ID',
  `user_id` bigint(20) NOT NULL COMMENT '发布用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文字内容',
  `location` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置信息',
  `visibility` tinyint(4) NULL DEFAULT 0 COMMENT '可见性：0-公开，1-私密，2-部分可见，3-不给谁看',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除标记',
  PRIMARY KEY (`moment_id`) USING BTREE,
  INDEX `idx_user_time`(`user_id`, `create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1950853861543673859 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈动态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_moments
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799001', 'DEFAULT', '0 0/5 * * * ? *', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799002', 'DEFAULT', '0 0 3 * * ? *', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799003', 'DEFAULT', '0 0/10 * * * ? *', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799004', 'DEFAULT', '0 0 5 * * ? *', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799005', 'DEFAULT', '0 0/5 * * * ? *', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_durable` tinyint(1) NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `requests_recovery` tinyint(1) NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799001', 'DEFAULT', NULL, 'com.platform.modules.quartz.factory.QuartzJobExecution', 0, '1', '0', 0, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372002C636F6D2E706C6174666F726D2E6D6F64756C65732E71756172747A2E646F6D61696E2E51756172747A4A6F6200000000000000010200054C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C000C696E766F6B6554617267657471007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C00067374617475737400274C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F5965734F724E6F456E756D3B78720029636F6D2E706C6174666F726D2E636F6D6D6F6E2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0009626567696E54696D657400104C6A6176612F7574696C2F446174653B4C0005636F756E7471007E000A4C0007656E6454696D6571007E000D4C00056C6162656C71007E00094C0005706172616D71007E00094C0006706172616D7371007E00034C000874696D65556E69747400284C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F54696D65556E6974456E756D3B78707070707070707074000F3020302F35202A202A202A203F202A74001877616C6C65745461736B536572766963652E7461736B28297372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787018E40E69117905D974000CE992B1E58C85E4BBBBE58AA17E720025636F6D2E706C6174666F726D2E636F6D6D6F6E2E656E756D732E5965734F724E6F456E756D00000000000000001200007872000E6A6176612E6C616E672E456E756D000000000000000012000078707400035945537800);
INSERT INTO `qrtz_job_details` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799002', 'DEFAULT', NULL, 'com.platform.modules.quartz.factory.QuartzJobExecution', 0, '1', '0', 0, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372002C636F6D2E706C6174666F726D2E6D6F64756C65732E71756172747A2E646F6D61696E2E51756172747A4A6F6200000000000000010200054C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C000C696E766F6B6554617267657471007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C00067374617475737400274C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F5965734F724E6F456E756D3B78720029636F6D2E706C6174666F726D2E636F6D6D6F6E2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0009626567696E54696D657400104C6A6176612F7574696C2F446174653B4C0005636F756E7471007E000A4C0007656E6454696D6571007E000D4C00056C6162656C71007E00094C0005706172616D71007E00094C0006706172616D7371007E00034C000874696D65556E69747400284C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F54696D65556E6974456E756D3B78707070707070707074000D3020302033202A202A203F202A740017636861745461736B536572766963652E766973697428297372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787018E40E69117905DA74000CE794A8E688B7E697A5E6B4BB7E720025636F6D2E706C6174666F726D2E636F6D6D6F6E2E656E756D732E5965734F724E6F456E756D00000000000000001200007872000E6A6176612E6C616E672E456E756D000000000000000012000078707400035945537800);
INSERT INTO `qrtz_job_details` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799003', 'DEFAULT', NULL, 'com.platform.modules.quartz.factory.QuartzJobExecution', 0, '1', '0', 0, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372002C636F6D2E706C6174666F726D2E6D6F64756C65732E71756172747A2E646F6D61696E2E51756172747A4A6F6200000000000000010200054C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C000C696E766F6B6554617267657471007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C00067374617475737400274C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F5965734F724E6F456E756D3B78720029636F6D2E706C6174666F726D2E636F6D6D6F6E2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0009626567696E54696D657400104C6A6176612F7574696C2F446174653B4C0005636F756E7471007E000A4C0007656E6454696D6571007E000D4C00056C6162656C71007E00094C0005706172616D71007E00094C0006706172616D7371007E00034C000874696D65556E69747400284C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F54696D65556E6974456E756D3B7870707070707070707400103020302F3130202A202A202A203F202A740018636861745461736B536572766963652E62616E6E656428297372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787018E40E69117905DB74000CE794A8E688B7E8A7A3E5B0817E720025636F6D2E706C6174666F726D2E636F6D6D6F6E2E656E756D732E5965734F724E6F456E756D00000000000000001200007872000E6A6176612E6C616E672E456E756D000000000000000012000078707400035945537800);
INSERT INTO `qrtz_job_details` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799004', 'DEFAULT', NULL, 'com.platform.modules.quartz.factory.QuartzJobExecution', 0, '1', '0', 0, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372002C636F6D2E706C6174666F726D2E6D6F64756C65732E71756172747A2E646F6D61696E2E51756172747A4A6F6200000000000000010200054C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C000C696E766F6B6554617267657471007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C00067374617475737400274C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F5965734F724E6F456E756D3B78720029636F6D2E706C6174666F726D2E636F6D6D6F6E2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0009626567696E54696D657400104C6A6176612F7574696C2F446174653B4C0005636F756E7471007E000A4C0007656E6454696D6571007E000D4C00056C6162656C71007E00094C0005706172616D71007E00094C0006706172616D7371007E00034C000874696D65556E69747400284C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F54696D65556E6974456E756D3B78707070707070707074000D3020302035202A202A203F202A740017636861745461736B536572766963652E6C6576656C28297372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787018E40E69117905DC74000CE7BEA4E7BB84E9998DE7BAA77E720025636F6D2E706C6174666F726D2E636F6D6D6F6E2E656E756D732E5965734F724E6F456E756D00000000000000001200007872000E6A6176612E6C616E672E456E756D000000000000000012000078707400035945537800);
INSERT INTO `qrtz_job_details` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799005', 'DEFAULT', NULL, 'com.platform.modules.quartz.factory.QuartzJobExecution', 0, '1', '0', 0, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372002C636F6D2E706C6174666F726D2E6D6F64756C65732E71756172747A2E646F6D61696E2E51756172747A4A6F6200000000000000010200054C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C000C696E766F6B6554617267657471007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C00067374617475737400274C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F5965734F724E6F456E756D3B78720029636F6D2E706C6174666F726D2E636F6D6D6F6E2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0009626567696E54696D657400104C6A6176612F7574696C2F446174653B4C0005636F756E7471007E000A4C0007656E6454696D6571007E000D4C00056C6162656C71007E00094C0005706172616D71007E00094C0006706172616D7371007E00034C000874696D65556E69747400284C636F6D2F706C6174666F726D2F636F6D6D6F6E2F656E756D732F54696D65556E6974456E756D3B78707070707070707074000F3020302F35202A202A202A203F202A74001B77616C6C657452656365697665536572766963652E7461736B28297372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787018E40E69117905DD74000CE992B1E58C85E8A1A5E581BF7E720025636F6D2E706C6174666F726D2E636F6D6D6F6E2E656E756D732E5965734F724E6F456E756D00000000000000001200007872000E6A6176612E6C616E672E456E756D000000000000000012000078707400035945537800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('AppScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('AppScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('AppScheduler', '10-30-18-41754531699703', 1754560287082, 15000);
INSERT INTO `qrtz_scheduler_state` VALUES ('AppScheduler', 'DESKTOP-PSRFMEG1754537465701', 1754560283023, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(13) NULL DEFAULT NULL,
  `prev_fire_time` bigint(13) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(2) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799001', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799001', 'DEFAULT', NULL, 1754560500000, 1754560200000, 5, 'WAITING', 'CRON', 1754537469000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799002', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799002', 'DEFAULT', NULL, 1754593200000, -1, 5, 'WAITING', 'CRON', 1754537469000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799003', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799003', 'DEFAULT', NULL, 1754560800000, 1754560200000, 5, 'WAITING', 'CRON', 1754537470000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799004', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799004', 'DEFAULT', NULL, 1754600400000, -1, 5, 'WAITING', 'CRON', 1754537470000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799005', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799005', 'DEFAULT', NULL, 1754560500000, 1754560200000, 5, 'WAITING', 'CRON', 1754537471000, 0, NULL, 2, '');

-- ----------------------------
-- Table structure for quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `quartz_job`;
CREATE TABLE `quartz_job`  (
  `job_id` bigint(20) NOT NULL COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '状态（Y正常N暂停）',
  PRIMARY KEY (`job_id`, `job_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quartz_job
-- ----------------------------
INSERT INTO `quartz_job` VALUES (1793574396027799001, '钱包任务', 'walletTaskService.task()', '0 0/5 * * * ? *', 'Y');
INSERT INTO `quartz_job` VALUES (1793574396027799002, '用户日活', 'chatTaskService.visit()', '0 0 3 * * ? *', 'Y');
INSERT INTO `quartz_job` VALUES (1793574396027799003, '用户解封', 'chatTaskService.banned()', '0 0/10 * * * ? *', 'Y');
INSERT INTO `quartz_job` VALUES (1793574396027799004, '群组降级', 'chatTaskService.level()', '0 0 5 * * ? *', 'Y');
INSERT INTO `quartz_job` VALUES (1793574396027799005, '钱包补偿', 'walletReceiveService.task()', '0 0/5 * * * ? *', 'Y');

-- ----------------------------
-- Table structure for quartz_log
-- ----------------------------
DROP TABLE IF EXISTS `quartz_log`;
CREATE TABLE `quartz_log`  (
  `log_id` bigint(20) NOT NULL COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `message` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quartz_log
-- ----------------------------
INSERT INTO `quartz_log` VALUES (1953303837045518337, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 11:55:00');
INSERT INTO `quartz_log` VALUES (1953303839625019394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：91毫秒', 'Y', '2025-08-07 11:55:01');
INSERT INTO `quartz_log` VALUES (1953305095353495554, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 12:00:00');
INSERT INTO `quartz_log` VALUES (1953305095588376578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 12:00:00');
INSERT INTO `quartz_log` VALUES (1953305097668755458, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-07 12:00:01');
INSERT INTO `quartz_log` VALUES (1953306353648889858, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 12:05:00');
INSERT INTO `quartz_log` VALUES (1953306356207419393, '钱包补偿', 'walletReceiveService.task()', '总共耗时：71毫秒', 'Y', '2025-08-07 12:05:01');
INSERT INTO `quartz_log` VALUES (1953307611935895554, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-07 12:10:00');
INSERT INTO `quartz_log` VALUES (1953307612116250626, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 12:10:00');
INSERT INTO `quartz_log` VALUES (1953307614410539010, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-07 12:10:01');
INSERT INTO `quartz_log` VALUES (1953308870235484162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 12:15:00');
INSERT INTO `quartz_log` VALUES (1953308872601075714, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-07 12:15:01');
INSERT INTO `quartz_log` VALUES (1953310128539267074, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 12:20:00');
INSERT INTO `quartz_log` VALUES (1953310128816091138, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 12:20:00');
INSERT INTO `quartz_log` VALUES (1953310131110379522, '用户解封', 'chatTaskService.banned()', '总共耗时：81毫秒', 'Y', '2025-08-07 12:20:01');
INSERT INTO `quartz_log` VALUES (1953311386780135426, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 12:25:00');
INSERT INTO `quartz_log` VALUES (1953311389128949761, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-07 12:25:01');
INSERT INTO `quartz_log` VALUES (1953312645100695553, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-07 12:30:00');
INSERT INTO `quartz_log` VALUES (1953312645331382274, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 12:30:00');
INSERT INTO `quartz_log` VALUES (1953312647889911810, '钱包任务', 'walletTaskService.task()', '总共耗时：103毫秒', 'Y', '2025-08-07 12:30:01');
INSERT INTO `quartz_log` VALUES (1953313903396089857, '钱包任务', 'walletTaskService.task()', '总共耗时：14毫秒', 'Y', '2025-08-07 12:35:00');
INSERT INTO `quartz_log` VALUES (1953313905547771906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 12:35:00');
INSERT INTO `quartz_log` VALUES (1953315161758593025, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 12:40:00');
INSERT INTO `quartz_log` VALUES (1953315162089943041, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 12:40:00');
INSERT INTO `quartz_log` VALUES (1953315163906080770, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 12:40:01');
INSERT INTO `quartz_log` VALUES (1953316419978489857, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 12:45:00');
INSERT INTO `quartz_log` VALUES (1953316422142754818, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 12:45:00');
INSERT INTO `quartz_log` VALUES (1953317678240329730, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-07 12:50:00');
INSERT INTO `quartz_log` VALUES (1953317678433267714, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 12:50:00');
INSERT INTO `quartz_log` VALUES (1953317680375234562, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 12:50:00');
INSERT INTO `quartz_log` VALUES (1953318936556695554, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 12:55:00');
INSERT INTO `quartz_log` VALUES (1953318938620297218, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-07 12:55:00');
INSERT INTO `quartz_log` VALUES (1953320194826924034, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-07 13:00:00');
INSERT INTO `quartz_log` VALUES (1953320195053416449, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 13:00:00');
INSERT INTO `quartz_log` VALUES (1953320197406425090, '用户解封', 'chatTaskService.banned()', '总共耗时：74毫秒', 'Y', '2025-08-07 13:00:01');
INSERT INTO `quartz_log` VALUES (1953321453139095553, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 13:05:00');
INSERT INTO `quartz_log` VALUES (1953321455592767490, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-07 13:05:01');
INSERT INTO `quartz_log` VALUES (1953322711400935425, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-07 13:10:00');
INSERT INTO `quartz_log` VALUES (1953322711572901890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 13:10:00');
INSERT INTO `quartz_log` VALUES (1953322713661669377, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-07 13:10:01');
INSERT INTO `quartz_log` VALUES (1953323969671163906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 13:15:00');
INSERT INTO `quartz_log` VALUES (1953323973081137154, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-07 13:15:01');
INSERT INTO `quartz_log` VALUES (1953325228000112641, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-07 13:20:00');
INSERT INTO `quartz_log` VALUES (1953325229933686785, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 13:20:00');
INSERT INTO `quartz_log` VALUES (1953325230181154818, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 13:20:00');
INSERT INTO `quartz_log` VALUES (1953326486303895554, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 13:25:00');
INSERT INTO `quartz_log` VALUES (1953326488564629506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 13:25:01');
INSERT INTO `quartz_log` VALUES (1953327744607678465, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-07 13:30:00');
INSERT INTO `quartz_log` VALUES (1953327746272817153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 13:30:00');
INSERT INTO `quartz_log` VALUES (1953327746641920002, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-07 13:30:00');
INSERT INTO `quartz_log` VALUES (1953329002848546818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 13:35:00');
INSERT INTO `quartz_log` VALUES (1953329005012811778, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-07 13:35:00');
INSERT INTO `quartz_log` VALUES (1953330261135552513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 13:40:00');
INSERT INTO `quartz_log` VALUES (1953330263102681090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 13:40:00');
INSERT INTO `quartz_log` VALUES (1953330263387897858, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-07 13:40:01');
INSERT INTO `quartz_log` VALUES (1953331519460306946, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 13:45:00');
INSERT INTO `quartz_log` VALUES (1953331526028591106, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-07 13:45:02');
INSERT INTO `quartz_log` VALUES (1953332777709563905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 13:50:00');
INSERT INTO `quartz_log` VALUES (1953332779597000705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 13:50:00');
INSERT INTO `quartz_log` VALUES (1953332779894800385, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 13:50:00');
INSERT INTO `quartz_log` VALUES (1953334036034318338, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 13:55:00');
INSERT INTO `quartz_log` VALUES (1953334038110502914, '钱包任务', 'walletTaskService.task()', '总共耗时：72毫秒', 'Y', '2025-08-07 13:55:00');
INSERT INTO `quartz_log` VALUES (1953335294308741121, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 14:00:00');
INSERT INTO `quartz_log` VALUES (1953335294560399362, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 14:00:00');
INSERT INTO `quartz_log` VALUES (1953335297194426369, '钱包任务', 'walletTaskService.task()', '总共耗时：98毫秒', 'Y', '2025-08-07 14:00:01');
INSERT INTO `quartz_log` VALUES (1953336552578969602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 14:05:00');
INSERT INTO `quartz_log` VALUES (1953336556462899202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：99毫秒', 'Y', '2025-08-07 14:05:01');
INSERT INTO `quartz_log` VALUES (1953337810882752513, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 14:10:00');
INSERT INTO `quartz_log` VALUES (1953337811092467713, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 14:10:00');
INSERT INTO `quartz_log` VALUES (1953337813483225089, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-07 14:10:01');
INSERT INTO `quartz_log` VALUES (1953339069190729730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 14:15:00');
INSERT INTO `quartz_log` VALUES (1953339072055443458, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-07 14:15:01');
INSERT INTO `quartz_log` VALUES (1953340327473541122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 14:20:00');
INSERT INTO `quartz_log` VALUES (1953340329390338050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 14:20:00');
INSERT INTO `quartz_log` VALUES (1953340329872687106, '用户解封', 'chatTaskService.banned()', '总共耗时：72毫秒', 'Y', '2025-08-07 14:20:01');
INSERT INTO `quartz_log` VALUES (1953341585773129730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 14:25:00');
INSERT INTO `quartz_log` VALUES (1953341588528791554, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-07 14:25:01');
INSERT INTO `quartz_log` VALUES (1953342844068524034, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 14:30:00');
INSERT INTO `quartz_log` VALUES (1953342844324376578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 14:30:00');
INSERT INTO `quartz_log` VALUES (1953342847067455489, '用户解封', 'chatTaskService.banned()', '总共耗时：171毫秒', 'Y', '2025-08-07 14:30:01');
INSERT INTO `quartz_log` VALUES (1953344102351335426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 14:35:00');
INSERT INTO `quartz_log` VALUES (1953344104561737730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-07 14:35:00');
INSERT INTO `quartz_log` VALUES (1953345360650924033, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-07 14:40:00');
INSERT INTO `quartz_log` VALUES (1953345360869027841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-07 14:40:00');
INSERT INTO `quartz_log` VALUES (1953345364589379586, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 14:40:01');
INSERT INTO `quartz_log` VALUES (1953346618908569601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 14:45:00');
INSERT INTO `quartz_log` VALUES (1953346621504847873, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-07 14:45:01');
INSERT INTO `quartz_log` VALUES (1953347877279461378, '用户解封', 'chatTaskService.banned()', '总共耗时：18毫秒', 'Y', '2025-08-07 14:50:00');
INSERT INTO `quartz_log` VALUES (1953347877455622145, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 14:50:00');
INSERT INTO `quartz_log` VALUES (1953347879842185217, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-07 14:50:01');
INSERT INTO `quartz_log` VALUES (1953349135528718338, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 14:55:00');
INSERT INTO `quartz_log` VALUES (1953349137743314945, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-07 14:55:00');
INSERT INTO `quartz_log` VALUES (1953350393811529729, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 15:00:00');
INSERT INTO `quartz_log` VALUES (1953350394155462657, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 15:00:00');
INSERT INTO `quartz_log` VALUES (1953350396370059265, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-07 15:00:01');
INSERT INTO `quartz_log` VALUES (1953351652106924033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 15:05:00');
INSERT INTO `quartz_log` VALUES (1953351659757338626, '钱包任务', 'walletTaskService.task()', '总共耗时：586毫秒', 'Y', '2025-08-07 15:05:01');
INSERT INTO `quartz_log` VALUES (1953352910377152513, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 15:10:00');
INSERT INTO `quartz_log` VALUES (1953352910591062017, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 15:10:00');
INSERT INTO `quartz_log` VALUES (1953352913401249793, '钱包任务', 'walletTaskService.task()', '总共耗时：123毫秒', 'Y', '2025-08-07 15:10:01');
INSERT INTO `quartz_log` VALUES (1953354168680935425, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 15:15:00');
INSERT INTO `quartz_log` VALUES (1953354171092664322, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 15:15:01');
INSERT INTO `quartz_log` VALUES (1953355426993106945, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 15:20:00');
INSERT INTO `quartz_log` VALUES (1953355427207016450, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 15:20:00');
INSERT INTO `quartz_log` VALUES (1953355430717652993, '用户解封', 'chatTaskService.banned()', '总共耗时：69毫秒', 'Y', '2025-08-07 15:20:01');
INSERT INTO `quartz_log` VALUES (1953356685263335425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 15:25:00');
INSERT INTO `quartz_log` VALUES (1953356687926722562, '钱包任务', 'walletTaskService.task()', '总共耗时：129毫秒', 'Y', '2025-08-07 15:25:01');
INSERT INTO `quartz_log` VALUES (1953357943554535426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 15:30:00');
INSERT INTO `quartz_log` VALUES (1953357943839748097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 15:30:00');
INSERT INTO `quartz_log` VALUES (1953357946117259266, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 15:30:01');
INSERT INTO `quartz_log` VALUES (1953359201849929730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 15:35:00');
INSERT INTO `quartz_log` VALUES (1953359204249075714, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-07 15:35:01');
INSERT INTO `quartz_log` VALUES (1953360460166295553, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 15:40:00');
INSERT INTO `quartz_log` VALUES (1953360462234087426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 15:40:01');
INSERT INTO `quartz_log` VALUES (1953360462544470018, '钱包任务', 'walletTaskService.task()', '总共耗时：75毫秒', 'Y', '2025-08-07 15:40:01');
INSERT INTO `quartz_log` VALUES (1953361718415552513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 15:45:00');
INSERT INTO `quartz_log` VALUES (1953361720844058625, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-07 15:45:01');
INSERT INTO `quartz_log` VALUES (1953362976698363906, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 15:50:00');
INSERT INTO `quartz_log` VALUES (1953362977008742402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 15:50:00');
INSERT INTO `quartz_log` VALUES (1953362979458220033, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 15:50:01');
INSERT INTO `quartz_log` VALUES (1953364234989563905, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 15:55:00');
INSERT INTO `quartz_log` VALUES (1953364237661339650, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-07 15:55:01');
INSERT INTO `quartz_log` VALUES (1953365493305929729, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 16:00:00');
INSERT INTO `quartz_log` VALUES (1953365493519839233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 16:00:00');
INSERT INTO `quartz_log` VALUES (1953365495759601665, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-07 16:00:01');
INSERT INTO `quartz_log` VALUES (1953366751530020866, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 16:05:00');
INSERT INTO `quartz_log` VALUES (1953366753941749762, '钱包补偿', 'walletReceiveService.task()', '总共耗时：84毫秒', 'Y', '2025-08-07 16:05:01');
INSERT INTO `quartz_log` VALUES (1953368009854775297, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-07 16:10:00');
INSERT INTO `quartz_log` VALUES (1953368010022547457, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 16:10:00');
INSERT INTO `quartz_log` VALUES (1953368012631408641, '钱包任务', 'walletTaskService.task()', '总共耗时：82毫秒', 'Y', '2025-08-07 16:10:01');
INSERT INTO `quartz_log` VALUES (1953369268275998721, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 16:15:00');
INSERT INTO `quartz_log` VALUES (1953369270738059265, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-07 16:15:01');
INSERT INTO `quartz_log` VALUES (1953370526479118338, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-07 16:20:00');
INSERT INTO `quartz_log` VALUES (1953370526705610753, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 16:20:00');
INSERT INTO `quartz_log` VALUES (1953370529108951041, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-07 16:20:01');
INSERT INTO `quartz_log` VALUES (1953371784761929730, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 16:25:00');
INSERT INTO `quartz_log` VALUES (1953371787265933314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-07 16:25:01');
INSERT INTO `quartz_log` VALUES (1953373043044741122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 16:30:00');
INSERT INTO `quartz_log` VALUES (1953373043355119618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 16:30:00');
INSERT INTO `quartz_log` VALUES (1953373045661990913, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 16:30:01');
INSERT INTO `quartz_log` VALUES (1953374301335941121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 16:35:00');
INSERT INTO `quartz_log` VALUES (1953374303798001666, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-07 16:35:01');
INSERT INTO `quartz_log` VALUES (1953375559622946817, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 16:40:00');
INSERT INTO `quartz_log` VALUES (1953375559836856322, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 16:40:00');
INSERT INTO `quartz_log` VALUES (1953375562105978882, '用户解封', 'chatTaskService.banned()', '总共耗时：74毫秒', 'Y', '2025-08-07 16:40:01');
INSERT INTO `quartz_log` VALUES (1953376817893175297, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 16:45:00');
INSERT INTO `quartz_log` VALUES (1953376820342652929, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-07 16:45:01');
INSERT INTO `quartz_log` VALUES (1953378076217929730, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-07 16:50:00');
INSERT INTO `quartz_log` VALUES (1953378076402479106, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 16:50:00');
INSERT INTO `quartz_log` VALUES (1953378078998757377, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 16:50:01');
INSERT INTO `quartz_log` VALUES (1953379334500741121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 16:55:00');
INSERT INTO `quartz_log` VALUES (1953379336933441537, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 16:55:01');
INSERT INTO `quartz_log` VALUES (1953380592804524034, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 17:00:00');
INSERT INTO `quartz_log` VALUES (1953380595761508353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 17:00:01');
INSERT INTO `quartz_log` VALUES (1953380596138999809, '用户解封', 'chatTaskService.banned()', '总共耗时：82毫秒', 'Y', '2025-08-07 17:00:01');
INSERT INTO `quartz_log` VALUES (1953381851104112641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 17:05:00');
INSERT INTO `quartz_log` VALUES (1953381853402595330, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-07 17:05:01');
INSERT INTO `quartz_log` VALUES (1953383109382729730, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 17:10:00');
INSERT INTO `quartz_log` VALUES (1953383109596639233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 17:10:00');
INSERT INTO `quartz_log` VALUES (1953383111903510530, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-07 17:10:01');
INSERT INTO `quartz_log` VALUES (1953384367636180993, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 17:15:00');
INSERT INTO `quartz_log` VALUES (1953384370626723842, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-07 17:15:01');
INSERT INTO `quartz_log` VALUES (1953385625956741121, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 17:20:00');
INSERT INTO `quartz_log` VALUES (1953385627848372225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 17:20:00');
INSERT INTO `quartz_log` VALUES (1953385628167143425, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 17:20:00');
INSERT INTO `quartz_log` VALUES (1953386884260524034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 17:25:00');
INSERT INTO `quartz_log` VALUES (1953386886491897858, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 17:25:01');
INSERT INTO `quartz_log` VALUES (1953388142530752514, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 17:30:00');
INSERT INTO `quartz_log` VALUES (1953388144447549441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-07 17:30:00');
INSERT INTO `quartz_log` VALUES (1953388144854401025, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-07 17:30:01');
INSERT INTO `quartz_log` VALUES (1953389400821952514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 17:35:00');
INSERT INTO `quartz_log` VALUES (1953389403070103554, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-07 17:35:01');
INSERT INTO `quartz_log` VALUES (1953390659129929729, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 17:40:00');
INSERT INTO `quartz_log` VALUES (1953390661050920962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 17:40:00');
INSERT INTO `quartz_log` VALUES (1953390661390663681, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-07 17:40:01');
INSERT INTO `quartz_log` VALUES (1953391917374992386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 17:45:00');
INSERT INTO `quartz_log` VALUES (1953391919912550401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-07 17:45:01');
INSERT INTO `quartz_log` VALUES (1953393175708135426, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 17:50:00');
INSERT INTO `quartz_log` VALUES (1953393177616543745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 17:50:00');
INSERT INTO `quartz_log` VALUES (1953393178119864322, '用户解封', 'chatTaskService.banned()', '总共耗时：88毫秒', 'Y', '2025-08-07 17:50:01');

-- ----------------------------
-- Table structure for sys_column
-- ----------------------------
DROP TABLE IF EXISTS `sys_column`;
CREATE TABLE `sys_column`  (
  `column_id` bigint(20) NOT NULL COMMENT '表格ID',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `table_id` int(9) NULL DEFAULT NULL COMMENT '字段ID',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '字段内容',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '动态表格' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_column
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `dict_id` bigint(20) NOT NULL COMMENT '主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `dict_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`, `dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_error
-- ----------------------------
DROP TABLE IF EXISTS `sys_error`;
CREATE TABLE `sys_error`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文本内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统错误表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_error
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `log_id` bigint(20) NOT NULL COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `log_type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '业务类型',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `request_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `ip_addr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `message` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '操作状态（Y正常N异常）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_login`;
CREATE TABLE `sys_login`  (
  `log_id` bigint(20) NOT NULL COMMENT '访问ID',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ip_addr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '登录状态（Y成功 N失败）',
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_login
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL COMMENT '主ID',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '类型（M目录 C菜单 F按钮）',
  `icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '图标',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路径',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `perms` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限',
  `sort` int(4) NULL DEFAULT 0 COMMENT '顺序',
  `frame_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '外链',
  `frame_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '地址',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Y' COMMENT '菜单状态（Y正常N停用）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '显示',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1590993102, 0, '系统设置', '1', 'SettingOutlined', NULL, NULL, NULL, 902, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993118, 0, '系统监控', '1', 'CloudServerOutlined', NULL, NULL, NULL, 903, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993159, 1590993506, '用户管理', '2', 'AuditOutlined', '/sys/user', '/sys/user/index', 'sys:user:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993181, 1590993506, '角色管理', '2', 'SlidersOutlined', '/sys/role', '/sys/role/index', 'sys:role:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993195, 1590993102, '菜单管理', '2', 'CopyOutlined', '/sys/menu', '/sys/menu/index', 'sys:menu:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993303, 1590993102, '字典管理', '2', 'BarcodeOutlined', '/sys/dict', '/sys/dict/index', 'sys:dict:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993365, 1590993118, '在线用户', '2', 'ContactsOutlined', '/monitor/online', '/monitor/online/index', 'monitor:online:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993390, 1616398154, '定时任务', '2', 'FileExcelOutlined', '/quartz/job', '/quartz/job/index', 'quartz:job:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993460, 1725692158, '操作日志', '2', 'PicLeftOutlined', '/sys/log', '/sys/log/index', 'sys:log:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993481, 1725692158, '登录日志', '2', 'PicRightOutlined', '/sys/login', '/sys/login/index', 'sys:login:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993506, 0, '系统账户', '1', 'UserOutlined', NULL, NULL, NULL, 901, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993543, 1590993159, '用户新增', '3', '#', NULL, NULL, 'sys:user:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993546, 1590993159, '用户修改', '3', '#', NULL, NULL, 'sys:user:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993549, 1590993159, '用户删除', '3', '#', NULL, NULL, 'sys:user:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993567, 1590993181, '角色新增', '3', '#', NULL, NULL, 'sys:role:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993570, 1590993181, '角色修改', '3', '#', NULL, NULL, 'sys:role:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993579, 1590993181, '角色删除', '3', '#', NULL, NULL, 'sys:role:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993625, 1590993195, '菜单新增', '3', '#', '', '', 'sys:menu:add', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993629, 1590993195, '菜单修改', '3', '#', '', '', 'sys:menu:edit', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993633, 1590993195, '菜单删除', '3', '#', '', '', 'sys:menu:remove', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993734, 1590993303, '字典新增', '3', '#', NULL, NULL, 'sys:dict:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993737, 1590993303, '字典修改', '3', '#', NULL, NULL, 'sys:dict:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993750, 1590993303, '字典删除', '3', '#', NULL, NULL, 'sys:dict:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993793, 1590993460, '操作删除', '3', '#', NULL, NULL, 'sys:log:remove', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993804, 1590993481, '登录删除', '3', '#', NULL, NULL, 'sys:login:remove', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993816, 1590993365, '批量强退', '3', '#', NULL, NULL, 'monitor:online:logout', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993827, 1590993390, '任务新增', '3', '#', NULL, NULL, 'quartz:job:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993831, 1590993390, '任务修改', '3', '#', NULL, NULL, 'quartz:job:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1590993834, 1590993390, '任务删除', '3', '#', NULL, NULL, 'quartz:job:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1612438635, 1590993390, '执行一次', '3', '#', NULL, NULL, 'quartz:job:run', 4, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1616398154, 0, '系统任务', '1', 'AppstoreOutlined', NULL, NULL, NULL, 904, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1616407020, 1590993118, '缓存监控', '2', 'FundProjectionScreenOutlined', '/monitor/cache', '/monitor/cache/index', 'monitor:cache:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1616653528, 1590993195, '菜单复制', '3', '#', NULL, NULL, 'sys:menu:copy', 4, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1660205475, 1616398154, '定时日志', '2', 'FileExclamationOutlined', '/quartz/log', '/quartz/log/index', 'quartz:log:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1660205479, 1660205475, '任务删除', '3', '#', NULL, NULL, 'quartz:log:remove', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667963359, 1667963444, '用户管理', '2', 'UserAddOutlined', '/chat/user', '/chat/user/index', 'chat:user:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667963444, 0, '用户管理', '1', 'UserSwitchOutlined', NULL, NULL, NULL, 101, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667985163, 1673405797, '系统公告', '2', 'ScheduleOutlined', '/operate/notice', '/operate/notice/index', 'operate:notice:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667985164, 1667985163, '查询', '3', '#', '', '', 'operate:notice:query', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667985165, 1667985163, '新增', '3', '#', '', '', 'operate:notice:add', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667985166, 1667985163, '修改', '3', '#', '', '', 'operate:notice:edit', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667985167, 1667985163, '删除', '3', '#', '', '', 'operate:notice:remove', 4, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667987841, 1673405797, '帮助中心', '2', 'LineHeightOutlined', '/operate/help', '/operate/help/index', 'operate:help:list', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667987843, 1667987841, '新增', '3', '#', NULL, NULL, 'operate:help:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667987844, 1667987841, '修改', '3', '#', NULL, NULL, 'operate:help:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667987845, 1667987841, '删除', '3', '#', NULL, NULL, 'operate:help:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667988519, 1673405797, '建议反馈', '2', 'ScheduleOutlined', '/operate/feedback', '/operate/feedback/index', 'operate:feedback:list', 4, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667988523, 1667988519, '删除', '3', '#', NULL, NULL, 'operate:feedback:remove', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667991656, 1667963444, '用户举报', '2', 'UserDeleteOutlined', '/inform/user', '/inform/user/index', 'inform:user:list', 5, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667991660, 1667991656, '处理', '3', '#', NULL, NULL, 'inform:user:banned', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667994420, 1725012573, '系统升级', '2', 'RadiusBottomleftOutlined', '/operate/version', '/operate/version/index', 'operate:version:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667994423, 1667994420, '修改', '3', '#', NULL, NULL, 'operate:version:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1667994424, 1667994420, '删除', '3', '#', NULL, NULL, 'chat:version:remove', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1668075049, 1667963444, '群组管理', '2', 'UsergroupAddOutlined', '/chat/group', '/chat/group/index', 'chat:group:list', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1669114031, 1725704817, '封禁', '3', '#', NULL, NULL, 'chat:user:banned', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1669116129, 1673405797, '首页公告', '2', 'VerticalAlignTopOutlined', '/operate/notify', '/operate/notify/index', 'operate:notify:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1669116132, 1669116129, '修改', '3', '#', NULL, NULL, 'operate:notify:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1669779155, 1668075049, '消息', '3', '#', NULL, NULL, 'chat:group:msg', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1669780522, 1667963444, '群组举报', '2', 'UsergroupDeleteOutlined', '/inform/group', '/inform/group/index', 'inform:group:list', 6, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1669780524, 1669780522, '处理', '3', '#', NULL, NULL, 'inform:group:banned', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222559, 0, '账单统计', '1', 'BarChartOutlined', NULL, NULL, NULL, 103, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222894, 1670222559, '充值记录', '2', 'FilePdfOutlined', '/trade/recharge', '/trade/recharge/index', 'wallet:trade:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222898, 1670222559, '提现记录', '2', 'FileExclamationOutlined', '/trade/cash', '/trade/cash/index', 'wallet:trade:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222900, 1670222559, '转账记录', '2', 'FileImageOutlined', '/trade/transfer', '/trade/transfer/index', 'wallet:trade:list', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222904, 1670222559, '个人红包', '2', 'FilePdfOutlined', '/trade/packet', '/trade/packet/index', 'wallet:trade:list', 5, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222907, 1670222559, '专属红包', '2', 'FilePptOutlined', '/trade/assign', '/trade/assign/index', 'wallet:trade:list', 6, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222910, 1670222559, '手气红包', '2', 'FileExclamationOutlined', '/trade/group', '/trade/group/index', 'wallet:trade:list', 7, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670222913, 1670222559, '普通红包', '2', 'FileZipOutlined', '/trade/normal', '/trade/normal/index', 'wallet:trade:list', 8, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1670236462, 1667963359, '新增', '3', '#', NULL, NULL, 'chat:user:add', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1673405797, 0, '运营管理', '1', 'StrikethroughOutlined', NULL, NULL, NULL, 104, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1673406441, 1725704817, '修改', '3', '#', NULL, NULL, 'chat:user:edit', 4, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1673406506, 1725792755, '修改', '3', '#', NULL, NULL, 'chat:group:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1673424543, 0, '应用扩展', '1', 'GlobalOutlined', NULL, NULL, NULL, 107, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1673580640, 1725704817, '充值', '3', '#', NULL, NULL, 'chat:user:wallet', 5, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1680512107, 1670222559, '扫码转账', '2', 'FileJpgOutlined', '/trade/scan', '/trade/scan/index', 'wallet:trade:list', 4, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1680601640, 0, '审批管理', '1', 'ClearOutlined', NULL, NULL, NULL, 102, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1680601960, 1680601640, '提现审批', '2', 'BorderVerticleOutlined', '/approve/cash', '/approve/cash/index', 'approve:cash:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1680601962, 1680601960, '处理', '3', '#', NULL, NULL, 'approve:cash:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1680606806, 1680601640, '认证审批', '2', 'BorderTopOutlined', '/approve/auth', '/approve/auth/index', 'approve:auth:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1680606808, 1680606806, '处理', '3', '#', NULL, NULL, 'approve:auth:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1682396198, 0, '统计管理', '1', 'AlignLeftOutlined', NULL, NULL, NULL, 106, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1682396199, 1682396198, '用户日活', '2', 'UserOutlined', '/statistics/visit', '/statistics/visit/index', 'statistics:user:visit', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1682396202, 1682396198, '用户增长', '2', 'FileAddOutlined', '/statistics/trend', '/statistics/trend/index', 'statistics:user:trend', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1683788284, 1725704817, '实名', '3', '#', NULL, NULL, 'chat:user:auth', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1683806084, 1670222559, '消费记录', '2', 'FileAddOutlined', '/trade/shopping', '/trade/shopping/index', 'wallet:trade:list', 10, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1689595552, 1725704817, '注销', '3', '#', NULL, NULL, 'chat:user:deleted', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1690877515, 1680601640, '解封审批', '2', 'BorderBottomOutlined', '/approve/banned', '/approve/banned/index', 'approve:banned:list', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1690877517, 1690877515, '处理', '3', '#', NULL, NULL, 'approve:banned:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724569052, 1669116129, 'demo', '3', '#', NULL, NULL, 'operate:notify:query', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724577139, 1682396198, '用户充值', '2', 'NodeExpandOutlined', '/statistics/recharge', '/statistics/recharge/index', 'statistics:user:recharge', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724584046, 1682396198, '用户提现', '2', 'NodeCollapseOutlined', '/statistics/cash', '/statistics/cash/index', 'statistics:user:cash', 4, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724648552, 1673405797, '用户头像', '2', 'UserAddOutlined', '/operate/portrait/user', '/operate/portrait/user/index', 'operate:portrait:user', 5, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651302, 1724648552, '新增', '3', '#', NULL, NULL, 'operate:portrait:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651355, 1724648552, '修改', '3', '#', NULL, NULL, 'operate:portrait:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651378, 1724648552, '删除', '3', '#', NULL, NULL, 'operate:portrait:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651404, 1673405797, '群聊头像', '2', 'UsergroupAddOutlined', '/operate/portrait/group', '/operate/portrait/group/index', 'operate:portrait:group', 6, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651405, 1724651404, '新增', '3', '#', NULL, NULL, 'operate:portrait:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651407, 1724651404, '修改', '3', '#', NULL, NULL, 'operate:portrait:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724651408, 1724651404, '删除', '3', '#', NULL, NULL, 'operate:portrait:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724663909, 1725012573, '充值配置', '2', 'RadiusBottomrightOutlined', '/operate/recharge', '/operate/recharge/index', 'operate:recharge:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724663910, 1724663909, '修改', '3', '#', '', '', 'operate:recharge:edit', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724668523, 1725012573, '群组扩容', '2', 'RadiusUpleftOutlined', '/operate/group', '/operate/group/index', 'operate:group:list', 4, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724668524, 1724668523, '修改', '3', '#', '', '', 'operate:group:edit', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724742619, 1725012573, '提现配置', '2', 'RadiusSettingOutlined', '/operate/cash', '/operate/cash/index', 'operate:cash:list', 3, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724742620, 1724742619, '修改', '3', '#', '', '', 'operate:cash:edit', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724744484, 1725012573, '配置中心', '2', 'RadiusUprightOutlined', '/operate/config', '/operate/config/index', 'operate:config:list', 5, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1724744485, 1724744484, '修改', '3', '#', '', '', 'operate:config:edit', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725012573, 0, '配置管理', '1', 'AppstoreOutlined', NULL, NULL, NULL, 105, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725692158, 0, '系统日志', '1', 'TableOutlined', NULL, NULL, NULL, 905, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725704817, 1667963444, '用户详情', '2', 'AntDesignOutlined', '/chat/user/info', '/chat/user/index-info', 'chat:user:query', 2, 'N', '', 'Y', 'N');
INSERT INTO `sys_menu` VALUES (1725792755, 1667963444, '群组详情', '2', '#', '/chat/group/info', '/chat/group/index-info', 'chat:group:query', 4, 'N', '', 'Y', 'N');
INSERT INTO `sys_menu` VALUES (1725849590, 1725704817, '群组', '3', '#', NULL, NULL, 'chat:user:group', 8, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725849605, 1725704817, '日志', '3', '#', NULL, NULL, 'chat:user:log', 6, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725849899, 1725704817, '好友', '3', '#', NULL, NULL, 'chat:user:friend', 7, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725854289, 1725792755, '日志', '3', '#', NULL, NULL, 'chat:group:log', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1725960694, 1725704817, '消息', '3', '#', NULL, NULL, 'chat:user:msg', 9, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1726030934, 1725792755, '封禁', '3', '#', NULL, NULL, 'chat:group:banned', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1726122468, 1667988519, '查询', '3', '#', NULL, NULL, 'operate:feedback:query', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1728638324, 1673424543, '服务管理', '2', 'RadarChartOutlined', '/extend/robot', '/extend/robot/index', 'extend:robot:list', 1, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1728639762, 1728638324, '修改', '3', '#', NULL, NULL, 'extend:robot:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1728980776, 1728638324, '回复', '3', '#', NULL, NULL, 'extend:robot:reply', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1728990347, 1670222559, '群内转账', '2', 'FileUnknownOutlined', '/trade/interior', '/trade/interior/index', 'wallet:trade:list', 9, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1729051469, 1682396198, '收支汇总', '2', 'TransactionOutlined', '/statistics/report', '/statistics/report/index', 'statistics:user:report', 5, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1731916066, 1680601640, '异常账户', '2', 'BorderInnerOutlined', '/approve/special', '/approve/special/index', 'approve:special:list', 4, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1734420922, 1682396198, '平台汇总', '2', 'CrownOutlined', '/statistics/balance', '/statistics/balance/index', 'statistics:user:balance', 6, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1734695226, 1673424543, '应用管理', '2', 'AimOutlined', '/extend/uni', '/extend/uni/index', 'extend:uni:list', 2, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1734695227, 1734695226, '新增', '3', '#', NULL, NULL, 'extend:uni:add', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1734695228, 1734695226, '删除', '3', '#', NULL, NULL, 'extend:uni:remove', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1734695304, 1734695226, '修改', '3', '#', NULL, NULL, 'extend:uni:edit', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1735786711, 1680601960, '导出', '3', '#', NULL, NULL, 'approve:cash:export', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1738810367, 1667963359, '详情', '3', '#', NULL, NULL, 'chat:user:list	', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1738810399, 1668075049, '详情', '3', '#', NULL, NULL, 'chat:group:list', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1745553948, 1725012573, '数据中心', '2', 'RadiusUpleftOutlined', '/operate/setting', '/operate/setting/index', 'operate:setting:list', 6, 'N', '', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1745553949, 1745553948, '修改', '3', '#', NULL, NULL, 'operate:setting:edit', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752214246, 1752215865, '评论表管理', '2', 'ArrowRightOutlined', '/friend/comments', '/friend/comments/index', 'friend:comments:list', 1, 'N', '朋友圈评论表管理菜单', 'Y', 'N');
INSERT INTO `sys_menu` VALUES (1752214247, 1752214246, '朋友圈评论表查询', '3', '#', NULL, NULL, 'friend:comments:query', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752214248, 1752214246, '朋友圈评论表新增', '3', '#', NULL, NULL, 'friend:comments:add', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752214249, 1752214246, '朋友圈评论表修改', '3', '#', NULL, NULL, 'friend:comments:edit', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752214250, 1752214246, '朋友圈评论表删除', '3', '#', NULL, NULL, 'friend:comments:remove', 4, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752215865, 1667963444, '朋友圈管理', '1', 'AliwangwangOutlined', NULL, NULL, NULL, 0, 'N', NULL, 'Y', 'N');
INSERT INTO `sys_menu` VALUES (1752225309, 1667963444, '圈子信息管理', '2', 'AliwangwangOutlined', '/friend/moments', '/friend/moments/index', 'friend:moments:list', 1, 'N', '朋友圈评论表管理菜单', 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752225310, 1752225309, '信息表查询', '3', '#', NULL, NULL, 'friend:moments:query', 1, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752225311, 1752225309, '信息新增', '3', '#', NULL, NULL, 'friend:moments:add', 2, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752225312, 1752225309, '信息修改', '3', '#', NULL, NULL, 'friend:moments:edit', 3, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1752225313, 1752225309, '信息表删除', '3', '#', NULL, NULL, 'friend:moments:remove', 4, 'N', NULL, 'Y', 'Y');
INSERT INTO `sys_menu` VALUES (1754493737, 1670222559, '用户签到', '2', 'FilePdfOutlined', '/trade/sign', '/trade/sign/index', 'wallet:trade:list', 11, 'N', '', 'Y', 'Y');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y' COMMENT '角色状态（Y正常N停用）',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE INDEX `role_name`(`role_name`) USING BTREE,
  UNIQUE INDEX `role_key`(`role_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1613012639384887298, '运营', 'admin', 1, 'Y', '运营');
INSERT INTO `sys_role` VALUES (1939279673435381761, '客服', 'kf', 300, 'Y', '客服');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1590993460);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1590993481);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1590993793);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1590993804);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1667963359);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1667963444);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1667991656);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1667991660);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1668075049);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1669114031);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1669779155);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1669780522);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1669780524);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1670236462);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1673406441);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1673406506);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1673580640);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1680606806);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1680606808);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1683788284);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1689595552);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1690877515);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1690877517);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725692158);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725704817);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725792755);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725849590);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725849605);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725849899);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725854289);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1725960694);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1726030934);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1731916066);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1738810367);
INSERT INTO `sys_role_menu` VALUES (1939279673435381761, 1738810399);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT 0 COMMENT '角色id',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nickname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `salt` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '盐',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Y' COMMENT '帐号状态（Y正常N停用）',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1613012757525848066, 1613012639384887298, 'admin', 'admin', 'u32t', '1f81a659afbc2f6275154cd50e70a136', 'Y', NULL);
INSERT INTO `sys_user` VALUES (1939279749394227201, 1939279673435381761, 'kf001', 'kf', 'h5oz', '55169619574fc49fafd4ac870e79203a', 'Y', '');

-- ----------------------------
-- Table structure for uni_item
-- ----------------------------
DROP TABLE IF EXISTS `uni_item`;
CREATE TABLE `uni_item`  (
  `uni_id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'appId',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `version` bigint(20) NULL DEFAULT 100 COMMENT '版本',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '状态',
  PRIMARY KEY (`uni_id`) USING BTREE,
  UNIQUE INDEX `appId`(`app_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '小程序表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of uni_item
-- ----------------------------
INSERT INTO `uni_item` VALUES (10001, NULL, '百度一下', 'http://192.168.0.1:19000/xim/root/4.png', 100, 'https://www.baidu.com/', 'url', 'Y');
INSERT INTO `uni_item` VALUES (10002, '__UNI__E28E426', '天气预报', 'http://192.168.0.1:19000/xim/root/5.png', 100, 'https://baidu.com/alpaca/wgt/__UNI__E28E426.wgt', 'mini', 'Y');
INSERT INTO `uni_item` VALUES (10003, '__UNI__50FBB74', '授权示例', 'http://192.168.0.1:19000/xim/root/6.png', 100, 'https://baidu.com/alpaca/wgt/__UNI__50FBB74.wgt', 'mini', 'Y');

-- ----------------------------
-- Table structure for wallet_bank
-- ----------------------------
DROP TABLE IF EXISTS `wallet_bank`;
CREATE TABLE `wallet_bank`  (
  `bank_id` bigint(20) NOT NULL COMMENT '卡包id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `wallet` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户',
  PRIMARY KEY (`bank_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包卡包' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_bank
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_cash
-- ----------------------------
DROP TABLE IF EXISTS `wallet_cash`;
CREATE TABLE `wallet_cash`  (
  `trade_id` bigint(20) NOT NULL COMMENT '交易id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `wallet` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户',
  `amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '申请金额',
  `rate` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '交易利率',
  `cost` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '交易加成',
  `charge` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '交易手续',
  `reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拒绝原因',
  `create_time` datetime NULL DEFAULT NULL COMMENT '交易时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`trade_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包提现' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_cash
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_info
-- ----------------------------
DROP TABLE IF EXISTS `wallet_info`;
CREATE TABLE `wallet_info`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `balance` decimal(65, 2) NULL DEFAULT 0.00 COMMENT '余额',
  `salt` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐巴',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `version` int(8) NULL DEFAULT 0 COMMENT '版本',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户钱包' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_info
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_packet
-- ----------------------------
DROP TABLE IF EXISTS `wallet_packet`;
CREATE TABLE `wallet_packet`  (
  `packet_id` bigint(20) NOT NULL COMMENT '主键',
  `trade_id` bigint(20) NULL DEFAULT NULL COMMENT '交易id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '接收id',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收no',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '头像',
  `amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`packet_id`) USING BTREE,
  UNIQUE INDEX `trade_id`(`trade_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包红包' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_packet
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_receive
-- ----------------------------
DROP TABLE IF EXISTS `wallet_receive`;
CREATE TABLE `wallet_receive`  (
  `trade_id` bigint(20) NOT NULL COMMENT '交易id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '接收人',
  `amount` decimal(8, 2) NULL DEFAULT NULL COMMENT '金额',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '状态',
  `version` int(8) NULL DEFAULT 0 COMMENT '执行版本',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`trade_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包余额' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_receive
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_recharge
-- ----------------------------
DROP TABLE IF EXISTS `wallet_recharge`;
CREATE TABLE `wallet_recharge`  (
  `trade_id` bigint(20) NOT NULL COMMENT '交易id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `user_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户号码',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户手机',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '支付金额',
  `trade_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易号码',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易号码',
  `create_time` datetime NULL DEFAULT NULL COMMENT '交易时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `pay_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付类型',
  PRIMARY KEY (`trade_id`) USING BTREE,
  UNIQUE INDEX `trade_no`(`trade_no`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包充值' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_shopping
-- ----------------------------
DROP TABLE IF EXISTS `wallet_shopping`;
CREATE TABLE `wallet_shopping`  (
  `trade_id` bigint(20) NOT NULL COMMENT '交易id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `user_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户号码',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户手机',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '支付金额',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '交易时间',
  PRIMARY KEY (`trade_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包消费' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_shopping
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_task
-- ----------------------------
DROP TABLE IF EXISTS `wallet_task`;
CREATE TABLE `wallet_task`  (
  `trade_id` bigint(20) NOT NULL COMMENT '交易id',
  `trade_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易类型',
  `task_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '执行状态',
  `version` int(8) NULL DEFAULT 0 COMMENT '执行版本',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`trade_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包任务' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_task
-- ----------------------------
INSERT INTO `wallet_task` VALUES (1939298330404216833, '1004', '2025-06-30 20:22:07', 'Y', 1, '2025-06-29 20:22:07', '2025-07-01 13:50:01');

-- ----------------------------
-- Table structure for wallet_trade
-- ----------------------------
DROP TABLE IF EXISTS `wallet_trade`;
CREATE TABLE `wallet_trade`  (
  `trade_id` bigint(20) NOT NULL COMMENT '主键',
  `trade_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易类型',
  `trade_packet` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT '是否红包',
  `trade_amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '交易金额',
  `trade_count` int(8) NULL DEFAULT 1 COMMENT '交易数量',
  `trade_remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易备注',
  `trade_balance` decimal(65, 2) NULL DEFAULT 0.00 COMMENT '余额',
  `trade_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易状态',
  `source_id` bigint(20) NULL DEFAULT 0 COMMENT '交易来源',
  `source_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易来源',
  `user_id` bigint(20) NULL DEFAULT 0 COMMENT '用户id',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户号码',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户手机',
  `portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '用户头像',
  `group_id` bigint(20) NULL DEFAULT 0 COMMENT '群组',
  `group_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群号',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群名',
  `receive_id` bigint(20) NULL DEFAULT 0 COMMENT '接收id',
  `receive_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收号码',
  `receive_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收昵称',
  `receive_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收手机',
  `receive_portrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '接收头像',
  `create_time` datetime NULL DEFAULT NULL COMMENT '生成时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '注销0正常null注销',
  PRIMARY KEY (`trade_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `receive_id`(`receive_id`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE,
  INDEX `trade_type`(`trade_type`) USING BTREE,
  INDEX `trade_packet`(`trade_packet`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包交易总表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_trade
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
