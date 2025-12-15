/*
 Navicat Premium Data Transfer

 Source Server         : 德讯测试
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : localhost:3306
 Source Schema         : kaolaim

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 12/08/2025 22:55:17
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
INSERT INTO `chat_friend` VALUES (1954024946560757762, 1954021065327996929, 1954024946552369154, 1954024510055346177, 'http://110.42.56.25:19000/xim/att/16.png', '诸葛暑狐', '11028524', '', '3', 'N', 'N', 'N', '2025-08-09 11:40:26', 0);
INSERT INTO `chat_friend` VALUES (1954024946577534977, 1954024510055346177, 1954024946552369154, 1954021065327996929, 'http://110.42.56.25:19000/xim/att/11.png', '钟离寞寒', '10076419', '', '3', 'N', 'N', 'N', '2025-08-09 11:40:26', 0);
INSERT INTO `chat_friend` VALUES (1954042166238081027, 1954042044259332098, 1954042166238081026, 1954021065327996929, 'http://110.42.56.25:19000/xim/att/11.png', '钟离寞寒', '10076419', '', '3', 'N', 'N', 'N', '2025-08-09 12:48:51', 0);
INSERT INTO `chat_friend` VALUES (1954042166250663938, 1954021065327996929, 1954042166238081026, 1954042044259332098, 'http://110.42.56.25:19000/xim/att/1.png', '司徒真', '11029765', '', '3', 'N', 'N', 'N', '2025-08-09 12:48:51', 0);
INSERT INTO `chat_friend` VALUES (1954076501968252930, 1954076247092981761, 1954076501964058626, 1954021065327996929, 'http://110.42.56.25:19000/xim/att/11.png', '钟离寞寒', '10076419', '', '3', 'N', 'N', 'N', '2025-08-09 15:05:18', 0);
INSERT INTO `chat_friend` VALUES (1954076501985030146, 1954021065327996929, 1954076501964058626, 1954076247092981761, 'http://110.42.56.25:19000/xim/att/9.png', '熊真', '12596108', '', '3', 'N', 'N', 'N', '2025-08-09 15:05:18', 0);
INSERT INTO `chat_friend` VALUES (1954108037950279681, 1953400949577977858, 1954108037941891073, 1954042044259332098, 'http://110.42.56.25:19000/xim/att/1.png', '司徒真', '11029765', '', '3', 'N', 'N', 'N', '2025-08-09 17:10:36', 0);
INSERT INTO `chat_friend` VALUES (1954108038252269570, 1954042044259332098, 1954108037941891073, 1953400949577977858, 'http://192.168.0.1:19000/xim/att/4.png', '濮阳棒风', '10045995', '', '3', 'N', 'N', 'N', '2025-08-09 17:10:37', 0);
INSERT INTO `chat_friend` VALUES (1954108055520219139, 1953400949577977858, 1954108055520219138, 1954076247092981761, 'http://110.42.56.25:19000/xim/att/9.png', '熊真', '12596108', '', '3', 'N', 'N', 'N', '2025-08-09 17:10:41', 0);
INSERT INTO `chat_friend` VALUES (1954108055952232450, 1954076247092981761, 1954108055520219138, 1953400949577977858, 'http://192.168.0.1:19000/xim/att/4.png', '濮阳棒风', '10045995', '', '3', 'N', 'N', 'N', '2025-08-09 17:10:41', 0);
INSERT INTO `chat_friend` VALUES (1954889788834574337, 1953400949577977858, 1954889788830380033, 1954024510055346177, 'http://110.42.56.25:19000/xim/att/16.png', '诸葛暑狐', '11028524', '', '3', 'N', 'N', 'N', '2025-08-11 20:57:00', 0);
INSERT INTO `chat_friend` VALUES (1954889789140758529, 1954024510055346177, 1954889788830380033, 1953400949577977858, 'http://110.42.56.25:19000/xim/att/4.png', '濮阳棒风', '10045995', '', '3', 'N', 'N', 'N', '2025-08-11 20:57:00', 0);

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
INSERT INTO `chat_friend_apply` VALUES (1954024923538223105, 1954024510055346177, 'http://110.42.56.25:19000/xim/att/16.png', '诸葛暑狐', '11028524', '我是诸葛暑狐', 1954021065327996929, '', '3', '2', '2025-08-09 11:40:20');
INSERT INTO `chat_friend_apply` VALUES (1954042147950915586, 1954021065327996929, 'http://110.42.56.25:19000/xim/att/11.png', '钟离寞寒', '10076419', '我是钟离寞寒', 1954042044259332098, '', '3', '2', '2025-08-09 12:48:47');
INSERT INTO `chat_friend_apply` VALUES (1954076476785651714, 1954021065327996929, 'http://110.42.56.25:19000/xim/att/11.png', '钟离寞寒', '10076419', '我是钟离寞寒', 1954076247092981761, '', '3', '2', '2025-08-09 15:05:12');
INSERT INTO `chat_friend_apply` VALUES (1954107194333032449, 1954076247092981761, 'http://110.42.56.25:19000/xim/att/9.png', '熊真', '12596108', '我是熊真', 1953400949577977858, '', '3', '2', '2025-08-09 17:07:15');
INSERT INTO `chat_friend_apply` VALUES (1954107813940785154, 1954042044259332098, 'http://110.42.56.25:19000/xim/att/1.png', '司徒真', '11029765', '我是司徒真', 1953400949577977858, '', '3', '2', '2025-08-09 17:09:43');
INSERT INTO `chat_friend_apply` VALUES (1954889760594325505, 1954024510055346177, 'http://110.42.56.25:19000/xim/att/16.png', '诸葛暑狐', '11028524', '我是诸葛暑狐', 1953400949577977858, '', '3', '2', '2025-08-11 20:56:54');

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
INSERT INTO `chat_msg` VALUES (1953417126685548546, 1953417126685548547, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":650,\"width\":650}', '2025-08-07 19:25:11');
INSERT INTO `chat_msg` VALUES (1953418987807289346, 1953418987807289347, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":323,\"width\":186}', '2025-08-07 19:32:34');
INSERT INTO `chat_msg` VALUES (1953419621012979714, 1953419621021368321, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":256,\"width\":256}', '2025-08-07 19:35:05');
INSERT INTO `chat_msg` VALUES (1953421176923607042, 1953421176923607043, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":256,\"width\":256}', '2025-08-07 19:41:16');
INSERT INTO `chat_msg` VALUES (1953422178909282305, 1953422178909282306, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":256,\"width\":256}', '2025-08-07 19:45:15');
INSERT INTO `chat_msg` VALUES (1953424278779195394, 1953424278779195395, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":256,\"width\":256}', '2025-08-07 19:53:36');
INSERT INTO `chat_msg` VALUES (1953424949863645186, 1953424949867839490, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":273,\"width\":186}', '2025-08-07 19:56:16');
INSERT INTO `chat_msg` VALUES (1953425496100442114, 1953425496100442115, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":273,\"width\":186}', '2025-08-07 19:58:26');
INSERT INTO `chat_msg` VALUES (1953427483944689665, 1953427483944689666, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":273,\"width\":186}', '2025-08-07 20:06:20');
INSERT INTO `chat_msg` VALUES (1953428484286197762, 1953428484286197763, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/20/689497a81ed01e35362c1957\",\"height\":273,\"width\":186}', '2025-08-07 20:10:18');
INSERT INTO `chat_msg` VALUES (1953434634507403266, 1953434634515791874, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":273,\"width\":186}', '2025-08-07 20:34:45');
INSERT INTO `chat_msg` VALUES (1953435868362592257, 1953435868362592258, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"\",\"height\":273,\"width\":186}', '2025-08-07 20:39:39');
INSERT INTO `chat_msg` VALUES (1953436448099299329, 1953436448099299330, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"http://img-amoa-cn-idvq9jw.qiniudns.com/alpaca/202508/07/20/68949f051ed0097d34ca08fe\",\"height\":273,\"width\":186}', '2025-08-07 20:41:57');
INSERT INTO `chat_msg` VALUES (1953437982639947777, 1953437982639947778, 1953400949577977858, 10001, 10001, '3', 'image', '{\"data\":\"http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/07/20/6894a0811ed03a347c76703c\",\"height\":323,\"width\":186}', '2025-08-07 20:48:03');
INSERT INTO `chat_msg` VALUES (1953438596627333122, 1953438596627333123, 1953400949577977858, 1953400949577977858, 1953400949577977858, '1', 'location', '{\"title\":\"西堂子胡同1号院\",\"latitude\":39.91663,\"longitude\":116.417016,\"address\":\"西堂子胡同1号(灯市口地铁站A西北口步行140米)\",\"thumbnail\":\"http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/07/20/6894a1141ed03a347c76703d\"}', '2025-08-07 20:50:29');
INSERT INTO `chat_msg` VALUES (1954024983172837377, 1954024983172837378, 1954024510055346177, 1954021065327996929, 1954024946552369154, '1', 'text', '{\"data\":\"🤣🤣\"}', '2025-08-09 11:40:35');
INSERT INTO `chat_msg` VALUES (1954025056506048514, 1954025056506048515, 1954024510055346177, 1954021065327996929, 1954024946552369154, '1', 'call', '{\"callStatus\":\"finish\",\"callType\":\"voice\",\"callTime\":\"2\"}', '2025-08-09 11:40:52');
INSERT INTO `chat_msg` VALUES (1954025279668187137, 1954025279668187138, 1954021065327996929, 1954024510055346177, 1954024946552369154, '1', 'call', '{\"callStatus\":\"finish\",\"callType\":\"voice\",\"callTime\":\"2\"}', '2025-08-09 11:41:45');
INSERT INTO `chat_msg` VALUES (1954025408064221186, 1954025408064221187, 1954024510055346177, 1954021065327996929, 1954024946552369154, '1', 'call', '{\"callStatus\":\"reject\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 11:42:16');
INSERT INTO `chat_msg` VALUES (1954041153892478977, 1954041153892478978, 1954021065327996929, 1954024510055346177, 1954024946552369154, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:44:50');
INSERT INTO `chat_msg` VALUES (1954041175598002178, 1954041175598002179, 1954021065327996929, 1954024510055346177, 1954024946552369154, '1', 'call', '{\"callStatus\":\"await\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:44:55');
INSERT INTO `chat_msg` VALUES (1954041250730569730, 1954041250730569731, 1954021065327996929, 1954024510055346177, 1954024946552369154, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:45:13');
INSERT INTO `chat_msg` VALUES (1954041799190343681, 1954041799190343682, 1954021065327996929, 1954024510055346177, 1954024946552369154, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:47:24');
INSERT INTO `chat_msg` VALUES (1954042206335627265, 1954042206335627266, 1954042044259332098, 1954021065327996929, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:49:01');
INSERT INTO `chat_msg` VALUES (1954042231518228481, 1954042231518228482, 1954042044259332098, 1954021065327996929, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:49:07');
INSERT INTO `chat_msg` VALUES (1954042362019803138, 1954042362019803139, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"reject\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:49:38');
INSERT INTO `chat_msg` VALUES (1954042447575216130, 1954042447575216131, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"reject\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:49:59');
INSERT INTO `chat_msg` VALUES (1954042496279474178, 1954042496279474179, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:50:10');
INSERT INTO `chat_msg` VALUES (1954042545164087297, 1954042545164087298, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:50:22');
INSERT INTO `chat_msg` VALUES (1954042591045578753, 1954042591045578754, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:50:33');
INSERT INTO `chat_msg` VALUES (1954043275283361794, 1954043275283361795, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😅😅🤩😝\"}', '2025-08-09 12:53:16');
INSERT INTO `chat_msg` VALUES (1954043297148268545, 1954043297148268546, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😇😇😇😇\"}', '2025-08-09 12:53:21');
INSERT INTO `chat_msg` VALUES (1954043412936224769, 1954043412936224770, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"🥰😁😁🥰\"}', '2025-08-09 12:53:49');
INSERT INTO `chat_msg` VALUES (1954043438974464002, 1954043438974464003, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:53:55');
INSERT INTO `chat_msg` VALUES (1954043499502465026, 1954043499502465027, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😆😆😍\"}', '2025-08-09 12:54:09');
INSERT INTO `chat_msg` VALUES (1954043544289243138, 1954043544289243139, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:54:20');
INSERT INTO `chat_msg` VALUES (1954043630889037826, 1954043630889037827, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😅😅😘😘\"}', '2025-08-09 12:54:41');
INSERT INTO `chat_msg` VALUES (1954043668918792193, 1954043668918792194, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😂😂\"}', '2025-08-09 12:54:50');
INSERT INTO `chat_msg` VALUES (1954043704826228738, 1954043704826228739, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:54:58');
INSERT INTO `chat_msg` VALUES (1954043728150753281, 1954043728150753282, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:55:04');
INSERT INTO `chat_msg` VALUES (1954044492180975618, 1954044492180975619, 1954042044259332098, 1954021065327996929, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:58:06');
INSERT INTO `chat_msg` VALUES (1954044569205174273, 1954044569205174274, 1954042044259332098, 1954021065327996929, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 12:58:24');
INSERT INTO `chat_msg` VALUES (1954050144282439681, 1954050144282439682, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😘🤣😘😘\"}', '2025-08-09 13:20:34');
INSERT INTO `chat_msg` VALUES (1954050161818824706, 1954050161818824707, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"😁😁😁😁\"}', '2025-08-09 13:20:38');
INSERT INTO `chat_msg` VALUES (1954067117594734594, 1954067117594734595, 1954021065327996929, 1954024510055346177, 1954024946552369154, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:28:00');
INSERT INTO `chat_msg` VALUES (1954067193381613569, 1954067193381613570, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'text', '{\"data\":\"🤣🤣🤣\"}', '2025-08-09 14:28:18');
INSERT INTO `chat_msg` VALUES (1954067212046266369, 1954067212046266370, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:28:23');
INSERT INTO `chat_msg` VALUES (1954067256732381186, 1954067256732381187, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:28:33');
INSERT INTO `chat_msg` VALUES (1954067372486782977, 1954067372486782978, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:29:01');
INSERT INTO `chat_msg` VALUES (1954067395039555586, 1954067395039555587, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:29:06');
INSERT INTO `chat_msg` VALUES (1954067470574776322, 1954067470574776323, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:29:24');
INSERT INTO `chat_msg` VALUES (1954071444711370754, 1954071444711370755, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:45:12');
INSERT INTO `chat_msg` VALUES (1954071505604276225, 1954071505604276226, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:45:26');
INSERT INTO `chat_msg` VALUES (1954071553155100674, 1954071553155100675, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:45:38');
INSERT INTO `chat_msg` VALUES (1954071600571707394, 1954071600571707395, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:45:49');
INSERT INTO `chat_msg` VALUES (1954071676748656642, 1954071676748656643, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"reject\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:46:07');
INSERT INTO `chat_msg` VALUES (1954071705613856769, 1954071705613856770, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:46:14');
INSERT INTO `chat_msg` VALUES (1954071760185946114, 1954071760185946115, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:46:27');
INSERT INTO `chat_msg` VALUES (1954071805547343873, 1954071805547343874, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:46:38');
INSERT INTO `chat_msg` VALUES (1954071839286325250, 1954071839286325251, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:46:46');
INSERT INTO `chat_msg` VALUES (1954071899516530690, 1954071899516530691, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:47:00');
INSERT INTO `chat_msg` VALUES (1954071919762436098, 1954071919762436099, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"finish\",\"callType\":\"voice\",\"callTime\":\"8\"}', '2025-08-09 14:47:05');
INSERT INTO `chat_msg` VALUES (1954071987907293185, 1954071987907293186, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:47:21');
INSERT INTO `chat_msg` VALUES (1954072036456361985, 1954072036456361986, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:47:33');
INSERT INTO `chat_msg` VALUES (1954072086339219458, 1954072086339219459, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:47:45');
INSERT INTO `chat_msg` VALUES (1954072487893495810, 1954072487893495811, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:49:21');
INSERT INTO `chat_msg` VALUES (1954072535595315201, 1954072535595315202, 1954021065327996929, 1954042044259332098, 1954042166238081026, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 14:49:32');
INSERT INTO `chat_msg` VALUES (1954076546662756354, 1954076546662756355, 1954021065327996929, 1954076247092981761, 1954076501964058626, '1', 'call', '{\"callStatus\":\"reject\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:05:28');
INSERT INTO `chat_msg` VALUES (1954076628397158401, 1954076628397158402, 1954021065327996929, 1954076247092981761, 1954076501964058626, '1', 'text', '{\"data\":\"🤣🤣🤣🤣\"}', '2025-08-09 15:05:48');
INSERT INTO `chat_msg` VALUES (1954076750774366209, 1954076750774366210, 1954021065327996929, 1954076247092981761, 1954076501964058626, '1', 'text', '{\"data\":\"婆娘娘\"}', '2025-08-09 15:06:17');
INSERT INTO `chat_msg` VALUES (1954076870639185922, 1954076870639185923, 1954021065327996929, 1954076247092981761, 1954076501964058626, '1', 'text', '{\"data\":\"贵\"}', '2025-08-09 15:06:46');
INSERT INTO `chat_msg` VALUES (1954076941950742530, 1954076941950742531, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'call', '{\"callStatus\":\"reject\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:07:03');
INSERT INTO `chat_msg` VALUES (1954076997961478145, 1954076997961478146, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:07:16');
INSERT INTO `chat_msg` VALUES (1954077409582084097, 1954077409582084098, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:08:54');
INSERT INTO `chat_msg` VALUES (1954077640205889538, 1954077640205889539, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'text', '{\"data\":\"😆😆😆\"}', '2025-08-09 15:09:49');
INSERT INTO `chat_msg` VALUES (1954077657545142274, 1954077657545142275, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:09:53');
INSERT INTO `chat_msg` VALUES (1954077691653222401, 1954077691653222402, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:10:01');
INSERT INTO `chat_msg` VALUES (1954078421378232322, 1954078421378232323, 1954021065327996929, 1954076247092981761, 1954076501964058626, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:12:55');
INSERT INTO `chat_msg` VALUES (1954078472221585409, 1954078472221585410, 1954021065327996929, 1954076247092981761, 1954076501964058626, '1', 'call', '{\"callStatus\":\"cancel\",\"callType\":\"voice\",\"callTime\":\"0\"}', '2025-08-09 15:13:07');
INSERT INTO `chat_msg` VALUES (1954079384541425665, 1954079384541425666, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'text', '{\"data\":\"😁\"}', '2025-08-09 15:16:45');
INSERT INTO `chat_msg` VALUES (1954080204896956417, 1954080204896956418, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'text', '{\"data\":\"😆\"}', '2025-08-09 15:20:01');
INSERT INTO `chat_msg` VALUES (1954087256096600065, 1954087256096600066, 1953400949577977858, 10001, 10001, '3', 'text', '{\"data\":\"😁\"}', '2025-08-09 15:48:02');
INSERT INTO `chat_msg` VALUES (1954087889402949633, 1954087889402949634, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'text', '{\"data\":\"111\"}', '2025-08-09 15:50:33');
INSERT INTO `chat_msg` VALUES (1954088009091710977, 1954088009091710978, 1953400949577977858, 10001, 10001, '3', 'text', '{\"data\":\"111\"}', '2025-08-09 15:51:01');
INSERT INTO `chat_msg` VALUES (1954107047993765890, 1954107047993765891, 1954076247092981761, 1954021065327996929, 1954076501964058626, '1', 'text', '{\"data\":\"😂😂😂\"}', '2025-08-09 17:06:40');
INSERT INTO `chat_msg` VALUES (1954108157974376449, 1954108157974376450, 1954042044259332098, 1953400949577977858, 1954108037941891073, '1', 'text', '{\"data\":\"😆😆😆\"}', '2025-08-09 17:11:05');
INSERT INTO `chat_msg` VALUES (1954147384493817858, 1954147384493817859, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"查看消息\"}', '2025-08-09 19:46:57');
INSERT INTO `chat_msg` VALUES (1954148770702901249, 1954148770702901250, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"555\"}', '2025-08-09 19:52:28');
INSERT INTO `chat_msg` VALUES (1954149036114264065, 1954149036114264066, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"999\"}', '2025-08-09 19:53:31');
INSERT INTO `chat_msg` VALUES (1954149566043602946, 1954149566043602947, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"😇\"}', '2025-08-09 19:55:38');
INSERT INTO `chat_msg` VALUES (1954149938854313986, 1954149938854313987, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"😆\"}', '2025-08-09 19:57:07');
INSERT INTO `chat_msg` VALUES (1954150049156120578, 1954150049156120579, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"😍\"}', '2025-08-09 19:57:33');
INSERT INTO `chat_msg` VALUES (1954153218758103041, 1954153218758103042, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"😷\"}', '2025-08-09 20:10:09');
INSERT INTO `chat_msg` VALUES (1954153808645017601, 1954153808645017602, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"😴\"}', '2025-08-09 20:12:29');
INSERT INTO `chat_msg` VALUES (1954154665604239361, 1954154665604239362, 1953400949577977858, 1954076247092981761, 1954108055520219138, '1', 'text', '{\"data\":\"🤣\"}', '2025-08-09 20:15:53');
INSERT INTO `chat_msg` VALUES (1954402295211114497, 1954402295211114498, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"555\"}', '2025-08-10 12:39:53');
INSERT INTO `chat_msg` VALUES (1954408398711963649, 1954408398711963650, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"444\"}', '2025-08-10 13:04:08');
INSERT INTO `chat_msg` VALUES (1954408450771664898, 1954408450771664899, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"444\"}', '2025-08-10 13:04:21');
INSERT INTO `chat_msg` VALUES (1954446009597972481, 1954446009597972482, 1953400949577977858, 1954076247092981761, 1954108055520219138, '1', 'text', '{\"data\":\"555\"}', '2025-08-10 15:33:35');
INSERT INTO `chat_msg` VALUES (1954707697199030274, 1954707697199030275, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"666\"}', '2025-08-11 08:53:26');
INSERT INTO `chat_msg` VALUES (1954719748063571969, 1954719748063571970, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"666\"}', '2025-08-11 09:41:20');
INSERT INTO `chat_msg` VALUES (1954749566805188609, 1954749566805188610, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"123\"}', '2025-08-11 11:39:49');
INSERT INTO `chat_msg` VALUES (1954753998758461441, 1954753998758461442, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"444\"}', '2025-08-11 11:57:26');
INSERT INTO `chat_msg` VALUES (1954799052160098306, 1954799052160098307, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"000\"}', '2025-08-11 14:56:27');
INSERT INTO `chat_msg` VALUES (1954802763628404738, 1954802763628404739, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"444\"}', '2025-08-11 15:11:12');
INSERT INTO `chat_msg` VALUES (1954827656881074177, 1954827656881074178, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"666\"}', '2025-08-11 16:50:07');
INSERT INTO `chat_msg` VALUES (1954827722094112769, 1954827722094112770, 1954076247092981761, 1953400949577977858, 1954108055520219138, '1', 'text', '{\"data\":\"123123\"}', '2025-08-11 16:50:23');
INSERT INTO `chat_msg` VALUES (1954879286767120385, 1954879286767120386, 1953400949577977858, 1954076247092981761, 1954108055520219138, '1', 'text', '{\"data\":\"998877\"}', '2025-08-11 20:15:17');
INSERT INTO `chat_msg` VALUES (1954880353009528833, 1954880353009528834, 1953400949577977858, 1954076247092981761, 1954108055520219138, '1', 'text', '{\"data\":\"发条测试信息\"}', '2025-08-11 20:19:31');
INSERT INTO `chat_msg` VALUES (1954884207600070657, 1954884207600070658, 1953400949577977858, 1954076247092981761, 1954108055520219138, '1', 'text', '{\"data\":\"333\"}', '2025-08-11 20:34:50');
INSERT INTO `chat_msg` VALUES (1954889888692563969, 1954889888692563970, 1954024510055346177, 1953400949577977858, 1954889788830380033, '1', 'text', '{\"data\":\"来一个信息\"}', '2025-08-11 20:57:24');
INSERT INTO `chat_msg` VALUES (1954890917874102274, 1954890917874102275, 1954024510055346177, 1953400949577977858, 1954889788830380033, '1', 'text', '{\"data\":\"你说话呀\"}', '2025-08-11 21:01:30');
INSERT INTO `chat_msg` VALUES (1954891098380169218, 1954891098380169219, 1954024510055346177, 1953400949577977858, 1954889788830380033, '1', 'text', '{\"data\":\"好吧，我休息一下\"}', '2025-08-11 21:02:13');
INSERT INTO `chat_msg` VALUES (1954898706125824001, 1954898706130018306, 1954024510055346177, 1953400949577977858, 1954889788830380033, '1', 'text', '{\"data\":\"发一条看一下\"}', '2025-08-11 21:32:27');
INSERT INTO `chat_msg` VALUES (1954941377359945729, 1954941377359945730, 1954024510055346177, 1953400949577977858, 1954889788830380033, '1', 'text', '{\"data\":\"111\"}', '2025-08-12 00:22:00');
INSERT INTO `chat_msg` VALUES (1955188990986571777, 1955188990986571778, 1954024510055346177, 1953400949577977858, 1954889788830380033, '1', 'text', '{\"data\":\"333\"}', '2025-08-12 16:45:56');

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
INSERT INTO `chat_number` VALUES ('10045995', 'Y');
INSERT INTO `chat_number` VALUES ('10076419', 'Y');
INSERT INTO `chat_number` VALUES ('11028524', 'Y');
INSERT INTO `chat_number` VALUES ('11029765', 'Y');
INSERT INTO `chat_number` VALUES ('12596108', 'Y');
INSERT INTO `chat_number` VALUES ('13996838', 'Y');
INSERT INTO `chat_number` VALUES ('14168662', 'N');
INSERT INTO `chat_number` VALUES ('14730483', 'N');
INSERT INTO `chat_number` VALUES ('15104659', 'N');
INSERT INTO `chat_number` VALUES ('15634090', 'N');
INSERT INTO `chat_number` VALUES ('15842579', 'N');
INSERT INTO `chat_number` VALUES ('16182784', 'N');
INSERT INTO `chat_number` VALUES ('16402008', 'N');
INSERT INTO `chat_number` VALUES ('16483728', 'N');
INSERT INTO `chat_number` VALUES ('16581377', 'N');
INSERT INTO `chat_number` VALUES ('16690415', 'N');
INSERT INTO `chat_number` VALUES ('17250676', 'N');
INSERT INTO `chat_number` VALUES ('17509750', 'N');
INSERT INTO `chat_number` VALUES ('17872888', 'N');
INSERT INTO `chat_number` VALUES ('17888824', 'N');
INSERT INTO `chat_number` VALUES ('17928682', 'N');
INSERT INTO `chat_number` VALUES ('18253332', 'N');
INSERT INTO `chat_number` VALUES ('18287311', 'N');
INSERT INTO `chat_number` VALUES ('18833053', 'N');
INSERT INTO `chat_number` VALUES ('19109846', 'N');
INSERT INTO `chat_number` VALUES ('19242912', 'N');
INSERT INTO `chat_number` VALUES ('20023478', 'N');
INSERT INTO `chat_number` VALUES ('21211240', 'N');
INSERT INTO `chat_number` VALUES ('21228991', 'N');
INSERT INTO `chat_number` VALUES ('21272471', 'N');
INSERT INTO `chat_number` VALUES ('22047248', 'N');
INSERT INTO `chat_number` VALUES ('23796179', 'N');
INSERT INTO `chat_number` VALUES ('24654396', 'N');
INSERT INTO `chat_number` VALUES ('24984451', 'N');
INSERT INTO `chat_number` VALUES ('25152239', 'N');
INSERT INTO `chat_number` VALUES ('25158309', 'N');
INSERT INTO `chat_number` VALUES ('25835339', 'N');
INSERT INTO `chat_number` VALUES ('26014078', 'N');
INSERT INTO `chat_number` VALUES ('26141489', 'N');
INSERT INTO `chat_number` VALUES ('26182393', 'N');
INSERT INTO `chat_number` VALUES ('26296229', 'N');
INSERT INTO `chat_number` VALUES ('26323343', 'N');
INSERT INTO `chat_number` VALUES ('27324199', 'N');
INSERT INTO `chat_number` VALUES ('27789548', 'N');
INSERT INTO `chat_number` VALUES ('27878260', 'N');
INSERT INTO `chat_number` VALUES ('28396295', 'N');
INSERT INTO `chat_number` VALUES ('29298762', 'N');
INSERT INTO `chat_number` VALUES ('29356120', 'N');
INSERT INTO `chat_number` VALUES ('30277666', 'N');
INSERT INTO `chat_number` VALUES ('30728461', 'N');
INSERT INTO `chat_number` VALUES ('30785178', 'N');
INSERT INTO `chat_number` VALUES ('31217777', 'N');
INSERT INTO `chat_number` VALUES ('31225041', 'N');
INSERT INTO `chat_number` VALUES ('31466783', 'N');
INSERT INTO `chat_number` VALUES ('31504648', 'N');
INSERT INTO `chat_number` VALUES ('31516689', 'N');
INSERT INTO `chat_number` VALUES ('32434649', 'N');
INSERT INTO `chat_number` VALUES ('33774033', 'N');
INSERT INTO `chat_number` VALUES ('34460403', 'N');
INSERT INTO `chat_number` VALUES ('34554154', 'N');
INSERT INTO `chat_number` VALUES ('34623948', 'N');
INSERT INTO `chat_number` VALUES ('36184326', 'N');
INSERT INTO `chat_number` VALUES ('36495988', 'N');
INSERT INTO `chat_number` VALUES ('36776092', 'N');
INSERT INTO `chat_number` VALUES ('36808668', 'N');
INSERT INTO `chat_number` VALUES ('37783573', 'N');
INSERT INTO `chat_number` VALUES ('38260846', 'N');
INSERT INTO `chat_number` VALUES ('38858241', 'N');
INSERT INTO `chat_number` VALUES ('38939876', 'N');
INSERT INTO `chat_number` VALUES ('39071878', 'N');
INSERT INTO `chat_number` VALUES ('39227922', 'N');
INSERT INTO `chat_number` VALUES ('39700076', 'N');
INSERT INTO `chat_number` VALUES ('39874730', 'N');
INSERT INTO `chat_number` VALUES ('41261145', 'N');
INSERT INTO `chat_number` VALUES ('42187618', 'N');
INSERT INTO `chat_number` VALUES ('42788527', 'N');
INSERT INTO `chat_number` VALUES ('44152408', 'N');
INSERT INTO `chat_number` VALUES ('44327322', 'N');
INSERT INTO `chat_number` VALUES ('45361244', 'N');
INSERT INTO `chat_number` VALUES ('45412628', 'N');
INSERT INTO `chat_number` VALUES ('45464072', 'N');
INSERT INTO `chat_number` VALUES ('45552799', 'N');
INSERT INTO `chat_number` VALUES ('45695752', 'N');
INSERT INTO `chat_number` VALUES ('45704614', 'N');
INSERT INTO `chat_number` VALUES ('45842230', 'N');
INSERT INTO `chat_number` VALUES ('46269761', 'N');
INSERT INTO `chat_number` VALUES ('46823101', 'N');
INSERT INTO `chat_number` VALUES ('47357062', 'N');
INSERT INTO `chat_number` VALUES ('47460749', 'N');
INSERT INTO `chat_number` VALUES ('47575946', 'N');
INSERT INTO `chat_number` VALUES ('47692046', 'N');
INSERT INTO `chat_number` VALUES ('48145677', 'N');
INSERT INTO `chat_number` VALUES ('48185817', 'N');
INSERT INTO `chat_number` VALUES ('48250892', 'N');
INSERT INTO `chat_number` VALUES ('48363087', 'N');
INSERT INTO `chat_number` VALUES ('48825240', 'N');
INSERT INTO `chat_number` VALUES ('49001393', 'N');
INSERT INTO `chat_number` VALUES ('49201145', 'N');
INSERT INTO `chat_number` VALUES ('49850452', 'N');
INSERT INTO `chat_number` VALUES ('50158100', 'N');
INSERT INTO `chat_number` VALUES ('50420700', 'N');
INSERT INTO `chat_number` VALUES ('50686548', 'N');
INSERT INTO `chat_number` VALUES ('50767969', 'N');
INSERT INTO `chat_number` VALUES ('51414538', 'N');
INSERT INTO `chat_number` VALUES ('51574122', 'N');
INSERT INTO `chat_number` VALUES ('51797416', 'N');
INSERT INTO `chat_number` VALUES ('51842180', 'N');
INSERT INTO `chat_number` VALUES ('52236446', 'N');
INSERT INTO `chat_number` VALUES ('53256798', 'N');
INSERT INTO `chat_number` VALUES ('54606146', 'N');
INSERT INTO `chat_number` VALUES ('54645990', 'N');
INSERT INTO `chat_number` VALUES ('55714464', 'N');
INSERT INTO `chat_number` VALUES ('56917225', 'N');
INSERT INTO `chat_number` VALUES ('56994044', 'N');
INSERT INTO `chat_number` VALUES ('57194614', 'N');
INSERT INTO `chat_number` VALUES ('57443794', 'N');
INSERT INTO `chat_number` VALUES ('57565483', 'N');
INSERT INTO `chat_number` VALUES ('58432099', 'N');
INSERT INTO `chat_number` VALUES ('58459783', 'N');
INSERT INTO `chat_number` VALUES ('59144767', 'N');
INSERT INTO `chat_number` VALUES ('59371491', 'N');
INSERT INTO `chat_number` VALUES ('59980285', 'N');
INSERT INTO `chat_number` VALUES ('60100946', 'N');
INSERT INTO `chat_number` VALUES ('60973303', 'N');
INSERT INTO `chat_number` VALUES ('61176121', 'N');
INSERT INTO `chat_number` VALUES ('61352300', 'N');
INSERT INTO `chat_number` VALUES ('61570147', 'N');
INSERT INTO `chat_number` VALUES ('63542974', 'N');
INSERT INTO `chat_number` VALUES ('63713622', 'N');
INSERT INTO `chat_number` VALUES ('63812950', 'N');
INSERT INTO `chat_number` VALUES ('64526016', 'N');
INSERT INTO `chat_number` VALUES ('65073034', 'N');
INSERT INTO `chat_number` VALUES ('65499417', 'N');
INSERT INTO `chat_number` VALUES ('65946903', 'N');
INSERT INTO `chat_number` VALUES ('66506321', 'N');
INSERT INTO `chat_number` VALUES ('66979878', 'N');
INSERT INTO `chat_number` VALUES ('67052420', 'N');
INSERT INTO `chat_number` VALUES ('67174718', 'N');
INSERT INTO `chat_number` VALUES ('67675143', 'N');
INSERT INTO `chat_number` VALUES ('68956613', 'N');
INSERT INTO `chat_number` VALUES ('69525148', 'N');
INSERT INTO `chat_number` VALUES ('69886429', 'N');
INSERT INTO `chat_number` VALUES ('70336638', 'N');
INSERT INTO `chat_number` VALUES ('70389176', 'N');
INSERT INTO `chat_number` VALUES ('73033743', 'N');
INSERT INTO `chat_number` VALUES ('73228325', 'N');
INSERT INTO `chat_number` VALUES ('73689225', 'N');
INSERT INTO `chat_number` VALUES ('73958431', 'N');
INSERT INTO `chat_number` VALUES ('74304453', 'N');
INSERT INTO `chat_number` VALUES ('75198326', 'N');
INSERT INTO `chat_number` VALUES ('75241347', 'N');
INSERT INTO `chat_number` VALUES ('75573289', 'N');
INSERT INTO `chat_number` VALUES ('75718652', 'N');
INSERT INTO `chat_number` VALUES ('75994514', 'N');
INSERT INTO `chat_number` VALUES ('76791912', 'N');
INSERT INTO `chat_number` VALUES ('76820112', 'N');
INSERT INTO `chat_number` VALUES ('76865937', 'N');
INSERT INTO `chat_number` VALUES ('77408461', 'N');
INSERT INTO `chat_number` VALUES ('77672500', 'N');
INSERT INTO `chat_number` VALUES ('78413207', 'N');
INSERT INTO `chat_number` VALUES ('78495589', 'N');
INSERT INTO `chat_number` VALUES ('78499685', 'N');
INSERT INTO `chat_number` VALUES ('79441852', 'N');
INSERT INTO `chat_number` VALUES ('79464597', 'N');
INSERT INTO `chat_number` VALUES ('79949636', 'N');
INSERT INTO `chat_number` VALUES ('81008716', 'N');
INSERT INTO `chat_number` VALUES ('81320634', 'N');
INSERT INTO `chat_number` VALUES ('81929634', 'N');
INSERT INTO `chat_number` VALUES ('82194909', 'N');
INSERT INTO `chat_number` VALUES ('82231420', 'N');
INSERT INTO `chat_number` VALUES ('82447170', 'N');
INSERT INTO `chat_number` VALUES ('83603347', 'N');
INSERT INTO `chat_number` VALUES ('83923734', 'N');
INSERT INTO `chat_number` VALUES ('85564110', 'N');
INSERT INTO `chat_number` VALUES ('86532858', 'N');
INSERT INTO `chat_number` VALUES ('86640595', 'N');
INSERT INTO `chat_number` VALUES ('87199910', 'N');
INSERT INTO `chat_number` VALUES ('87403406', 'N');
INSERT INTO `chat_number` VALUES ('87842569', 'N');
INSERT INTO `chat_number` VALUES ('88821410', 'N');
INSERT INTO `chat_number` VALUES ('90227478', 'N');
INSERT INTO `chat_number` VALUES ('92217724', 'N');
INSERT INTO `chat_number` VALUES ('93069479', 'N');
INSERT INTO `chat_number` VALUES ('93272617', 'N');
INSERT INTO `chat_number` VALUES ('93599258', 'N');
INSERT INTO `chat_number` VALUES ('93608259', 'N');
INSERT INTO `chat_number` VALUES ('93912192', 'N');
INSERT INTO `chat_number` VALUES ('95211962', 'N');
INSERT INTO `chat_number` VALUES ('95909915', 'N');
INSERT INTO `chat_number` VALUES ('96067439', 'N');
INSERT INTO `chat_number` VALUES ('96880387', 'N');
INSERT INTO `chat_number` VALUES ('97146884', 'N');
INSERT INTO `chat_number` VALUES ('97350594', 'N');
INSERT INTO `chat_number` VALUES ('97465864', 'N');
INSERT INTO `chat_number` VALUES ('98136761', 'N');
INSERT INTO `chat_number` VALUES ('98188371', 'N');
INSERT INTO `chat_number` VALUES ('98206369', 'N');
INSERT INTO `chat_number` VALUES ('98335029', 'N');
INSERT INTO `chat_number` VALUES ('98605848', 'N');
INSERT INTO `chat_number` VALUES ('99165853', 'N');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天头像' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_portrait
-- ----------------------------
INSERT INTO `chat_portrait` VALUES (1793574396027731910, 'http://110.42.56.25:19000/xim/att/1.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731911, 'http://110.42.56.25:19000/xim/att/2.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731912, 'http://110.42.56.25:19000/xim/att/3.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731913, 'http://110.42.56.25:19000/xim/att/4.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731914, 'http://110.42.56.25:19000/xim/att/5.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731915, 'http://110.42.56.25:19000/xim/att/6.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731916, 'http://110.42.56.25:19000/xim/att/7.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731917, 'http://110.42.56.25:19000/xim/att/8.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731918, 'http://110.42.56.25:19000/xim/att/9.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731919, 'http://110.42.56.25:19000/xim/att/10.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731920, 'http://110.42.56.25:19000/xim/att/11.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731921, 'http://110.42.56.25:19000/xim/att/12.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731922, 'http://110.42.56.25:19000/xim/att/13.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731923, 'http://110.42.56.25:19000/xim/att/14.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731924, 'http://110.42.56.25:19000/xim/att/15.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731925, 'http://110.42.56.25:19000/xim/att/16.png', '1', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731970, 'http://110.42.56.25:19000/xim/btt/1.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731971, 'http://110.42.56.25:19000/xim/btt/2.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731972, 'http://110.42.56.25:19000/xim/btt/3.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731973, 'http://110.42.56.25:19000/xim/btt/4.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731974, 'http://110.42.56.25:19000/xim/btt/5.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731975, 'http://110.42.56.25:19000/xim/btt/6.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731976, 'http://110.42.56.25:19000/xim/btt/7.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731977, 'http://110.42.56.25:19000/xim/btt/8.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731978, 'http://110.42.56.25:19000/xim/btt/9.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731979, 'http://110.42.56.25:19000/xim/btt/10.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731980, 'http://110.42.56.25:19000/xim/btt/11.png', '2', 'Y');
INSERT INTO `chat_portrait` VALUES (1793574396027731981, 'http://110.42.56.25:19000/xim/btt/12.png', '2', 'Y');

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
INSERT INTO `chat_resource` VALUES (1953417123162333186, 1953400949577977858, 'http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/19/68948d151ed0dec536ea670e', '2025-08-07 19:25:10');
INSERT INTO `chat_resource` VALUES (1953418984527343617, 1953400949577977858, 'http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/19/68948ed11ed031f0daf07cde', '2025-08-07 19:32:33');
INSERT INTO `chat_resource` VALUES (1953419618269904897, 1953400949577977858, 'http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/19/68948f681ed0ed929cafa574', '2025-08-07 19:35:04');
INSERT INTO `chat_resource` VALUES (1953421174088257537, 1953400949577977858, 'http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/19/689490db1ed054de702842fb', '2025-08-07 19:41:15');
INSERT INTO `chat_resource` VALUES (1953422175218294785, 1953400949577977858, 'http://t0ang7c9g.hn-bkt.clouddn.com/alpaca/202508/07/19/689491ca1ed021731529d75b', '2025-08-07 19:45:14');
INSERT INTO `chat_resource` VALUES (1953424276065480705, 1953400949577977858, 'http://t0ang7c9g.hn-bkt.clouddn.com/alpaca/202508/07/19/689493be1ed0b33a0122d3a2', '2025-08-07 19:53:35');
INSERT INTO `chat_resource` VALUES (1953424947066044418, 1953400949577977858, 'http://t0ang7c9g.hn-bkt.clouddn.com/alpaca/202508/07/19/6894945e1ed00f6a348efa30', '2025-08-07 19:56:15');
INSERT INTO `chat_resource` VALUES (1953425492614975490, 1953400949577977858, 'http://t0ang7c9g.hn-bkt.clouddn.com/alpaca/202508/07/19/689494e01ed00f58f74c71dd', '2025-08-07 19:58:25');
INSERT INTO `chat_resource` VALUES (1953427481331638274, 1953400949577977858, 'http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/20/689496bb1ed001d97b2cdd38', '2025-08-07 20:06:19');
INSERT INTO `chat_resource` VALUES (1953428478594527234, 1953400949577977858, 'http://ximtest.s3.cn-south-1.qiniucs.com/alpaca/202508/07/20/689497a81ed01e35362c1957', '2025-08-07 20:10:17');
INSERT INTO `chat_resource` VALUES (1953434506371416065, 1953400949577977858, 'http://img.amoa.cn/alpaca/202508/07/20/68949d461ed0e8102d00d7f2', '2025-08-07 20:34:14');
INSERT INTO `chat_resource` VALUES (1953435854928236546, 1953400949577977858, 'http://img-amoa-cn-idvq9jw.qiniudns.com/alpaca/202508/07/20/68949e871ed07720f18a3f60', '2025-08-07 20:39:36');
INSERT INTO `chat_resource` VALUES (1953436382198394881, 1953400949577977858, 'http://img-amoa-cn-idvq9jw.qiniudns.com/alpaca/202508/07/20/68949f051ed0097d34ca08fe', '2025-08-07 20:41:41');
INSERT INTO `chat_resource` VALUES (1953437977585811457, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/07/20/6894a0811ed03a347c76703c', '2025-08-07 20:48:02');
INSERT INTO `chat_resource` VALUES (1953438594404352001, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/07/20/6894a1141ed03a347c76703d', '2025-08-07 20:50:29');
INSERT INTO `chat_resource` VALUES (1954384025837875201, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689811951ed02197c9065f5a', '2025-08-10 11:27:17');
INSERT INTO `chat_resource` VALUES (1954384029109432321, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689811951ed02197c9065f5b', '2025-08-10 11:27:18');
INSERT INTO `chat_resource` VALUES (1954387958077583362, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/6898153e1ed0fb9f3c2875e8', '2025-08-10 11:42:55');
INSERT INTO `chat_resource` VALUES (1954389065508061185, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689816461ed068eab89b13b9', '2025-08-10 11:47:19');
INSERT INTO `chat_resource` VALUES (1954389701683318785, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689816de1ed030fd7b88f483', '2025-08-10 11:49:50');
INSERT INTO `chat_resource` VALUES (1954389704782909442, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689816df1ed030fd7b88f484', '2025-08-10 11:49:51');
INSERT INTO `chat_resource` VALUES (1954391962996187138, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689818f91ed0c294ab076cc7', '2025-08-10 11:58:49');
INSERT INTO `chat_resource` VALUES (1954392483844861954, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/12/689819751ed01452c0aea63f', '2025-08-10 12:00:54');
INSERT INTO `chat_resource` VALUES (1954394602224238593, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/12/68981b6e1ed0c85808f1fd81', '2025-08-10 12:09:19');
INSERT INTO `chat_resource` VALUES (1954453900207869954, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/16/689852a81ed00d9bb3866f3a', '2025-08-10 16:04:56');
INSERT INTO `chat_resource` VALUES (1954471338089664514, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/17/689862e51ed00d9bb3866f3b', '2025-08-10 17:14:14');
INSERT INTO `chat_resource` VALUES (1954471340606246914, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/17/689862e61ed00d9bb3866f3c', '2025-08-10 17:14:15');
INSERT INTO `chat_resource` VALUES (1954472928712347650, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/17/689864611ed00d9bb3866f3d', '2025-08-10 17:20:33');
INSERT INTO `chat_resource` VALUES (1954494378185871361, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/18/6898785b1ed00d9bb3866f3e', '2025-08-10 18:45:47');
INSERT INTO `chat_resource` VALUES (1954504289510772737, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/19/689881961ed00d9bb3866f3f', '2025-08-10 19:25:10');
INSERT INTO `chat_resource` VALUES (1954543729184665601, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898a6511ed0108592f37d63', '2025-08-10 22:01:53');
INSERT INTO `chat_resource` VALUES (1954545975767134210, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898a8681ed0108592f37d64', '2025-08-10 22:10:49');
INSERT INTO `chat_resource` VALUES (1954545978044641281, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898a8691ed0108592f37d65', '2025-08-10 22:10:50');
INSERT INTO `chat_resource` VALUES (1954554561499037698, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898b0671ed018538ab34c27', '2025-08-10 22:44:56');
INSERT INTO `chat_resource` VALUES (1954807990645551105, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/15/68999c6e1ed0b09aa359bfec', '2025-08-11 15:31:58');
INSERT INTO `chat_resource` VALUES (1954827467025903618, 1954076247092981761, 'http://110.42.56.25:19000/xim/alpaca/202508/11/16/6899ae916820aa9d08fe2ed1', '2025-08-11 16:49:22');
INSERT INTO `chat_resource` VALUES (1954827471161487361, 1954076247092981761, 'http://110.42.56.25:19000/xim/alpaca/202508/11/16/6899ae926820aa9d08fe2ed2.png', '2025-08-11 16:49:23');
INSERT INTO `chat_resource` VALUES (1954835533658456066, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/17/6899b6146820dd11c2511433', '2025-08-11 17:21:25');
INSERT INTO `chat_resource` VALUES (1954835550079156225, 1954076247092981761, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/17/6899b6186820dd11c2511434', '2025-08-11 17:21:29');
INSERT INTO `chat_resource` VALUES (1954877292459454466, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/20/6899dcf91ed0b09aa359bfed', '2025-08-11 20:07:21');
INSERT INTO `chat_resource` VALUES (1954879034639118337, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/20/6899de981ed0b09aa359bfee', '2025-08-11 20:14:16');
INSERT INTO `chat_resource` VALUES (1954889295144022017, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/20/6899e8261ed0b09aa359bfef', '2025-08-11 20:55:03');
INSERT INTO `chat_resource` VALUES (1954891941116125185, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899ea9d1ed0529e4faee889', '2025-08-11 21:05:34');
INSERT INTO `chat_resource` VALUES (1954892963263815682, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899eb911ed0529e4faee88a', '2025-08-11 21:09:37');
INSERT INTO `chat_resource` VALUES (1954900025817440258, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899f2251ed0529e4faee88b', '2025-08-11 21:37:41');
INSERT INTO `chat_resource` VALUES (1954904323720757250, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899f6251ed0089e11098864', '2025-08-11 21:54:46');
INSERT INTO `chat_resource` VALUES (1954916169773240321, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/22/689a012e1ed0ec5b0939a29d', '2025-08-11 22:41:50');
INSERT INTO `chat_resource` VALUES (1954921092405547009, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/23/689a05c31ed0ec5b0939a29e', '2025-08-11 23:01:24');
INSERT INTO `chat_resource` VALUES (1954928716786196481, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/23/689a0cdd1ed07c4a36b1df1a', '2025-08-11 23:31:42');
INSERT INTO `chat_resource` VALUES (1954930543787270145, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/23/689a0e911ed07c4a36b1df1b', '2025-08-11 23:38:57');
INSERT INTO `chat_resource` VALUES (1954944459300978689, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/00/689a1b861ed00c7d289f3211', '2025-08-12 00:34:15');
INSERT INTO `chat_resource` VALUES (1954944462102773761, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/00/689a1b871ed00c7d289f3212', '2025-08-12 00:34:16');
INSERT INTO `chat_resource` VALUES (1954948994891300865, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/00/689a1fc01ed00c7d289f3213', '2025-08-12 00:52:16');
INSERT INTO `chat_resource` VALUES (1955128593646448641, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/12/689ac7031ed0c4e8ed699bef', '2025-08-12 12:45:56');
INSERT INTO `chat_resource` VALUES (1955128721895682050, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/12/689ac7221ed0c4e8ed699bf0', '2025-08-12 12:46:26');
INSERT INTO `chat_resource` VALUES (1955130983137251329, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/12/689ac93d1ed007ff2c7b7621', '2025-08-12 12:55:26');
INSERT INTO `chat_resource` VALUES (1955132323607449601, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/13/689aca7d1ed007ff2c7b7622', '2025-08-12 13:00:45');
INSERT INTO `chat_resource` VALUES (1955172818970865665, 1953400949577977858, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/15/689af0341ed041c2f0f073cf', '2025-08-12 15:41:40');
INSERT INTO `chat_resource` VALUES (1955191235404779521, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/16/689b015a682057115b88690b', '2025-08-12 16:54:51');
INSERT INTO `chat_resource` VALUES (1955191309589434369, 1954024510055346177, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/16/689b016c682057115b88690c', '2025-08-12 16:55:09');

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
INSERT INTO `chat_robot` VALUES (10001, '8ykc55fcq1fc21agt11qtni60hujhrxf', '在线客服', 'http://110.42.56.25:19000/xim/root/1.png', '[]');
INSERT INTO `chat_robot` VALUES (10002, 'qry41hxsjg8l4kg242z5s1u91oxll8b', '支付助手', 'http://110.42.56.25:19000/xim/root/2.png', '[]');
INSERT INTO `chat_robot` VALUES (10003, 'zgs5ibsx565wn4ccbb3hqlnozwyiktm9', 'AI助理', 'http://110.42.56.25:19000/xim/root/3.png', '[]');

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
INSERT INTO `chat_sms` VALUES (1953400889096114177, '8615', '13955555555', 'Y', 'local', '2025-08-07 18:20:39');
INSERT INTO `chat_sms` VALUES (1954021050492743682, '4290', '13977777777', 'Y', 'local', '2025-08-09 11:24:57');
INSERT INTO `chat_sms` VALUES (1954024506720874497, '1748', '13988888888', 'Y', 'local', '2025-08-09 11:38:41');
INSERT INTO `chat_sms` VALUES (1954042040689979394, '0785', '13944444444', 'Y', 'local', '2025-08-09 12:48:22');
INSERT INTO `chat_sms` VALUES (1954076243519434754, '4986', '13188888888', 'Y', 'local', '2025-08-09 15:04:16');
INSERT INTO `chat_sms` VALUES (1954840741209444353, '7780', '13966666666', 'Y', 'local', '2025-08-11 17:42:07');

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
  `portrait` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
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
INSERT INTO `chat_user` VALUES (1953400949577977858, '10045995', '13955555555', 'qq@qq.com', '濮阳棒风', 'http://110.42.56.25:19000/xim/att/4.png', NULL, '1', '1970-01-01', NULL, '北京市', '北京城区', 'kgb6', '591ca2e1d52b6ad5e56d3dc10e3c89e5', 'N', '0', 'N', 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', NULL, NULL, NULL, '2025-08-12 22:36:44', '2025-08-07 18:20:53', '192.168.1.106', '0|0|0|内网IP|内网IP', 0, '666666', 'cAvCHs', 0, '', 0, 0);
INSERT INTO `chat_user` VALUES (1954021065327996929, '10076419', '13977777777', 'qq@qq.com', '钟离寞寒', 'http://110.42.56.25:19000/xim/att/11.png', NULL, '1', '1970-01-01', NULL, '北京市', '北京城区', 'cv8i', '3f17a1af712b5534076fbf57cdf65121', 'N', '0', 'N', 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', NULL, NULL, NULL, '2025-08-10 07:56:27', '2025-08-09 11:25:01', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 0, '666666', '0Q3npv', 0, '', 0, 0);
INSERT INTO `chat_user` VALUES (1954024510055346177, '11028524', '13988888888', 'qq@qq.com', '诸葛暑狐', 'http://110.42.56.25:19000/xim/att/16.png', NULL, '1', '1970-01-01', NULL, '北京市', '北京城区', 'xu6c', '0460adc3ad5d80db96cc2c1206aea072', 'N', '0', 'N', 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', NULL, NULL, NULL, '2025-08-12 21:43:03', '2025-08-09 11:38:42', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 0, '666666', 'Vudxpz', 0, '', 0, 0);
INSERT INTO `chat_user` VALUES (1954042044259332098, '11029765', '13944444444', 'qq@qq.com', '司徒真', 'http://110.42.56.25:19000/xim/att/1.png', NULL, '1', '1970-01-01', NULL, '北京市', '北京城区', '2g5h', 'eea7e91b506bf178378eee62d51ae649', 'N', '0', 'N', 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', NULL, NULL, NULL, '2025-08-09 14:44:47', '2025-08-09 12:48:22', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 0, '666666', 'Q4tKFF', 0, '', 0, 0);
INSERT INTO `chat_user` VALUES (1954076247092981761, '12596108', '13188888888', 'qq@qq.com', '熊真', 'http://110.42.56.25:19000/xim/att/9.png', NULL, '1', '1970-01-01', NULL, '北京市', '北京城区', 'v807', 'c592d10ae877066bf605907f8a1cefc0', 'N', '0', 'N', 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', NULL, NULL, NULL, '2025-08-11 16:47:00', '2025-08-09 15:04:17', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 0, '666666', 'b01Yrn', 0, '', 0, 0);
INSERT INTO `chat_user` VALUES (1954840748109074433, '13996838', '13966666666', 'qq@qq.com', '太叔刀伤', 'http://110.42.56.25:19000/xim/att/7.png', NULL, '1', '1970-01-01', NULL, '北京市', '北京城区', 'k0bg', '9439cae751ac233765af139267a007c5', 'N', '0', 'N', 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', NULL, NULL, NULL, NULL, '2025-08-11 17:42:08', NULL, NULL, 0, '666666', 'JZrnwK', 0, '', 0, 0);

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
INSERT INTO `chat_user_info` VALUES (1953400949577977858, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_user_info` VALUES (1954021065327996929, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_user_info` VALUES (1954024510055346177, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_user_info` VALUES (1954042044259332098, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_user_info` VALUES (1954076247092981761, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_user_info` VALUES (1954840748109074433, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员注册邀请表' ROW_FORMAT = Dynamic;

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
INSERT INTO `chat_user_log` VALUES (1953400752122728450, 1952279326569910274, '1005', '退出登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-07 18:20:06');
INSERT INTO `chat_user_log` VALUES (1953400950567833601, 1953400949577977858, '1001', '用户注册', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-07 18:20:54');
INSERT INTO `chat_user_log` VALUES (1953400956087537665, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-07 18:20:55');
INSERT INTO `chat_user_log` VALUES (1953401664941690882, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-07 18:23:44');
INSERT INTO `chat_user_log` VALUES (1953402735684587521, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-07 18:27:59');
INSERT INTO `chat_user_log` VALUES (1954021066175246337, 1954021065327996929, '1001', '用户注册', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:25:01');
INSERT INTO `chat_user_log` VALUES (1954021075306246145, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:25:03');
INSERT INTO `chat_user_log` VALUES (1954023375819075586, 1954021065327996929, '1002', '密码登录', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:34:11');
INSERT INTO `chat_user_log` VALUES (1954023377106726913, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:34:12');
INSERT INTO `chat_user_log` VALUES (1954024510311198721, 1954024510055346177, '1001', '用户注册', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:38:42');
INSERT INTO `chat_user_log` VALUES (1954024511791788034, 1954024510055346177, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:38:42');
INSERT INTO `chat_user_log` VALUES (1954027061442080770, 1954021065327996929, '1002', '密码登录', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:48:50');
INSERT INTO `chat_user_log` VALUES (1954027064864632833, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:48:51');
INSERT INTO `chat_user_log` VALUES (1954027921593167873, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:52:15');
INSERT INTO `chat_user_log` VALUES (1954028320660221954, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:53:50');
INSERT INTO `chat_user_log` VALUES (1954028680082714626, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:55:16');
INSERT INTO `chat_user_log` VALUES (1954028706951426049, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 11:55:22');
INSERT INTO `chat_user_log` VALUES (1954041779296759809, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 12:47:19');
INSERT INTO `chat_user_log` VALUES (1954042044506796034, 1954042044259332098, '1001', '用户注册', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 12:48:22');
INSERT INTO `chat_user_log` VALUES (1954042045861556225, 1954042044259332098, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 12:48:23');
INSERT INTO `chat_user_log` VALUES (1954044367941496833, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 12:57:36');
INSERT INTO `chat_user_log` VALUES (1954044755847507970, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 12:59:09');
INSERT INTO `chat_user_log` VALUES (1954067049256939522, 1954042044259332098, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 14:27:44');
INSERT INTO `chat_user_log` VALUES (1954071342039003137, 1954042044259332098, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 14:44:47');
INSERT INTO `chat_user_log` VALUES (1954071425618898945, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 14:45:07');
INSERT INTO `chat_user_log` VALUES (1954076142432514049, 1952278488039825409, '1005', '退出登录', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 15:03:52');
INSERT INTO `chat_user_log` VALUES (1954076247306891266, 1954076247092981761, '1001', '用户注册', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 15:04:17');
INSERT INTO `chat_user_log` VALUES (1954076248577765377, 1954076247092981761, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 15:04:17');
INSERT INTO `chat_user_log` VALUES (1954076337530564610, 1954076247092981761, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 15:04:39');
INSERT INTO `chat_user_log` VALUES (1954077607951691777, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 15:09:41');
INSERT INTO `chat_user_log` VALUES (1954086921760239618, 1953400949577977858, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-09 15:46:42');
INSERT INTO `chat_user_log` VALUES (1954087695160639489, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 15:49:46');
INSERT INTO `chat_user_log` VALUES (1954107352810721281, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 17:07:53');
INSERT INTO `chat_user_log` VALUES (1954107928206315521, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 17:10:10');
INSERT INTO `chat_user_log` VALUES (1954111020863787009, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 17:22:28');
INSERT INTO `chat_user_log` VALUES (1954115408248381441, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 17:39:54');
INSERT INTO `chat_user_log` VALUES (1954116056327069697, 1954076247092981761, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 17:42:28');
INSERT INTO `chat_user_log` VALUES (1954116206252466178, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 17:43:04');
INSERT INTO `chat_user_log` VALUES (1954120754937413634, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 18:01:08');
INSERT INTO `chat_user_log` VALUES (1954131678549196801, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 18:44:33');
INSERT INTO `chat_user_log` VALUES (1954132794976452610, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 18:48:59');
INSERT INTO `chat_user_log` VALUES (1954134411905810433, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 18:55:25');
INSERT INTO `chat_user_log` VALUES (1954136052885307393, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 19:01:56');
INSERT INTO `chat_user_log` VALUES (1954136181990178818, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 19:02:27');
INSERT INTO `chat_user_log` VALUES (1954137463387799554, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 19:07:32');
INSERT INTO `chat_user_log` VALUES (1954141683524517889, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 19:24:18');
INSERT INTO `chat_user_log` VALUES (1954148887438770177, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 19:52:56');
INSERT INTO `chat_user_log` VALUES (1954150016448937986, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 19:57:25');
INSERT INTO `chat_user_log` VALUES (1954151729868259330, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 20:04:13');
INSERT INTO `chat_user_log` VALUES (1954152268085542914, 1954076247092981761, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 20:06:22');
INSERT INTO `chat_user_log` VALUES (1954168989357924354, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-09 21:12:48');
INSERT INTO `chat_user_log` VALUES (1954330969074921474, 1954021065327996929, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-10 07:56:27');
INSERT INTO `chat_user_log` VALUES (1954388821802053633, 1953400949577977858, '1026', '用户刷新', '118.248.47.223', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-10 11:46:21');
INSERT INTO `chat_user_log` VALUES (1954388907751899138, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 11:46:41');
INSERT INTO `chat_user_log` VALUES (1954402269403561986, 1954076247092981761, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 12:39:47');
INSERT INTO `chat_user_log` VALUES (1954406806587719682, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 12:57:48');
INSERT INTO `chat_user_log` VALUES (1954407898008535042, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 13:02:09');
INSERT INTO `chat_user_log` VALUES (1954409744383098881, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 13:09:29');
INSERT INTO `chat_user_log` VALUES (1954412307228672001, 1953400949577977858, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 13:19:40');
INSERT INTO `chat_user_log` VALUES (1954412310399565825, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 13:19:41');
INSERT INTO `chat_user_log` VALUES (1954413513674080257, 1953400949577977858, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 13:24:28');
INSERT INTO `chat_user_log` VALUES (1954413517566394369, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 13:24:28');
INSERT INTO `chat_user_log` VALUES (1954451904910348289, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 15:57:01');
INSERT INTO `chat_user_log` VALUES (1954452375712583682, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 15:58:53');
INSERT INTO `chat_user_log` VALUES (1954452701253488642, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 16:00:11');
INSERT INTO `chat_user_log` VALUES (1954452861664645121, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 16:00:49');
INSERT INTO `chat_user_log` VALUES (1954453199041875969, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 16:02:09');
INSERT INTO `chat_user_log` VALUES (1954453600646483970, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 16:03:45');
INSERT INTO `chat_user_log` VALUES (1954454027756654593, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 16:05:27');
INSERT INTO `chat_user_log` VALUES (1954456421693411329, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 16:14:58');
INSERT INTO `chat_user_log` VALUES (1954469008233484289, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:04:58');
INSERT INTO `chat_user_log` VALUES (1954470402021675010, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:10:31');
INSERT INTO `chat_user_log` VALUES (1954471195349110786, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:13:40');
INSERT INTO `chat_user_log` VALUES (1954472208936226817, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:17:42');
INSERT INTO `chat_user_log` VALUES (1954472333691604994, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:18:11');
INSERT INTO `chat_user_log` VALUES (1954472648935493634, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:19:27');
INSERT INTO `chat_user_log` VALUES (1954477477258874882, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:38:38');
INSERT INTO `chat_user_log` VALUES (1954478145583468546, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:41:17');
INSERT INTO `chat_user_log` VALUES (1954478465004883969, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 17:42:33');
INSERT INTO `chat_user_log` VALUES (1954495792438071298, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 18:51:24');
INSERT INTO `chat_user_log` VALUES (1954497275371999233, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 18:57:18');
INSERT INTO `chat_user_log` VALUES (1954497674908815361, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 18:58:53');
INSERT INTO `chat_user_log` VALUES (1954499369864810498, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:05:37');
INSERT INTO `chat_user_log` VALUES (1954499792239611905, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:07:18');
INSERT INTO `chat_user_log` VALUES (1954500444420329473, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:09:53');
INSERT INTO `chat_user_log` VALUES (1954502140387151873, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:16:38');
INSERT INTO `chat_user_log` VALUES (1954504229662248962, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:24:56');
INSERT INTO `chat_user_log` VALUES (1954505749908705281, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:30:58');
INSERT INTO `chat_user_log` VALUES (1954506011234816002, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:32:01');
INSERT INTO `chat_user_log` VALUES (1954506404236906497, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 19:33:34');
INSERT INTO `chat_user_log` VALUES (1954539172895453185, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 21:43:47');
INSERT INTO `chat_user_log` VALUES (1954539707816013826, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 21:45:55');
INSERT INTO `chat_user_log` VALUES (1954540902135689218, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 21:50:39');
INSERT INTO `chat_user_log` VALUES (1954541600906735618, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 21:53:26');
INSERT INTO `chat_user_log` VALUES (1954541743194304513, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 21:54:00');
INSERT INTO `chat_user_log` VALUES (1954541899419545602, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 21:54:37');
INSERT INTO `chat_user_log` VALUES (1954543425915514882, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:00:41');
INSERT INTO `chat_user_log` VALUES (1954543618148855809, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:01:27');
INSERT INTO `chat_user_log` VALUES (1954544499615395842, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:04:57');
INSERT INTO `chat_user_log` VALUES (1954544717933113346, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:05:49');
INSERT INTO `chat_user_log` VALUES (1954545758464438274, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:09:57');
INSERT INTO `chat_user_log` VALUES (1954554423804231682, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:44:23');
INSERT INTO `chat_user_log` VALUES (1954555238526812161, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:47:37');
INSERT INTO `chat_user_log` VALUES (1954555420991619073, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:48:21');
INSERT INTO `chat_user_log` VALUES (1954555508161839106, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:48:42');
INSERT INTO `chat_user_log` VALUES (1954555818884268033, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:49:56');
INSERT INTO `chat_user_log` VALUES (1954556090444480513, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:51:01');
INSERT INTO `chat_user_log` VALUES (1954556148351041538, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:51:14');
INSERT INTO `chat_user_log` VALUES (1954556223445860354, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:51:32');
INSERT INTO `chat_user_log` VALUES (1954556288629538818, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:51:48');
INSERT INTO `chat_user_log` VALUES (1954556468460322818, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:52:31');
INSERT INTO `chat_user_log` VALUES (1954556696898895874, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:53:25');
INSERT INTO `chat_user_log` VALUES (1954556757477228545, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:53:40');
INSERT INTO `chat_user_log` VALUES (1954556915464077314, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:54:17');
INSERT INTO `chat_user_log` VALUES (1954556973207060482, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:54:31');
INSERT INTO `chat_user_log` VALUES (1954557533205364738, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-10 22:56:44');
INSERT INTO `chat_user_log` VALUES (1954698658394210306, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 08:17:31');
INSERT INTO `chat_user_log` VALUES (1954700413005795331, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 08:24:30');
INSERT INTO `chat_user_log` VALUES (1954705962606858242, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 08:46:33');
INSERT INTO `chat_user_log` VALUES (1954706136532062209, 1954076247092981761, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 08:47:14');
INSERT INTO `chat_user_log` VALUES (1954714498879533058, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 09:20:28');
INSERT INTO `chat_user_log` VALUES (1954741867229044737, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 11:09:13');
INSERT INTO `chat_user_log` VALUES (1954753554757828610, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 11:55:40');
INSERT INTO `chat_user_log` VALUES (1954797274299490306, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 14:49:23');
INSERT INTO `chat_user_log` VALUES (1954807516152328193, 1953400949577977858, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 15:30:05');
INSERT INTO `chat_user_log` VALUES (1954807519772012545, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 15:30:06');
INSERT INTO `chat_user_log` VALUES (1954826871501844482, 1954076247092981761, '1026', '用户刷新', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-11 16:47:00');
INSERT INTO `chat_user_log` VALUES (1954836534876565506, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:25:24');
INSERT INTO `chat_user_log` VALUES (1954836978185138178, 1953400949577977858, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:27:09');
INSERT INTO `chat_user_log` VALUES (1954836981246980097, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:27:10');
INSERT INTO `chat_user_log` VALUES (1954837456423874562, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:29:03');
INSERT INTO `chat_user_log` VALUES (1954838995452424194, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:35:10');
INSERT INTO `chat_user_log` VALUES (1954839708064673794, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:38:00');
INSERT INTO `chat_user_log` VALUES (1954839823525474306, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:38:28');
INSERT INTO `chat_user_log` VALUES (1954839954517782529, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 17:38:59');
INSERT INTO `chat_user_log` VALUES (1954840748872437762, 1954840748109074433, '1001', '用户注册', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-11 17:42:08');
INSERT INTO `chat_user_log` VALUES (1954846045024677889, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 18:03:11');
INSERT INTO `chat_user_log` VALUES (1954863297639870465, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:11:44');
INSERT INTO `chat_user_log` VALUES (1954863414816141314, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:12:12');
INSERT INTO `chat_user_log` VALUES (1954863535695982593, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:12:41');
INSERT INTO `chat_user_log` VALUES (1954863906719920130, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:14:10');
INSERT INTO `chat_user_log` VALUES (1954864181736239106, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:15:15');
INSERT INTO `chat_user_log` VALUES (1954864877709684738, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:18:01');
INSERT INTO `chat_user_log` VALUES (1954865245810192385, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:19:29');
INSERT INTO `chat_user_log` VALUES (1954865957269008386, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:22:19');
INSERT INTO `chat_user_log` VALUES (1954866550322622465, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:24:40');
INSERT INTO `chat_user_log` VALUES (1954867260292460545, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:27:29');
INSERT INTO `chat_user_log` VALUES (1954867509543170050, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:28:29');
INSERT INTO `chat_user_log` VALUES (1954870499796709378, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:40:22');
INSERT INTO `chat_user_log` VALUES (1954874700408942594, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:57:03');
INSERT INTO `chat_user_log` VALUES (1954875202500685826, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 19:59:03');
INSERT INTO `chat_user_log` VALUES (1954875957185998849, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:02:03');
INSERT INTO `chat_user_log` VALUES (1954876168868327426, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:02:53');
INSERT INTO `chat_user_log` VALUES (1954876297969004545, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:03:24');
INSERT INTO `chat_user_log` VALUES (1954878910965870593, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:13:47');
INSERT INTO `chat_user_log` VALUES (1954880274441826306, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:19:12');
INSERT INTO `chat_user_log` VALUES (1954880852223979522, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:21:30');
INSERT INTO `chat_user_log` VALUES (1954881073733562370, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:22:23');
INSERT INTO `chat_user_log` VALUES (1954881680825511937, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:24:47');
INSERT INTO `chat_user_log` VALUES (1954881788757536770, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:25:13');
INSERT INTO `chat_user_log` VALUES (1954883991891210242, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:33:58');
INSERT INTO `chat_user_log` VALUES (1954887484681089026, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:47:51');
INSERT INTO `chat_user_log` VALUES (1954889196795981826, 1954024510055346177, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:54:39');
INSERT INTO `chat_user_log` VALUES (1954889200814125058, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:54:40');
INSERT INTO `chat_user_log` VALUES (1954889696731852802, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 20:56:38');
INSERT INTO `chat_user_log` VALUES (1954891014343094274, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 21:01:53');
INSERT INTO `chat_user_log` VALUES (1954905616757571586, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 21:59:54');
INSERT INTO `chat_user_log` VALUES (1954906442041409537, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:03:11');
INSERT INTO `chat_user_log` VALUES (1954906701761101826, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:04:13');
INSERT INTO `chat_user_log` VALUES (1954907050739777538, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:05:36');
INSERT INTO `chat_user_log` VALUES (1954912755102269441, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:28:16');
INSERT INTO `chat_user_log` VALUES (1954912928280887297, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:28:57');
INSERT INTO `chat_user_log` VALUES (1954913092978622466, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:29:37');
INSERT INTO `chat_user_log` VALUES (1954914183166316545, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:33:56');
INSERT INTO `chat_user_log` VALUES (1954916032434950145, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:41:17');
INSERT INTO `chat_user_log` VALUES (1954916096804933634, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:41:33');
INSERT INTO `chat_user_log` VALUES (1954916723740135425, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:44:02');
INSERT INTO `chat_user_log` VALUES (1954917642162688002, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:47:41');
INSERT INTO `chat_user_log` VALUES (1954917645962727425, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:47:42');
INSERT INTO `chat_user_log` VALUES (1954917973420429313, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:49:00');
INSERT INTO `chat_user_log` VALUES (1954919779965882370, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 22:56:11');
INSERT INTO `chat_user_log` VALUES (1954920808845430785, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:00:16');
INSERT INTO `chat_user_log` VALUES (1954921007915487233, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:01:04');
INSERT INTO `chat_user_log` VALUES (1954921534606823425, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:03:09');
INSERT INTO `chat_user_log` VALUES (1954922045443690497, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:05:11');
INSERT INTO `chat_user_log` VALUES (1954922171004375041, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:05:41');
INSERT INTO `chat_user_log` VALUES (1954922375032098818, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:06:30');
INSERT INTO `chat_user_log` VALUES (1954922419663687682, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:06:40');
INSERT INTO `chat_user_log` VALUES (1954922792713474049, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:08:09');
INSERT INTO `chat_user_log` VALUES (1954922879590092802, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:08:30');
INSERT INTO `chat_user_log` VALUES (1954923157034913793, 1954024510055346177, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:09:36');
INSERT INTO `chat_user_log` VALUES (1954923160570712065, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:09:37');
INSERT INTO `chat_user_log` VALUES (1954926256004816898, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:21:55');
INSERT INTO `chat_user_log` VALUES (1954928068061585410, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:29:07');
INSERT INTO `chat_user_log` VALUES (1954929775424331777, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:35:54');
INSERT INTO `chat_user_log` VALUES (1954931006800683010, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:40:48');
INSERT INTO `chat_user_log` VALUES (1954934636912082945, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:55:13');
INSERT INTO `chat_user_log` VALUES (1954935315986681857, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-11 23:57:55');
INSERT INTO `chat_user_log` VALUES (1954939748535537665, 1953400949577977858, '1005', '退出登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:15:32');
INSERT INTO `chat_user_log` VALUES (1954939786288467970, 1953400949577977858, '1002', '密码登录', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:15:41');
INSERT INTO `chat_user_log` VALUES (1954939788574363650, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:15:41');
INSERT INTO `chat_user_log` VALUES (1954945133485015041, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:36:56');
INSERT INTO `chat_user_log` VALUES (1954945257615441922, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:37:25');
INSERT INTO `chat_user_log` VALUES (1954946899593183234, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:43:57');
INSERT INTO `chat_user_log` VALUES (1954948897042382850, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 00:51:53');
INSERT INTO `chat_user_log` VALUES (1954951178223665153, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 01:00:57');
INSERT INTO `chat_user_log` VALUES (1955101996876918786, 1954024510055346177, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 11:00:15');
INSERT INTO `chat_user_log` VALUES (1955106035404468226, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 11:16:18');
INSERT INTO `chat_user_log` VALUES (1955122101635608577, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 12:20:08');
INSERT INTO `chat_user_log` VALUES (1955127831637880833, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 12:42:54');
INSERT INTO `chat_user_log` VALUES (1955128365304344577, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 12:45:01');
INSERT INTO `chat_user_log` VALUES (1955130743839625218, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 12:54:29');
INSERT INTO `chat_user_log` VALUES (1955132228136701954, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 13:00:22');
INSERT INTO `chat_user_log` VALUES (1955133053579923458, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 13:03:39');
INSERT INTO `chat_user_log` VALUES (1955137418302693378, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 13:21:00');
INSERT INTO `chat_user_log` VALUES (1955185803789340674, 1954024510055346177, '1026', '用户刷新', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-12 16:33:16');
INSERT INTO `chat_user_log` VALUES (1955255786057912321, 1953400949577977858, '1026', '用户刷新', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-12 21:11:21');
INSERT INTO `chat_user_log` VALUES (1955263762776870914, 1954024510055346177, '1026', '用户刷新', '118.248.42.247', '中国|0|湖南省|益阳市|电信', 'android', '1.1.9', '2025-08-12 21:43:03');
INSERT INTO `chat_user_log` VALUES (1955277272009310209, 1953400949577977858, '1026', '用户刷新', '192.168.1.106', '0|0|0|内网IP|内网IP', 'android', '1.1.9', '2025-08-12 22:36:44');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1955263655100698627 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户按天签到记录' ROW_FORMAT = Dynamic;

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
INSERT INTO `chat_user_sign` VALUES (1953402780299399169, 1953400949577977858, 1953402780299399170, '2025-08-07', 3.00, 1, 1, '2025-08-07 18:28:10', '2025-08-07 18:28:10');
INSERT INTO `chat_user_sign` VALUES (1954021097473142785, 1954021065327996929, 1954021097473142786, '2025-08-09', 3.00, 1, 1, '2025-08-09 11:25:08', '2025-08-09 11:25:08');
INSERT INTO `chat_user_sign` VALUES (1954169435778670594, 1953400949577977858, 1954169435778670595, '2025-08-09', 3.00, 1, 1, '2025-08-09 21:14:35', '2025-08-09 21:14:35');
INSERT INTO `chat_user_sign` VALUES (1954331019008110594, 1954021065327996929, 1954331019008110595, '2025-08-10', 3.00, 1, 1, '2025-08-10 07:56:39', '2025-08-10 07:56:39');
INSERT INTO `chat_user_sign` VALUES (1954827100242407426, 1954076247092981761, 1954827100242407427, '2025-08-11', 3.00, 1, 1, '2025-08-11 16:47:54', '2025-08-11 16:47:54');
INSERT INTO `chat_user_sign` VALUES (1954907296853147650, 1953400949577977858, 1954907296853147651, '2025-08-11', 3.00, 1, 1, '2025-08-11 22:06:35', '2025-08-11 22:06:35');
INSERT INTO `chat_user_sign` VALUES (1954946568696152065, 1953400949577977858, 1954946568696152066, '2025-08-12', 3.00, 1, 1, '2025-08-12 00:42:38', '2025-08-12 00:42:38');
INSERT INTO `chat_user_sign` VALUES (1955263655100698626, 1954024510055346177, 1955263655100698627, '2025-08-12', 3.00, 1, 1, '2025-08-12 21:42:37', '2025-08-12 21:42:37');

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
INSERT INTO `chat_user_token` VALUES (1953400952346218498, 1953400949577977858, '0b9309c168fea98dd79ade35b3a08567ff97bd513e8015580bfd68821ed3fed93002f4ee681c04c83d42149c2dc1f57d5bba37132f92e7bdbce7609099b60bd1', 'android', 'phone', '2025-08-07 18:20:54', NULL);
INSERT INTO `chat_user_token` VALUES (1954021073209094146, 1954021065327996929, '07ce64cf20f2d6bfdada9152e433013a4924510f89da17f6ea47f19a9ec8da4f08099ebde542f20d378cdeb60ef1f2316d96e13fb3c74b78f6792746a5b88e99', 'android', 'phone', '2025-08-09 11:25:02', NULL);
INSERT INTO `chat_user_token` VALUES (1954023375789715458, 1954021065327996929, '942e44ab02a47302b4652d6ccf551718d1d5de8f48f20b1f437070ea05e940f61c9c4c4585adebb50be0e19f124c61d1069f0f341d0057e6784794aae42d7980', 'android', 'phone', '2025-08-09 11:34:11', NULL);
INSERT INTO `chat_user_token` VALUES (1954024510336364545, 1954024510055346177, '4ecee70519ada5be32d98dc80f1da65f7467d14414178f1408d275a98e46eef6b0f297563ba9743967ee5bb4c1a7be02d0ac701be4c9270b7949243a03ec1867', 'android', 'phone', '2025-08-09 11:38:42', NULL);
INSERT INTO `chat_user_token` VALUES (1954027061425303553, 1954021065327996929, 'f196d58d786ad033a9a22b6db0015af7d17b4885261306d37245f5b0462a0177aaa959b02f4b439daf7fd06c99001c237e1327daf2a131dab5747a8d3e979356', 'android', 'phone', '2025-08-09 11:48:50', 0);
INSERT INTO `chat_user_token` VALUES (1954042044531961858, 1954042044259332098, 'fa02a7ebd7bc606a0db66cd611c9c9500fae0804d50c2b13aa0121d073937c9efbf56dcdb55b78aaf4afd2792c9caaf69284e1639d91231896fb4fe77f39f71b', 'android', 'phone', '2025-08-09 12:48:22', 0);
INSERT INTO `chat_user_token` VALUES (1954076247332057089, 1954076247092981761, '63ff71829ccdfe8c1e521d5bf5318f6d5ca0786b8fb6f0df978bcb64434b21f544564da1aa150e8f8b2bf22037ffdcf9d3919097e8b1f44b4280b0d1f9e4cd5d', 'android', 'phone', '2025-08-09 15:04:17', 0);
INSERT INTO `chat_user_token` VALUES (1954412306985402369, 1953400949577977858, '954e6c3dd4c10cf0642ce670e2bd921883dd9fcb284cf13d20093261760414df4ff8cb5ff1fce5c830932453a3fe29adfc9c36fe2b3e1615f1fc53ea51b5f036', 'android', 'phone', '2025-08-10 13:19:40', NULL);
INSERT INTO `chat_user_token` VALUES (1954413513426616321, 1953400949577977858, '7bf866c7f80682f9e0a4a673892227a60a19d1cd8a4839e0af3e0d08a02a12553aaeb1feeceffce05c8ae05c28c27f865a43f924560687a4c1c489e99df3cb28', 'android', 'phone', '2025-08-10 13:24:28', NULL);
INSERT INTO `chat_user_token` VALUES (1954807515623845889, 1953400949577977858, 'cc0b4ef818cb5396df0ac0f6cc6f6bcec923a512c1d36f632d369f0a762fc0df9fc56f3ccc3a476b26033d9246b8c456b5481a475505d7d69793875ef427ac99', 'android', 'phone', '2025-08-11 15:30:05', NULL);
INSERT INTO `chat_user_token` VALUES (1954836977908314114, 1953400949577977858, '84313c3ae4c1848e296e6d82469f6c679734bc5e6848d616b5d2572e765032c5421c47c528bebed3d1096baec2cdedf0f4989202ab184cacfc8c884573981c53', 'android', 'phone', '2025-08-11 17:27:09', NULL);
INSERT INTO `chat_user_token` VALUES (1954889196535934977, 1954024510055346177, '9b42ac5d1707db919808404c324b81a5beb8b9f0ff757ac120108139b5a047f22553e5306d4998eca81a970094365e66fe5712e62853fb861dbdb01db83a1e7b', 'android', 'phone', '2025-08-11 20:54:39', NULL);
INSERT INTO `chat_user_token` VALUES (1954923156766478337, 1954024510055346177, 'beb6d519bc3887be1629d0131f95245d6d2f0e7f50417a57cf59bdfc9a67663c7f37a2476612befc1adbfb0e2555211e19f11162449573a6231d4f12f9fe3f45', 'android', 'phone', '2025-08-11 23:09:36', 0);
INSERT INTO `chat_user_token` VALUES (1954939786028421122, 1953400949577977858, 'f46692a1f1ac20282c78f2345efba8da7cec6b720cd30127a9ec83c66f11986ed115f95bd6329d3b4b99892b4e52d9353e1523445f89ba9aeff9129b8c41cf7a', 'android', 'phone', '2025-08-12 00:15:41', 0);

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
INSERT INTO `chat_visit` VALUES (1953531590403588098, '2025-08-07', 2);
INSERT INTO `chat_visit` VALUES (1954256366004822018, '2025-08-09', 6);
INSERT INTO `chat_visit` VALUES (1954618753941831681, '2025-08-10', 3);
INSERT INTO `chat_visit` VALUES (1954981140137775105, '2025-08-11', 4);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1954930224118390787 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_comments
-- ----------------------------
INSERT INTO `friend_comments` VALUES (1954538486979948546, 1954538181437485058, 1954076247092981761, 1954076247092981761, '😀', '2025-08-10 21:41:03', 0, 0);
INSERT INTO `friend_comments` VALUES (1954542022639808513, 1954540967784935425, 1954076247092981761, 1954076247092981761, '我自己都觉得牛B😀', '2025-08-10 21:55:06', 0, 0);
INSERT INTO `friend_comments` VALUES (1954542255683727362, 1954539759548559361, 1954076247092981761, 1954076247092981761, '这是第二条的评论', '2025-08-10 21:56:02', 0, 0);
INSERT INTO `friend_comments` VALUES (1954543906960240641, 1954543760704860162, 1954076247092981761, 1954076247092981761, '😀😁', '2025-08-10 22:02:35', 0, 0);
INSERT INTO `friend_comments` VALUES (1954544085247520770, 1954543760704860162, 1954076247092981761, 1954076247092981761, '怎么信息图片不见了', '2025-08-10 22:03:18', 0, 0);
INSERT INTO `friend_comments` VALUES (1954544390601240578, 1954543760704860162, 1954076247092981761, 1954076247092981761, '就不信了，居然会这样，是怎么一回事？', '2025-08-10 22:04:31', 0, 0);
INSERT INTO `friend_comments` VALUES (1954544772605865985, 1954543760704860162, 1954076247092981761, 1954076247092981761, '再来一条看一下', '2025-08-10 22:06:02', 0, 0);
INSERT INTO `friend_comments` VALUES (1954545139527774210, 1954543760704860162, 1954076247092981761, 1954076247092981761, '总算知道是怎么一回事了', '2025-08-10 22:07:29', 0, 0);
INSERT INTO `friend_comments` VALUES (1954545851447963650, 1954540967784935425, 1954076247092981761, 1954076247092981761, '换个来评论', '2025-08-10 22:10:19', 0, 0);
INSERT INTO `friend_comments` VALUES (1954546086144438273, 1954545986500358145, 1954076247092981761, 1954076247092981761, '图片又不见了，看来要查询一下', '2025-08-10 22:11:15', 0, 0);
INSERT INTO `friend_comments` VALUES (1954547563625775106, 1954545986500358145, 1954076247092981761, 1954076247092981761, '我可以把图片找回来', '2025-08-10 22:17:07', 0, 0);
INSERT INTO `friend_comments` VALUES (1954547755762647041, 1954545986500358145, 1953400949577977858, 1954076247092981761, '我也试一下吧，看下可以不', '2025-08-10 22:17:53', 0, 1);
INSERT INTO `friend_comments` VALUES (1954547951615672321, 1954545986500358145, 1954076247092981761, 1954076247092981761, '你确认可以吗？', '2025-08-10 22:18:40', 0, 0);
INSERT INTO `friend_comments` VALUES (1954547954199363585, 1954545986500358145, 1954076247092981761, 1954076247092981761, '你确认可以吗？', '2025-08-10 22:18:40', 0, 0);
INSERT INTO `friend_comments` VALUES (1954548963629924354, 1954545986500358145, 1954076247092981761, 1954076247092981761, '🌋🏆', '2025-08-10 22:22:41', 0, 0);
INSERT INTO `friend_comments` VALUES (1954551477565718530, 1954550765003800578, 1954076247092981761, 1954076247092981761, '222', '2025-08-10 22:32:40', 0, 0);
INSERT INTO `friend_comments` VALUES (1954553322048651266, 1954550765003800578, 1954076247092981761, 1954076247092981761, '333', '2025-08-10 22:40:00', 0, 0);
INSERT INTO `friend_comments` VALUES (1954553379791634433, 1954550765003800578, 1954076247092981761, 1954076247092981761, '444', '2025-08-10 22:40:14', 0, 0);
INSERT INTO `friend_comments` VALUES (1954553381427412993, 1954550765003800578, 1954076247092981761, 1954076247092981761, '444', '2025-08-10 22:40:14', 0, 0);
INSERT INTO `friend_comments` VALUES (1954553421692731393, 1954550765003800578, 1954076247092981761, 1954076247092981761, '555', '2025-08-10 22:40:24', 0, 0);
INSERT INTO `friend_comments` VALUES (1954554689148485634, 1954554581828829186, 1954076247092981761, 1954076247092981761, '💘', '2025-08-10 22:45:26', 0, 0);
INSERT INTO `friend_comments` VALUES (1954555205639274498, 1954554581828829186, 1954076247092981761, 1954076247092981761, '369', '2025-08-10 22:47:29', 0, 0);
INSERT INTO `friend_comments` VALUES (1954555453652664321, 1954554581828829186, 1954076247092981761, 1954076247092981761, '211314', '2025-08-10 22:48:28', 0, 0);
INSERT INTO `friend_comments` VALUES (1954555455577849857, 1954554581828829186, 1954076247092981761, 1954076247092981761, '211314', '2025-08-10 22:48:29', 0, 0);
INSERT INTO `friend_comments` VALUES (1954841699859951618, 1954808100758614018, 1953400949577977858, 1954076247092981761, '看起来好漂亮，好美！', '2025-08-11 17:45:55', 0, 1);
INSERT INTO `friend_comments` VALUES (1954923312475820033, 1954923192573251585, 1953400949577977858, 1954024510055346177, '中国情节', '2025-08-11 23:10:13', 0, 1);
INSERT INTO `friend_comments` VALUES (1954925391625871361, 1954923192573251585, 1953400949577977858, 1954024510055346177, '评论这里回复逻辑测试', '2025-08-11 23:18:28', 0, 1);
INSERT INTO `friend_comments` VALUES (1954925393437810690, 1954923192573251585, 1953400949577977858, 1954024510055346177, '评论这里回复逻辑测试', '2025-08-11 23:18:29', 0, 1);
INSERT INTO `friend_comments` VALUES (1954926317367484417, 1954923192573251585, 1953400949577977858, 1954024510055346177, '再评一条看一下', '2025-08-11 23:22:09', 0, 0);
INSERT INTO `friend_comments` VALUES (1954928401756217345, 1954923192573251585, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:30:26', 0, 0);
INSERT INTO `friend_comments` VALUES (1954928512758472705, 1954923192573251585, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:30:52', 0, 0);
INSERT INTO `friend_comments` VALUES (1954928663078133762, 1954923192573251585, 1954024510055346177, 1954024510055346177, '不是文字不行吗？', '2025-08-11 23:31:28', 0, 0);
INSERT INTO `friend_comments` VALUES (1954928770766888961, 1954928721995522050, 1954024510055346177, 1954024510055346177, '这主', '2025-08-11 23:31:54', 0, 0);
INSERT INTO `friend_comments` VALUES (1954928836705542146, 1954928721995522050, 1953400949577977858, 1954024510055346177, '😄', '2025-08-11 23:32:10', 0, 0);
INSERT INTO `friend_comments` VALUES (1954928907706720258, 1954928721995522050, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:32:27', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929025264672770, 1954928721995522050, 1954024510055346177, 1954024510055346177, '看一下是不是超长了，就不行了，还是怎能柘城地夺顶替', '2025-08-11 23:32:55', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929175403978753, 1954928721995522050, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:33:30', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929230265475073, 1954928721995522050, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:33:44', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929266000945154, 1954928721995522050, 1953400949577977858, 1954024510055346177, '😄', '2025-08-11 23:33:52', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929388831137793, 1954929359965937666, 1953400949577977858, 1954024510055346177, '😄', '2025-08-11 23:34:21', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929879501791233, 1954929359965937666, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:36:18', 0, 0);
INSERT INTO `friend_comments` VALUES (1954929975207419906, 1954929359965937666, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:36:41', 0, 0);
INSERT INTO `friend_comments` VALUES (1954930187409842178, 1954930060569894914, 1954024510055346177, 1954024510055346177, '😇', '2025-08-11 23:37:32', 0, 0);
INSERT INTO `friend_comments` VALUES (1954930224118390786, 1954930060569894914, 1953400949577977858, 1954024510055346177, '😄', '2025-08-11 23:37:40', 0, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1955280989962027011 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_likes
-- ----------------------------
INSERT INTO `friend_likes` VALUES (1954507067427672066, 1954504900574728193, 1954076247092981761, '2025-08-10 19:36:12', 0);
INSERT INTO `friend_likes` VALUES (1954507105201573889, 1954504900574728193, 1953400949577977858, '2025-08-10 19:36:21', 0);
INSERT INTO `friend_likes` VALUES (1954532408825253890, 1954504294309056513, 1954076247092981761, '2025-08-10 21:16:54', 0);
INSERT INTO `friend_likes` VALUES (1954533082707304449, 1954502208779472897, 1954076247092981761, '2025-08-10 21:19:35', 0);
INSERT INTO `friend_likes` VALUES (1954534065860554754, 1954500689132802050, 1954076247092981761, '2025-08-10 21:23:29', 0);
INSERT INTO `friend_likes` VALUES (1954534512562323458, 1954504841061748738, 1954076247092981761, '2025-08-10 21:25:16', 0);
INSERT INTO `friend_likes` VALUES (1954537100749889538, 1954501004498325506, 1954076247092981761, '2025-08-10 21:35:33', 0);
INSERT INTO `friend_likes` VALUES (1954537971776811009, 1954497837584896002, 1954076247092981761, '2025-08-10 21:39:00', 0);
INSERT INTO `friend_likes` VALUES (1954538217005182978, 1954538181437485058, 1954076247092981761, '2025-08-10 21:39:59', 0);
INSERT INTO `friend_likes` VALUES (1954539376193368065, 1954539322330116097, 1954076247092981761, '2025-08-10 21:44:35', 0);
INSERT INTO `friend_likes` VALUES (1954539780599771138, 1954539759548559361, 1954076247092981761, '2025-08-10 21:46:12', 0);
INSERT INTO `friend_likes` VALUES (1954540989071028225, 1954540967784935425, 1954076247092981761, '2025-08-10 21:51:00', 0);
INSERT INTO `friend_likes` VALUES (1954543792879366145, 1954543760704860162, 1954076247092981761, '2025-08-10 22:02:08', 0);
INSERT INTO `friend_likes` VALUES (1954546020117704705, 1954545986500358145, 1954076247092981761, '2025-08-10 22:10:59', 0);
INSERT INTO `friend_likes` VALUES (1954547691447189506, 1954545986500358145, 1953400949577977858, '2025-08-10 22:17:38', 0);
INSERT INTO `friend_likes` VALUES (1954548326024413186, 1954543760704860162, 1953400949577977858, '2025-08-10 22:20:09', 0);
INSERT INTO `friend_likes` VALUES (1954551429582880769, 1954550765003800578, 1954076247092981761, '2025-08-10 22:32:29', 0);
INSERT INTO `friend_likes` VALUES (1954554610865995777, 1954554581828829186, 1954076247092981761, '2025-08-10 22:45:07', 0);
INSERT INTO `friend_likes` VALUES (1954556941066108929, 1954555885967966210, 1954076247092981761, '2025-08-10 22:54:23', 0);
INSERT INTO `friend_likes` VALUES (1954841165761474561, 1954835559533117442, 1953400949577977858, '2025-08-11 17:43:47', 0);
INSERT INTO `friend_likes` VALUES (1954841539662704642, 1954808100758614018, 1953400949577977858, '2025-08-11 17:45:16', 0);
INSERT INTO `friend_likes` VALUES (1954912681286713345, 1954906623495389185, 1953400949577977858, '2025-08-11 22:27:58', 0);
INSERT INTO `friend_likes` VALUES (1954912796940451842, 1954904355853320193, 1953400949577977858, '2025-08-11 22:28:25', 0);
INSERT INTO `friend_likes` VALUES (1954916265965408258, 1954916174118539265, 1953400949577977858, '2025-08-11 22:42:13', 0);
INSERT INTO `friend_likes` VALUES (1954916879961182209, 1954916783471218689, 1953400949577977858, '2025-08-11 22:44:39', 0);
INSERT INTO `friend_likes` VALUES (1954922962737975298, 1954922916445442050, 1953400949577977858, '2025-08-11 23:08:49', 0);
INSERT INTO `friend_likes` VALUES (1954922975631265794, 1954922757082861570, 1953400949577977858, '2025-08-11 23:08:52', 0);
INSERT INTO `friend_likes` VALUES (1954923249896804353, 1954923192573251585, 1953400949577977858, '2025-08-11 23:09:58', 0);
INSERT INTO `friend_likes` VALUES (1954923470164873217, 1954923192573251585, 1954024510055346177, '2025-08-11 23:10:50', 0);
INSERT INTO `friend_likes` VALUES (1954930135215923201, 1954930060569894914, 1954024510055346177, '2025-08-11 23:37:19', 0);
INSERT INTO `friend_likes` VALUES (1955114437732036610, 1955102034533380097, 1953400949577977858, '2025-08-12 11:49:40', 0);
INSERT INTO `friend_likes` VALUES (1955114470732820482, 1954949003233771521, 1953400949577977858, '2025-08-12 11:49:48', 0);
INSERT INTO `friend_likes` VALUES (1955114491574317057, 1955102034533380097, 1954024510055346177, '2025-08-12 11:49:53', 0);
INSERT INTO `friend_likes` VALUES (1955114507768524801, 1954949003233771521, 1954024510055346177, '2025-08-12 11:49:57', 0);
INSERT INTO `friend_likes` VALUES (1955185900346413058, 1955176813156245505, 1954024510055346177, '2025-08-12 16:33:38', 0);
INSERT INTO `friend_likes` VALUES (1955186006986735617, 1955179177799991298, 1953400949577977858, '2025-08-12 16:34:04', 0);
INSERT INTO `friend_likes` VALUES (1955280989962027010, 1955223076362928129, 1953400949577977858, '2025-08-12 22:51:29', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1955191342602801155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈媒体资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_medias
-- ----------------------------
INSERT INTO `friend_medias` VALUES (1954384226405298177, 1954384225876815873, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689811951ed02197c9065f5a', '/storage/emulated/0/Pictures/头像/20250619105431669206_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954384226405298178, 1954384225876815873, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689811951ed02197c9065f5b', '/storage/emulated/0/Pictures/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954388069281165314, 1954388068803014658, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/6898153e1ed0fb9f3c2875e8', '/storage/emulated/0/Pictures/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954388069281165315, 1954388068803014659, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/6898153e1ed0fb9f3c2875e8', '/storage/emulated/0/Pictures/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954389075645693954, 1954389075167543298, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689816461ed068eab89b13b9', '/storage/emulated/0/Pictures/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954389742045106177, 1954389741499846658, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689816df1ed030fd7b88f484', '/storage/emulated/0/Pictures/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954392020881776642, 1954392020374265857, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/11/689818f91ed0c294ab076cc7', '/storage/emulated/0/Pictures/头像/ic_face_06.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954392560961335298, 1954392560508350466, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/12/689819751ed01452c0aea63f', '/storage/emulated/0/Pictures/res/u3.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954394685640556546, 1954394685120462850, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/12/68981b6e1ed0c85808f1fd81', '/storage/emulated/0/Pictures/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954453932961189890, 1954453932147494913, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/16/689852a81ed00d9bb3866f3a', '/storage/emulated/0/DCIM/Camera/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954471349498171394, 1954471349070352386, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/17/689862e51ed00d9bb3866f3b', '/storage/emulated/0/Pictures/头像/20250619105431669206_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954471349498171395, 1954471349070352386, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/17/689862e61ed00d9bb3866f3c', '/storage/emulated/0/Pictures/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954472974673530882, 1954472974166020097, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/17/689864611ed00d9bb3866f3d', '/storage/emulated/0/DCIM/Camera/头像/ic_face_01.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954494428718845953, 1954494428077117441, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/18/6898785b1ed00d9bb3866f3e', '/storage/emulated/0/DCIM/Camera/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954504294728486913, 1954504294309056513, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/19/689881961ed00d9bb3866f3f', '/storage/emulated/0/DCIM/Camera/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954543761136873473, 1954543760704860162, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898a6511ed0108592f37d63', '/storage/emulated/0/DCIM/Camera/头像/20250703173526661215_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954545986982703105, 1954545986500358145, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898a8681ed0108592f37d64', '/storage/emulated/0/DCIM/Camera/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954545986982703106, 1954545986500358145, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898a8691ed0108592f37d65', '/storage/emulated/0/DCIM/Camera/头像/20250619105431669206_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954554582306979841, 1954554581828829186, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/10/22/6898b0671ed018538ab34c27', '/storage/emulated/0/DCIM/Camera/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954808101429702658, 1954808100758614018, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/15/68999c6e1ed0b09aa359bfec', '/storage/emulated/0/DCIM/Camera/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954827543370625025, 1954827543240601601, NULL, 'http://110.42.56.25:19000/xim/alpaca/202508/11/16/6899ae926820aa9d08fe2ed2.png', '/storage/emulated/0/DCIM/Camera/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954835559734444034, 1954835559533117442, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/17/6899b6146820dd11c2511433', '/storage/emulated/0/DCIM/Camera/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954835559734444035, 1954835559533117442, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/17/6899b6186820dd11c2511434', '/storage/emulated/0/DCIM/Camera/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954877301212966914, 1954877300747399169, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/20/6899dcf91ed0b09aa359bfed', '/storage/emulated/0/Pictures/res/u3.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954879045246513154, 1954879044785139713, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/20/6899de981ed0b09aa359bfee', '/storage/emulated/0/Pictures/res/u3.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954889323640123394, 1954889323120029697, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/20/6899e8261ed0b09aa359bfef', '/storage/emulated/0/DCIM/Camera/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954891949328572418, 1954891948854616065, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899ea9d1ed0529e4faee889', '/storage/emulated/0/DCIM/Camera/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954892983723630594, 1954892983312588801, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899eb911ed0529e4faee88a', '/storage/emulated/0/Pictures/头像/ic_face_05.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954900032201170946, 1954900031731408897, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899f2251ed0529e4faee88b', '/storage/emulated/0/DCIM/Camera/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954904356474077185, 1954904355853320193, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/21/6899f6251ed0089e11098864', '/storage/emulated/0/DCIM/Camera/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954916174642827265, 1954916174118539265, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/22/689a012e1ed0ec5b0939a29d', '/storage/emulated/0/DCIM/Camera/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954921111011479553, 1954921110503968770, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/23/689a05c31ed0ec5b0939a29e', '/storage/emulated/0/DCIM/Camera/头像/ic_face_01.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954928722544975874, 1954928721995522050, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/23/689a0cdd1ed07c4a36b1df1a', '/storage/emulated/0/DCIM/Camera/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954930549449580545, 1954930549017567234, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/11/23/689a0e911ed07c4a36b1df1b', '/storage/emulated/0/DCIM/Camera/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954944521385066498, 1954944520877555713, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/00/689a1b861ed00c7d289f3211', '/storage/emulated/0/DCIM/Camera/1752067385300.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954944521385066499, 1954944520877555713, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/00/689a1b871ed00c7d289f3212', '/storage/emulated/0/DCIM/Camera/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1954949003661590530, 1954949003233771521, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/00/689a1fc01ed00c7d289f3213', '/storage/emulated/0/DCIM/Camera/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1955172835907465218, 1955172835282513922, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/15/689af0341ed041c2f0f073cf', '/storage/emulated/0/Pictures/头像/20250617114401884048_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1955191242426044417, 1955191242262466562, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/16/689b015a682057115b88690b', '/storage/emulated/0/DCIM/Camera/头像/20250613165956877342_s.png', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `friend_medias` VALUES (1955191342602801154, 1955191342523109378, NULL, 'http://lxim.oss-cn-shenzhen.aliyuncs.com/alpaca/202508/12/16/689b016c682057115b88690c', '/storage/emulated/0/DCIM/Camera/头像/20250606160911248086.png', 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for friend_moments
-- ----------------------------
DROP TABLE IF EXISTS `friend_moments`;
CREATE TABLE `friend_moments`  (
  `moment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '动态ID',
  `user_id` bigint(20) NOT NULL COMMENT '发布用户ID',
  `content` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文字内容',
  `location` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置信息',
  `visibility` tinyint(4) NULL DEFAULT 0 COMMENT '可见性：0-公开，1-好友可见，2-私密，3-部分可见，4-不给谁看',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除标记',
  `visuser` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '可见用户ID',
  PRIMARY KEY (`moment_id`) USING BTREE,
  INDEX `idx_user_time`(`user_id`, `create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1955280891240665090 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈动态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_moments
-- ----------------------------
INSERT INTO `friend_moments` VALUES (1954105481576411138, 1954076247092981761, '222', '|', 1, '2025-08-09 17:00:27', '2025-08-09 17:00:26', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954384225876815873, 1953400949577977858, '发个朋友圈测试', '王府半岛酒店·凰庭|116.416404|39.914949', 1, '2025-08-10 11:28:05', '2025-08-10 11:28:04', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954388068803014658, 1953400949577977858, '第二条朋友圈', '新亿美食城|116.417529|39.917277', 1, '2025-08-10 11:43:21', '2025-08-10 11:43:21', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954388068803014659, 1953400949577977858, '第二条朋友圈', '新亿美食城|116.417529|39.917277', 1, '2025-08-10 11:43:21', '2025-08-10 11:43:20', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954389075167543298, 1953400949577977858, '第三条信息', '|', 1, '2025-08-10 11:47:21', '2025-08-10 11:47:20', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954389741499846658, 1953400949577977858, '第4条朋友圈信息', '|', 1, '2025-08-10 11:50:00', '2025-08-10 11:49:59', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954392020374265857, 1953400949577977858, '234', '|', 1, '2025-08-10 11:59:03', '2025-08-10 11:59:03', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954392560508350466, 1953400949577977858, '999', '西堂子胡同1号院|116.417016|39.91663', 1, '2025-08-10 12:01:12', '2025-08-10 12:01:11', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954394685120462850, 1953400949577977858, '最新一条，1张图', '西堂子胡同1号院|116.417016|39.91663', 1, '2025-08-10 12:09:38', '2025-08-10 12:09:38', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954406378907123714, 1953400949577977858, '558', '|', 1, '2025-08-10 12:56:07', '2025-08-10 12:56:06', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954406951568031745, 1953400949577977858, '000', '|', 1, '2025-08-10 12:58:23', '2025-08-10 12:58:23', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954407509158805505, 1953400949577977858, '888', '|', 1, '2025-08-10 13:00:36', '2025-08-10 13:00:36', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954407937934114818, 1953400949577977858, 'qqqq', '|', 1, '2025-08-10 13:02:18', '2025-08-10 13:02:18', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954409201996677121, 1953400949577977858, '963', '|', 1, '2025-08-10 13:07:20', '2025-08-10 13:07:19', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954409791120228353, 1953400949577977858, '456', '|', 1, '2025-08-10 13:09:40', '2025-08-10 13:09:40', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954412415647236098, 1953400949577977858, '123123', '|', 1, '2025-08-10 13:20:06', '2025-08-10 13:20:05', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954413550512652289, 1953400949577977858, '123654', '|', 1, '2025-08-10 13:24:36', '2025-08-10 13:24:36', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954413914762788865, 1953400949577977858, 'gggg', '|', 1, '2025-08-10 13:26:03', '2025-08-10 13:26:03', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954453932147494913, 1954076247092981761, '我也来发一条', '西堂子胡同1号院|116.417016|39.91663', 1, '2025-08-10 16:05:04', '2025-08-10 16:05:04', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954471349070352386, 1953400949577977858, '你发我也发', '|', 1, '2025-08-10 17:14:17', '2025-08-10 17:14:16', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954472974166020097, 1954076247092981761, '好吧，一起造起来', '成都高新孵化园1号楼|104.066439|30.574702', 1, '2025-08-10 17:20:44', '2025-08-10 17:20:44', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954473060572876801, 1954076247092981761, '当今天世界谁怕谁', '|', 1, '2025-08-10 17:21:05', '2025-08-10 17:21:04', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954477537568772097, 1954076247092981761, '来吧宝贝', '|', 1, '2025-08-10 17:38:52', '2025-08-10 17:38:52', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954478189208424449, 1954076247092981761, '看看', '|', 1, '2025-08-10 17:41:27', '2025-08-10 17:41:27', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954478521397301250, 1954076247092981761, '123', '|', 1, '2025-08-10 17:42:47', '2025-08-10 17:42:46', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954494428077117441, 1954076247092981761, '456789', '德佑地产(富春山居店)|113.425965|23.18392', 1, '2025-08-10 18:45:59', '2025-08-10 18:45:59', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954497837584896002, 1954076247092981761, '456', '|', 1, '2025-08-10 18:59:32', '2025-08-10 18:59:32', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954500689132802050, 1954076247092981761, '看下更新不', '|', 1, '2025-08-10 19:10:52', '2025-08-10 19:10:51', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954501004498325506, 1954076247092981761, '怎么跑到最下面了', '|', 1, '2025-08-10 19:12:07', '2025-08-10 19:12:07', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954502208779472897, 1954076247092981761, '看下在最上面没有', '|', 1, '2025-08-10 19:16:54', '2025-08-10 19:16:54', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954504294309056513, 1954076247092981761, '最新的在最上面', '|', 1, '2025-08-10 19:25:11', '2025-08-10 19:25:11', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954504841061748738, 1954076247092981761, '继续继续', '|', 1, '2025-08-10 19:27:22', '2025-08-10 19:27:21', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954504900574728193, 1954076247092981761, '看到来了', '|', 1, '2025-08-10 19:27:36', '2025-08-10 19:27:36', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954538181437485058, 1954076247092981761, '先发一条再点赞', '|', 1, '2025-08-10 21:39:51', '2025-08-10 21:39:50', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954539322330116097, 1954076247092981761, '再发一条', '|', 1, '2025-08-10 21:44:23', '2025-08-10 21:44:22', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954539759548559361, 1954076247092981761, '第二条', '|', 1, '2025-08-10 21:46:07', '2025-08-10 21:46:07', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954540967784935425, 1954076247092981761, '来，整一条', '|', 1, '2025-08-10 21:50:55', '2025-08-10 21:50:55', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954543760704860162, 1954076247092981761, '88888', '甘雨胡同2号院|116.41673|39.917092', 1, '2025-08-10 22:02:01', '2025-08-10 22:02:00', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954545986500358145, 1954076247092981761, '不行就新发一条咯', '|', 1, '2025-08-10 22:10:52', '2025-08-10 22:10:51', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954550765003800578, 1954076247092981761, '0.0', '|', 1, '2025-08-10 22:29:51', '2025-08-10 22:29:50', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954554581828829186, 1954076247092981761, '发条新信息', '甘雨社区服务站|116.416929|39.916961', 1, '2025-08-10 22:45:01', '2025-08-10 22:45:00', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954555885967966210, 1954076247092981761, '1236', '|', 1, '2025-08-10 22:50:12', '2025-08-10 22:50:11', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954557122008383489, 1954076247092981761, '看一下有没有离线消息', '|', 1, '2025-08-10 22:55:06', '2025-08-10 22:55:06', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954707346307751938, 1954076247092981761, '离线1', '|', 1, '2025-08-11 08:52:03', '2025-08-11 08:52:02', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954708653651337218, 1954076247092981761, '离线2', '|', 1, '2025-08-11 08:57:14', '2025-08-11 08:57:14', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954708845188423681, 1953400949577977858, '离线3', '|', 1, '2025-08-11 08:58:00', '2025-08-11 08:58:00', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954714385599770625, 1954076247092981761, '1', '|', 1, '2025-08-11 09:20:01', '2025-08-11 09:20:01', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954714557461377026, 1954076247092981761, '2', '|', 1, '2025-08-11 09:20:42', '2025-08-11 09:20:42', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954737752465817601, 1954076247092981761, '698', '|', 1, '2025-08-11 10:52:52', '2025-08-11 10:52:52', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954740739930152961, 1954076247092981761, 'LSDFSD', '|', 1, '2025-08-11 11:04:44', '2025-08-11 11:04:44', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954741914784063489, 1954076247092981761, 'AASBB', '|', 1, '2025-08-11 11:09:24', '2025-08-11 11:09:24', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954742221454798850, 1954076247092981761, 'DDDD', '|', 1, '2025-08-11 11:10:38', '2025-08-11 11:10:37', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954743699271680001, 1954076247092981761, 'AAAA', '|', 1, '2025-08-11 11:16:30', '2025-08-11 11:16:30', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954744754072031234, 1954076247092981761, '5666', '|', 1, '2025-08-11 11:20:41', '2025-08-11 11:20:41', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954744892060438530, 1954076247092981761, '8999', '|', 1, '2025-08-11 11:21:14', '2025-08-11 11:21:14', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954745187461074946, 1954076247092981761, '999', '|', 1, '2025-08-11 11:22:25', '2025-08-11 11:22:24', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954745812668223490, 1954076247092981761, '异步消息', '|', 1, '2025-08-11 11:24:54', '2025-08-11 11:24:53', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954748568690860034, 1954076247092981761, '987', '|', 1, '2025-08-11 11:35:51', '2025-08-11 11:35:50', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954753677252476929, 1954076247092981761, '9876', '|', 1, '2025-08-11 11:56:09', '2025-08-11 11:56:08', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954793494174617602, 1954076247092981761, '123123', '|', 1, '2025-08-11 14:34:22', '2025-08-11 14:34:22', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954794598870409218, 1954076247092981761, '321321', '|', 1, '2025-08-11 14:38:45', '2025-08-11 14:38:45', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954797031814193153, 1954076247092981761, '999', '|', 1, '2025-08-11 14:48:25', '2025-08-11 14:48:25', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954798645971116034, 1954076247092981761, '659', '|', 1, '2025-08-11 14:54:50', '2025-08-11 14:54:50', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954804570295496706, 1954076247092981761, '999', '|', 1, '2025-08-11 15:18:23', '2025-08-11 15:18:22', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954808100758614018, 1954076247092981761, '今天阳光比较好', '指朴轻美甲|113.424674|23.184423', 1, '2025-08-11 15:32:24', '2025-08-11 15:32:24', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954827543240601601, 1954076247092981761, '今天太阳不错，上山转转', '中国邮政(行政中心邮政支局)|102.834527|24.877759', 1, '2025-08-11 16:49:40', '2025-08-11 16:49:39', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954835559533117442, 1954076247092981761, '今天阳光不错，上山转转', '德佑地产(富春山居店)|113.425965|23.18392', 1, '2025-08-11 17:21:31', '2025-08-11 17:21:31', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954877300747399169, 1953400949577977858, '大家一起来看看', '|', 1, '2025-08-11 20:07:23', '2025-08-11 20:07:23', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954879044785139713, 1953400949577977858, '自己发一条看看', '|', 1, '2025-08-11 20:14:19', '2025-08-11 20:14:18', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954889323120029697, 1954024510055346177, '先发一个看下', '|', 1, '2025-08-11 20:55:09', '2025-08-11 20:55:09', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954891948854616065, 1954024510055346177, '发条朋友圈给自己看', '|', 1, '2025-08-11 21:05:35', '2025-08-11 21:05:35', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954892983312588801, 1953400949577977858, '我也发一条给自己', '|', 1, '2025-08-11 21:09:42', '2025-08-11 21:09:42', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954900031731408897, 1954024510055346177, '123456', '|', 1, '2025-08-11 21:37:43', '2025-08-11 21:37:42', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954904355853320193, 1954024510055346177, '9987', '新亿美食城|116.417529|39.917277', 1, '2025-08-11 21:54:53', '2025-08-11 21:54:53', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954906623495389185, 1954024510055346177, '3321', '|', 1, '2025-08-11 22:03:54', '2025-08-11 22:03:54', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954913032039579649, 1953400949577977858, '222', '|', 1, '2025-08-11 22:29:22', '2025-08-11 22:29:22', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954913858632044545, 1953400949577977858, '666', '|', 1, '2025-08-11 22:32:39', '2025-08-11 22:32:39', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954914423663513602, 1953400949577977858, '333', '|', 1, '2025-08-11 22:34:54', '2025-08-11 22:34:53', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954914842125029378, 1954024510055346177, '369', '|', 1, '2025-08-11 22:36:34', '2025-08-11 22:36:33', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954916174118539265, 1954024510055346177, '123456', '|', 1, '2025-08-11 22:41:51', '2025-08-11 22:41:51', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954916783471218689, 1954024510055346177, '99963', '|', 1, '2025-08-11 22:44:16', '2025-08-11 22:44:16', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954917675855532034, 1954024510055346177, '444', '|', 1, '2025-08-11 22:47:49', '2025-08-11 22:47:49', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954918003770413058, 1954024510055346177, '321', '|', 1, '2025-08-11 22:49:07', '2025-08-11 22:49:07', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954918121974288386, 1954024510055346177, '112', '|', 1, '2025-08-11 22:49:36', '2025-08-11 22:49:35', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954919879534465025, 1954024510055346177, '996', '|', 1, '2025-08-11 22:56:35', '2025-08-11 22:56:34', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954920269021728769, 1954024510055346177, '3724', '|', 1, '2025-08-11 22:58:07', '2025-08-11 22:58:07', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954920873211219970, 1954024510055346177, '113114', '|', 1, '2025-08-11 23:00:32', '2025-08-11 23:00:31', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954921110503968770, 1954024510055346177, 'kiss', '|', 1, '2025-08-11 23:01:28', '2025-08-11 23:01:28', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954921495905980417, 1954024510055346177, '886', '|', 1, '2025-08-11 23:03:00', '2025-08-11 23:03:00', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954921587413110785, 1954024510055346177, '456987', '|', 1, '2025-08-11 23:03:22', '2025-08-11 23:03:21', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954921636750708737, 1954024510055346177, '369', '|', 1, '2025-08-11 23:03:34', '2025-08-11 23:03:33', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954922074048843778, 1954024510055346177, '369', '|', 1, '2025-08-11 23:05:18', '2025-08-11 23:05:17', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954922112393170945, 1954024510055346177, '789', '|', 1, '2025-08-11 23:05:27', '2025-08-11 23:05:26', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954922139765198849, 1954024510055346177, '332', '|', 1, '2025-08-11 23:05:33', '2025-08-11 23:05:33', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954922479893893122, 1954024510055346177, '558', '|', 1, '2025-08-11 23:06:55', '2025-08-11 23:06:54', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954922757082861570, 1954024510055346177, '333', '|', 1, '2025-08-11 23:08:01', '2025-08-11 23:08:00', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954922916445442050, 1954024510055346177, '333', '|', 1, '2025-08-11 23:08:39', '2025-08-11 23:08:38', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954923030375321602, 1953400949577977858, '息事宁人', '|', 1, '2025-08-11 23:09:06', '2025-08-11 23:09:05', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954923192573251585, 1954024510055346177, '1245', '|', 1, '2025-08-11 23:09:44', '2025-08-11 23:09:44', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954928721995522050, 1954024510055346177, '32', '|', 1, '2025-08-11 23:31:43', '2025-08-11 23:31:42', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954929359965937666, 1954024510055346177, '2365', '|', 1, '2025-08-11 23:34:15', '2025-08-11 23:34:14', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954930060569894914, 1954024510055346177, '699', '|', 1, '2025-08-11 23:37:02', '2025-08-11 23:37:01', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954930549017567234, 1954024510055346177, '发个离线朋友圈', '|', 1, '2025-08-11 23:38:58', '2025-08-11 23:38:58', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954944520877555713, 1954024510055346177, '继续高线', '甘雨胡同2号院|116.41673|39.917092', 1, '2025-08-12 00:34:30', '2025-08-12 00:34:29', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954946721565949954, 1954024510055346177, '321321', '|', 1, '2025-08-12 00:43:14', '2025-08-12 00:43:14', 0, NULL);
INSERT INTO `friend_moments` VALUES (1954949003233771521, 1954024510055346177, '离线开始工作了', '|', 1, '2025-08-12 00:52:18', '2025-08-12 00:52:18', 0, NULL);
INSERT INTO `friend_moments` VALUES (1955102034533380097, 1954024510055346177, '哈哈哈', '|', 1, '2025-08-12 11:00:24', '2025-08-12 11:00:23', 0, NULL);
INSERT INTO `friend_moments` VALUES (1955137160185225218, 1953400949577977858, '123', '|', 3, '2025-08-12 13:19:58', '2025-08-12 13:19:58', 0, NULL);
INSERT INTO `friend_moments` VALUES (1955162575905865730, 1953400949577977858, '只给你一个人看', '|', 3, '2025-08-12 15:00:58', '2025-08-12 15:00:57', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955165952463196162, 1953400949577977858, '只给一个人看', '|', 3, '2025-08-12 15:14:23', '2025-08-12 15:14:23', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955170258985803778, 1953400949577977858, '只给一个人看', '|', 3, '2025-08-12 15:31:30', '2025-08-12 15:31:29', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955172835282513922, 1953400949577977858, '再给你看一个不一样的', '|', 3, '2025-08-12 15:41:44', '2025-08-12 15:41:43', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955175121387913218, 1953400949577977858, '给2个人看', '|', 3, '2025-08-12 15:50:49', '2025-08-12 15:50:48', 0, '[\"1954024510055346177\",\"1954042044259332098\"]');
INSERT INTO `friend_moments` VALUES (1955175958189314050, 1953400949577977858, '22', '西堂子胡同1号院|116.417016|39.91663', 3, '2025-08-12 15:54:08', '2025-08-12 15:54:08', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955176813156245505, 1953400949577977858, '22222', '甘雨社区服务站|116.416929|39.916961', 3, '2025-08-12 15:57:32', '2025-08-12 15:57:32', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955178472720707585, 1953400949577977858, '发个就你看不到的', '|', 4, '2025-08-12 16:04:08', '2025-08-12 16:04:07', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955179177799991298, 1953400949577977858, '发个就你看不到的', '|', 4, '2025-08-12 16:06:56', '2025-08-12 16:06:56', 0, '[\"1954024510055346177\"]');
INSERT INTO `friend_moments` VALUES (1955191242262466562, 1954024510055346177, '我也不给你看', '|', 4, '2025-08-12 16:54:53', '2025-08-12 16:54:52', 0, '[\"1953400949577977858\"]');
INSERT INTO `friend_moments` VALUES (1955191342523109378, 1954024510055346177, '我只给你看', '|', 3, '2025-08-12 16:55:16', '2025-08-12 16:55:16', 0, '[\"1953400949577977858\"]');
INSERT INTO `friend_moments` VALUES (1955223076362928129, 1953400949577977858, '发不了朋友圈了？', '|', 1, '2025-08-12 19:01:22', '2025-08-12 19:01:22', 0, '[]');
INSERT INTO `friend_moments` VALUES (1955280625602809858, 1954024510055346177, '只给自己看', '|', 1, '2025-08-12 22:50:03', '2025-08-12 22:50:03', 0, '[]');
INSERT INTO `friend_moments` VALUES (1955280754632183810, 1954024510055346177, '只给自己看，你们看不到', '|', 2, '2025-08-12 22:50:34', '2025-08-12 22:50:33', 0, '[]');
INSERT INTO `friend_moments` VALUES (1955280834282016769, 1954024510055346177, '只给你看', '|', 3, '2025-08-12 22:50:53', '2025-08-12 22:50:52', 0, '[\"1953400949577977858\"]');
INSERT INTO `friend_moments` VALUES (1955280891240665089, 1954024510055346177, '就不给你看', '|', 4, '2025-08-12 22:51:06', '2025-08-12 22:51:06', 0, '[\"1953400949577977858\"]');

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
INSERT INTO `qrtz_scheduler_state` VALUES ('AppScheduler', '10-30-18-41754988071188', 1755010535925, 15000);
INSERT INTO `qrtz_scheduler_state` VALUES ('AppScheduler', 'DESKTOP-PSRFMEG1755010157988', 1755010538215, 15000);

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
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799001', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799001', 'DEFAULT', NULL, 1755010800000, 1755010500000, 5, 'WAITING', 'CRON', 1755010160000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799002', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799002', 'DEFAULT', NULL, 1755025200000, -1, 5, 'WAITING', 'CRON', 1755010161000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799003', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799003', 'DEFAULT', NULL, 1755010800000, 1755010200000, 5, 'WAITING', 'CRON', 1755010162000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799004', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799004', 'DEFAULT', NULL, 1755032400000, -1, 5, 'WAITING', 'CRON', 1755010162000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AppScheduler', 'TASK_CLASS_NAME1793574396027799005', 'DEFAULT', 'TASK_CLASS_NAME1793574396027799005', 'DEFAULT', NULL, 1755010800000, 1755010500000, 5, 'WAITING', 'CRON', 1755010163000, 0, NULL, 2, '');

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
INSERT INTO `quartz_log` VALUES (1953394433982558210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 17:55:00');
INSERT INTO `quartz_log` VALUES (1953394436209737729, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-07 17:55:01');
INSERT INTO `quartz_log` VALUES (1953395692273758210, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-07 18:00:00');
INSERT INTO `quartz_log` VALUES (1953395693993422850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 18:00:00');
INSERT INTO `quartz_log` VALUES (1953395694500937729, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-07 18:00:01');
INSERT INTO `quartz_log` VALUES (1953396950548180993, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 18:05:00');
INSERT INTO `quartz_log` VALUES (1953396952800526337, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-07 18:05:01');
INSERT INTO `quartz_log` VALUES (1953398208877129730, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-07 18:10:00');
INSERT INTO `quartz_log` VALUES (1953398210756177921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 18:10:00');
INSERT INTO `quartz_log` VALUES (1953398211041394689, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-07 18:10:01');
INSERT INTO `quartz_log` VALUES (1953399467155746817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 18:15:00');
INSERT INTO `quartz_log` VALUES (1953399469567479809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：75毫秒', 'Y', '2025-08-07 18:15:01');
INSERT INTO `quartz_log` VALUES (1953400725463724033, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 18:20:00');
INSERT INTO `quartz_log` VALUES (1953400727644762113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 18:20:01');
INSERT INTO `quartz_log` VALUES (1953400728286498817, '钱包任务', 'walletTaskService.task()', '总共耗时：90毫秒', 'Y', '2025-08-07 18:20:01');
INSERT INTO `quartz_log` VALUES (1953401983742341122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 18:25:00');
INSERT INTO `quartz_log` VALUES (1953401986019856385, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 18:25:01');
INSERT INTO `quartz_log` VALUES (1953403242041929730, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 18:30:00');
INSERT INTO `quartz_log` VALUES (1953403244734672897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 18:30:01');
INSERT INTO `quartz_log` VALUES (1953403245330272257, '用户解封', 'chatTaskService.banned()', '总共耗时：87毫秒', 'Y', '2025-08-07 18:30:01');
INSERT INTO `quartz_log` VALUES (1953404500303769601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 18:35:00');
INSERT INTO `quartz_log` VALUES (1953404502606450689, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 18:35:01');
INSERT INTO `quartz_log` VALUES (1953405758603358210, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-07 18:40:00');
INSERT INTO `quartz_log` VALUES (1953405760335605761, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-07 18:40:00');
INSERT INTO `quartz_log` VALUES (1953405760872484865, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-07 18:40:01');
INSERT INTO `quartz_log` VALUES (1953407016881975297, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 18:45:00');
INSERT INTO `quartz_log` VALUES (1953407019247570946, '钱包补偿', 'walletReceiveService.task()', '总共耗时：35毫秒', 'Y', '2025-08-07 18:45:01');
INSERT INTO `quartz_log` VALUES (1953408275198341122, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 18:50:00');
INSERT INTO `quartz_log` VALUES (1953408277173858305, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 18:50:01');
INSERT INTO `quartz_log` VALUES (1953408277610074113, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-07 18:50:01');
INSERT INTO `quartz_log` VALUES (1953409533502124033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 18:55:00');
INSERT INTO `quartz_log` VALUES (1953409535934828546, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-07 18:55:01');
INSERT INTO `quartz_log` VALUES (1953410791789129729, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 19:00:00');
INSERT INTO `quartz_log` VALUES (1953410793492017153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 19:00:00');
INSERT INTO `quartz_log` VALUES (1953410794070839298, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-07 19:00:01');
INSERT INTO `quartz_log` VALUES (1953412050076135426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 19:05:00');
INSERT INTO `quartz_log` VALUES (1953412052374622209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-07 19:05:01');
INSERT INTO `quartz_log` VALUES (1953413308375724033, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 19:10:00');
INSERT INTO `quartz_log` VALUES (1953413308719656962, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 19:10:00');
INSERT INTO `quartz_log` VALUES (1953413309021646849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 19:10:00');
INSERT INTO `quartz_log` VALUES (1953414566641758210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 19:15:00');
INSERT INTO `quartz_log` VALUES (1953414566964719618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 19:15:00');
INSERT INTO `quartz_log` VALUES (1953415824941346818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 19:20:00');
INSERT INTO `quartz_log` VALUES (1953415825293668353, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 19:20:00');
INSERT INTO `quartz_log` VALUES (1953415825599852546, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 19:20:00');
INSERT INTO `quartz_log` VALUES (1953417083194798082, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 19:25:00');
INSERT INTO `quartz_log` VALUES (1953417083610034177, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 19:25:00');
INSERT INTO `quartz_log` VALUES (1953418341540524034, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 19:30:00');
INSERT INTO `quartz_log` VALUES (1953418343339880450, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 19:30:00');
INSERT INTO `quartz_log` VALUES (1953418344401051649, '用户解封', 'chatTaskService.banned()', '总共耗时：170毫秒', 'Y', '2025-08-07 19:30:01');
INSERT INTO `quartz_log` VALUES (1953419599814946818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 19:35:00');
INSERT INTO `quartz_log` VALUES (1953419602461573122, '钱包任务', 'walletTaskService.task()', '总共耗时：78毫秒', 'Y', '2025-08-07 19:35:01');
INSERT INTO `quartz_log` VALUES (1953420864431181826, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-07 19:40:01');
INSERT INTO `quartz_log` VALUES (1953422116414124034, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 19:45:00');
INSERT INTO `quartz_log` VALUES (1953422116623839233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 19:45:00');
INSERT INTO `quartz_log` VALUES (1953423376366268418, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-07 19:50:00');
INSERT INTO `quartz_log` VALUES (1953423376613732353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 19:50:00');
INSERT INTO `quartz_log` VALUES (1953423378069184514, '钱包任务', 'walletTaskService.task()', '总共耗时：291毫秒', 'Y', '2025-08-07 19:50:01');
INSERT INTO `quartz_log` VALUES (1953424634670051329, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 19:55:00');
INSERT INTO `quartz_log` VALUES (1953424635437641729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：74毫秒', 'Y', '2025-08-07 19:55:01');
INSERT INTO `quartz_log` VALUES (1953425892873170945, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-07 20:00:00');
INSERT INTO `quartz_log` VALUES (1953425893091274753, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 20:00:00');
INSERT INTO `quartz_log` VALUES (1953425893758210050, '钱包任务', 'walletTaskService.task()', '总共耗时：88毫秒', 'Y', '2025-08-07 20:00:01');
INSERT INTO `quartz_log` VALUES (1953427151353114626, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 20:05:00');
INSERT INTO `quartz_log` VALUES (1953427152066187266, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-07 20:05:01');
INSERT INTO `quartz_log` VALUES (1953428409333936130, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 20:10:00');
INSERT INTO `quartz_log` VALUES (1953428409556234241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 20:10:00');
INSERT INTO `quartz_log` VALUES (1953428410088960001, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-07 20:10:00');
INSERT INTO `quartz_log` VALUES (1953429667629330433, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 20:15:00');
INSERT INTO `quartz_log` VALUES (1953429668292079618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：75毫秒', 'Y', '2025-08-07 20:15:00');
INSERT INTO `quartz_log` VALUES (1953430924465106946, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-07 20:20:00');
INSERT INTO `quartz_log` VALUES (1953430926449012738, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 20:20:01');
INSERT INTO `quartz_log` VALUES (1953430927086596098, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-07 20:20:01');
INSERT INTO `quartz_log` VALUES (1953432184257867777, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 20:25:00');
INSERT INTO `quartz_log` VALUES (1953432184866091009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-07 20:25:00');
INSERT INTO `quartz_log` VALUES (1953433441005563905, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 20:30:00');
INSERT INTO `quartz_log` VALUES (1953433442691674113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 20:30:00');
INSERT INTO `quartz_log` VALUES (1953433443308285953, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-07 20:30:01');
INSERT INTO `quartz_log` VALUES (1953434699246432257, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 20:35:00');
INSERT INTO `quartz_log` VALUES (1953434702169915393, '钱包任务', 'walletTaskService.task()', '总共耗时：92毫秒', 'Y', '2025-08-07 20:35:01');
INSERT INTO `quartz_log` VALUES (1953435957587963905, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-07 20:40:00');
INSERT INTO `quartz_log` VALUES (1953435959353765889, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 20:40:00');
INSERT INTO `quartz_log` VALUES (1953435960247209986, '钱包任务', 'walletTaskService.task()', '总共耗时：87毫秒', 'Y', '2025-08-07 20:40:01');
INSERT INTO `quartz_log` VALUES (1953437215992410114, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 20:45:00');
INSERT INTO `quartz_log` VALUES (1953437218769104897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：80毫秒', 'Y', '2025-08-07 20:45:01');
INSERT INTO `quartz_log` VALUES (1953438474229084161, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 20:50:00');
INSERT INTO `quartz_log` VALUES (1953438474656903169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 20:50:00');
INSERT INTO `quartz_log` VALUES (1953438478343766018, '用户解封', 'chatTaskService.banned()', '总共耗时：205毫秒', 'Y', '2025-08-07 20:50:01');
INSERT INTO `quartz_log` VALUES (1953439734491607041, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 20:55:01');
INSERT INTO `quartz_log` VALUES (1953439735754162177, '钱包补偿', 'walletReceiveService.task()', '总共耗时：126毫秒', 'Y', '2025-08-07 20:55:01');
INSERT INTO `quartz_log` VALUES (1953440992287879169, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 21:00:00');
INSERT INTO `quartz_log` VALUES (1953440992547926017, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 21:00:00');
INSERT INTO `quartz_log` VALUES (1953440993000980481, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-07 21:00:01');
INSERT INTO `quartz_log` VALUES (1953442249056546818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 21:05:00');
INSERT INTO `quartz_log` VALUES (1953442254156890114, '钱包任务', 'walletTaskService.task()', '总共耗时：99毫秒', 'Y', '2025-08-07 21:05:01');
INSERT INTO `quartz_log` VALUES (1953443508782198785, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 21:10:00');
INSERT INTO `quartz_log` VALUES (1953443509004496897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 21:10:00');
INSERT INTO `quartz_log` VALUES (1953443509499494402, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-07 21:10:00');
INSERT INTO `quartz_log` VALUES (1953444767169867778, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 21:15:00');
INSERT INTO `quartz_log` VALUES (1953444767912329217, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-07 21:15:01');
INSERT INTO `quartz_log` VALUES (1953446025612062722, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 21:20:00');
INSERT INTO `quartz_log` VALUES (1953446025935024130, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 21:20:01');
INSERT INTO `quartz_log` VALUES (1953446026375495681, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-07 21:20:01');
INSERT INTO `quartz_log` VALUES (1953447283785822209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 21:25:00');
INSERT INTO `quartz_log` VALUES (1953447284612169729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-07 21:25:01');
INSERT INTO `quartz_log` VALUES (1953448542282543106, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 21:30:00');
INSERT INTO `quartz_log` VALUES (1953448542492258306, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 21:30:01');
INSERT INTO `quartz_log` VALUES (1953448543066947585, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-07 21:30:01');
INSERT INTO `quartz_log` VALUES (1953449800326279169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 21:35:00');
INSERT INTO `quartz_log` VALUES (1953449801110683650, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-07 21:35:01');
INSERT INTO `quartz_log` VALUES (1953451057073975298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 21:40:00');
INSERT INTO `quartz_log` VALUES (1953451057375965185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 21:40:00');
INSERT INTO `quartz_log` VALUES (1953451061817802753, '用户解封', 'chatTaskService.banned()', '总共耗时：106毫秒', 'Y', '2025-08-07 21:40:01');
INSERT INTO `quartz_log` VALUES (1953452316975788034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-07 21:45:00');
INSERT INTO `quartz_log` VALUES (1953452318024433665, '钱包任务', 'walletTaskService.task()', '总共耗时：122毫秒', 'Y', '2025-08-07 21:45:01');
INSERT INTO `quartz_log` VALUES (1953453575371845634, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-07 21:50:00');
INSERT INTO `quartz_log` VALUES (1953453575573172225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 21:50:00');
INSERT INTO `quartz_log` VALUES (1953453576152055810, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-07 21:50:01');
INSERT INTO `quartz_log` VALUES (1953454833625296898, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 21:55:00');
INSERT INTO `quartz_log` VALUES (1953454834397118465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：69毫秒', 'Y', '2025-08-07 21:55:01');
INSERT INTO `quartz_log` VALUES (1953456091962634241, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:00:00');
INSERT INTO `quartz_log` VALUES (1953456092293984258, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:00:01');
INSERT INTO `quartz_log` VALUES (1953456092797370369, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-07 22:00:01');
INSERT INTO `quartz_log` VALUES (1953457348529975298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 22:05:00');
INSERT INTO `quartz_log` VALUES (1953457353609347074, '钱包任务', 'walletTaskService.task()', '总共耗时：128毫秒', 'Y', '2025-08-07 22:05:01');
INSERT INTO `quartz_log` VALUES (1953458608322736130, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-07 22:10:00');
INSERT INTO `quartz_log` VALUES (1953458608524062722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 22:10:00');
INSERT INTO `quartz_log` VALUES (1953458609073586178, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-07 22:10:01');
INSERT INTO `quartz_log` VALUES (1953459866630713345, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 22:15:00');
INSERT INTO `quartz_log` VALUES (1953459867482226690, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-07 22:15:01');
INSERT INTO `quartz_log` VALUES (1953461125303595009, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 22:20:00');
INSERT INTO `quartz_log` VALUES (1953461125601390594, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 22:20:01');
INSERT INTO `quartz_log` VALUES (1953461126117359617, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-07 22:20:01');
INSERT INTO `quartz_log` VALUES (1953462383276027906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:25:00');
INSERT INTO `quartz_log` VALUES (1953462384110764034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-07 22:25:01');
INSERT INTO `quartz_log` VALUES (1953463641491730434, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 22:30:00');
INSERT INTO `quartz_log` VALUES (1953463641718222849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 22:30:00');
INSERT INTO `quartz_log` VALUES (1953463642284523522, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-07 22:30:01');
INSERT INTO `quartz_log` VALUES (1953464899770347522, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 22:35:00');
INSERT INTO `quartz_log` VALUES (1953464900546363394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-07 22:35:01');
INSERT INTO `quartz_log` VALUES (1953466158216736769, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:40:00');
INSERT INTO `quartz_log` VALUES (1953466158556475393, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:40:01');
INSERT INTO `quartz_log` VALUES (1953466159122776066, '用户解封', 'chatTaskService.banned()', '总共耗时：84毫秒', 'Y', '2025-08-07 22:40:01');
INSERT INTO `quartz_log` VALUES (1953467416197558273, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:45:00');
INSERT INTO `quartz_log` VALUES (1953467417061654530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：74毫秒', 'Y', '2025-08-07 22:45:00');
INSERT INTO `quartz_log` VALUES (1953468674878828545, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-07 22:50:00');
INSERT INTO `quartz_log` VALUES (1953468675096932353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 22:50:00');
INSERT INTO `quartz_log` VALUES (1953468675738730498, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-07 22:50:01');
INSERT INTO `quartz_log` VALUES (1953469933023227906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 22:55:00');
INSERT INTO `quartz_log` VALUES (1953469933929267202, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-07 22:55:01');
INSERT INTO `quartz_log` VALUES (1953471191163432961, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 23:00:00');
INSERT INTO `quartz_log` VALUES (1953471191377342465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 23:00:00');
INSERT INTO `quartz_log` VALUES (1953471192052695041, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-07 23:00:01');
INSERT INTO `quartz_log` VALUES (1953472449643376642, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 23:05:00');
INSERT INTO `quartz_log` VALUES (1953472450524250113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-07 23:05:01');
INSERT INTO `quartz_log` VALUES (1953473707980713985, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 23:10:00');
INSERT INTO `quartz_log` VALUES (1953473708161069057, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 23:10:00');
INSERT INTO `quartz_log` VALUES (1953473708840615938, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-07 23:10:01');
INSERT INTO `quartz_log` VALUES (1953474966058004482, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 23:15:00');
INSERT INTO `quartz_log` VALUES (1953474966972432386, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-07 23:15:01');
INSERT INTO `quartz_log` VALUES (1953476224319844354, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-07 23:20:00');
INSERT INTO `quartz_log` VALUES (1953476224663777282, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 23:20:00');
INSERT INTO `quartz_log` VALUES (1953476225259438081, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-07 23:20:01');
INSERT INTO `quartz_log` VALUES (1953477482497798146, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 23:25:00');
INSERT INTO `quartz_log` VALUES (1953477483311562754, '钱包任务', 'walletTaskService.task()', '总共耗时：38毫秒', 'Y', '2025-08-07 23:25:00');
INSERT INTO `quartz_log` VALUES (1953478740788998145, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 23:30:00');
INSERT INTO `quartz_log` VALUES (1953478741082599426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 23:30:00');
INSERT INTO `quartz_log` VALUES (1953478741720203265, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-07 23:30:00');
INSERT INTO `quartz_log` VALUES (1953479998954369026, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 23:35:00');
INSERT INTO `quartz_log` VALUES (1953479999872991233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-07 23:35:00');
INSERT INTO `quartz_log` VALUES (1953481257283317762, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-07 23:40:00');
INSERT INTO `quartz_log` VALUES (1953481257585307649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-07 23:40:00');
INSERT INTO `quartz_log` VALUES (1953481258189357057, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-07 23:40:00');
INSERT INTO `quartz_log` VALUES (1953482515733901314, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-07 23:45:00');
INSERT INTO `quartz_log` VALUES (1953482516618969089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-07 23:45:01');
INSERT INTO `quartz_log` VALUES (1953483773983158273, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-07 23:50:00');
INSERT INTO `quartz_log` VALUES (1953483774280953858, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-07 23:50:00');
INSERT INTO `quartz_log` VALUES (1953483774939529217, '用户解封', 'chatTaskService.banned()', '总共耗时：74毫秒', 'Y', '2025-08-07 23:50:01');
INSERT INTO `quartz_log` VALUES (1953485032274358273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-07 23:55:00');
INSERT INTO `quartz_log` VALUES (1953485033155231745, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-07 23:55:01');
INSERT INTO `quartz_log` VALUES (1953486289261129730, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 00:00:00');
INSERT INTO `quartz_log` VALUES (1953486289525370882, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 00:00:00');
INSERT INTO `quartz_log` VALUES (1953486289844137985, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 00:00:00');
INSERT INTO `quartz_log` VALUES (1953487549041307649, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 00:05:00');
INSERT INTO `quartz_log` VALUES (1953487550370971649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：162毫秒', 'Y', '2025-08-08 00:05:01');
INSERT INTO `quartz_log` VALUES (1953488807059877889, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 00:10:00');
INSERT INTO `quartz_log` VALUES (1953488807269593089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 00:10:00');
INSERT INTO `quartz_log` VALUES (1953488807940751362, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-08 00:10:00');
INSERT INTO `quartz_log` VALUES (1953490065665650690, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 00:15:00');
INSERT INTO `quartz_log` VALUES (1953490066609438721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 00:15:01');
INSERT INTO `quartz_log` VALUES (1953491323914907649, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 00:20:00');
INSERT INTO `quartz_log` VALUES (1953491324221091841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 00:20:00');
INSERT INTO `quartz_log` VALUES (1953491324879667202, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-08 00:20:01');
INSERT INTO `quartz_log` VALUES (1953492582210301953, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 00:25:00');
INSERT INTO `quartz_log` VALUES (1953492583145701377, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-08 00:25:01');
INSERT INTO `quartz_log` VALUES (1953493840505696258, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 00:30:00');
INSERT INTO `quartz_log` VALUES (1953493840841240578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 00:30:00');
INSERT INTO `quartz_log` VALUES (1953493841453678594, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-08 00:30:01');
INSERT INTO `quartz_log` VALUES (1953495098658484225, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 00:35:00');
INSERT INTO `quartz_log` VALUES (1953495099598077953, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-08 00:35:01');
INSERT INTO `quartz_log` VALUES (1953496357020987393, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 00:40:00');
INSERT INTO `quartz_log` VALUES (1953496357247479809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 00:40:00');
INSERT INTO `quartz_log` VALUES (1953496358338068482, '钱包任务', 'walletTaskService.task()', '总共耗时：153毫秒', 'Y', '2025-08-08 00:40:01');
INSERT INTO `quartz_log` VALUES (1953497615136026625, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 00:45:00');
INSERT INTO `quartz_log` VALUES (1953497616113369089, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-08 00:45:01');
INSERT INTO `quartz_log` VALUES (1953498873536278529, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 00:50:00');
INSERT INTO `quartz_log` VALUES (1953498873737605122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 00:50:00');
INSERT INTO `quartz_log` VALUES (1953498874475872258, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 00:50:01');
INSERT INTO `quartz_log` VALUES (1953500131814895618, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 00:55:00');
INSERT INTO `quartz_log` VALUES (1953500132758683649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-08 00:55:01');
INSERT INTO `quartz_log` VALUES (1953501389950906369, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 01:00:00');
INSERT INTO `quartz_log` VALUES (1953501390286450690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 01:00:00');
INSERT INTO `quartz_log` VALUES (1953501390894694402, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-08 01:00:00');
INSERT INTO `quartz_log` VALUES (1953502648271466497, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 01:05:00');
INSERT INTO `quartz_log` VALUES (1953502649181700098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 01:05:00');
INSERT INTO `quartz_log` VALUES (1953503906587832321, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 01:10:00');
INSERT INTO `quartz_log` VALUES (1953503906797547521, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 01:10:00');
INSERT INTO `quartz_log` VALUES (1953503907661643778, '钱包任务', 'walletTaskService.task()', '总共耗时：78毫秒', 'Y', '2025-08-08 01:10:01');
INSERT INTO `quartz_log` VALUES (1953505165088747522, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 01:15:00');
INSERT INTO `quartz_log` VALUES (1953505166045118466, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-08 01:15:01');
INSERT INTO `quartz_log` VALUES (1953506423413501953, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 01:20:00');
INSERT INTO `quartz_log` VALUES (1953506423610634241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 01:20:00');
INSERT INTO `quartz_log` VALUES (1953506424327929857, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-08 01:20:01');
INSERT INTO `quartz_log` VALUES (1953507680177975298, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 01:25:00');
INSERT INTO `quartz_log` VALUES (1953507680433827841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 01:25:00');
INSERT INTO `quartz_log` VALUES (1953508940184645633, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 01:30:00');
INSERT INTO `quartz_log` VALUES (1953508940478246913, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 01:30:01');
INSERT INTO `quartz_log` VALUES (1953508940977438722, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-08 01:30:01');
INSERT INTO `quartz_log` VALUES (1953510199121838081, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 01:35:01');
INSERT INTO `quartz_log` VALUES (1953510203169341442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 01:35:01');
INSERT INTO `quartz_log` VALUES (1953511456699936770, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 01:40:00');
INSERT INTO `quartz_log` VALUES (1953511456926429186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 01:40:00');
INSERT INTO `quartz_log` VALUES (1953511457438203906, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 01:40:01');
INSERT INTO `quartz_log` VALUES (1953512713359552513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 01:45:00');
INSERT INTO `quartz_log` VALUES (1953512715989450754, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 01:45:01');
INSERT INTO `quartz_log` VALUES (1953513973445914626, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-08 01:50:00');
INSERT INTO `quartz_log` VALUES (1953513973697572865, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 01:50:01');
INSERT INTO `quartz_log` VALUES (1953513974121267202, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-08 01:50:01');
INSERT INTO `quartz_log` VALUES (1953515231573536770, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 01:55:00');
INSERT INTO `quartz_log` VALUES (1953515232232112129, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 01:55:01');
INSERT INTO `quartz_log` VALUES (1953516488237346818, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 02:00:00');
INSERT INTO `quartz_log` VALUES (1953516490204475393, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 02:00:01');
INSERT INTO `quartz_log` VALUES (1953516490766581762, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-08 02:00:01');
INSERT INTO `quartz_log` VALUES (1953517746515963906, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 02:05:00');
INSERT INTO `quartz_log` VALUES (1953517749007450114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 02:05:01');
INSERT INTO `quartz_log` VALUES (1953519004807163906, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 02:10:00');
INSERT INTO `quartz_log` VALUES (1953519006791069698, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 02:10:01');
INSERT INTO `quartz_log` VALUES (1953519007378341890, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-08 02:10:01');
INSERT INTO `quartz_log` VALUES (1953520263089975298, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 02:15:00');
INSERT INTO `quartz_log` VALUES (1953520265480798210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 02:15:01');
INSERT INTO `quartz_log` VALUES (1953521521397952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 02:20:00');
INSERT INTO `quartz_log` VALUES (1953521523465744386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 02:20:01');
INSERT INTO `quartz_log` VALUES (1953521523948158977, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-08 02:20:01');
INSERT INTO `quartz_log` VALUES (1953522779693346818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 02:25:00');
INSERT INTO `quartz_log` VALUES (1953522782046420994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 02:25:01');
INSERT INTO `quartz_log` VALUES (1953524037976158209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 02:30:00');
INSERT INTO `quartz_log` VALUES (1953524039775514626, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 02:30:00');
INSERT INTO `quartz_log` VALUES (1953524040136294401, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-08 02:30:00');
INSERT INTO `quartz_log` VALUES (1953525296267358210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 02:35:00');
INSERT INTO `quartz_log` VALUES (1953525298582683650, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 02:35:01');
INSERT INTO `quartz_log` VALUES (1953526554562752514, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 02:40:00');
INSERT INTO `quartz_log` VALUES (1953526554743107586, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 02:40:00');
INSERT INTO `quartz_log` VALUES (1953526560153829377, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-08 02:40:01');
INSERT INTO `quartz_log` VALUES (1953527812858146817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 02:45:00');
INSERT INTO `quartz_log` VALUES (1953527815227998209, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-08 02:45:01');
INSERT INTO `quartz_log` VALUES (1953529071124180993, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 02:50:00');
INSERT INTO `quartz_log` VALUES (1953529071367450625, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-08 02:50:00');
INSERT INTO `quartz_log` VALUES (1953529074567774210, '用户解封', 'chatTaskService.banned()', '总共耗时：108毫秒', 'Y', '2025-08-08 02:50:01');
INSERT INTO `quartz_log` VALUES (1953530329440546818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 02:55:00');
INSERT INTO `quartz_log` VALUES (1953530331726512129, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-08 02:55:01');
INSERT INTO `quartz_log` VALUES (1953531587710775297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 03:00:00');
INSERT INTO `quartz_log` VALUES (1953531588025348098, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 03:00:00');
INSERT INTO `quartz_log` VALUES (1953531589778567170, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 03:00:01');
INSERT INTO `quartz_log` VALUES (1953531590751715330, '用户日活', 'chatTaskService.visit()', '总共耗时：228毫秒', 'Y', '2025-08-08 03:00:01');
INSERT INTO `quartz_log` VALUES (1953532846031335425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 03:05:00');
INSERT INTO `quartz_log` VALUES (1953532848300523521, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-08 03:05:01');
INSERT INTO `quartz_log` VALUES (1953534104309952513, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 03:10:00');
INSERT INTO `quartz_log` VALUES (1953534104616136705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 03:10:00');
INSERT INTO `quartz_log` VALUES (1953534106633666562, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-08 03:10:01');
INSERT INTO `quartz_log` VALUES (1953535362601152514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 03:15:00');
INSERT INTO `quartz_log` VALUES (1953535364723539970, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-08 03:15:00');
INSERT INTO `quartz_log` VALUES (1953536620883963905, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 03:20:00');
INSERT INTO `quartz_log` VALUES (1953536621227896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 03:20:00');
INSERT INTO `quartz_log` VALUES (1953536623262203906, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-08 03:20:01');
INSERT INTO `quartz_log` VALUES (1953537879162580993, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 03:25:00');
INSERT INTO `quartz_log` VALUES (1953537881297551361, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 03:25:00');
INSERT INTO `quartz_log` VALUES (1953539137428615170, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 03:30:00');
INSERT INTO `quartz_log` VALUES (1953539137600581633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 03:30:00');
INSERT INTO `quartz_log` VALUES (1953539139647471618, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-08 03:30:00');
INSERT INTO `quartz_log` VALUES (1953540395778535426, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 03:35:00');
INSERT INTO `quartz_log` VALUES (1953540397963837441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：55毫秒', 'Y', '2025-08-08 03:35:01');
INSERT INTO `quartz_log` VALUES (1953541654057152514, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 03:40:00');
INSERT INTO `quartz_log` VALUES (1953541654233313282, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 03:40:00');
INSERT INTO `quartz_log` VALUES (1953541656406032386, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-08 03:40:01');
INSERT INTO `quartz_log` VALUES (1953542912344158209, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 03:45:00');
INSERT INTO `quartz_log` VALUES (1953542914663677953, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-08 03:45:01');
INSERT INTO `quartz_log` VALUES (1953544170618580994, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 03:50:00');
INSERT INTO `quartz_log` VALUES (1953544170824101889, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 03:50:00');
INSERT INTO `quartz_log` VALUES (1953544172975849473, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 03:50:01');
INSERT INTO `quartz_log` VALUES (1953545428934946818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 03:55:00');
INSERT INTO `quartz_log` VALUES (1953545431107665922, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 03:55:00');
INSERT INTO `quartz_log` VALUES (1953546687230341122, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 04:00:00');
INSERT INTO `quartz_log` VALUES (1953546687427473410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 04:00:00');
INSERT INTO `quartz_log` VALUES (1953546689499529218, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 04:00:01');
INSERT INTO `quartz_log` VALUES (1953547945504763905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:05:00');
INSERT INTO `quartz_log` VALUES (1953547947841060866, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-08 04:05:01');
INSERT INTO `quartz_log` VALUES (1953549203783380993, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:10:00');
INSERT INTO `quartz_log` VALUES (1953549204102148098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:10:00');
INSERT INTO `quartz_log` VALUES (1953549205981265922, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-08 04:10:00');
INSERT INTO `quartz_log` VALUES (1953550462074580994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 04:15:00');
INSERT INTO `quartz_log` VALUES (1953550464230522881, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-08 04:15:00');
INSERT INTO `quartz_log` VALUES (1953551720386752513, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 04:20:00');
INSERT INTO `quartz_log` VALUES (1953551720558718977, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:20:00');
INSERT INTO `quartz_log` VALUES (1953551722504945665, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-08 04:20:00');
INSERT INTO `quartz_log` VALUES (1953552978707312641, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 04:25:00');
INSERT INTO `quartz_log` VALUES (1953552980762591233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-08 04:25:00');
INSERT INTO `quartz_log` VALUES (1953554236964958209, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 04:30:00');
INSERT INTO `quartz_log` VALUES (1953554237292113922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:30:00');
INSERT INTO `quartz_log` VALUES (1953554239234146306, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-08 04:30:01');
INSERT INTO `quartz_log` VALUES (1953555495268741121, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 04:35:00');
INSERT INTO `quartz_log` VALUES (1953555497550512129, '钱包补偿', 'walletReceiveService.task()', '总共耗时：55毫秒', 'Y', '2025-08-08 04:35:01');
INSERT INTO `quartz_log` VALUES (1953556753564135426, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 04:40:00');
INSERT INTO `quartz_log` VALUES (1953556753908068354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 04:40:00');
INSERT INTO `quartz_log` VALUES (1953556755883655169, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 04:40:01');
INSERT INTO `quartz_log` VALUES (1953558011855335426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 04:45:00');
INSERT INTO `quartz_log` VALUES (1953558014132912130, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-08 04:45:01');
INSERT INTO `quartz_log` VALUES (1953559270159118337, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:50:00');
INSERT INTO `quartz_log` VALUES (1953559270456913922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 04:50:00');
INSERT INTO `quartz_log` VALUES (1953559272377974786, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-08 04:50:01');
INSERT INTO `quartz_log` VALUES (1953560528412569601, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 04:55:00');
INSERT INTO `quartz_log` VALUES (1953560530635620353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 04:55:01');
INSERT INTO `quartz_log` VALUES (1953561786758295554, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-08 05:00:00');
INSERT INTO `quartz_log` VALUES (1953561787135782914, '群组降级', 'chatTaskService.level()', '总共耗时：40毫秒', 'Y', '2025-08-08 05:00:00');
INSERT INTO `quartz_log` VALUES (1953561788758978561, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 05:00:01');
INSERT INTO `quartz_log` VALUES (1953561788931014658, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-08 05:00:01');
INSERT INTO `quartz_log` VALUES (1953563045011746818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 05:05:00');
INSERT INTO `quartz_log` VALUES (1953563047205437442, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-08 05:05:00');
INSERT INTO `quartz_log` VALUES (1953564303298752513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 05:10:00');
INSERT INTO `quartz_log` VALUES (1953564303596548098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 05:10:00');
INSERT INTO `quartz_log` VALUES (1953564305555357697, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-08 05:10:01');
INSERT INTO `quartz_log` VALUES (1953565561602535425, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 05:15:00');
INSERT INTO `quartz_log` VALUES (1953565563682979841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 05:15:00');
INSERT INTO `quartz_log` VALUES (1953566819876958210, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 05:20:00');
INSERT INTO `quartz_log` VALUES (1953566820074090498, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 05:20:00');
INSERT INTO `quartz_log` VALUES (1953566822070648833, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-08 05:20:00');
INSERT INTO `quartz_log` VALUES (1953568080294739970, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 05:25:00');
INSERT INTO `quartz_log` VALUES (1953568083985727489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 05:25:01');
INSERT INTO `quartz_log` VALUES (1953569336434192386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 05:30:00');
INSERT INTO `quartz_log` VALUES (1953569336736182274, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 05:30:00');
INSERT INTO `quartz_log` VALUES (1953569338598522882, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-08 05:30:00');
INSERT INTO `quartz_log` VALUES (1953570594750558210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 05:35:00');
INSERT INTO `quartz_log` VALUES (1953570596801642497, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-08 05:35:00');
INSERT INTO `quartz_log` VALUES (1953571853066924033, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 05:40:00');
INSERT INTO `quartz_log` VALUES (1953571853272444929, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 05:40:00');
INSERT INTO `quartz_log` VALUES (1953571855369666562, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-08 05:40:01');
INSERT INTO `quartz_log` VALUES (1953573111341346817, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 05:45:00');
INSERT INTO `quartz_log` VALUES (1953573113614729217, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-08 05:45:01');
INSERT INTO `quartz_log` VALUES (1953574369636741121, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 05:50:00');
INSERT INTO `quartz_log` VALUES (1953574369942925313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 05:50:00');
INSERT INTO `quartz_log` VALUES (1953574371918512130, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 05:50:01');
INSERT INTO `quartz_log` VALUES (1953575627911163906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 05:55:00');
INSERT INTO `quartz_log` VALUES (1953575630184546306, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-08 05:55:01');
INSERT INTO `quartz_log` VALUES (1953576886214946818, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 06:00:00');
INSERT INTO `quartz_log` VALUES (1953576886487576577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 06:00:00');
INSERT INTO `quartz_log` VALUES (1953576888471552001, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-08 06:00:01');
INSERT INTO `quartz_log` VALUES (1953578144489369602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 06:05:00');
INSERT INTO `quartz_log` VALUES (1953578146599174145, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 06:05:00');
INSERT INTO `quartz_log` VALUES (1953579402801541122, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 06:10:00');
INSERT INTO `quartz_log` VALUES (1953579403002867714, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 06:10:00');
INSERT INTO `quartz_log` VALUES (1953579404902957057, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 06:10:00');
INSERT INTO `quartz_log` VALUES (1953580661088546818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 06:15:00');
INSERT INTO `quartz_log` VALUES (1953580663655530497, '钱包任务', 'walletTaskService.task()', '总共耗时：157毫秒', 'Y', '2025-08-08 06:15:00');
INSERT INTO `quartz_log` VALUES (1953581919350386689, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 06:20:00');
INSERT INTO `quartz_log` VALUES (1953581919539130369, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 06:20:00');
INSERT INTO `quartz_log` VALUES (1953581921535688706, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-08 06:20:00');
INSERT INTO `quartz_log` VALUES (1953583177654169602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 06:25:00');
INSERT INTO `quartz_log` VALUES (1953583179680088065, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-08 06:25:00');
INSERT INTO `quartz_log` VALUES (1953584435949563906, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 06:30:00');
INSERT INTO `quartz_log` VALUES (1953584436167667713, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 06:30:00');
INSERT INTO `quartz_log` VALUES (1953584438113894401, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-08 06:30:00');
INSERT INTO `quartz_log` VALUES (1953585694253346817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 06:35:00');
INSERT INTO `quartz_log` VALUES (1953585696698695682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：55毫秒', 'Y', '2025-08-08 06:35:01');
INSERT INTO `quartz_log` VALUES (1953586952561324034, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 06:40:00');
INSERT INTO `quartz_log` VALUES (1953586952754262018, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 06:40:00');
INSERT INTO `quartz_log` VALUES (1953586954893426690, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-08 06:40:01');
INSERT INTO `quartz_log` VALUES (1953588210818969601, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 06:45:00');
INSERT INTO `quartz_log` VALUES (1953588213142683650, '钱包补偿', 'walletReceiveService.task()', '总共耗时：52毫秒', 'Y', '2025-08-08 06:45:01');
INSERT INTO `quartz_log` VALUES (1953589469105975297, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 06:50:00');
INSERT INTO `quartz_log` VALUES (1953589469277941761, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 06:50:00');
INSERT INTO `quartz_log` VALUES (1953589471467438081, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 06:50:01');
INSERT INTO `quartz_log` VALUES (1953590727384592385, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 06:55:00');
INSERT INTO `quartz_log` VALUES (1953590729767026690, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 06:55:01');
INSERT INTO `quartz_log` VALUES (1953591985684180994, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:00:00');
INSERT INTO `quartz_log` VALUES (1953591985944227841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:00:00');
INSERT INTO `quartz_log` VALUES (1953591987760431106, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-08 07:00:00');
INSERT INTO `quartz_log` VALUES (1953593243941826561, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 07:05:00');
INSERT INTO `quartz_log` VALUES (1953593246198431746, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 07:05:00');
INSERT INTO `quartz_log` VALUES (1953594502274969601, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 07:10:00');
INSERT INTO `quartz_log` VALUES (1953594502476296194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 07:10:00');
INSERT INTO `quartz_log` VALUES (1953594504518991873, '钱包任务', 'walletTaskService.task()', '总共耗时：80毫秒', 'Y', '2025-08-08 07:10:00');
INSERT INTO `quartz_log` VALUES (1953595760570363906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:15:00');
INSERT INTO `quartz_log` VALUES (1953595762789220353, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-08 07:15:00');
INSERT INTO `quartz_log` VALUES (1953597018861563905, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 07:20:00');
INSERT INTO `quartz_log` VALUES (1953597019054501890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 07:20:00');
INSERT INTO `quartz_log` VALUES (1953597020975562753, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-08 07:20:00');
INSERT INTO `quartz_log` VALUES (1953598277156958210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:25:00');
INSERT INTO `quartz_log` VALUES (1953598279304511489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-08 07:25:00');
INSERT INTO `quartz_log` VALUES (1953599535439769602, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-08 07:30:00');
INSERT INTO `quartz_log` VALUES (1953599535670456321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 07:30:00');
INSERT INTO `quartz_log` VALUES (1953599537566351361, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-08 07:30:00');
INSERT INTO `quartz_log` VALUES (1953600793730969602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 07:35:00');
INSERT INTO `quartz_log` VALUES (1953600796096626690, '钱包任务', 'walletTaskService.task()', '总共耗时：91毫秒', 'Y', '2025-08-08 07:35:01');
INSERT INTO `quartz_log` VALUES (1953602052059918337, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 07:40:00');
INSERT INTO `quartz_log` VALUES (1953602052361908226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:40:00');
INSERT INTO `quartz_log` VALUES (1953602054333300737, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 07:40:01');
INSERT INTO `quartz_log` VALUES (1953603310330146818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 07:45:00');
INSERT INTO `quartz_log` VALUES (1953603313727602690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：324毫秒', 'Y', '2025-08-08 07:45:01');
INSERT INTO `quartz_log` VALUES (1953604568621346817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:50:00');
INSERT INTO `quartz_log` VALUES (1953604568914948098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 07:50:00');
INSERT INTO `quartz_log` VALUES (1953604570861174785, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-08 07:50:01');
INSERT INTO `quartz_log` VALUES (1953605826891575297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 07:55:00');
INSERT INTO `quartz_log` VALUES (1953605829106237442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-08 07:55:00');
INSERT INTO `quartz_log` VALUES (1953607085182775298, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:00:00');
INSERT INTO `quartz_log` VALUES (1953607085409267713, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-08 08:00:00');
INSERT INTO `quartz_log` VALUES (1953607087288385537, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-08 08:00:00');
INSERT INTO `quartz_log` VALUES (1953608343465586690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:05:00');
INSERT INTO `quartz_log` VALUES (1953608345546031106, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 08:05:00');
INSERT INTO `quartz_log` VALUES (1953609601781952514, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 08:10:00');
INSERT INTO `quartz_log` VALUES (1953609601979084801, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 08:10:00');
INSERT INTO `quartz_log` VALUES (1953609603908534273, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 08:10:00');
INSERT INTO `quartz_log` VALUES (1953610860073152513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:15:00');
INSERT INTO `quartz_log` VALUES (1953610863625797633, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 08:15:01');
INSERT INTO `quartz_log` VALUES (1953612118364352513, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:20:00');
INSERT INTO `quartz_log` VALUES (1953612118662148097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:20:00');
INSERT INTO `quartz_log` VALUES (1953612120717426690, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 08:20:01');
INSERT INTO `quartz_log` VALUES (1953613376634580993, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 08:25:00');
INSERT INTO `quartz_log` VALUES (1953613378853437441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-08 08:25:00');
INSERT INTO `quartz_log` VALUES (1953614634955141121, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 08:30:00');
INSERT INTO `quartz_log` VALUES (1953614635269713921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 08:30:00');
INSERT INTO `quartz_log` VALUES (1953614666295050241, '钱包任务', 'walletTaskService.task()', '总共耗时：1034毫秒', 'Y', '2025-08-08 08:30:06');
INSERT INTO `quartz_log` VALUES (1953615893212786690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 08:35:00');
INSERT INTO `quartz_log` VALUES (1953615925181841410, '钱包任务', 'walletTaskService.task()', '总共耗时：1194毫秒', 'Y', '2025-08-08 08:35:06');
INSERT INTO `quartz_log` VALUES (1953617151541735425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 08:40:00');
INSERT INTO `quartz_log` VALUES (1953617151839531010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:40:00');
INSERT INTO `quartz_log` VALUES (1953617154335211522, '用户解封', 'chatTaskService.banned()', '总共耗时：99毫秒', 'Y', '2025-08-08 08:40:01');
INSERT INTO `quartz_log` VALUES (1953618409811963906, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 08:45:00');
INSERT INTO `quartz_log` VALUES (1953618412076957697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：91毫秒', 'Y', '2025-08-08 08:45:00');
INSERT INTO `quartz_log` VALUES (1953619668077998081, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:50:00');
INSERT INTO `quartz_log` VALUES (1953619668258353154, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 08:50:00');
INSERT INTO `quartz_log` VALUES (1953619670095527937, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-08 08:50:00');
INSERT INTO `quartz_log` VALUES (1953620926381780993, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 08:55:00');
INSERT INTO `quartz_log` VALUES (1953620928361562113, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-08 08:55:00');
INSERT INTO `quartz_log` VALUES (1953622184702341122, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 09:00:00');
INSERT INTO `quartz_log` VALUES (1953622185025302530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:00:00');
INSERT INTO `quartz_log` VALUES (1953622186937974785, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-08 09:00:01');
INSERT INTO `quartz_log` VALUES (1953623442968375297, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:05:00');
INSERT INTO `quartz_log` VALUES (1953623445371781122, '钱包任务', 'walletTaskService.task()', '总共耗时：85毫秒', 'Y', '2025-08-08 09:05:01');
INSERT INTO `quartz_log` VALUES (1953624701280546818, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 09:10:00');
INSERT INTO `quartz_log` VALUES (1953624701523816450, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 09:10:00');
INSERT INTO `quartz_log` VALUES (1953624703373574145, '钱包任务', 'walletTaskService.task()', '总共耗时：75毫秒', 'Y', '2025-08-08 09:10:00');
INSERT INTO `quartz_log` VALUES (1953625959575941122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 09:15:00');
INSERT INTO `quartz_log` VALUES (1953625961656385537, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-08 09:15:00');
INSERT INTO `quartz_log` VALUES (1953627217862946818, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:20:00');
INSERT INTO `quartz_log` VALUES (1953627218156548098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:20:00');
INSERT INTO `quartz_log` VALUES (1953627220090191874, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-08 09:20:01');
INSERT INTO `quartz_log` VALUES (1953628476158341121, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:25:00');
INSERT INTO `quartz_log` VALUES (1953628478301700097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 09:25:00');
INSERT INTO `quartz_log` VALUES (1953629734415986690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:30:00');
INSERT INTO `quartz_log` VALUES (1953629734738948097, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:30:00');
INSERT INTO `quartz_log` VALUES (1953629735028355073, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 09:30:00');
INSERT INTO `quartz_log` VALUES (1953630992690409474, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:35:00');
INSERT INTO `quartz_log` VALUES (1953630994917654530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 09:35:00');
INSERT INTO `quartz_log` VALUES (1953632251044524033, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 09:40:00');
INSERT INTO `quartz_log` VALUES (1953632251401039873, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 09:40:00');
INSERT INTO `quartz_log` VALUES (1953632253250797570, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-08 09:40:01');
INSERT INTO `quartz_log` VALUES (1953633509297975298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 09:45:00');
INSERT INTO `quartz_log` VALUES (1953633512309555202, '钱包任务', 'walletTaskService.task()', '总共耗时：143毫秒', 'Y', '2025-08-08 09:45:01');
INSERT INTO `quartz_log` VALUES (1953634767593369601, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:50:00');
INSERT INTO `quartz_log` VALUES (1953634767916331010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 09:50:00');
INSERT INTO `quartz_log` VALUES (1953634769803837441, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 09:50:00');
INSERT INTO `quartz_log` VALUES (1953636025926512641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 09:55:00');
INSERT INTO `quartz_log` VALUES (1953636028401221634, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-08 09:55:01');
INSERT INTO `quartz_log` VALUES (1953637284188352513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 10:00:00');
INSERT INTO `quartz_log` VALUES (1953637284490342401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 10:00:00');
INSERT INTO `quartz_log` VALUES (1953637286616924162, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-08 10:00:01');
INSERT INTO `quartz_log` VALUES (1953638542458580993, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 10:05:00');
INSERT INTO `quartz_log` VALUES (1953638544807460865, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 10:05:01');
INSERT INTO `quartz_log` VALUES (1953639800733003777, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 10:10:00');
INSERT INTO `quartz_log` VALUES (1953639800867221505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 10:10:00');
INSERT INTO `quartz_log` VALUES (1953639803098660866, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-08 10:10:01');
INSERT INTO `quartz_log` VALUES (1953641059049369602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 10:15:00');
INSERT INTO `quartz_log` VALUES (1953641061456969729, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 10:15:01');
INSERT INTO `quartz_log` VALUES (1953642317348958209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:20:00');
INSERT INTO `quartz_log` VALUES (1953642317634170882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:20:00');
INSERT INTO `quartz_log` VALUES (1953642319764946946, '用户解封', 'chatTaskService.banned()', '总共耗时：72毫秒', 'Y', '2025-08-08 10:20:01');
INSERT INTO `quartz_log` VALUES (1953643575614992386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:25:00');
INSERT INTO `quartz_log` VALUES (1953643577955483649, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-08 10:25:01');
INSERT INTO `quartz_log` VALUES (1953644833881026561, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:30:00');
INSERT INTO `quartz_log` VALUES (1953644834187210753, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:30:00');
INSERT INTO `quartz_log` VALUES (1953644836301209601, '用户解封', 'chatTaskService.banned()', '总共耗时：73毫秒', 'Y', '2025-08-08 10:30:01');
INSERT INTO `quartz_log` VALUES (1953646092281278466, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 10:35:00');
INSERT INTO `quartz_log` VALUES (1953646094986678273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：74毫秒', 'Y', '2025-08-08 10:35:01');
INSERT INTO `quartz_log` VALUES (1953647350547312642, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 10:40:00');
INSERT INTO `quartz_log` VALUES (1953647350882856962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 10:40:00');
INSERT INTO `quartz_log` VALUES (1953647353626005506, '用户解封', 'chatTaskService.banned()', '总共耗时：175毫秒', 'Y', '2025-08-08 10:40:01');
INSERT INTO `quartz_log` VALUES (1953648608809152513, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:45:00');
INSERT INTO `quartz_log` VALUES (1953648612957392898, '钱包补偿', 'walletReceiveService.task()', '总共耗时：315毫秒', 'Y', '2025-08-08 10:45:01');
INSERT INTO `quartz_log` VALUES (1953649867083575298, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 10:50:00');
INSERT INTO `quartz_log` VALUES (1953649867305873410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-08 10:50:00');
INSERT INTO `quartz_log` VALUES (1953649870518784001, '钱包任务', 'walletTaskService.task()', '总共耗时：98毫秒', 'Y', '2025-08-08 10:50:01');
INSERT INTO `quartz_log` VALUES (1953651125370580994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 10:55:00');
INSERT INTO `quartz_log` VALUES (1953651127945957378, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-08 10:55:01');
INSERT INTO `quartz_log` VALUES (1953652383674363905, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 11:00:00');
INSERT INTO `quartz_log` VALUES (1953652383871496193, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 11:00:00');
INSERT INTO `quartz_log` VALUES (1953652408550854657, '钱包任务', 'walletTaskService.task()', '总共耗时：610毫秒', 'Y', '2025-08-08 11:00:05');
INSERT INTO `quartz_log` VALUES (1953653641978146818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 11:05:00');
INSERT INTO `quartz_log` VALUES (1953653642296913922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 11:05:00');
INSERT INTO `quartz_log` VALUES (1953654900244180994, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 11:10:00');
INSERT INTO `quartz_log` VALUES (1953654900588113922, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 11:10:00');
INSERT INTO `quartz_log` VALUES (1953654900885909505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:10:00');
INSERT INTO `quartz_log` VALUES (1953656158564741122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 11:15:00');
INSERT INTO `quartz_log` VALUES (1953656158891896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 11:15:00');
INSERT INTO `quartz_log` VALUES (1953657416826580993, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 11:20:00');
INSERT INTO `quartz_log` VALUES (1953657417157931009, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 11:20:00');
INSERT INTO `quartz_log` VALUES (1953657417455726594, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:20:00');
INSERT INTO `quartz_log` VALUES (1953658675117780994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:25:00');
INSERT INTO `quartz_log` VALUES (1953658675449131010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:25:00');
INSERT INTO `quartz_log` VALUES (1953659933417369602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 11:30:00');
INSERT INTO `quartz_log` VALUES (1953659933765496833, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 11:30:00');
INSERT INTO `quartz_log` VALUES (1953659933983600641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:30:00');
INSERT INTO `quartz_log` VALUES (1953661191729541121, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 11:35:00');
INSERT INTO `quartz_log` VALUES (1953661192052502530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 11:35:00');
INSERT INTO `quartz_log` VALUES (1953662450016546818, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 11:40:00');
INSERT INTO `quartz_log` VALUES (1953662450259816449, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 11:40:00');
INSERT INTO `quartz_log` VALUES (1953662450586972162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 11:40:00');
INSERT INTO `quartz_log` VALUES (1953663708282580994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:45:00');
INSERT INTO `quartz_log` VALUES (1953663708571987970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:45:00');
INSERT INTO `quartz_log` VALUES (1953664966569586690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:50:00');
INSERT INTO `quartz_log` VALUES (1953664966905131010, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 11:50:00');
INSERT INTO `quartz_log` VALUES (1953664967198732290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 11:50:00');
INSERT INTO `quartz_log` VALUES (1953666224869175298, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 11:55:00');
INSERT INTO `quartz_log` VALUES (1953666225108250625, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 11:55:00');
INSERT INTO `quartz_log` VALUES (1953667483164569601, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:00:00');
INSERT INTO `quartz_log` VALUES (1953667483504308225, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 12:00:00');
INSERT INTO `quartz_log` VALUES (1953667483810492417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:00:00');
INSERT INTO `quartz_log` VALUES (1953668741434798081, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 12:05:00');
INSERT INTO `quartz_log` VALUES (1953668741803896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:05:00');
INSERT INTO `quartz_log` VALUES (1953669999746969601, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 12:10:00');
INSERT INTO `quartz_log` VALUES (1953670000082513921, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 12:10:00');
INSERT INTO `quartz_log` VALUES (1953670000292229122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 12:10:00');
INSERT INTO `quartz_log` VALUES (1953671258029780994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:15:00');
INSERT INTO `quartz_log` VALUES (1953671258348548098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:15:00');
INSERT INTO `quartz_log` VALUES (1953672516320980994, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:20:00');
INSERT INTO `quartz_log` VALUES (1953672516849463297, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:20:00');
INSERT INTO `quartz_log` VALUES (1953672517109510146, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 12:20:00');
INSERT INTO `quartz_log` VALUES (1953673774624763905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:25:00');
INSERT INTO `quartz_log` VALUES (1953673774855450626, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 12:25:00');
INSERT INTO `quartz_log` VALUES (1953675032899186689, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:30:00');
INSERT INTO `quartz_log` VALUES (1953675033138262017, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 12:30:00');
INSERT INTO `quartz_log` VALUES (1953675033473806337, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:30:00');
INSERT INTO `quartz_log` VALUES (1953676291232329730, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 12:35:00');
INSERT INTO `quartz_log` VALUES (1953676291546902529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:35:00');
INSERT INTO `quartz_log` VALUES (1953677549544501250, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-08 12:40:00');
INSERT INTO `quartz_log` VALUES (1953677549884239873, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 12:40:00');
INSERT INTO `quartz_log` VALUES (1953677550194618369, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:40:00');
INSERT INTO `quartz_log` VALUES (1953678807785369601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:45:00');
INSERT INTO `quartz_log` VALUES (1953678808020250626, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 12:45:00');
INSERT INTO `quartz_log` VALUES (1953680066089152513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 12:50:00');
INSERT INTO `quartz_log` VALUES (1953680066378559490, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 12:50:00');
INSERT INTO `quartz_log` VALUES (1953680066563108866, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 12:50:00');
INSERT INTO `quartz_log` VALUES (1953681324380352514, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:55:00');
INSERT INTO `quartz_log` VALUES (1953681324694925314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 12:55:00');
INSERT INTO `quartz_log` VALUES (1953682582700912641, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 13:00:00');
INSERT INTO `quartz_log` VALUES (1953682583032262658, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:00:00');
INSERT INTO `quartz_log` VALUES (1953682583321669633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:00:00');
INSERT INTO `quartz_log` VALUES (1953683840971141121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 13:05:00');
INSERT INTO `quartz_log` VALUES (1953683841302491137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:05:00');
INSERT INTO `quartz_log` VALUES (1953685099262341122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 13:10:00');
INSERT INTO `quartz_log` VALUES (1953685099593691138, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 13:10:00');
INSERT INTO `quartz_log` VALUES (1953685099887292417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:10:00');
INSERT INTO `quartz_log` VALUES (1953686357519986690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:15:00');
INSERT INTO `quartz_log` VALUES (1953686357847142401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:15:00');
INSERT INTO `quartz_log` VALUES (1953687615798603777, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 13:20:00');
INSERT INTO `quartz_log` VALUES (1953687616100593665, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 13:20:00');
INSERT INTO `quartz_log` VALUES (1953687616410972161, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:20:00');
INSERT INTO `quartz_log` VALUES (1953688874131746818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:25:00');
INSERT INTO `quartz_log` VALUES (1953688874475679746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:25:00');
INSERT INTO `quartz_log` VALUES (1953690132360032257, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:30:00');
INSERT INTO `quartz_log` VALUES (1953690132464889857, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 13:30:00');
INSERT INTO `quartz_log` VALUES (1953690132859154433, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:30:00');
INSERT INTO `quartz_log` VALUES (1953691390722535426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 13:35:00');
INSERT INTO `quartz_log` VALUES (1953691391053885441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 13:35:00');
INSERT INTO `quartz_log` VALUES (1953692649005346818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 13:40:00');
INSERT INTO `quartz_log` VALUES (1953692649340891138, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 13:40:00');
INSERT INTO `quartz_log` VALUES (1953692649634492417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:40:00');
INSERT INTO `quartz_log` VALUES (1953693907296546817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 13:45:00');
INSERT INTO `quartz_log` VALUES (1953693907585953793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:45:00');
INSERT INTO `quartz_log` VALUES (1953695165579358210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:50:00');
INSERT INTO `quartz_log` VALUES (1953695165898125313, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 13:50:00');
INSERT INTO `quartz_log` VALUES (1953695166183337985, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:50:00');
INSERT INTO `quartz_log` VALUES (1953696423849586689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:55:00');
INSERT INTO `quartz_log` VALUES (1953696424185131009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 13:55:00');
INSERT INTO `quartz_log` VALUES (1953697682157563905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:00:00');
INSERT INTO `quartz_log` VALUES (1953697682484719617, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 14:00:00');
INSERT INTO `quartz_log` VALUES (1953697682778320897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:00:00');
INSERT INTO `quartz_log` VALUES (1953698940473929730, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 14:05:00');
INSERT INTO `quartz_log` VALUES (1953698940805279746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 14:05:00');
INSERT INTO `quartz_log` VALUES (1953700198765129729, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 14:10:00');
INSERT INTO `quartz_log` VALUES (1953700199109062657, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 14:10:00');
INSERT INTO `quartz_log` VALUES (1953700199398469633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:10:00');
INSERT INTO `quartz_log` VALUES (1953701457031163906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:15:00');
INSERT INTO `quartz_log` VALUES (1953701457358319618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 14:15:00');
INSERT INTO `quartz_log` VALUES (1953702715305586689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:20:00');
INSERT INTO `quartz_log` VALUES (1953702715628548097, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:20:00');
INSERT INTO `quartz_log` VALUES (1953702715934732289, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:20:00');
INSERT INTO `quartz_log` VALUES (1953703973592592386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:25:00');
INSERT INTO `quartz_log` VALUES (1953703973911359489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:25:00');
INSERT INTO `quartz_log` VALUES (1953705231892180993, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 14:30:00');
INSERT INTO `quartz_log` VALUES (1953705232139644930, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 14:30:00');
INSERT INTO `quartz_log` VALUES (1953705232450023426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:30:00');
INSERT INTO `quartz_log` VALUES (1953706490200158209, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 14:35:00');
INSERT INTO `quartz_log` VALUES (1953706490439233537, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 14:35:00');
INSERT INTO `quartz_log` VALUES (1953707748495552513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 14:40:00');
INSERT INTO `quartz_log` VALUES (1953707748847874049, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 14:40:00');
INSERT INTO `quartz_log` VALUES (1953707749145669634, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 14:40:00');
INSERT INTO `quartz_log` VALUES (1953709006769975298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:45:00');
INSERT INTO `quartz_log` VALUES (1953709007092936706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 14:45:00');
INSERT INTO `quartz_log` VALUES (1953710265077952514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 14:50:00');
INSERT INTO `quartz_log` VALUES (1953710265409302530, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 14:50:00');
INSERT INTO `quartz_log` VALUES (1953710265707098113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:50:00');
INSERT INTO `quartz_log` VALUES (1953711523369152513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 14:55:00');
INSERT INTO `quartz_log` VALUES (1953711523851497474, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 14:55:00');
INSERT INTO `quartz_log` VALUES (1953712781651963906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:00:00');
INSERT INTO `quartz_log` VALUES (1953712781983313922, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 15:00:00');
INSERT INTO `quartz_log` VALUES (1953712782234972162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:00:00');
INSERT INTO `quartz_log` VALUES (1953714039972524033, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 15:05:00');
INSERT INTO `quartz_log` VALUES (1953714040219987970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 15:05:00');
INSERT INTO `quartz_log` VALUES (1953715298234363905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:10:00');
INSERT INTO `quartz_log` VALUES (1953715298569908225, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 15:10:00');
INSERT INTO `quartz_log` VALUES (1953715298863509505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:10:00');
INSERT INTO `quartz_log` VALUES (1953716556529758209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:15:00');
INSERT INTO `quartz_log` VALUES (1953716556852719617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:15:00');
INSERT INTO `quartz_log` VALUES (1953717814799986689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:20:00');
INSERT INTO `quartz_log` VALUES (1953717815139725313, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:20:00');
INSERT INTO `quartz_log` VALUES (1953717815441715201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:20:00');
INSERT INTO `quartz_log` VALUES (1953719073149906946, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:25:00');
INSERT INTO `quartz_log` VALUES (1953719073489645570, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:25:00');
INSERT INTO `quartz_log` VALUES (1953720331411746818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:30:00');
INSERT INTO `quartz_log` VALUES (1953720331713736706, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 15:30:00');
INSERT INTO `quartz_log` VALUES (1953720332003143682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:30:00');
INSERT INTO `quartz_log` VALUES (1953721589702946817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 15:35:00');
INSERT INTO `quartz_log` VALUES (1953721590034296833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 15:35:00');
INSERT INTO `quartz_log` VALUES (1953722847998341121, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 15:40:00');
INSERT INTO `quartz_log` VALUES (1953722848342274049, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 15:40:00');
INSERT INTO `quartz_log` VALUES (1953722848635875330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:40:00');
INSERT INTO `quartz_log` VALUES (1953724106272763906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:45:00');
INSERT INTO `quartz_log` VALUES (1953724106599919617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:45:00');
INSERT INTO `quartz_log` VALUES (1953725364580741122, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:50:00');
INSERT INTO `quartz_log` VALUES (1953725364912091138, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 15:50:00');
INSERT INTO `quartz_log` VALUES (1953725365205692417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 15:50:00');
INSERT INTO `quartz_log` VALUES (1953726622859358209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 15:55:00');
INSERT INTO `quartz_log` VALUES (1953726623165542401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 15:55:00');
INSERT INTO `quartz_log` VALUES (1953727881150558209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:00:00');
INSERT INTO `quartz_log` VALUES (1953727881494491138, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 16:00:00');
INSERT INTO `quartz_log` VALUES (1953727881783898114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:00:00');
INSERT INTO `quartz_log` VALUES (1953729139458535425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 16:05:00');
INSERT INTO `quartz_log` VALUES (1953729139726970882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:05:00');
INSERT INTO `quartz_log` VALUES (1953730397770706945, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 16:10:00');
INSERT INTO `quartz_log` VALUES (1953730398106251266, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 16:10:00');
INSERT INTO `quartz_log` VALUES (1953730398399852545, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:10:00');
INSERT INTO `quartz_log` VALUES (1953731656003186690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:15:00');
INSERT INTO `quartz_log` VALUES (1953731656233873410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 16:15:00');
INSERT INTO `quartz_log` VALUES (1953732914319552514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:20:00');
INSERT INTO `quartz_log` VALUES (1953732914650902530, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 16:20:00');
INSERT INTO `quartz_log` VALUES (1953732914940309505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:20:00');
INSERT INTO `quartz_log` VALUES (1953734172623335425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 16:25:00');
INSERT INTO `quartz_log` VALUES (1953734172824662017, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:25:00');
INSERT INTO `quartz_log` VALUES (1953735430901952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:30:00');
INSERT INTO `quartz_log` VALUES (1953735431233302530, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 16:30:00');
INSERT INTO `quartz_log` VALUES (1953735431526903809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 16:30:00');
INSERT INTO `quartz_log` VALUES (1953736689197346818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:35:00');
INSERT INTO `quartz_log` VALUES (1953736689520308226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 16:35:00');
INSERT INTO `quartz_log` VALUES (1953737947475963906, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 16:40:00');
INSERT INTO `quartz_log` VALUES (1953737947719233538, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 16:40:00');
INSERT INTO `quartz_log` VALUES (1953737948042194946, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:40:00');
INSERT INTO `quartz_log` VALUES (1953739205746192386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:45:00');
INSERT INTO `quartz_log` VALUES (1953739206069153794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:45:00');
INSERT INTO `quartz_log` VALUES (1953740464041586689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:50:00');
INSERT INTO `quartz_log` VALUES (1953740464385519617, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 16:50:00');
INSERT INTO `quartz_log` VALUES (1953740464691703810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 16:50:00');
INSERT INTO `quartz_log` VALUES (1953741722353758210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:55:00');
INSERT INTO `quartz_log` VALUES (1953741722676719617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 16:55:00');
INSERT INTO `quartz_log` VALUES (1953742980644958209, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 17:00:00');
INSERT INTO `quartz_log` VALUES (1953742980976308225, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 17:00:00');
INSERT INTO `quartz_log` VALUES (1953742981253132290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:00:00');
INSERT INTO `quartz_log` VALUES (1953744238948741121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:05:00');
INSERT INTO `quartz_log` VALUES (1953744239275896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:05:00');
INSERT INTO `quartz_log` VALUES (1953745497214775297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:10:00');
INSERT INTO `quartz_log` VALUES (1953745497533542401, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:10:00');
INSERT INTO `quartz_log` VALUES (1953745497814560769, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 17:10:00');
INSERT INTO `quartz_log` VALUES (1953746755505975298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:15:00');
INSERT INTO `quartz_log` VALUES (1953746755837325314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:15:00');
INSERT INTO `quartz_log` VALUES (1953748013801369602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:20:00');
INSERT INTO `quartz_log` VALUES (1953748014099165185, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:20:00');
INSERT INTO `quartz_log` VALUES (1953748014346629122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:20:00');
INSERT INTO `quartz_log` VALUES (1953749272092569601, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:25:00');
INSERT INTO `quartz_log` VALUES (1953749272423919617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:25:00');
INSERT INTO `quartz_log` VALUES (1953750530387963906, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:30:00');
INSERT INTO `quartz_log` VALUES (1953750530836754434, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 17:30:00');
INSERT INTO `quartz_log` VALUES (1953750531134550018, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:30:00');
INSERT INTO `quartz_log` VALUES (1953751788691746818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:35:00');
INSERT INTO `quartz_log` VALUES (1953751789014708226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 17:35:00');
INSERT INTO `quartz_log` VALUES (1953753046961975297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:40:00');
INSERT INTO `quartz_log` VALUES (1953753047301713921, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 17:40:00');
INSERT INTO `quartz_log` VALUES (1953753047595315201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:40:00');
INSERT INTO `quartz_log` VALUES (1953754305274146817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:45:00');
INSERT INTO `quartz_log` VALUES (1953754305597108225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:45:00');
INSERT INTO `quartz_log` VALUES (1953755563544375297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:50:00');
INSERT INTO `quartz_log` VALUES (1953755563871531010, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:50:00');
INSERT INTO `quartz_log` VALUES (1953755564165132290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:50:00');
INSERT INTO `quartz_log` VALUES (1953756821835575297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 17:55:00');
INSERT INTO `quartz_log` VALUES (1953756822166925314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 17:55:00');
INSERT INTO `quartz_log` VALUES (1953758080151941121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 18:00:00');
INSERT INTO `quartz_log` VALUES (1953758080500068353, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 18:00:00');
INSERT INTO `quartz_log` VALUES (1953758080802058241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 18:00:00');
INSERT INTO `quartz_log` VALUES (1953759338464112641, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 18:05:00');
INSERT INTO `quartz_log` VALUES (1953759338774491137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 18:05:00');
INSERT INTO `quartz_log` VALUES (1953760596700786690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 18:10:00');
INSERT INTO `quartz_log` VALUES (1953760596944056321, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 18:10:00');
INSERT INTO `quartz_log` VALUES (1953760597246046210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:10:00');
INSERT INTO `quartz_log` VALUES (1953761854991986690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:15:00');
INSERT INTO `quartz_log` VALUES (1953761855310753794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:15:00');
INSERT INTO `quartz_log` VALUES (1953763113287380994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:20:00');
INSERT INTO `quartz_log` VALUES (1953763113618731010, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 18:20:00');
INSERT INTO `quartz_log` VALUES (1953763113815863297, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 18:20:00');
INSERT INTO `quartz_log` VALUES (1953764371565998081, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 18:25:00');
INSERT INTO `quartz_log` VALUES (1953764371851210753, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 18:25:00');
INSERT INTO `quartz_log` VALUES (1953765629865586690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 18:30:00');
INSERT INTO `quartz_log` VALUES (1953765630142410753, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 18:30:00');
INSERT INTO `quartz_log` VALUES (1953765630335348737, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:30:00');
INSERT INTO `quartz_log` VALUES (1953766888148398082, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 18:35:00');
INSERT INTO `quartz_log` VALUES (1953766888483942401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:35:00');
INSERT INTO `quartz_log` VALUES (1953768146456375297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:40:00');
INSERT INTO `quartz_log` VALUES (1953768146775142401, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 18:40:00');
INSERT INTO `quartz_log` VALUES (1953768147056160770, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:40:00');
INSERT INTO `quartz_log` VALUES (1953769404751769601, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:45:00');
INSERT INTO `quartz_log` VALUES (1953769405003427841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-08 18:45:00');
INSERT INTO `quartz_log` VALUES (1953770663017803777, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 18:50:00');
INSERT INTO `quartz_log` VALUES (1953770663294627841, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 18:50:00');
INSERT INTO `quartz_log` VALUES (1953770663592423425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 18:50:00');
INSERT INTO `quartz_log` VALUES (1953771921334169601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 18:55:00');
INSERT INTO `quartz_log` VALUES (1953771921569050625, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 18:55:00');
INSERT INTO `quartz_log` VALUES (1953773179625369601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 19:00:00');
INSERT INTO `quartz_log` VALUES (1953773179948331010, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 19:00:00');
INSERT INTO `quartz_log` VALUES (1953773180233543682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:00:00');
INSERT INTO `quartz_log` VALUES (1953774437945929730, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 19:05:00');
INSERT INTO `quartz_log` VALUES (1953774438273085442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 19:05:00');
INSERT INTO `quartz_log` VALUES (1953775696195186690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:10:00');
INSERT INTO `quartz_log` VALUES (1953775696518148098, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 19:10:00');
INSERT INTO `quartz_log` VALUES (1953775696815943681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:10:00');
INSERT INTO `quartz_log` VALUES (1953776954519941121, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 19:15:00');
INSERT INTO `quartz_log` VALUES (1953776954847096833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:15:00');
INSERT INTO `quartz_log` VALUES (1953778212790169602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 19:20:00');
INSERT INTO `quartz_log` VALUES (1953778213125713921, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 19:20:00');
INSERT INTO `quartz_log` VALUES (1953778213427703809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:20:00');
INSERT INTO `quartz_log` VALUES (1953779471056203777, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:25:00');
INSERT INTO `quartz_log` VALUES (1953779471278501890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 19:25:00');
INSERT INTO `quartz_log` VALUES (1953780729393541122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 19:30:00');
INSERT INTO `quartz_log` VALUES (1953780729733279746, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 19:30:00');
INSERT INTO `quartz_log` VALUES (1953780730022686721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:30:00');
INSERT INTO `quartz_log` VALUES (1953781987693129729, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 19:35:00');
INSERT INTO `quartz_log` VALUES (1953781987944787969, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-08 19:35:00');
INSERT INTO `quartz_log` VALUES (1953783245950775298, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 19:40:00');
INSERT INTO `quartz_log` VALUES (1953783246282125314, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 19:40:00');
INSERT INTO `quartz_log` VALUES (1953783246571532290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:40:00');
INSERT INTO `quartz_log` VALUES (1953784504241975297, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 19:45:00');
INSERT INTO `quartz_log` VALUES (1953784504560742401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:45:00');
INSERT INTO `quartz_log` VALUES (1953785762520592386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:50:00');
INSERT INTO `quartz_log` VALUES (1953785762864525313, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 19:50:00');
INSERT INTO `quartz_log` VALUES (1953785763158126594, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 19:50:00');
INSERT INTO `quartz_log` VALUES (1953787020836958209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 19:55:00');
INSERT INTO `quartz_log` VALUES (1953787021080227842, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 19:55:00');
INSERT INTO `quartz_log` VALUES (1953788279123963906, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 20:00:00');
INSERT INTO `quartz_log` VALUES (1953788279413370881, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 20:00:00');
INSERT INTO `quartz_log` VALUES (1953788279727943682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:00:00');
INSERT INTO `quartz_log` VALUES (1953789537440329729, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 20:05:00');
INSERT INTO `quartz_log` VALUES (1953789537771679746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:05:00');
INSERT INTO `quartz_log` VALUES (1953790795668615169, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 20:10:00');
INSERT INTO `quartz_log` VALUES (1953790795802832897, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-08 20:10:00');
INSERT INTO `quartz_log` VALUES (1953790795945439233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:10:00');
INSERT INTO `quartz_log` VALUES (1953792053976592385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:15:00');
INSERT INTO `quartz_log` VALUES (1953792054228250625, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:15:00');
INSERT INTO `quartz_log` VALUES (1953793312288763905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:20:00');
INSERT INTO `quartz_log` VALUES (1953793312569782274, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 20:20:00');
INSERT INTO `quartz_log` VALUES (1953793312829829121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:20:00');
INSERT INTO `quartz_log` VALUES (1953794570554798081, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 20:25:00');
INSERT INTO `quartz_log` VALUES (1953794570881953793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:25:00');
INSERT INTO `quartz_log` VALUES (1953795828887941122, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 20:30:00');
INSERT INTO `quartz_log` VALUES (1953795829131210754, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 20:30:00');
INSERT INTO `quartz_log` VALUES (1953795829454172161, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 20:30:00');
INSERT INTO `quartz_log` VALUES (1953797087170752513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 20:35:00');
INSERT INTO `quartz_log` VALUES (1953797087489519617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:35:00');
INSERT INTO `quartz_log` VALUES (1953798345453563905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:40:00');
INSERT INTO `quartz_log` VALUES (1953798345776525313, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 20:40:00');
INSERT INTO `quartz_log` VALUES (1953798346070126594, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 20:40:00');
INSERT INTO `quartz_log` VALUES (1953799603753152514, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:45:00');
INSERT INTO `quartz_log` VALUES (1953799604050948097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:45:00');
INSERT INTO `quartz_log` VALUES (1953800862044352514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 20:50:00');
INSERT INTO `quartz_log` VALUES (1953800862363119618, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 20:50:00');
INSERT INTO `quartz_log` VALUES (1953800862652526594, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:50:00');
INSERT INTO `quartz_log` VALUES (1953802120339746817, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:55:00');
INSERT INTO `quartz_log` VALUES (1953802120662708226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 20:55:00');
INSERT INTO `quartz_log` VALUES (1953803378622558209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 21:00:00');
INSERT INTO `quartz_log` VALUES (1953803378958102529, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 21:00:00');
INSERT INTO `quartz_log` VALUES (1953803379247509505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:00:00');
INSERT INTO `quartz_log` VALUES (1953804636917952513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 21:05:00');
INSERT INTO `quartz_log` VALUES (1953804637245108226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:05:00');
INSERT INTO `quartz_log` VALUES (1953805895196569601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 21:10:00');
INSERT INTO `quartz_log` VALUES (1953805895536308226, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 21:10:00');
INSERT INTO `quartz_log` VALUES (1953805895834103809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 21:10:00');
INSERT INTO `quartz_log` VALUES (1953807153475186689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:15:00');
INSERT INTO `quartz_log` VALUES (1953807153798148097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:15:00');
INSERT INTO `quartz_log` VALUES (1953808411791552514, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:20:00');
INSERT INTO `quartz_log` VALUES (1953808412114513921, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 21:20:00');
INSERT INTO `quartz_log` VALUES (1953808412412309505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:20:00');
INSERT INTO `quartz_log` VALUES (1953809670078558209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 21:25:00');
INSERT INTO `quartz_log` VALUES (1953809670393131009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:25:00');
INSERT INTO `quartz_log` VALUES (1953810928382341121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 21:30:00');
INSERT INTO `quartz_log` VALUES (1953810928713691138, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 21:30:00');
INSERT INTO `quartz_log` VALUES (1953810929003098113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:30:00');
INSERT INTO `quartz_log` VALUES (1953812186660958209, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 21:35:00');
INSERT INTO `quartz_log` VALUES (1953812186921005058, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-08 21:35:00');
INSERT INTO `quartz_log` VALUES (1953813444935380994, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 21:40:00');
INSERT INTO `quartz_log` VALUES (1953813445182844930, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-08 21:40:00');
INSERT INTO `quartz_log` VALUES (1953813445505806338, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:40:00');
INSERT INTO `quartz_log` VALUES (1953814703209803778, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:45:00');
INSERT INTO `quartz_log` VALUES (1953814703541153793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 21:45:00');
INSERT INTO `quartz_log` VALUES (1953815961534558210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:50:00');
INSERT INTO `quartz_log` VALUES (1953815961865908225, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 21:50:00');
INSERT INTO `quartz_log` VALUES (1953815962159509506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:50:00');
INSERT INTO `quartz_log` VALUES (1953817219829952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 21:55:00');
INSERT INTO `quartz_log` VALUES (1953817220157108225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 21:55:00');
INSERT INTO `quartz_log` VALUES (1953818478091792386, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:00:00');
INSERT INTO `quartz_log` VALUES (1953818478301507586, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 22:00:00');
INSERT INTO `quartz_log` VALUES (1953818478473474050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:00:00');
INSERT INTO `quartz_log` VALUES (1953819736441712641, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 22:05:00');
INSERT INTO `quartz_log` VALUES (1953819736768868353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:05:00');
INSERT INTO `quartz_log` VALUES (1953820994699358209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:10:00');
INSERT INTO `quartz_log` VALUES (1953820995022319618, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:10:00');
INSERT INTO `quartz_log` VALUES (1953820995307532290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:10:00');
INSERT INTO `quartz_log` VALUES (1953822252994752514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:15:00');
INSERT INTO `quartz_log` VALUES (1953822253313519618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:15:00');
INSERT INTO `quartz_log` VALUES (1953823511277563906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:20:00');
INSERT INTO `quartz_log` VALUES (1953823511604719617, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:20:00');
INSERT INTO `quartz_log` VALUES (1953823511894126593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 22:20:00');
INSERT INTO `quartz_log` VALUES (1953824769560375297, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:25:00');
INSERT INTO `quartz_log` VALUES (1953824769887531010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:25:00');
INSERT INTO `quartz_log` VALUES (1953826027872546818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 22:30:00');
INSERT INTO `quartz_log` VALUES (1953826028208091137, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 22:30:00');
INSERT INTO `quartz_log` VALUES (1953826028505886722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:30:00');
INSERT INTO `quartz_log` VALUES (1953827286167941122, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 22:35:00');
INSERT INTO `quartz_log` VALUES (1953827286499291138, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:35:00');
INSERT INTO `quartz_log` VALUES (1953828544433975298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:40:00');
INSERT INTO `quartz_log` VALUES (1953828544752742401, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:40:00');
INSERT INTO `quartz_log` VALUES (1953828545100869633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:40:00');
INSERT INTO `quartz_log` VALUES (1953829802712592385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:45:00');
INSERT INTO `quartz_log` VALUES (1953829802930696193, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:45:00');
INSERT INTO `quartz_log` VALUES (1953831061012180994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:50:00');
INSERT INTO `quartz_log` VALUES (1953831061335142401, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-08 22:50:00');
INSERT INTO `quartz_log` VALUES (1953831061624549378, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 22:50:00');
INSERT INTO `quartz_log` VALUES (1953832319324352513, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 22:55:00');
INSERT INTO `quartz_log` VALUES (1953832319651508225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 22:55:00');
INSERT INTO `quartz_log` VALUES (1953833577619746818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:00:00');
INSERT INTO `quartz_log` VALUES (1953833577955291137, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-08 23:00:00');
INSERT INTO `quartz_log` VALUES (1953833578240503809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:00:00');
INSERT INTO `quartz_log` VALUES (1953834835898363906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 23:05:00');
INSERT INTO `quartz_log` VALUES (1953834836225519617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-08 23:05:00');
INSERT INTO `quartz_log` VALUES (1953836094185369602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:10:00');
INSERT INTO `quartz_log` VALUES (1953836094428639234, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-08 23:10:00');
INSERT INTO `quartz_log` VALUES (1953836094747406337, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:10:00');
INSERT INTO `quartz_log` VALUES (1953837352463986690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:15:00');
INSERT INTO `quartz_log` VALUES (1953837352778559489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-08 23:15:00');
INSERT INTO `quartz_log` VALUES (1953838610763575297, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 23:20:00');
INSERT INTO `quartz_log` VALUES (1953838611103313922, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:20:00');
INSERT INTO `quartz_log` VALUES (1953838611392720897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:20:00');
INSERT INTO `quartz_log` VALUES (1953839869084135426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:25:00');
INSERT INTO `quartz_log` VALUES (1953839869440651265, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-08 23:25:00');
INSERT INTO `quartz_log` VALUES (1953841127371141122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:30:00');
INSERT INTO `quartz_log` VALUES (1953841127698296833, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 23:30:00');
INSERT INTO `quartz_log` VALUES (1953841127983509506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:30:00');
INSERT INTO `quartz_log` VALUES (1953842385624592386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:35:00');
INSERT INTO `quartz_log` VALUES (1953842385943359490, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 23:35:00');
INSERT INTO `quartz_log` VALUES (1953843643949346817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:40:00');
INSERT INTO `quartz_log` VALUES (1953843644276502529, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:40:00');
INSERT INTO `quartz_log` VALUES (1953843644570103809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:40:00');
INSERT INTO `quartz_log` VALUES (1953844902215380993, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:45:00');
INSERT INTO `quartz_log` VALUES (1953844902538342401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-08 23:45:00');
INSERT INTO `quartz_log` VALUES (1953846160531746818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:50:00');
INSERT INTO `quartz_log` VALUES (1953846160858902529, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-08 23:50:00');
INSERT INTO `quartz_log` VALUES (1953846161152503810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:50:00');
INSERT INTO `quartz_log` VALUES (1953847418818752514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-08 23:55:00');
INSERT INTO `quartz_log` VALUES (1953847419175268353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-08 23:55:00');
INSERT INTO `quartz_log` VALUES (1953848677109952514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:00:00');
INSERT INTO `quartz_log` VALUES (1953848677453885441, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 00:00:00');
INSERT INTO `quartz_log` VALUES (1953848677747486721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:00:00');
INSERT INTO `quartz_log` VALUES (1953849935413735426, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 00:05:00');
INSERT INTO `quartz_log` VALUES (1953849935828971521, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:05:00');
INSERT INTO `quartz_log` VALUES (1953851193679769601, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:10:00');
INSERT INTO `quartz_log` VALUES (1953851194019508225, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 00:10:00');
INSERT INTO `quartz_log` VALUES (1953851194220834818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:10:00');
INSERT INTO `quartz_log` VALUES (1953852451958386689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:15:00');
INSERT INTO `quartz_log` VALUES (1953852452298125314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:15:00');
INSERT INTO `quartz_log` VALUES (1953853710270558210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:20:00');
INSERT INTO `quartz_log` VALUES (1953853710593519617, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 00:20:00');
INSERT INTO `quartz_log` VALUES (1953853710853566465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 00:20:00');
INSERT INTO `quartz_log` VALUES (1953854968578535426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:25:00');
INSERT INTO `quartz_log` VALUES (1953854968918274049, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 00:25:00');
INSERT INTO `quartz_log` VALUES (1953856226869735426, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 00:30:00');
INSERT INTO `quartz_log` VALUES (1953856227213668353, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 00:30:00');
INSERT INTO `quartz_log` VALUES (1953856227536629761, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:30:00');
INSERT INTO `quartz_log` VALUES (1953857485173518338, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 00:35:00');
INSERT INTO `quartz_log` VALUES (1953857485446148097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:35:00');
INSERT INTO `quartz_log` VALUES (1953858743418580993, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:40:00');
INSERT INTO `quartz_log` VALUES (1953858743657656322, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:40:00');
INSERT INTO `quartz_log` VALUES (1953858743825428481, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:40:00');
INSERT INTO `quartz_log` VALUES (1953860001705586690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:45:00');
INSERT INTO `quartz_log` VALUES (1953860002032742402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 00:45:00');
INSERT INTO `quartz_log` VALUES (1953861260009369602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 00:50:00');
INSERT INTO `quartz_log` VALUES (1953861260323942401, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:50:00');
INSERT INTO `quartz_log` VALUES (1953861260554629122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-09 00:50:00');
INSERT INTO `quartz_log` VALUES (1953862518308958209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:55:00');
INSERT INTO `quartz_log` VALUES (1953862518644502529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 00:55:00');
INSERT INTO `quartz_log` VALUES (1953863776600158209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:00:00');
INSERT INTO `quartz_log` VALUES (1953863776931508225, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:00:00');
INSERT INTO `quartz_log` VALUES (1953863777233498113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:00:00');
INSERT INTO `quartz_log` VALUES (1953865034916524034, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 01:05:00');
INSERT INTO `quartz_log` VALUES (1953865035281428481, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:05:00');
INSERT INTO `quartz_log` VALUES (1953866293199335425, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:10:00');
INSERT INTO `quartz_log` VALUES (1953866293526491137, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 01:10:00');
INSERT INTO `quartz_log` VALUES (1953866293815898113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:10:00');
INSERT INTO `quartz_log` VALUES (1953867551490535426, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 01:15:00');
INSERT INTO `quartz_log` VALUES (1953867551817691137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 01:15:00');
INSERT INTO `quartz_log` VALUES (1953868809777541121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:20:00');
INSERT INTO `quartz_log` VALUES (1953868810108891137, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:20:00');
INSERT INTO `quartz_log` VALUES (1953868810406686722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:20:00');
INSERT INTO `quartz_log` VALUES (1953870068072935425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:25:00');
INSERT INTO `quartz_log` VALUES (1953870068400091138, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:25:00');
INSERT INTO `quartz_log` VALUES (1953871326359941121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:30:00');
INSERT INTO `quartz_log` VALUES (1953871326708068353, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:30:00');
INSERT INTO `quartz_log` VALUES (1953871326997475330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:30:00');
INSERT INTO `quartz_log` VALUES (1953872584642752514, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:35:00');
INSERT INTO `quartz_log` VALUES (1953872584974102530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:35:00');
INSERT INTO `quartz_log` VALUES (1953873842917175297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:40:00');
INSERT INTO `quartz_log` VALUES (1953873843235942401, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 01:40:00');
INSERT INTO `quartz_log` VALUES (1953873843529543682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 01:40:00');
INSERT INTO `quartz_log` VALUES (1953875101183209473, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 01:45:00');
INSERT INTO `quartz_log` VALUES (1953875101296455681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:45:00');
INSERT INTO `quartz_log` VALUES (1953876359507963906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:50:00');
INSERT INTO `quartz_log` VALUES (1953876359839313921, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:50:00');
INSERT INTO `quartz_log` VALUES (1953876360132915201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 01:50:00');
INSERT INTO `quartz_log` VALUES (1953877617815941121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 01:55:00');
INSERT INTO `quartz_log` VALUES (1953877618155679745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 01:55:00');
INSERT INTO `quartz_log` VALUES (1953878876090363906, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 02:00:00');
INSERT INTO `quartz_log` VALUES (1953878876438491137, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 02:00:00');
INSERT INTO `quartz_log` VALUES (1953878876732092417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:00:00');
INSERT INTO `quartz_log` VALUES (1953880134385758209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 02:05:00');
INSERT INTO `quartz_log` VALUES (1953880134704525313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 02:05:00');
INSERT INTO `quartz_log` VALUES (1953881392681152513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 02:10:00');
INSERT INTO `quartz_log` VALUES (1953881392999919618, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 02:10:00');
INSERT INTO `quartz_log` VALUES (1953881393280937985, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:10:00');
INSERT INTO `quartz_log` VALUES (1953882650976546818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 02:15:00');
INSERT INTO `quartz_log` VALUES (1953882651299508225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:15:00');
INSERT INTO `quartz_log` VALUES (1953883909242580994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:20:00');
INSERT INTO `quartz_log` VALUES (1953883909477462018, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-09 02:20:00');
INSERT INTO `quartz_log` VALUES (1953883909813006337, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:20:00');
INSERT INTO `quartz_log` VALUES (1953885167584112641, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-09 02:25:00');
INSERT INTO `quartz_log` VALUES (1953885167902879745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 02:25:00');
INSERT INTO `quartz_log` VALUES (1953886425871118338, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 02:30:00');
INSERT INTO `quartz_log` VALUES (1953886426215051265, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 02:30:00');
INSERT INTO `quartz_log` VALUES (1953886426496069634, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:30:00');
INSERT INTO `quartz_log` VALUES (1953887684111986690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:35:00');
INSERT INTO `quartz_log` VALUES (1953887684443336706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:35:00');
INSERT INTO `quartz_log` VALUES (1953888942411575298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:40:00');
INSERT INTO `quartz_log` VALUES (1953888942688399361, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 02:40:00');
INSERT INTO `quartz_log` VALUES (1953888942952640514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:40:00');
INSERT INTO `quartz_log` VALUES (1953890200711163905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:45:00');
INSERT INTO `quartz_log` VALUES (1953890201029931010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:45:00');
INSERT INTO `quartz_log` VALUES (1953891459002363905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 02:50:00');
INSERT INTO `quartz_log` VALUES (1953891459346296834, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 02:50:00');
INSERT INTO `quartz_log` VALUES (1953891459639898114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 02:50:00');
INSERT INTO `quartz_log` VALUES (1953892717318729729, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 02:55:00');
INSERT INTO `quartz_log` VALUES (1953892717645885442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 02:55:00');
INSERT INTO `quartz_log` VALUES (1953893975605735425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 03:00:00');
INSERT INTO `quartz_log` VALUES (1953893976171966465, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 03:00:00');
INSERT INTO `quartz_log` VALUES (1953893976532676609, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:00:00');
INSERT INTO `quartz_log` VALUES (1953893976566231042, '用户日活', 'chatTaskService.visit()', '总共耗时：154毫秒', 'Y', '2025-08-09 03:00:00');
INSERT INTO `quartz_log` VALUES (1953895233888546817, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:05:00');
INSERT INTO `quartz_log` VALUES (1953895234219896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:05:00');
INSERT INTO `quartz_log` VALUES (1953896492171358209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:10:00');
INSERT INTO `quartz_log` VALUES (1953896492506902530, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 03:10:00');
INSERT INTO `quartz_log` VALUES (1953896492804698114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:10:00');
INSERT INTO `quartz_log` VALUES (1953897750437392385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:15:00');
INSERT INTO `quartz_log` VALUES (1953897750630330369, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:15:00');
INSERT INTO `quartz_log` VALUES (1953899008745369601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:20:00');
INSERT INTO `quartz_log` VALUES (1953899009038970882, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:20:00');
INSERT INTO `quartz_log` VALUES (1953899009303212034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:20:00');
INSERT INTO `quartz_log` VALUES (1953900267040763906, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 03:25:00');
INSERT INTO `quartz_log` VALUES (1953900267334365186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 03:25:00');
INSERT INTO `quartz_log` VALUES (1953901525327769602, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 03:30:00');
INSERT INTO `quartz_log` VALUES (1953901525646536706, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-09 03:30:00');
INSERT INTO `quartz_log` VALUES (1953901525914972161, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:30:00');
INSERT INTO `quartz_log` VALUES (1953902783614775298, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:35:00');
INSERT INTO `quartz_log` VALUES (1953902783904182273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-09 03:35:00');
INSERT INTO `quartz_log` VALUES (1953904041914363905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:40:00');
INSERT INTO `quartz_log` VALUES (1953904042241519617, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 03:40:00');
INSERT INTO `quartz_log` VALUES (1953904042543509506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:40:00');
INSERT INTO `quartz_log` VALUES (1953905300205563905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:45:00');
INSERT INTO `quartz_log` VALUES (1953905300528525313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:45:00');
INSERT INTO `quartz_log` VALUES (1953906558492569602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:50:00');
INSERT INTO `quartz_log` VALUES (1953906558832308226, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 03:50:00');
INSERT INTO `quartz_log` VALUES (1953906559134298113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 03:50:00');
INSERT INTO `quartz_log` VALUES (1953907816825712642, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-09 03:55:00');
INSERT INTO `quartz_log` VALUES (1953907817157062657, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 03:55:00');
INSERT INTO `quartz_log` VALUES (1953909075272101890, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 04:00:00');
INSERT INTO `quartz_log` VALUES (1953909075712503810, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 04:00:00');
INSERT INTO `quartz_log` VALUES (1953909076014493698, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:00:00');
INSERT INTO `quartz_log` VALUES (1953910333374558210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:05:00');
INSERT INTO `quartz_log` VALUES (1953910333668159489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:05:00');
INSERT INTO `quartz_log` VALUES (1953911591661563905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:10:00');
INSERT INTO `quartz_log` VALUES (1953911591997108226, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 04:10:00');
INSERT INTO `quartz_log` VALUES (1953911592286515201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:10:00');
INSERT INTO `quartz_log` VALUES (1953912849952763906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:15:00');
INSERT INTO `quartz_log` VALUES (1953912850267336705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:15:00');
INSERT INTO `quartz_log` VALUES (1953914108260741121, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:20:00');
INSERT INTO `quartz_log` VALUES (1953914108587896834, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 04:20:00');
INSERT INTO `quartz_log` VALUES (1953914108868915202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 04:20:00');
INSERT INTO `quartz_log` VALUES (1953915366564524033, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 04:25:00');
INSERT INTO `quartz_log` VALUES (1953915366900068354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:25:00');
INSERT INTO `quartz_log` VALUES (1953916624864112642, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-09 04:30:00');
INSERT INTO `quartz_log` VALUES (1953916625212239874, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 04:30:00');
INSERT INTO `quartz_log` VALUES (1953916625510035457, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:30:00');
INSERT INTO `quartz_log` VALUES (1953917883125952513, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:35:00');
INSERT INTO `quartz_log` VALUES (1953917883457302529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:35:00');
INSERT INTO `quartz_log` VALUES (1953919141412958210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:40:00');
INSERT INTO `quartz_log` VALUES (1953919141740113921, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 04:40:00');
INSERT INTO `quartz_log` VALUES (1953919142029520897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:40:00');
INSERT INTO `quartz_log` VALUES (1953920399704158209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 04:45:00');
INSERT INTO `quartz_log` VALUES (1953920400022925314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:45:00');
INSERT INTO `quartz_log` VALUES (1953921658024718337, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 04:50:00');
INSERT INTO `quartz_log` VALUES (1953921658280570881, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-09 04:50:00');
INSERT INTO `quartz_log` VALUES (1953921658624503809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 04:50:00');
INSERT INTO `quartz_log` VALUES (1953922916307529730, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 04:55:00');
INSERT INTO `quartz_log` VALUES (1953922916626296833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 04:55:00');
INSERT INTO `quartz_log` VALUES (1953924174619701250, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 05:00:00');
INSERT INTO `quartz_log` VALUES (1953924174959439874, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 05:00:00');
INSERT INTO `quartz_log` VALUES (1953924175290789889, '群组降级', 'chatTaskService.level()', '总共耗时：10毫秒', 'Y', '2025-08-09 05:00:00');
INSERT INTO `quartz_log` VALUES (1953924175483727873, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 05:00:00');
INSERT INTO `quartz_log` VALUES (1953925432852180993, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:05:00');
INSERT INTO `quartz_log` VALUES (1953925433179336706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:05:00');
INSERT INTO `quartz_log` VALUES (1953926691147575297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:10:00');
INSERT INTO `quartz_log` VALUES (1953926691478925314, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:10:00');
INSERT INTO `quartz_log` VALUES (1953926691772526593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:10:00');
INSERT INTO `quartz_log` VALUES (1953927949447163905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:15:00');
INSERT INTO `quartz_log` VALUES (1953927949694627842, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 05:15:00');
INSERT INTO `quartz_log` VALUES (1953929207755141122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 05:20:00');
INSERT INTO `quartz_log` VALUES (1953929208073908225, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 05:20:00');
INSERT INTO `quartz_log` VALUES (1953929208359120898, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:20:00');
INSERT INTO `quartz_log` VALUES (1953930466046341122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 05:25:00');
INSERT INTO `quartz_log` VALUES (1953930466365108226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:25:00');
INSERT INTO `quartz_log` VALUES (1953931724366901249, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 05:30:00');
INSERT INTO `quartz_log` VALUES (1953931724673085441, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 05:30:00');
INSERT INTO `quartz_log` VALUES (1953931724966686722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:30:00');
INSERT INTO `quartz_log` VALUES (1953932982611963906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:35:00');
INSERT INTO `quartz_log` VALUES (1953932982918148098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:35:00');
INSERT INTO `quartz_log` VALUES (1953934240915746817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:40:00');
INSERT INTO `quartz_log` VALUES (1953934241242902529, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 05:40:00');
INSERT INTO `quartz_log` VALUES (1953934241532309506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:40:00');
INSERT INTO `quartz_log` VALUES (1953935499190169602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:45:00');
INSERT INTO `quartz_log` VALUES (1953935499462799361, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-09 05:45:00');
INSERT INTO `quartz_log` VALUES (1953936757502341121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 05:50:00');
INSERT INTO `quartz_log` VALUES (1953936757833691138, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 05:50:00');
INSERT INTO `quartz_log` VALUES (1953936758127292417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 05:50:00');
INSERT INTO `quartz_log` VALUES (1953938015793541121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 05:55:00');
INSERT INTO `quartz_log` VALUES (1953938016112308225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 05:55:00');
INSERT INTO `quartz_log` VALUES (1953939274122489857, '钱包任务', 'walletTaskService.task()', '总共耗时：12毫秒', 'Y', '2025-08-09 06:00:00');
INSERT INTO `quartz_log` VALUES (1953939274474811393, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-09 06:00:00');
INSERT INTO `quartz_log` VALUES (1953939274772606977, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:00:00');
INSERT INTO `quartz_log` VALUES (1953940532338192385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:05:00');
INSERT INTO `quartz_log` VALUES (1953940532581462018, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 06:05:00');
INSERT INTO `quartz_log` VALUES (1953941790658752513, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:10:00');
INSERT INTO `quartz_log` VALUES (1953941790985908226, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 06:10:00');
INSERT INTO `quartz_log` VALUES (1953941791279509505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:10:00');
INSERT INTO `quartz_log` VALUES (1953943048920592385, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 06:15:00');
INSERT INTO `quartz_log` VALUES (1953943049180639234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 06:15:00');
INSERT INTO `quartz_log` VALUES (1953944307236958210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 06:20:00');
INSERT INTO `quartz_log` VALUES (1953944307543142401, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 06:20:00');
INSERT INTO `quartz_log` VALUES (1953944307790606337, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:20:00');
INSERT INTO `quartz_log` VALUES (1953945565536546818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 06:25:00');
INSERT INTO `quartz_log` VALUES (1953945565855313922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 06:25:00');
INSERT INTO `quartz_log` VALUES (1953946823840329729, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 06:30:00');
INSERT INTO `quartz_log` VALUES (1953946824175874050, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 06:30:00');
INSERT INTO `quartz_log` VALUES (1953946824469475330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:30:00');
INSERT INTO `quartz_log` VALUES (1953948082106363905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:35:00');
INSERT INTO `quartz_log` VALUES (1953948082425131010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 06:35:00');
INSERT INTO `quartz_log` VALUES (1953949340414341121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 06:40:00');
INSERT INTO `quartz_log` VALUES (1953949340754079745, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 06:40:00');
INSERT INTO `quartz_log` VALUES (1953949341060263938, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:40:00');
INSERT INTO `quartz_log` VALUES (1953950598692958209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:45:00');
INSERT INTO `quartz_log` VALUES (1953950599028502529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:45:00');
INSERT INTO `quartz_log` VALUES (1953951857000935425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 06:50:00');
INSERT INTO `quartz_log` VALUES (1953951857332285442, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 06:50:00');
INSERT INTO `quartz_log` VALUES (1953951857630081026, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 06:50:00');
INSERT INTO `quartz_log` VALUES (1953953115292135426, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 06:55:00');
INSERT INTO `quartz_log` VALUES (1953953115631874049, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 06:55:00');
INSERT INTO `quartz_log` VALUES (1953954373574946818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:00:00');
INSERT INTO `quartz_log` VALUES (1953954373927268354, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-09 07:00:00');
INSERT INTO `quartz_log` VALUES (1953954374225063937, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:00:00');
INSERT INTO `quartz_log` VALUES (1953955631866146817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:05:00');
INSERT INTO `quartz_log` VALUES (1953955632214274050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:05:00');
INSERT INTO `quartz_log` VALUES (1953956890136375297, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 07:10:00');
INSERT INTO `quartz_log` VALUES (1953956890438365186, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 07:10:00');
INSERT INTO `quartz_log` VALUES (1953956890740355074, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:10:00');
INSERT INTO `quartz_log` VALUES (1953958148381437954, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:15:00');
INSERT INTO `quartz_log` VALUES (1953958148792479745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:15:00');
INSERT INTO `quartz_log` VALUES (1953959406743941121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 07:20:00');
INSERT INTO `quartz_log` VALUES (1953959407083679745, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 07:20:00');
INSERT INTO `quartz_log` VALUES (1953959407381475330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:20:00');
INSERT INTO `quartz_log` VALUES (1953960665039335425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 07:25:00');
INSERT INTO `quartz_log` VALUES (1953960665370685441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:25:00');
INSERT INTO `quartz_log` VALUES (1953961923255037954, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:30:00');
INSERT INTO `quartz_log` VALUES (1953961923666079745, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 07:30:00');
INSERT INTO `quartz_log` VALUES (1953961923926126593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:30:00');
INSERT INTO `quartz_log` VALUES (1953963181596569601, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:35:00');
INSERT INTO `quartz_log` VALUES (1953963181865005058, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:35:00');
INSERT INTO `quartz_log` VALUES (1953964439879380994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:40:00');
INSERT INTO `quartz_log` VALUES (1953964440168787969, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:40:00');
INSERT INTO `quartz_log` VALUES (1953964440424640514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:40:00');
INSERT INTO `quartz_log` VALUES (1953965698178969601, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:45:00');
INSERT INTO `quartz_log` VALUES (1953965698464182274, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 07:45:00');
INSERT INTO `quartz_log` VALUES (1953966956482752514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 07:50:00');
INSERT INTO `quartz_log` VALUES (1953966956793131009, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 07:50:00');
INSERT INTO `quartz_log` VALUES (1953966957057372162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 07:50:00');
INSERT INTO `quartz_log` VALUES (1953968214782341121, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 07:55:00');
INSERT INTO `quartz_log` VALUES (1953968215080136706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 07:55:00');
INSERT INTO `quartz_log` VALUES (1953969473056763906, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:00:00');
INSERT INTO `quartz_log` VALUES (1953969473354559489, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:00:00');
INSERT INTO `quartz_log` VALUES (1953969473622994946, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:00:00');
INSERT INTO `quartz_log` VALUES (1953970731347963906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:05:00');
INSERT INTO `quartz_log` VALUES (1953970731654148098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:05:00');
INSERT INTO `quartz_log` VALUES (1953971989643358209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 08:10:00');
INSERT INTO `quartz_log` VALUES (1953971989936959490, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:10:00');
INSERT INTO `quartz_log` VALUES (1953971990188617730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:10:00');
INSERT INTO `quartz_log` VALUES (1953973247921975297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:15:00');
INSERT INTO `quartz_log` VALUES (1953973248223965186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:15:00');
INSERT INTO `quartz_log` VALUES (1953974506221563906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 08:20:00');
INSERT INTO `quartz_log` VALUES (1953974506527748098, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 08:20:00');
INSERT INTO `quartz_log` VALUES (1953974506800377857, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:20:00');
INSERT INTO `quartz_log` VALUES (1953975764521152514, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 08:25:00');
INSERT INTO `quartz_log` VALUES (1953975764831531009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 08:25:00');
INSERT INTO `quartz_log` VALUES (1953977022799769602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:30:00');
INSERT INTO `quartz_log` VALUES (1953977023047233537, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:30:00');
INSERT INTO `quartz_log` VALUES (1953977023244365826, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:30:00');
INSERT INTO `quartz_log` VALUES (1953978281086775297, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 08:35:00');
INSERT INTO `quartz_log` VALUES (1953978281371987970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 08:35:00');
INSERT INTO `quartz_log` VALUES (1953979539382169602, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:40:00');
INSERT INTO `quartz_log` VALUES (1953979539671576578, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:40:00');
INSERT INTO `quartz_log` VALUES (1953979539931623425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:40:00');
INSERT INTO `quartz_log` VALUES (1953980797660786690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:45:00');
INSERT INTO `quartz_log` VALUES (1953980797941805058, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 08:45:00');
INSERT INTO `quartz_log` VALUES (1953982055985541122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 08:50:00');
INSERT INTO `quartz_log` VALUES (1953982056316891138, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:50:00');
INSERT INTO `quartz_log` VALUES (1953982056610492418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 08:50:00');
INSERT INTO `quartz_log` VALUES (1953983314280935425, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 08:55:00');
INSERT INTO `quartz_log` VALUES (1953983314629062658, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 08:55:00');
INSERT INTO `quartz_log` VALUES (1953984572559552514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:00:00');
INSERT INTO `quartz_log` VALUES (1953984572899291138, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 09:00:00');
INSERT INTO `quartz_log` VALUES (1953984573188698113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 09:00:00');
INSERT INTO `quartz_log` VALUES (1953985830842363905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 09:05:00');
INSERT INTO `quartz_log` VALUES (1953985831169519617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:05:00');
INSERT INTO `quartz_log` VALUES (1953987089141952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:10:00');
INSERT INTO `quartz_log` VALUES (1953987089473302529, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 09:10:00');
INSERT INTO `quartz_log` VALUES (1953987089775292418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 09:10:00');
INSERT INTO `quartz_log` VALUES (1953988347416375298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 09:15:00');
INSERT INTO `quartz_log` VALUES (1953988347823222786, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:15:00');
INSERT INTO `quartz_log` VALUES (1953989605694992385, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:20:00');
INSERT INTO `quartz_log` VALUES (1953989606034731009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 09:20:00');
INSERT INTO `quartz_log` VALUES (1953989608173924354, '用户解封', 'chatTaskService.banned()', '总共耗时：124毫秒', 'Y', '2025-08-09 09:20:00');
INSERT INTO `quartz_log` VALUES (1953990864011358210, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 09:25:00');
INSERT INTO `quartz_log` VALUES (1953990866020528129, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-09 09:25:00');
INSERT INTO `quartz_log` VALUES (1953992122310946818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 09:30:00');
INSERT INTO `quartz_log` VALUES (1953992122625519617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:30:00');
INSERT INTO `quartz_log` VALUES (1953992124399808514, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-09 09:30:00');
INSERT INTO `quartz_log` VALUES (1953993380564398082, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 09:35:00');
INSERT INTO `quartz_log` VALUES (1953993382821031937, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-09 09:35:00');
INSERT INTO `quartz_log` VALUES (1953994638893346818, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:40:00');
INSERT INTO `quartz_log` VALUES (1953994639191142401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 09:40:00');
INSERT INTO `quartz_log` VALUES (1953994641057705985, '钱包任务', 'walletTaskService.task()', '总共耗时：84毫秒', 'Y', '2025-08-09 09:40:00');
INSERT INTO `quartz_log` VALUES (1953995897155186689, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 09:45:00');
INSERT INTO `quartz_log` VALUES (1953995899105636353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：38毫秒', 'Y', '2025-08-09 09:45:00');
INSERT INTO `quartz_log` VALUES (1953997155454775297, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 09:50:00');
INSERT INTO `quartz_log` VALUES (1953997155744182274, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 09:50:00');
INSERT INTO `quartz_log` VALUES (1953997157971456002, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-09 09:50:01');
INSERT INTO `quartz_log` VALUES (1953998413741780993, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 09:55:00');
INSERT INTO `quartz_log` VALUES (1953998414068936705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 09:55:00');
INSERT INTO `quartz_log` VALUES (1953999672053952514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:00:00');
INSERT INTO `quartz_log` VALUES (1953999672393691137, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 10:00:00');
INSERT INTO `quartz_log` VALUES (1953999672691486721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 10:00:00');
INSERT INTO `quartz_log` VALUES (1954000930345152513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:05:00');
INSERT INTO `quartz_log` VALUES (1954000930676502529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:05:00');
INSERT INTO `quartz_log` VALUES (1954002188640546817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:10:00');
INSERT INTO `quartz_log` VALUES (1954002188971896834, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:10:00');
INSERT INTO `quartz_log` VALUES (1954002189265498113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 10:10:00');
INSERT INTO `quartz_log` VALUES (1954003446948524034, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 10:15:00');
INSERT INTO `quartz_log` VALUES (1954003447275679746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:15:00');
INSERT INTO `quartz_log` VALUES (1954004705218752514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:20:00');
INSERT INTO `quartz_log` VALUES (1954004705558491138, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 10:20:00');
INSERT INTO `quartz_log` VALUES (1954004705856286722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 10:20:00');
INSERT INTO `quartz_log` VALUES (1954005963514146818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:25:00');
INSERT INTO `quartz_log` VALUES (1954005963841302530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:25:00');
INSERT INTO `quartz_log` VALUES (1954007221809541121, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:30:00');
INSERT INTO `quartz_log` VALUES (1954007222128308225, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:30:00');
INSERT INTO `quartz_log` VALUES (1954007222392549377, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 10:30:00');
INSERT INTO `quartz_log` VALUES (1954008480092352514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:35:00');
INSERT INTO `quartz_log` VALUES (1954008480415313922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:35:00');
INSERT INTO `quartz_log` VALUES (1954009738375163905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 10:40:00');
INSERT INTO `quartz_log` VALUES (1954009738706513922, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:40:00');
INSERT INTO `quartz_log` VALUES (1954009739033669633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 10:40:00');
INSERT INTO `quartz_log` VALUES (1954010996683141122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 10:45:00');
INSERT INTO `quartz_log` VALUES (1954010997022879745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 10:45:00');
INSERT INTO `quartz_log` VALUES (1954012254974341122, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 10:50:00');
INSERT INTO `quartz_log` VALUES (1954012255314079745, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 10:50:00');
INSERT INTO `quartz_log` VALUES (1954012255611875330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 10:50:00');
INSERT INTO `quartz_log` VALUES (1954013513269735425, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 10:55:00');
INSERT INTO `quartz_log` VALUES (1954013513601085441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 10:55:00');
INSERT INTO `quartz_log` VALUES (1954014771523186690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:00:00');
INSERT INTO `quartz_log` VALUES (1954014771867119617, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:00:00');
INSERT INTO `quartz_log` VALUES (1954014772156526593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:00:00');
INSERT INTO `quartz_log` VALUES (1954016029873106945, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 11:05:00');
INSERT INTO `quartz_log` VALUES (1954016030120570882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 11:05:00');
INSERT INTO `quartz_log` VALUES (1954017288113975298, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:10:00');
INSERT INTO `quartz_log` VALUES (1954017288365633538, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 11:10:00');
INSERT INTO `quartz_log` VALUES (1954017288701177857, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:10:00');
INSERT INTO `quartz_log` VALUES (1954018546434535425, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:15:00');
INSERT INTO `quartz_log` VALUES (1954018546698776577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-09 11:15:00');
INSERT INTO `quartz_log` VALUES (1954019804713152514, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 11:20:00');
INSERT INTO `quartz_log` VALUES (1954019805073862658, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-09 11:20:00');
INSERT INTO `quartz_log` VALUES (1954019805363269634, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:20:00');
INSERT INTO `quartz_log` VALUES (1954021063012741122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 11:25:00');
INSERT INTO `quartz_log` VALUES (1954021063360868354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 11:25:00');
INSERT INTO `quartz_log` VALUES (1954022321287163906, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 11:30:00');
INSERT INTO `quartz_log` VALUES (1954022321589153793, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 11:30:00');
INSERT INTO `quartz_log` VALUES (1954022321886949377, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:30:00');
INSERT INTO `quartz_log` VALUES (1954023579590946817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:35:00');
INSERT INTO `quartz_log` VALUES (1954023579913908226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:35:00');
INSERT INTO `quartz_log` VALUES (1954024837869563906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:40:00');
INSERT INTO `quartz_log` VALUES (1954024838188331009, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:40:00');
INSERT INTO `quartz_log` VALUES (1954024838427406338, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:40:00');
INSERT INTO `quartz_log` VALUES (1954026096177541122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 11:45:00');
INSERT INTO `quartz_log` VALUES (1954026096525668354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 11:45:00');
INSERT INTO `quartz_log` VALUES (1954027354447769602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:50:00');
INSERT INTO `quartz_log` VALUES (1954027354896560130, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:50:00');
INSERT INTO `quartz_log` VALUES (1954027355190161409, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:50:00');
INSERT INTO `quartz_log` VALUES (1954028612755746817, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 11:55:00');
INSERT INTO `quartz_log` VALUES (1954028613074513922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 11:55:00');
INSERT INTO `quartz_log` VALUES (1954029871034363905, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 12:00:00');
INSERT INTO `quartz_log` VALUES (1954029871365713922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:00:00');
INSERT INTO `quartz_log` VALUES (1954029873572020225, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-09 12:00:01');
INSERT INTO `quartz_log` VALUES (1954031129333952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 12:05:00');
INSERT INTO `quartz_log` VALUES (1954031131552841730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 12:05:01');
INSERT INTO `quartz_log` VALUES (1954032387604180993, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:10:00');
INSERT INTO `quartz_log` VALUES (1954032387767758850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:10:00');
INSERT INTO `quartz_log` VALUES (1954032390427049986, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-09 12:10:01');
INSERT INTO `quartz_log` VALUES (1954033645916352514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 12:15:00');
INSERT INTO `quartz_log` VALUES (1954033648219127809, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-09 12:15:01');
INSERT INTO `quartz_log` VALUES (1954034904232718337, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 12:20:00');
INSERT INTO `quartz_log` VALUES (1954034906006908930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 12:20:00');
INSERT INTO `quartz_log` VALUES (1954034906682294273, '用户解封', 'chatTaskService.banned()', '总共耗时：154毫秒', 'Y', '2025-08-09 12:20:00');
INSERT INTO `quartz_log` VALUES (1954036162511335426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 12:25:00');
INSERT INTO `quartz_log` VALUES (1954036164998660097, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 12:25:01');
INSERT INTO `quartz_log` VALUES (1954037420794146817, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 12:30:00');
INSERT INTO `quartz_log` VALUES (1954037422698360833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:30:00');
INSERT INTO `quartz_log` VALUES (1954037423038201857, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 12:30:01');
INSERT INTO `quartz_log` VALUES (1954038679051792385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:35:00');
INSERT INTO `quartz_log` VALUES (1954038681258098690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 12:35:00');
INSERT INTO `quartz_log` VALUES (1954039937363963905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:40:00');
INSERT INTO `quartz_log` VALUES (1954039937644982273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:40:00');
INSERT INTO `quartz_log` VALUES (1954039939662544897, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-09 12:40:01');
INSERT INTO `quartz_log` VALUES (1954041195676135426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 12:45:00');
INSERT INTO `quartz_log` VALUES (1954041197781778433, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-09 12:45:00');
INSERT INTO `quartz_log` VALUES (1954042453963141121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 12:50:00');
INSERT INTO `quartz_log` VALUES (1954042454260936706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 12:50:00');
INSERT INTO `quartz_log` VALUES (1954042456328830977, '用户解封', 'chatTaskService.banned()', '总共耗时：57毫秒', 'Y', '2025-08-09 12:50:01');
INSERT INTO `quartz_log` VALUES (1954043712237563905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 12:55:00');
INSERT INTO `quartz_log` VALUES (1954043714628419585, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 12:55:01');
INSERT INTO `quartz_log` VALUES (1954044970528763906, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 13:00:00');
INSERT INTO `quartz_log` VALUES (1954044970700730370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 13:00:00');
INSERT INTO `quartz_log` VALUES (1954044973133529089, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-09 13:00:01');
INSERT INTO `quartz_log` VALUES (1954046228828352514, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 13:05:00');
INSERT INTO `quartz_log` VALUES (1954046231105961986, '钱包补偿', 'walletReceiveService.task()', '总共耗时：83毫秒', 'Y', '2025-08-09 13:05:00');
INSERT INTO `quartz_log` VALUES (1954047487090192386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 13:10:00');
INSERT INTO `quartz_log` VALUES (1954047487283130369, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 13:10:00');
INSERT INTO `quartz_log` VALUES (1954047489300692994, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-09 13:10:00');
INSERT INTO `quartz_log` VALUES (1954048745431724033, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 13:15:00');
INSERT INTO `quartz_log` VALUES (1954048747684167681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：71毫秒', 'Y', '2025-08-09 13:15:01');
INSERT INTO `quartz_log` VALUES (1954050003680980994, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 13:20:00');
INSERT INTO `quartz_log` VALUES (1954050003873918977, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 13:20:00');
INSERT INTO `quartz_log` VALUES (1954050005744680961, '钱包任务', 'walletTaskService.task()', '总共耗时：35毫秒', 'Y', '2025-08-09 13:20:00');
INSERT INTO `quartz_log` VALUES (1954051261984763906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 13:25:00');
INSERT INTO `quartz_log` VALUES (1954051264144932865, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-09 13:25:00');
INSERT INTO `quartz_log` VALUES (1954052520301129729, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 13:30:00');
INSERT INTO `quartz_log` VALUES (1954052522083708930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 13:30:00');
INSERT INTO `quartz_log` VALUES (1954052522507436033, '用户解封', 'chatTaskService.banned()', '总共耗时：80毫秒', 'Y', '2025-08-09 13:30:00');
INSERT INTO `quartz_log` VALUES (1954053778550386689, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 13:35:00');
INSERT INTO `quartz_log` VALUES (1954053780584726530, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-09 13:35:00');
INSERT INTO `quartz_log` VALUES (1954055036854169602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 13:40:00');
INSERT INTO `quartz_log` VALUES (1954055037202296833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 13:40:00');
INSERT INTO `quartz_log` VALUES (1954055039152750594, '用户解封', 'chatTaskService.banned()', '总共耗时：54毫秒', 'Y', '2025-08-09 13:40:01');
INSERT INTO `quartz_log` VALUES (1954056295183118338, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 13:45:00');
INSERT INTO `quartz_log` VALUES (1954056297620111361, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-09 13:45:01');
INSERT INTO `quartz_log` VALUES (1954057553457541122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 13:50:00');
INSERT INTO `quartz_log` VALUES (1954057555319812098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 13:50:00');
INSERT INTO `quartz_log` VALUES (1954057555609321474, '用户解封', 'chatTaskService.banned()', '总共耗时：54毫秒', 'Y', '2025-08-09 13:50:00');
INSERT INTO `quartz_log` VALUES (1954058811773906945, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-09 13:55:00');
INSERT INTO `quartz_log` VALUES (1954058814227677185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-09 13:55:01');
INSERT INTO `quartz_log` VALUES (1954060070014775298, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 14:00:00');
INSERT INTO `quartz_log` VALUES (1954060070190936065, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 14:00:00');
INSERT INTO `quartz_log` VALUES (1954060072393048065, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-09 14:00:01');
INSERT INTO `quartz_log` VALUES (1954061328289198082, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:05:00');
INSERT INTO `quartz_log` VALUES (1954061330659082242, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-09 14:05:01');
INSERT INTO `quartz_log` VALUES (1954062586580398081, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:10:00');
INSERT INTO `quartz_log` VALUES (1954062586781724674, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 14:10:00');
INSERT INTO `quartz_log` VALUES (1954062589122248705, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-09 14:10:01');
INSERT INTO `quartz_log` VALUES (1954063844917735425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 14:15:00');
INSERT INTO `quartz_log` VALUES (1954063847350534146, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 14:15:01');
INSERT INTO `quartz_log` VALUES (1954065103208935426, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 14:20:00');
INSERT INTO `quartz_log` VALUES (1954065103544479745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 14:20:00');
INSERT INTO `quartz_log` VALUES (1954065105742397442, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-09 14:20:01');
INSERT INTO `quartz_log` VALUES (1954066361512718338, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 14:25:00');
INSERT INTO `quartz_log` VALUES (1954066363958099969, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-09 14:25:01');
INSERT INTO `quartz_log` VALUES (1954067619753586690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:30:00');
INSERT INTO `quartz_log` VALUES (1954067620051382273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:30:00');
INSERT INTO `quartz_log` VALUES (1954067622031196162, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-09 14:30:01');
INSERT INTO `quartz_log` VALUES (1954068878061563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:35:00');
INSERT INTO `quartz_log` VALUES (1954068880230121473, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-09 14:35:00');
INSERT INTO `quartz_log` VALUES (1954070136365346818, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 14:40:00');
INSERT INTO `quartz_log` VALUES (1954070136688308225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:40:00');
INSERT INTO `quartz_log` VALUES (1954070139234353154, '钱包任务', 'walletTaskService.task()', '总共耗时：89毫秒', 'Y', '2025-08-09 14:40:01');
INSERT INTO `quartz_log` VALUES (1954071394652352513, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 14:45:00');
INSERT INTO `quartz_log` VALUES (1954071397169037314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：86毫秒', 'Y', '2025-08-09 14:45:01');
INSERT INTO `quartz_log` VALUES (1954072652960329730, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 14:50:00');
INSERT INTO `quartz_log` VALUES (1954072653300068354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 14:50:00');
INSERT INTO `quartz_log` VALUES (1954072655229550594, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-09 14:50:01');
INSERT INTO `quartz_log` VALUES (1954073911209586690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 14:55:00');
INSERT INTO `quartz_log` VALUES (1954073913600442370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：71毫秒', 'Y', '2025-08-09 14:55:01');
INSERT INTO `quartz_log` VALUES (1954075169504980993, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:00:00');
INSERT INTO `quartz_log` VALUES (1954075169689530370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 15:00:00');
INSERT INTO `quartz_log` VALUES (1954075172105551874, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-09 15:00:01');
INSERT INTO `quartz_log` VALUES (1954076427817152513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 15:05:00');
INSERT INTO `quartz_log` VALUES (1954076430283505665, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-09 15:05:01');
INSERT INTO `quartz_log` VALUES (1954077686104158210, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:10:00');
INSERT INTO `quartz_log` VALUES (1954077688050315265, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:10:00');
INSERT INTO `quartz_log` VALUES (1954077688432099330, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-09 15:10:01');
INSERT INTO `quartz_log` VALUES (1954078944399552513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:15:00');
INSERT INTO `quartz_log` VALUES (1954078947042066433, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-09 15:15:01');
INSERT INTO `quartz_log` VALUES (1954080202699141122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 15:20:00');
INSERT INTO `quartz_log` VALUES (1954080204775321601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 15:20:01');
INSERT INTO `quartz_log` VALUES (1954080205165494273, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-09 15:20:01');
INSERT INTO `quartz_log` VALUES (1954081460977758209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:25:00');
INSERT INTO `quartz_log` VALUES (1954081463523803138, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 15:25:01');
INSERT INTO `quartz_log` VALUES (1954082719273152514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:30:00');
INSERT INTO `quartz_log` VALUES (1954082719558365185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:30:00');
INSERT INTO `quartz_log` VALUES (1954082721794031617, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-09 15:30:01');
INSERT INTO `quartz_log` VALUES (1954083977564352513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:35:00');
INSERT INTO `quartz_log` VALUES (1954083980072648706, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-09 15:35:01');
INSERT INTO `quartz_log` VALUES (1954085235855552514, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:40:00');
INSERT INTO `quartz_log` VALUES (1954085238003036161, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:40:01');
INSERT INTO `quartz_log` VALUES (1954085238560980993, '钱包任务', 'walletTaskService.task()', '总共耗时：95毫秒', 'Y', '2025-08-09 15:40:01');
INSERT INTO `quartz_log` VALUES (1954086494150946817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 15:45:00');
INSERT INTO `quartz_log` VALUES (1954086496873152514, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-09 15:45:01');
INSERT INTO `quartz_log` VALUES (1954087752450535425, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 15:50:00');
INSERT INTO `quartz_log` VALUES (1954087754719653890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 15:50:01');
INSERT INTO `quartz_log` VALUES (1954087755130798081, '用户解封', 'chatTaskService.banned()', '总共耗时：77毫秒', 'Y', '2025-08-09 15:50:01');
INSERT INTO `quartz_log` VALUES (1954089010733346817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 15:55:00');
INSERT INTO `quartz_log` VALUES (1954089012767686657, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 15:55:00');
INSERT INTO `quartz_log` VALUES (1954090269003575298, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 16:00:00');
INSERT INTO `quartz_log` VALUES (1954090270840680449, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 16:00:00');
INSERT INTO `quartz_log` VALUES (1954090271205687297, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-09 16:00:00');
INSERT INTO `quartz_log` VALUES (1954091527282192385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 16:05:00');
INSERT INTO `quartz_log` VALUES (1954091529354280962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-09 16:05:00');
INSERT INTO `quartz_log` VALUES (1954092785569198081, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:10:00');
INSERT INTO `quartz_log` VALUES (1954092787704098817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 16:10:01');
INSERT INTO `quartz_log` VALUES (1954092788190740482, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 16:10:01');
INSERT INTO `quartz_log` VALUES (1954094043885563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:15:00');
INSERT INTO `quartz_log` VALUES (1954094046674878465, '钱包任务', 'walletTaskService.task()', '总共耗时：42毫秒', 'Y', '2025-08-09 16:15:01');
INSERT INTO `quartz_log` VALUES (1954095302189346818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:20:00');
INSERT INTO `quartz_log` VALUES (1954095304223584258, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 16:20:01');
INSERT INTO `quartz_log` VALUES (1954095304655699969, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-09 16:20:01');
INSERT INTO `quartz_log` VALUES (1954096560446992386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 16:25:00');
INSERT INTO `quartz_log` VALUES (1954096562846236673, '钱包任务', 'walletTaskService.task()', '总共耗时：53毫秒', 'Y', '2025-08-09 16:25:01');
INSERT INTO `quartz_log` VALUES (1954097818754969602, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:30:00');
INSERT INTO `quartz_log` VALUES (1954097820671766529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 16:30:00');
INSERT INTO `quartz_log` VALUES (1954097821187768322, '钱包任务', 'walletTaskService.task()', '总共耗时：53毫秒', 'Y', '2025-08-09 16:30:01');
INSERT INTO `quartz_log` VALUES (1954099077033586690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 16:35:00');
INSERT INTO `quartz_log` VALUES (1954099079218921473, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-09 16:35:00');
INSERT INTO `quartz_log` VALUES (1954100335320592386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 16:40:00');
INSERT INTO `quartz_log` VALUES (1954100335760994306, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:40:00');
INSERT INTO `quartz_log` VALUES (1954100336054595585, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 16:40:00');
INSERT INTO `quartz_log` VALUES (1954101593645346817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:45:00');
INSERT INTO `quartz_log` VALUES (1954101596019429377, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-09 16:45:01');
INSERT INTO `quartz_log` VALUES (1954102851919769602, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 16:50:00');
INSERT INTO `quartz_log` VALUES (1954102853647822850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 16:50:00');
INSERT INTO `quartz_log` VALUES (1954102854159634434, '钱包任务', 'walletTaskService.task()', '总共耗时：48毫秒', 'Y', '2025-08-09 16:50:01');
INSERT INTO `quartz_log` VALUES (1954104110198386690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 16:55:00');
INSERT INTO `quartz_log` VALUES (1954104112547303426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-09 16:55:01');
INSERT INTO `quartz_log` VALUES (1954105368497975297, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:00:00');
INSERT INTO `quartz_log` VALUES (1954105370288943105, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 17:00:00');
INSERT INTO `quartz_log` VALUES (1954105370830114818, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-09 17:00:01');
INSERT INTO `quartz_log` VALUES (1954106626801758209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:05:00');
INSERT INTO `quartz_log` VALUES (1954106629180035074, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-09 17:05:01');
INSERT INTO `quartz_log` VALUES (1954107885084569602, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 17:10:00');
INSERT INTO `quartz_log` VALUES (1954107887009755137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 17:10:00');
INSERT INTO `quartz_log` VALUES (1954107887542538242, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 17:10:01');
INSERT INTO `quartz_log` VALUES (1954109143392546817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 17:15:00');
INSERT INTO `quartz_log` VALUES (1954109145846321154, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 17:15:01');
INSERT INTO `quartz_log` VALUES (1954110401692135425, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 17:20:00');
INSERT INTO `quartz_log` VALUES (1954110403445354498, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 17:20:00');
INSERT INTO `quartz_log` VALUES (1954110403864891394, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-09 17:20:00');
INSERT INTO `quartz_log` VALUES (1954111659941392385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:25:00');
INSERT INTO `quartz_log` VALUES (1954111661992513537, '钱包补偿', 'walletReceiveService.task()', '总共耗时：33毫秒', 'Y', '2025-08-09 17:25:00');
INSERT INTO `quartz_log` VALUES (1954112918261952514, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:30:00');
INSERT INTO `quartz_log` VALUES (1954112920124223489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:30:00');
INSERT INTO `quartz_log` VALUES (1954112920757669890, '用户解封', 'chatTaskService.banned()', '总共耗时：97毫秒', 'Y', '2025-08-09 17:30:01');
INSERT INTO `quartz_log` VALUES (1954114176540569601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:35:00');
INSERT INTO `quartz_log` VALUES (1954114178625245185, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-09 17:35:00');
INSERT INTO `quartz_log` VALUES (1954115434869518337, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 17:40:00');
INSERT INTO `quartz_log` VALUES (1954115436996030465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 17:40:01');
INSERT INTO `quartz_log` VALUES (1954115437533011970, '用户解封', 'chatTaskService.banned()', '总共耗时：78毫秒', 'Y', '2025-08-09 17:40:01');
INSERT INTO `quartz_log` VALUES (1954116693148135426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 17:45:00');
INSERT INTO `quartz_log` VALUES (1954116695635468290, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-09 17:45:01');
INSERT INTO `quartz_log` VALUES (1954117951443529730, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 17:50:00');
INSERT INTO `quartz_log` VALUES (1954117953423241217, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 17:50:01');
INSERT INTO `quartz_log` VALUES (1954117953846976514, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-09 17:50:01');
INSERT INTO `quartz_log` VALUES (1954119209713758210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 17:55:00');
INSERT INTO `quartz_log` VALUES (1954119210011553794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 17:55:00');
INSERT INTO `quartz_log` VALUES (1954120468009152514, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 18:00:00');
INSERT INTO `quartz_log` VALUES (1954120468340502529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 18:00:00');
INSERT INTO `quartz_log` VALUES (1954120471599595522, '钱包任务', 'walletTaskService.task()', '总共耗时：105毫秒', 'Y', '2025-08-09 18:00:01');
INSERT INTO `quartz_log` VALUES (1954121726329712642, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 18:05:00');
INSERT INTO `quartz_log` VALUES (1954121728724779010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-09 18:05:01');
INSERT INTO `quartz_log` VALUES (1954122984595746817, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 18:10:00');
INSERT INTO `quartz_log` VALUES (1954122986680315906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 18:10:01');
INSERT INTO `quartz_log` VALUES (1954122987099865090, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 18:10:01');
INSERT INTO `quartz_log` VALUES (1954124242874363906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 18:15:00');
INSERT INTO `quartz_log` VALUES (1954124245240070145, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 18:15:01');
INSERT INTO `quartz_log` VALUES (1954125501178146818, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 18:20:00');
INSERT INTO `quartz_log` VALUES (1954125503417905154, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 18:20:01');
INSERT INTO `quartz_log` VALUES (1954125503808094210, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 18:20:01');
INSERT INTO `quartz_log` VALUES (1954126759452569602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 18:25:00');
INSERT INTO `quartz_log` VALUES (1954126761763749890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 18:25:01');
INSERT INTO `quartz_log` VALUES (1954128017714409474, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 18:30:00');
INSERT INTO `quartz_log` VALUES (1954128019622817794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 18:30:00');
INSERT INTO `quartz_log` VALUES (1954128020214333442, '用户解封', 'chatTaskService.banned()', '总共耗时：83毫秒', 'Y', '2025-08-09 18:30:01');
INSERT INTO `quartz_log` VALUES (1954129276034969601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 18:35:00');
INSERT INTO `quartz_log` VALUES (1954129278258069505, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 18:35:01');
INSERT INTO `quartz_log` VALUES (1954130534347141122, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 18:40:00');
INSERT INTO `quartz_log` VALUES (1954130536322658305, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 18:40:01');
INSERT INTO `quartz_log` VALUES (1954130536662515714, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-09 18:40:01');
INSERT INTO `quartz_log` VALUES (1954131792642535426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 18:45:00');
INSERT INTO `quartz_log` VALUES (1954131794781749249, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-09 18:45:00');
INSERT INTO `quartz_log` VALUES (1954133050933735426, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 18:50:00');
INSERT INTO `quartz_log` VALUES (1954133052926029825, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 18:50:01');
INSERT INTO `quartz_log` VALUES (1954133053328801793, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-09 18:50:01');
INSERT INTO `quartz_log` VALUES (1954134309212352513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 18:55:00');
INSERT INTO `quartz_log` VALUES (1954134311565475841, '钱包任务', 'walletTaskService.task()', '总共耗时：86毫秒', 'Y', '2025-08-09 18:55:01');
INSERT INTO `quartz_log` VALUES (1954135567499358210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 19:00:00');
INSERT INTO `quartz_log` VALUES (1954135569361629185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 19:00:00');
INSERT INTO `quartz_log` VALUES (1954135569743429633, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-09 19:00:01');
INSERT INTO `quartz_log` VALUES (1954136825782169601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 19:05:00');
INSERT INTO `quartz_log` VALUES (1954136828026241026, '钱包补偿', 'walletReceiveService.task()', '总共耗时：56毫秒', 'Y', '2025-08-09 19:05:01');
INSERT INTO `quartz_log` VALUES (1954138084094341122, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 19:10:00');
INSERT INTO `quartz_log` VALUES (1954138085902086145, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 19:10:00');
INSERT INTO `quartz_log` VALUES (1954138086212583426, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-09 19:10:00');
INSERT INTO `quartz_log` VALUES (1954139342377152513, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 19:15:00');
INSERT INTO `quartz_log` VALUES (1954139345019682817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：192毫秒', 'Y', '2025-08-09 19:15:00');
INSERT INTO `quartz_log` VALUES (1954140600676741121, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 19:20:00');
INSERT INTO `quartz_log` VALUES (1954140602559983618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 19:20:00');
INSERT INTO `quartz_log` VALUES (1954140602933395458, '钱包任务', 'walletTaskService.task()', '总共耗时：54毫秒', 'Y', '2025-08-09 19:20:01');
INSERT INTO `quartz_log` VALUES (1954141858976329729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 19:25:00');
INSERT INTO `quartz_log` VALUES (1954141861514002434, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-09 19:25:01');
INSERT INTO `quartz_log` VALUES (1954143117246558210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 19:30:00');
INSERT INTO `quartz_log` VALUES (1954143119029137410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 19:30:00');
INSERT INTO `quartz_log` VALUES (1954143119490629633, '用户解封', 'chatTaskService.banned()', '总共耗时：81毫秒', 'Y', '2025-08-09 19:30:00');
INSERT INTO `quartz_log` VALUES (1954144375550341121, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 19:35:00');
INSERT INTO `quartz_log` VALUES (1954144377983156226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-09 19:35:01');
INSERT INTO `quartz_log` VALUES (1954145633833152513, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 19:40:00');
INSERT INTO `quartz_log` VALUES (1954145635619926018, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 19:40:00');
INSERT INTO `quartz_log` VALUES (1954145636135944193, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-09 19:40:01');
INSERT INTO `quartz_log` VALUES (1954146892136935425, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-09 19:45:00');
INSERT INTO `quartz_log` VALUES (1954146894712356865, '钱包补偿', 'walletReceiveService.task()', '总共耗时：55毫秒', 'Y', '2025-08-09 19:45:01');
INSERT INTO `quartz_log` VALUES (1954148150419746817, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 19:50:00');
INSERT INTO `quartz_log` VALUES (1954148152319766529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 19:50:00');
INSERT INTO `quartz_log` VALUES (1954148152760287234, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 19:50:01');
INSERT INTO `quartz_log` VALUES (1954149408706752513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 19:55:00');
INSERT INTO `quartz_log` VALUES (1954149411043098626, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-09 19:55:01');
INSERT INTO `quartz_log` VALUES (1954150666972786689, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:00:00');
INSERT INTO `quartz_log` VALUES (1954150668713422849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:00:00');
INSERT INTO `quartz_log` VALUES (1954150669170720770, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-09 20:00:00');
INSERT INTO `quartz_log` VALUES (1954151925284958209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 20:05:00');
INSERT INTO `quartz_log` VALUES (1954151927432560641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-09 20:05:00');
INSERT INTO `quartz_log` VALUES (1954153183580352513, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 20:10:00');
INSERT INTO `quartz_log` VALUES (1954153183911702529, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-09 20:10:00');
INSERT INTO `quartz_log` VALUES (1954153184196915201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:10:00');
INSERT INTO `quartz_log` VALUES (1954154441842192386, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 20:15:00');
INSERT INTO `quartz_log` VALUES (1954154444551835650, '钱包补偿', 'walletReceiveService.task()', '总共耗时：91毫秒', 'Y', '2025-08-09 20:15:01');
INSERT INTO `quartz_log` VALUES (1954155700141780993, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 20:20:00');
INSERT INTO `quartz_log` VALUES (1954155700393439233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 20:20:00');
INSERT INTO `quartz_log` VALUES (1954155703778365441, '用户解封', 'chatTaskService.banned()', '总共耗时：150毫秒', 'Y', '2025-08-09 20:20:01');
INSERT INTO `quartz_log` VALUES (1954156958428786690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:25:00');
INSERT INTO `quartz_log` VALUES (1954156960865800194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-09 20:25:01');
INSERT INTO `quartz_log` VALUES (1954158216740958209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:30:00');
INSERT INTO `quartz_log` VALUES (1954158218997493762, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:30:01');
INSERT INTO `quartz_log` VALUES (1954158219467378689, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-09 20:30:01');
INSERT INTO `quartz_log` VALUES (1954159474981826561, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 20:35:00');
INSERT INTO `quartz_log` VALUES (1954159477712441346, '钱包任务', 'walletTaskService.task()', '总共耗时：78毫秒', 'Y', '2025-08-09 20:35:01');
INSERT INTO `quartz_log` VALUES (1954160733335941121, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 20:40:00');
INSERT INTO `quartz_log` VALUES (1954160735319846913, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 20:40:01');
INSERT INTO `quartz_log` VALUES (1954160735651319809, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-09 20:40:01');
INSERT INTO `quartz_log` VALUES (1954161991631335425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 20:45:00');
INSERT INTO `quartz_log` VALUES (1954161993875410945, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-09 20:45:01');
INSERT INTO `quartz_log` VALUES (1954163249884786690, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 20:50:00');
INSERT INTO `quartz_log` VALUES (1954163251948384258, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 20:50:01');
INSERT INTO `quartz_log` VALUES (1954163252464406529, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-09 20:50:01');
INSERT INTO `quartz_log` VALUES (1954164508184375297, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 20:55:00');
INSERT INTO `quartz_log` VALUES (1954164510722052097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：56毫秒', 'Y', '2025-08-09 20:55:01');
INSERT INTO `quartz_log` VALUES (1954165766488158209, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-09 21:00:00');
INSERT INTO `quartz_log` VALUES (1954165768518201345, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 21:00:01');
INSERT INTO `quartz_log` VALUES (1954165769030029314, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-09 21:00:01');
INSERT INTO `quartz_log` VALUES (1954167024775163906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 21:05:00');
INSERT INTO `quartz_log` VALUES (1954167027363172354, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-09 21:05:01');
INSERT INTO `quartz_log` VALUES (1954168283091529729, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-09 21:10:00');
INSERT INTO `quartz_log` VALUES (1954168285129961473, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 21:10:01');
INSERT INTO `quartz_log` VALUES (1954168285662760962, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-09 21:10:01');
INSERT INTO `quartz_log` VALUES (1954169541370146818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 21:15:00');
INSERT INTO `quartz_log` VALUES (1954169544021073921, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-09 21:15:01');
INSERT INTO `quartz_log` VALUES (1954170799657152514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 21:20:00');
INSERT INTO `quartz_log` VALUES (1954170801708167169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 21:20:01');
INSERT INTO `quartz_log` VALUES (1954170802350022658, '用户解封', 'chatTaskService.banned()', '总共耗时：80毫秒', 'Y', '2025-08-09 21:20:01');
INSERT INTO `quartz_log` VALUES (1954172057948352514, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 21:25:00');
INSERT INTO `quartz_log` VALUES (1954172060351815681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-09 21:25:01');
INSERT INTO `quartz_log` VALUES (1954173318076657665, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 21:30:00');
INSERT INTO `quartz_log` VALUES (1954173318412201986, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 21:30:01');
INSERT INTO `quartz_log` VALUES (1954173318739484674, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-09 21:30:01');
INSERT INTO `quartz_log` VALUES (1954174574526558209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 21:35:00');
INSERT INTO `quartz_log` VALUES (1954174577315897346, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-09 21:35:01');
INSERT INTO `quartz_log` VALUES (1954175834524839938, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 21:40:00');
INSERT INTO `quartz_log` VALUES (1954175834835218434, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 21:40:01');
INSERT INTO `quartz_log` VALUES (1954175835162501122, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-09 21:40:01');
INSERT INTO `quartz_log` VALUES (1954177091117346818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 21:45:00');
INSERT INTO `quartz_log` VALUES (1954177093793439746, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-09 21:45:01');
INSERT INTO `quartz_log` VALUES (1954178349412741122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 21:50:00');
INSERT INTO `quartz_log` VALUES (1954178351442784257, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 21:50:01');
INSERT INTO `quartz_log` VALUES (1954178352000753665, '用户解封', 'chatTaskService.banned()', '总共耗时：33毫秒', 'Y', '2025-08-09 21:50:01');
INSERT INTO `quartz_log` VALUES (1954179609486520322, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 21:55:00');
INSERT INTO `quartz_log` VALUES (1954179610245816321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：71毫秒', 'Y', '2025-08-09 21:55:01');
INSERT INTO `quartz_log` VALUES (1954180867693834241, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 22:00:00');
INSERT INTO `quartz_log` VALUES (1954180867991629826, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 22:00:01');
INSERT INTO `quartz_log` VALUES (1954180868457324546, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-09 22:00:01');
INSERT INTO `quartz_log` VALUES (1954182126035365890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 22:05:00');
INSERT INTO `quartz_log` VALUES (1954182126807244801, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-09 22:05:01');
INSERT INTO `quartz_log` VALUES (1954183384100073473, '钱包任务', 'walletTaskService.task()', '总共耗时：14毫秒', 'Y', '2025-08-09 22:10:00');
INSERT INTO `quartz_log` VALUES (1954183384431423490, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 22:10:00');
INSERT INTO `quartz_log` VALUES (1954183384771289089, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-09 22:10:00');
INSERT INTO `quartz_log` VALUES (1954184642491936769, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 22:15:00');
INSERT INTO `quartz_log` VALUES (1954184643196706817, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-09 22:15:01');
INSERT INTO `quartz_log` VALUES (1954185901013823489, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-09 22:20:00');
INSERT INTO `quartz_log` VALUES (1954185901320007682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 22:20:01');
INSERT INTO `quartz_log` VALUES (1954185901659873281, '用户解封', 'chatTaskService.banned()', '总共耗时：56毫秒', 'Y', '2025-08-09 22:20:01');
INSERT INTO `quartz_log` VALUES (1954187158906564610, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 22:25:00');
INSERT INTO `quartz_log` VALUES (1954187159581974530, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-09 22:25:00');
INSERT INTO `quartz_log` VALUES (1954188417231319042, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 22:30:00');
INSERT INTO `quartz_log` VALUES (1954188417524920321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 22:30:00');
INSERT INTO `quartz_log` VALUES (1954188417910923265, '用户解封', 'chatTaskService.banned()', '总共耗时：56毫秒', 'Y', '2025-08-09 22:30:00');
INSERT INTO `quartz_log` VALUES (1954189674020958210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 22:35:00');
INSERT INTO `quartz_log` VALUES (1954189678953586690, '钱包任务', 'walletTaskService.task()', '总共耗时：233毫秒', 'Y', '2025-08-09 22:35:01');
INSERT INTO `quartz_log` VALUES (1954190934346395649, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-09 22:40:01');
INSERT INTO `quartz_log` VALUES (1954190934694522881, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 22:40:01');
INSERT INTO `quartz_log` VALUES (1954190935101497345, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-09 22:40:01');
INSERT INTO `quartz_log` VALUES (1954192192515960833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-09 22:45:00');
INSERT INTO `quartz_log` VALUES (1954192193313005570, '钱包任务', 'walletTaskService.task()', '总共耗时：75毫秒', 'Y', '2025-08-09 22:45:01');
INSERT INTO `quartz_log` VALUES (1954193450672943105, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 22:50:00');
INSERT INTO `quartz_log` VALUES (1954193451000098817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 22:50:01');
INSERT INTO `quartz_log` VALUES (1954193451407073282, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-09 22:50:01');
INSERT INTO `quartz_log` VALUES (1954194708918005762, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-09 22:55:00');
INSERT INTO `quartz_log` VALUES (1954194709677301761, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-09 22:55:01');
INSERT INTO `quartz_log` VALUES (1954195967242760193, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-09 23:00:00');
INSERT INTO `quartz_log` VALUES (1954195967540555778, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:00:01');
INSERT INTO `quartz_log` VALUES (1954195968052387842, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-09 23:00:01');
INSERT INTO `quartz_log` VALUES (1954197225395548162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-09 23:05:00');
INSERT INTO `quartz_log` VALUES (1954197226196787202, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-09 23:05:01');
INSERT INTO `quartz_log` VALUES (1954198483783217154, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 23:10:00');
INSERT INTO `quartz_log` VALUES (1954198484076818434, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:10:01');
INSERT INTO `quartz_log` VALUES (1954198484542513154, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-09 23:10:01');
INSERT INTO `quartz_log` VALUES (1954199742053445634, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-09 23:15:00');
INSERT INTO `quartz_log` VALUES (1954199742825324546, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-09 23:15:01');
INSERT INTO `quartz_log` VALUES (1954201000348839937, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 23:20:00');
INSERT INTO `quartz_log` VALUES (1954201000684384258, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:20:01');
INSERT INTO `quartz_log` VALUES (1954201001007472642, '用户解封', 'chatTaskService.banned()', '总共耗时：36毫秒', 'Y', '2025-08-09 23:20:01');
INSERT INTO `quartz_log` VALUES (1954202258686177281, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:25:00');
INSERT INTO `quartz_log` VALUES (1954202259558719489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：69毫秒', 'Y', '2025-08-09 23:25:01');
INSERT INTO `quartz_log` VALUES (1954203516742496257, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:30:00');
INSERT INTO `quartz_log` VALUES (1954203517065457665, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:30:00');
INSERT INTO `quartz_log` VALUES (1954203517438877698, '用户解封', 'chatTaskService.banned()', '总共耗时：34毫秒', 'Y', '2025-08-09 23:30:01');
INSERT INTO `quartz_log` VALUES (1954204775016919042, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 23:35:00');
INSERT INTO `quartz_log` VALUES (1954204775746854914, '钱包任务', 'walletTaskService.task()', '总共耗时：35毫秒', 'Y', '2025-08-09 23:35:01');
INSERT INTO `quartz_log` VALUES (1954206033597526017, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-09 23:40:00');
INSERT INTO `quartz_log` VALUES (1954206033949847553, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:40:01');
INSERT INTO `quartz_log` VALUES (1954206034486845441, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-09 23:40:01');
INSERT INTO `quartz_log` VALUES (1954207291662233601, '钱包任务', 'walletTaskService.task()', '总共耗时：11毫秒', 'Y', '2025-08-09 23:45:00');
INSERT INTO `quartz_log` VALUES (1954207292367003649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：32毫秒', 'Y', '2025-08-09 23:45:01');
INSERT INTO `quartz_log` VALUES (1954208549815021569, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-09 23:50:00');
INSERT INTO `quartz_log` VALUES (1954208550108622850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-09 23:50:00');
INSERT INTO `quartz_log` VALUES (1954208550528180226, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-09 23:50:01');
INSERT INTO `quartz_log` VALUES (1954209808034918402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-09 23:55:00');
INSERT INTO `quartz_log` VALUES (1954209808777437185, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-09 23:55:01');
INSERT INTO `quartz_log` VALUES (1954211066435170306, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 00:00:00');
INSERT INTO `quartz_log` VALUES (1954211066732965889, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 00:00:00');
INSERT INTO `quartz_log` VALUES (1954211067236409346, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 00:00:01');
INSERT INTO `quartz_log` VALUES (1954212324663455746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 00:05:00');
INSERT INTO `quartz_log` VALUES (1954212325443723266, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 00:05:01');
INSERT INTO `quartz_log` VALUES (1954213582916907010, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 00:10:00');
INSERT INTO `quartz_log` VALUES (1954213583252451330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 00:10:00');
INSERT INTO `quartz_log` VALUES (1954213583705563137, '用户解封', 'chatTaskService.banned()', '总共耗时：29毫秒', 'Y', '2025-08-10 00:10:01');
INSERT INTO `quartz_log` VALUES (1954214841266827265, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 00:15:00');
INSERT INTO `quartz_log` VALUES (1954214842051289090, '钱包任务', 'walletTaskService.task()', '总共耗时：29毫秒', 'Y', '2025-08-10 00:15:01');
INSERT INTO `quartz_log` VALUES (1954216098144546817, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 00:20:00');
INSERT INTO `quartz_log` VALUES (1954216098433953793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 00:20:00');
INSERT INTO `quartz_log` VALUES (1954216102938763265, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 00:20:01');
INSERT INTO `quartz_log` VALUES (1954217357777924097, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 00:25:00');
INSERT INTO `quartz_log` VALUES (1954217358621106178, '钱包补偿', 'walletReceiveService.task()', '总共耗时：29毫秒', 'Y', '2025-08-10 00:25:01');
INSERT INTO `quartz_log` VALUES (1954218614701780993, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 00:30:00');
INSERT INTO `quartz_log` VALUES (1954218614978605058, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 00:30:00');
INSERT INTO `quartz_log` VALUES (1954218617935716354, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 00:30:01');
INSERT INTO `quartz_log` VALUES (1954219874532290562, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-10 00:35:00');
INSERT INTO `quartz_log` VALUES (1954219875337723905, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 00:35:01');
INSERT INTO `quartz_log` VALUES (1954221131288375297, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 00:40:00');
INSERT INTO `quartz_log` VALUES (1954221131581976577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 00:40:00');
INSERT INTO `quartz_log` VALUES (1954221135549915138, '钱包任务', 'walletTaskService.task()', '总共耗时：86毫秒', 'Y', '2025-08-10 00:40:01');
INSERT INTO `quartz_log` VALUES (1954222391915802626, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 00:45:01');
INSERT INTO `quartz_log` VALUES (1954222392951922690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 00:45:01');
INSERT INTO `quartz_log` VALUES (1954223649032597506, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 00:50:00');
INSERT INTO `quartz_log` VALUES (1954223649355558913, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 00:50:00');
INSERT INTO `quartz_log` VALUES (1954223650005803009, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-10 00:50:00');
INSERT INTO `quartz_log` VALUES (1954224907315408898, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 00:55:00');
INSERT INTO `quartz_log` VALUES (1954224908351528962, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-10 00:55:00');
INSERT INTO `quartz_log` VALUES (1954226165984096257, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 01:00:00');
INSERT INTO `quartz_log` VALUES (1954226166311251970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 01:00:00');
INSERT INTO `quartz_log` VALUES (1954226166990856193, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-10 01:00:01');
INSERT INTO `quartz_log` VALUES (1954227423881031681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-10 01:05:00');
INSERT INTO `quartz_log` VALUES (1954227424837459969, '钱包任务', 'walletTaskService.task()', '总共耗时：54毫秒', 'Y', '2025-08-10 01:05:00');
INSERT INTO `quartz_log` VALUES (1954228682180620290, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 01:10:00');
INSERT INTO `quartz_log` VALUES (1954228682482610177, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 01:10:00');
INSERT INTO `quartz_log` VALUES (1954228683103494146, '用户解封', 'chatTaskService.banned()', '总共耗时：34毫秒', 'Y', '2025-08-10 01:10:00');
INSERT INTO `quartz_log` VALUES (1954229940480208897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 01:15:00');
INSERT INTO `quartz_log` VALUES (1954229941474385921, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-10 01:15:01');
INSERT INTO `quartz_log` VALUES (1954231198830129154, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 01:20:00');
INSERT INTO `quartz_log` VALUES (1954231199132119042, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 01:20:00');
INSERT INTO `quartz_log` VALUES (1954231199753003009, '用户解封', 'chatTaskService.banned()', '总共耗时：31毫秒', 'Y', '2025-08-10 01:20:01');
INSERT INTO `quartz_log` VALUES (1954232457012277249, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 01:25:00');
INSERT INTO `quartz_log` VALUES (1954232457943539714, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 01:25:00');
INSERT INTO `quartz_log` VALUES (1954233715102150658, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 01:30:00');
INSERT INTO `quartz_log` VALUES (1954233715458666498, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 01:30:00');
INSERT INTO `quartz_log` VALUES (1954233716104716289, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 01:30:00');
INSERT INTO `quartz_log` VALUES (1954234973414322177, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-10 01:35:00');
INSERT INTO `quartz_log` VALUES (1954234974450442241, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 01:35:00');
INSERT INTO `quartz_log` VALUES (1954236231814574082, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 01:40:00');
INSERT INTO `quartz_log` VALUES (1954236232145924097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 01:40:00');
INSERT INTO `quartz_log` VALUES (1954236232833916930, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 01:40:00');
INSERT INTO `quartz_log` VALUES (1954237490072219649, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 01:45:00');
INSERT INTO `quartz_log` VALUES (1954237491125116930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 01:45:00');
INSERT INTO `quartz_log` VALUES (1954238748363419649, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 01:50:00');
INSERT INTO `quartz_log` VALUES (1954238748682186754, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 01:50:00');
INSERT INTO `quartz_log` VALUES (1954238749437288450, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 01:50:00');
INSERT INTO `quartz_log` VALUES (1954240006608482306, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 01:55:00');
INSERT INTO `quartz_log` VALUES (1954240007774625794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：38毫秒', 'Y', '2025-08-10 01:55:00');
INSERT INTO `quartz_log` VALUES (1954241264924848130, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:00:00');
INSERT INTO `quartz_log` VALUES (1954241265218449409, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 02:00:00');
INSERT INTO `quartz_log` VALUES (1954241266036465665, '用户解封', 'chatTaskService.banned()', '总共耗时：34毫秒', 'Y', '2025-08-10 02:00:00');
INSERT INTO `quartz_log` VALUES (1954242523186688002, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 02:05:00');
INSERT INTO `quartz_log` VALUES (1954242524298305537, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 02:05:00');
INSERT INTO `quartz_log` VALUES (1954243781561774081, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 02:10:00');
INSERT INTO `quartz_log` VALUES (1954243781880541186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:10:00');
INSERT INTO `quartz_log` VALUES (1954243782665003010, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 02:10:01');
INSERT INTO `quartz_log` VALUES (1954245039811031041, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-10 02:15:00');
INSERT INTO `quartz_log` VALUES (1954245041186889729, '钱包任务', 'walletTaskService.task()', '总共耗时：102毫秒', 'Y', '2025-08-10 02:15:00');
INSERT INTO `quartz_log` VALUES (1954246298236448769, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:20:00');
INSERT INTO `quartz_log` VALUES (1954246298538438658, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 02:20:00');
INSERT INTO `quartz_log` VALUES (1954246299339677698, '钱包任务', 'walletTaskService.task()', '总共耗时：28毫秒', 'Y', '2025-08-10 02:20:01');
INSERT INTO `quartz_log` VALUES (1954247556368265217, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:25:00');
INSERT INTO `quartz_log` VALUES (1954247557467299841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：29毫秒', 'Y', '2025-08-10 02:25:00');
INSERT INTO `quartz_log` VALUES (1954248814684631041, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:30:00');
INSERT INTO `quartz_log` VALUES (1954248815007592449, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 02:30:00');
INSERT INTO `quartz_log` VALUES (1954248815804637185, '用户解封', 'chatTaskService.banned()', '总共耗时：29毫秒', 'Y', '2025-08-10 02:30:01');
INSERT INTO `quartz_log` VALUES (1954250072950665218, '钱包任务', 'walletTaskService.task()', '总共耗时：14毫秒', 'Y', '2025-08-10 02:35:00');
INSERT INTO `quartz_log` VALUES (1954250074024534017, '钱包补偿', 'walletReceiveService.task()', '总共耗时：28毫秒', 'Y', '2025-08-10 02:35:00');
INSERT INTO `quartz_log` VALUES (1954251331216699394, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 02:40:00');
INSERT INTO `quartz_log` VALUES (1954251331510300674, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:40:00');
INSERT INTO `quartz_log` VALUES (1954251332353482753, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 02:40:00');
INSERT INTO `quartz_log` VALUES (1954252589826666497, '钱包任务', 'walletTaskService.task()', '总共耗时：12毫秒', 'Y', '2025-08-10 02:45:00');
INSERT INTO `quartz_log` VALUES (1954252590938284034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 02:45:01');
INSERT INTO `quartz_log` VALUES (1954253848189169666, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 02:50:00');
INSERT INTO `quartz_log` VALUES (1954253848512131074, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 02:50:00');
INSERT INTO `quartz_log` VALUES (1954253849284009986, '钱包任务', 'walletTaskService.task()', '总共耗时：35毫秒', 'Y', '2025-08-10 02:50:01');
INSERT INTO `quartz_log` VALUES (1954255106513924098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 02:55:00');
INSERT INTO `quartz_log` VALUES (1954255107558432769, '钱包任务', 'walletTaskService.task()', '总共耗时：40毫秒', 'Y', '2025-08-10 02:55:01');
INSERT INTO `quartz_log` VALUES (1954256364662517761, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 03:00:00');
INSERT INTO `quartz_log` VALUES (1954256364989673473, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 03:00:00');
INSERT INTO `quartz_log` VALUES (1954256365274886146, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:00:00');
INSERT INTO `quartz_log` VALUES (1954256366369726465, '用户日活', 'chatTaskService.visit()', '总共耗时：226毫秒', 'Y', '2025-08-10 03:00:01');
INSERT INTO `quartz_log` VALUES (1954256369439956994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：42毫秒', 'Y', '2025-08-10 03:00:01');
INSERT INTO `quartz_log` VALUES (1954257623276679169, '钱包任务', 'walletTaskService.task()', '总共耗时：11毫秒', 'Y', '2025-08-10 03:05:00');
INSERT INTO `quartz_log` VALUES (1954257624061140993, '钱包补偿', 'walletReceiveService.task()', '总共耗时：28毫秒', 'Y', '2025-08-10 03:05:01');
INSERT INTO `quartz_log` VALUES (1954258881425272833, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-10 03:10:00');
INSERT INTO `quartz_log` VALUES (1954258881739845633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 03:10:00');
INSERT INTO `quartz_log` VALUES (1954258882171985921, '用户解封', 'chatTaskService.banned()', '总共耗时：37毫秒', 'Y', '2025-08-10 03:10:01');
INSERT INTO `quartz_log` VALUES (1954260139557089282, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 03:15:00');
INSERT INTO `quartz_log` VALUES (1954260140261859329, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 03:15:00');
INSERT INTO `quartz_log` VALUES (1954261397944758273, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 03:20:00');
INSERT INTO `quartz_log` VALUES (1954261398242553858, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:20:00');
INSERT INTO `quartz_log` VALUES (1954261398595002369, '用户解封', 'chatTaskService.banned()', '总共耗时：36毫秒', 'Y', '2025-08-10 03:20:00');
INSERT INTO `quartz_log` VALUES (1954262656198209537, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 03:25:00');
INSERT INTO `quartz_log` VALUES (1954262656819093506, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 03:25:00');
INSERT INTO `quartz_log` VALUES (1954263914611044353, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 03:30:00');
INSERT INTO `quartz_log` VALUES (1954263914904645633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:30:00');
INSERT INTO `quartz_log` VALUES (1954263915240316929, '钱包任务', 'walletTaskService.task()', '总共耗时：36毫秒', 'Y', '2025-08-10 03:30:00');
INSERT INTO `quartz_log` VALUES (1954265173023879169, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 03:35:00');
INSERT INTO `quartz_log` VALUES (1954265173640568834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：35毫秒', 'Y', '2025-08-10 03:35:01');
INSERT INTO `quartz_log` VALUES (1954266431382188034, '用户解封', 'chatTaskService.banned()', '总共耗时：13毫秒', 'Y', '2025-08-10 03:40:00');
INSERT INTO `quartz_log` VALUES (1954266431688372225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 03:40:00');
INSERT INTO `quartz_log` VALUES (1954266431927574530, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 03:40:01');
INSERT INTO `quartz_log` VALUES (1954267689685970945, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:45:00');
INSERT INTO `quartz_log` VALUES (1954267690348797954, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-10 03:45:01');
INSERT INTO `quartz_log` VALUES (1954268946353975298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:50:00');
INSERT INTO `quartz_log` VALUES (1954268948266577921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:50:00');
INSERT INTO `quartz_log` VALUES (1954268948681940994, '用户解封', 'chatTaskService.banned()', '总共耗时：34毫秒', 'Y', '2025-08-10 03:50:01');
INSERT INTO `quartz_log` VALUES (1954270204653563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 03:55:00');
INSERT INTO `quartz_log` VALUES (1954270206868283394, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-10 03:55:01');
INSERT INTO `quartz_log` VALUES (1954271462948958210, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 04:00:00');
INSERT INTO `quartz_log` VALUES (1954271464937058306, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:00:01');
INSERT INTO `quartz_log` VALUES (1954271465251758082, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 04:00:01');
INSERT INTO `quartz_log` VALUES (1954272721235963906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 04:05:00');
INSERT INTO `quartz_log` VALUES (1954272724050468866, '钱包任务', 'walletTaskService.task()', '总共耗时：48毫秒', 'Y', '2025-08-10 04:05:01');
INSERT INTO `quartz_log` VALUES (1954273979514580993, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 04:10:00');
INSERT INTO `quartz_log` VALUES (1954273981393629185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 04:10:00');
INSERT INTO `quartz_log` VALUES (1954273981779632129, '钱包任务', 'walletTaskService.task()', '总共耗时：37毫秒', 'Y', '2025-08-10 04:10:01');
INSERT INTO `quartz_log` VALUES (1954275237814169602, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 04:15:00');
INSERT INTO `quartz_log` VALUES (1954275240079220738, '钱包补偿', 'walletReceiveService.task()', '总共耗时：35毫秒', 'Y', '2025-08-10 04:15:01');
INSERT INTO `quartz_log` VALUES (1954276496113758209, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:20:00');
INSERT INTO `quartz_log` VALUES (1954276496302501889, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 04:20:00');
INSERT INTO `quartz_log` VALUES (1954276498664022018, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 04:20:01');
INSERT INTO `quartz_log` VALUES (1954277754409152514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:25:00');
INSERT INTO `quartz_log` VALUES (1954277756770672642, '钱包任务', 'walletTaskService.task()', '总共耗时：37毫秒', 'Y', '2025-08-10 04:25:01');
INSERT INTO `quartz_log` VALUES (1954279012704546817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:30:00');
INSERT INTO `quartz_log` VALUES (1954279014671675393, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 04:30:01');
INSERT INTO `quartz_log` VALUES (1954279014923460609, '用户解封', 'chatTaskService.banned()', '总共耗时：34毫秒', 'Y', '2025-08-10 04:30:01');
INSERT INTO `quartz_log` VALUES (1954280270995746817, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:35:00');
INSERT INTO `quartz_log` VALUES (1954280273088831490, '钱包补偿', 'walletReceiveService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 04:35:01');
INSERT INTO `quartz_log` VALUES (1954281529286946817, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 04:40:00');
INSERT INTO `quartz_log` VALUES (1954281531191160833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:40:00');
INSERT INTO `quartz_log` VALUES (1954281531405197314, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 04:40:01');
INSERT INTO `quartz_log` VALUES (1954282787569758209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 04:45:00');
INSERT INTO `quartz_log` VALUES (1954282789763506178, '钱包补偿', 'walletReceiveService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 04:45:01');
INSERT INTO `quartz_log` VALUES (1954284045856763905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 04:50:00');
INSERT INTO `quartz_log` VALUES (1954284047714840578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 04:50:00');
INSERT INTO `quartz_log` VALUES (1954284048012763138, '用户解封', 'chatTaskService.banned()', '总共耗时：30毫秒', 'Y', '2025-08-10 04:50:01');
INSERT INTO `quartz_log` VALUES (1954285304147963905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 04:55:00');
INSERT INTO `quartz_log` VALUES (1954285306324934657, '钱包补偿', 'walletReceiveService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 04:55:01');
INSERT INTO `quartz_log` VALUES (1954286562481106945, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 05:00:00');
INSERT INTO `quartz_log` VALUES (1954286564347572225, '群组降级', 'chatTaskService.level()', '总共耗时：10毫秒', 'Y', '2025-08-10 05:00:00');
INSERT INTO `quartz_log` VALUES (1954286564553093121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 05:00:01');
INSERT INTO `quartz_log` VALUES (1954286564624523266, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-10 05:00:01');
INSERT INTO `quartz_log` VALUES (1954287820755529729, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 05:05:00');
INSERT INTO `quartz_log` VALUES (1954287823108661249, '钱包补偿', 'walletReceiveService.task()', '总共耗时：34毫秒', 'Y', '2025-08-10 05:05:01');
INSERT INTO `quartz_log` VALUES (1954289079206113282, '钱包任务', 'walletTaskService.task()', '总共耗时：43毫秒', 'Y', '2025-08-10 05:10:00');
INSERT INTO `quartz_log` VALUES (1954289081064189953, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 05:10:01');
INSERT INTO `quartz_log` VALUES (1954289081374695426, '用户解封', 'chatTaskService.banned()', '总共耗时：34毫秒', 'Y', '2025-08-10 05:10:01');
INSERT INTO `quartz_log` VALUES (1954290337321152514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 05:15:00');
INSERT INTO `quartz_log` VALUES (1954290339967885314, '钱包任务', 'walletTaskService.task()', '总共耗时：39毫秒', 'Y', '2025-08-10 05:15:01');
INSERT INTO `quartz_log` VALUES (1954291595608158210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 05:20:00');
INSERT INTO `quartz_log` VALUES (1954291597814362114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 05:20:01');
INSERT INTO `quartz_log` VALUES (1954291598099701762, '用户解封', 'chatTaskService.banned()', '总共耗时：36毫秒', 'Y', '2025-08-10 05:20:01');
INSERT INTO `quartz_log` VALUES (1954292853895163906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 05:25:00');
INSERT INTO `quartz_log` VALUES (1954292856474787841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：36毫秒', 'Y', '2025-08-10 05:25:01');
INSERT INTO `quartz_log` VALUES (1954294112215724034, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-10 05:30:00');
INSERT INTO `quartz_log` VALUES (1954294114224795649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 05:30:01');
INSERT INTO `quartz_log` VALUES (1954294114552078337, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 05:30:01');
INSERT INTO `quartz_log` VALUES (1954295370502729729, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 05:35:00');
INSERT INTO `quartz_log` VALUES (1954295372855861249, '钱包补偿', 'walletReceiveService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 05:35:01');
INSERT INTO `quartz_log` VALUES (1954296628772958209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 05:40:00');
INSERT INTO `quartz_log` VALUES (1954296629066559489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 05:40:00');
INSERT INTO `quartz_log` VALUES (1954296631243530241, '用户解封', 'chatTaskService.banned()', '总共耗时：28毫秒', 'Y', '2025-08-10 05:40:01');
INSERT INTO `quartz_log` VALUES (1954297887055769601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 05:45:00');
INSERT INTO `quartz_log` VALUES (1954297889564090369, '钱包任务', 'walletTaskService.task()', '总共耗时：27毫秒', 'Y', '2025-08-10 05:45:01');
INSERT INTO `quartz_log` VALUES (1954299145351163906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 05:50:00');
INSERT INTO `quartz_log` VALUES (1954299145636376577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 05:50:00');
INSERT INTO `quartz_log` VALUES (1954299147846901762, '用户解封', 'chatTaskService.banned()', '总共耗时：31毫秒', 'Y', '2025-08-10 05:50:01');
INSERT INTO `quartz_log` VALUES (1954300403625586690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 05:55:00');
INSERT INTO `quartz_log` VALUES (1954300405966135297, '钱包补偿', 'walletReceiveService.task()', '总共耗时：45毫秒', 'Y', '2025-08-10 05:55:01');
INSERT INTO `quartz_log` VALUES (1954301661958729730, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 06:00:00');
INSERT INTO `quartz_log` VALUES (1954301663661617153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 06:00:00');
INSERT INTO `quartz_log` VALUES (1954301663787573250, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 06:00:00');
INSERT INTO `quartz_log` VALUES (1954302920245735425, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 06:05:00');
INSERT INTO `quartz_log` VALUES (1954302922418511873, '钱包补偿', 'walletReceiveService.task()', '总共耗时：41毫秒', 'Y', '2025-08-10 06:05:01');
INSERT INTO `quartz_log` VALUES (1954304178507575298, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 06:10:00');
INSERT INTO `quartz_log` VALUES (1954304178666958850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 06:10:00');
INSERT INTO `quartz_log` VALUES (1954304180772626434, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 06:10:01');
INSERT INTO `quartz_log` VALUES (1954305436807163905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 06:15:00');
INSERT INTO `quartz_log` VALUES (1954305439042854914, '钱包任务', 'walletTaskService.task()', '总共耗时：38毫秒', 'Y', '2025-08-10 06:15:01');
INSERT INTO `quartz_log` VALUES (1954306695069003778, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 06:20:00');
INSERT INTO `quartz_log` VALUES (1954306695249358850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 06:20:00');
INSERT INTO `quartz_log` VALUES (1954306697396969474, '用户解封', 'chatTaskService.banned()', '总共耗时：31毫秒', 'Y', '2025-08-10 06:20:01');
INSERT INTO `quartz_log` VALUES (1954307953385369602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 06:25:00');
INSERT INTO `quartz_log` VALUES (1954307955977576450, '钱包任务', 'walletTaskService.task()', '总共耗时：36毫秒', 'Y', '2025-08-10 06:25:01');
INSERT INTO `quartz_log` VALUES (1954309211680763905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 06:30:00');
INSERT INTO `quartz_log` VALUES (1954309213748555778, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 06:30:01');
INSERT INTO `quartz_log` VALUES (1954309214264582146, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-10 06:30:01');
INSERT INTO `quartz_log` VALUES (1954310469984546817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 06:35:00');
INSERT INTO `quartz_log` VALUES (1954310472367038465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：37毫秒', 'Y', '2025-08-10 06:35:01');
INSERT INTO `quartz_log` VALUES (1954311728271552514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 06:40:00');
INSERT INTO `quartz_log` VALUES (1954311730318372866, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 06:40:01');
INSERT INTO `quartz_log` VALUES (1954311730662432769, '用户解封', 'chatTaskService.banned()', '总共耗时：48毫秒', 'Y', '2025-08-10 06:40:01');
INSERT INTO `quartz_log` VALUES (1954312986558558210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 06:45:00');
INSERT INTO `quartz_log` VALUES (1954312989096239106, '钱包补偿', 'walletReceiveService.task()', '总共耗时：39毫秒', 'Y', '2025-08-10 06:45:01');
INSERT INTO `quartz_log` VALUES (1954314244832980994, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 06:50:00');
INSERT INTO `quartz_log` VALUES (1954314246904967170, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 06:50:01');
INSERT INTO `quartz_log` VALUES (1954314247240638466, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 06:50:01');
INSERT INTO `quartz_log` VALUES (1954315503124180994, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 06:55:00');
INSERT INTO `quartz_log` VALUES (1954315505565392897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：45毫秒', 'Y', '2025-08-10 06:55:01');
INSERT INTO `quartz_log` VALUES (1954316761423769601, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 07:00:00');
INSERT INTO `quartz_log` VALUES (1954316763600613378, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 07:00:01');
INSERT INTO `quartz_log` VALUES (1954316763902730242, '钱包任务', 'walletTaskService.task()', '总共耗时：43毫秒', 'Y', '2025-08-10 07:00:01');
INSERT INTO `quartz_log` VALUES (1954318019748524034, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 07:05:00');
INSERT INTO `quartz_log` VALUES (1954318022009380866, '钱包补偿', 'walletReceiveService.task()', '总共耗时：42毫秒', 'Y', '2025-08-10 07:05:01');
INSERT INTO `quartz_log` VALUES (1954319278027141121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 07:10:00');
INSERT INTO `quartz_log` VALUES (1954319279788748801, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 07:10:00');
INSERT INTO `quartz_log` VALUES (1954319280178946049, '用户解封', 'chatTaskService.banned()', '总共耗时：33毫秒', 'Y', '2025-08-10 07:10:01');
INSERT INTO `quartz_log` VALUES (1954320536301563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 07:15:00');
INSERT INTO `quartz_log` VALUES (1954320538587586562, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 07:15:01');
INSERT INTO `quartz_log` VALUES (1954321794605346818, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 07:20:00');
INSERT INTO `quartz_log` VALUES (1954321796501172226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 07:20:00');
INSERT INTO `quartz_log` VALUES (1954321796882980865, '钱包任务', 'walletTaskService.task()', '总共耗时：35毫秒', 'Y', '2025-08-10 07:20:01');
INSERT INTO `quartz_log` VALUES (1954323052888158209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 07:25:00');
INSERT INTO `quartz_log` VALUES (1954323055216123906, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-10 07:25:01');
INSERT INTO `quartz_log` VALUES (1954324311200329730, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-10 07:30:00');
INSERT INTO `quartz_log` VALUES (1954324313154875394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 07:30:01');
INSERT INTO `quartz_log` VALUES (1954324334638227458, '钱包任务', 'walletTaskService.task()', '总共耗时：5058毫秒', 'Y', '2025-08-10 07:30:01');
INSERT INTO `quartz_log` VALUES (1954325569487335425, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 07:35:00');
INSERT INTO `quartz_log` VALUES (1954325573765652482, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-10 07:35:01');
INSERT INTO `quartz_log` VALUES (1954326827753369602, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 07:40:00');
INSERT INTO `quartz_log` VALUES (1954326829728886786, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 07:40:00');
INSERT INTO `quartz_log` VALUES (1954326830131666946, '用户解封', 'chatTaskService.banned()', '总共耗时：36毫秒', 'Y', '2025-08-10 07:40:01');
INSERT INTO `quartz_log` VALUES (1954328086052958210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 07:45:00');
INSERT INTO `quartz_log` VALUES (1954328088594833409, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 07:45:01');
INSERT INTO `quartz_log` VALUES (1954329344344158209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 07:50:00');
INSERT INTO `quartz_log` VALUES (1954329346558750722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 07:50:01');
INSERT INTO `quartz_log` VALUES (1954329346844090370, '用户解封', 'chatTaskService.banned()', '总共耗时：33毫秒', 'Y', '2025-08-10 07:50:01');
INSERT INTO `quartz_log` VALUES (1954330602639552513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 07:55:00');
INSERT INTO `quartz_log` VALUES (1954330605030432770, '钱包补偿', 'walletReceiveService.task()', '总共耗时：35毫秒', 'Y', '2025-08-10 07:55:01');
INSERT INTO `quartz_log` VALUES (1954331860930752514, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 08:00:00');
INSERT INTO `quartz_log` VALUES (1954331862902075393, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 08:00:00');
INSERT INTO `quartz_log` VALUES (1954331863225163778, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 08:00:01');
INSERT INTO `quartz_log` VALUES (1954333119234535426, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 08:05:00');
INSERT INTO `quartz_log` VALUES (1954333119557496834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:05:00');
INSERT INTO `quartz_log` VALUES (1954334377492180994, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 08:10:00');
INSERT INTO `quartz_log` VALUES (1954334381829091329, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 08:10:01');
INSERT INTO `quartz_log` VALUES (1954334382412226562, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-10 08:10:01');
INSERT INTO `quartz_log` VALUES (1954335635779186689, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 08:15:00');
INSERT INTO `quartz_log` VALUES (1954335636169256962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:15:00');
INSERT INTO `quartz_log` VALUES (1954336894070386689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:20:00');
INSERT INTO `quartz_log` VALUES (1954336894284296193, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:20:00');
INSERT INTO `quartz_log` VALUES (1954336894636617730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:20:00');
INSERT INTO `quartz_log` VALUES (1954338152365780993, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:25:00');
INSERT INTO `quartz_log` VALUES (1954338152592273410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:25:00');
INSERT INTO `quartz_log` VALUES (1954339410690535426, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 08:30:00');
INSERT INTO `quartz_log` VALUES (1954339411017691138, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 08:30:00');
INSERT INTO `quartz_log` VALUES (1954339411311292417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:30:00');
INSERT INTO `quartz_log` VALUES (1954340668973346817, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 08:35:00');
INSERT INTO `quartz_log` VALUES (1954340669464080386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 08:35:00');
INSERT INTO `quartz_log` VALUES (1954341927289712641, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 08:40:00');
INSERT INTO `quartz_log` VALUES (1954341927621062657, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 08:40:00');
INSERT INTO `quartz_log` VALUES (1954341927910469633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:40:00');
INSERT INTO `quartz_log` VALUES (1954343185538969601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:45:00');
INSERT INTO `quartz_log` VALUES (1954343185861931010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:45:00');
INSERT INTO `quartz_log` VALUES (1954344443838558209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:50:00');
INSERT INTO `quartz_log` VALUES (1954344444174102529, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:50:00');
INSERT INTO `quartz_log` VALUES (1954344444463509506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:50:00');
INSERT INTO `quartz_log` VALUES (1954345702108786689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 08:55:00');
INSERT INTO `quartz_log` VALUES (1954345702414970881, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 08:55:00');
INSERT INTO `quartz_log` VALUES (1954346960425152514, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 09:00:00');
INSERT INTO `quartz_log` VALUES (1954346962379698177, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 09:00:00');
INSERT INTO `quartz_log` VALUES (1954346963440996354, '用户解封', 'chatTaskService.banned()', '总共耗时：151毫秒', 'Y', '2025-08-10 09:00:01');
INSERT INTO `quartz_log` VALUES (1954348220662509569, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 09:05:00');
INSERT INTO `quartz_log` VALUES (1954348221455372289, '钱包任务', 'walletTaskService.task()', '总共耗时：87毫秒', 'Y', '2025-08-10 09:05:01');
INSERT INTO `quartz_log` VALUES (1954349477003358209, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 09:10:00');
INSERT INTO `quartz_log` VALUES (1954349477334708225, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 09:10:00');
INSERT INTO `quartz_log` VALUES (1954349477628309505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 09:10:00');
INSERT INTO `quartz_log` VALUES (1954350737270075394, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 09:15:01');
INSERT INTO `quartz_log` VALUES (1954350738314600449, '钱包补偿', 'walletReceiveService.task()', '总共耗时：124毫秒', 'Y', '2025-08-10 09:15:01');
INSERT INTO `quartz_log` VALUES (1954351995355754498, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 09:20:00');
INSERT INTO `quartz_log` VALUES (1954351995678715905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 09:20:01');
INSERT INTO `quartz_log` VALUES (1954351996660326402, '用户解封', 'chatTaskService.banned()', '总共耗时：191毫秒', 'Y', '2025-08-10 09:20:01');
INSERT INTO `quartz_log` VALUES (1954353253458210817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 09:25:00');
INSERT INTO `quartz_log` VALUES (1954353254364323842, '钱包任务', 'walletTaskService.task()', '总共耗时：86毫秒', 'Y', '2025-08-10 09:25:01');
INSERT INTO `quartz_log` VALUES (1954354512374362114, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-10 09:30:01');
INSERT INTO `quartz_log` VALUES (1954354512705712129, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 09:30:01');
INSERT INTO `quartz_log` VALUES (1954354513091731457, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-10 09:30:01');
INSERT INTO `quartz_log` VALUES (1954355770069970946, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-10 09:35:00');
INSERT INTO `quartz_log` VALUES (1954355770770563073, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-10 09:35:01');
INSERT INTO `quartz_log` VALUES (1954357028113707010, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 09:40:00');
INSERT INTO `quartz_log` VALUES (1954357028411502593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 09:40:00');
INSERT INTO `quartz_log` VALUES (1954357028747190274, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-10 09:40:00');
INSERT INTO `quartz_log` VALUES (1954358286396518402, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 09:45:00');
INSERT INTO `quartz_log` VALUES (1954358287025807362, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 09:45:00');
INSERT INTO `quartz_log` VALUES (1954359544775798786, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 09:50:00');
INSERT INTO `quartz_log` VALUES (1954359545014874113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 09:50:00');
INSERT INTO `quartz_log` VALUES (1954359545434447873, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-10 09:50:00');
INSERT INTO `quartz_log` VALUES (1954360803553538049, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 09:55:00');
INSERT INTO `quartz_log` VALUES (1954360825124986882, '钱包任务', 'walletTaskService.task()', '总共耗时：5060毫秒', 'Y', '2025-08-10 09:55:01');
INSERT INTO `quartz_log` VALUES (1954362061496610817, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-10 10:00:00');
INSERT INTO `quartz_log` VALUES (1954362061702131714, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:00:00');
INSERT INTO `quartz_log` VALUES (1954362062180425729, '钱包任务', 'walletTaskService.task()', '总共耗时：78毫秒', 'Y', '2025-08-10 10:00:00');
INSERT INTO `quartz_log` VALUES (1954363318214946817, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 10:05:00');
INSERT INTO `quartz_log` VALUES (1954363322082238466, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-10 10:05:01');
INSERT INTO `quartz_log` VALUES (1954364578573938689, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 10:10:01');
INSERT INTO `quartz_log` VALUES (1954364578875928578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 10:10:01');
INSERT INTO `quartz_log` VALUES (1954364579341639682, '用户解封', 'chatTaskService.banned()', '总共耗时：93毫秒', 'Y', '2025-08-10 10:10:01');
INSERT INTO `quartz_log` VALUES (1954365836508622849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:15:00');
INSERT INTO `quartz_log` VALUES (1954365838018715649, '钱包任务', 'walletTaskService.task()', '总共耗时：221毫秒', 'Y', '2025-08-10 10:15:01');
INSERT INTO `quartz_log` VALUES (1954367094720131074, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 10:20:00');
INSERT INTO `quartz_log` VALUES (1954367095005343746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:20:00');
INSERT INTO `quartz_log` VALUES (1954367095353614337, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 10:20:01');
INSERT INTO `quartz_log` VALUES (1954368352902279170, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:25:00');
INSERT INTO `quartz_log` VALUES (1954368374582779905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5070毫秒', 'Y', '2025-08-10 10:25:00');
INSERT INTO `quartz_log` VALUES (1954369611461914626, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-10 10:30:00');
INSERT INTO `quartz_log` VALUES (1954369611742932994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:30:01');
INSERT INTO `quartz_log` VALUES (1954369633121443842, '钱包任务', 'walletTaskService.task()', '总共耗时：5069毫秒', 'Y', '2025-08-10 10:30:01');
INSERT INTO `quartz_log` VALUES (1954370869627285506, '钱包任务', 'walletTaskService.task()', '总共耗时：11毫秒', 'Y', '2025-08-10 10:35:00');
INSERT INTO `quartz_log` VALUES (1954370870223020034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-10 10:35:01');
INSERT INTO `quartz_log` VALUES (1954372126257541122, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 10:40:00');
INSERT INTO `quartz_log` VALUES (1954372128178532353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 10:40:00');
INSERT INTO `quartz_log` VALUES (1954372128736518146, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 10:40:01');
INSERT INTO `quartz_log` VALUES (1954373384552935426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:45:00');
INSERT INTO `quartz_log` VALUES (1954373387140964354, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 10:45:01');
INSERT INTO `quartz_log` VALUES (1954374644362473473, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 10:50:00');
INSERT INTO `quartz_log` VALUES (1954374644672851969, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 10:50:00');
INSERT INTO `quartz_log` VALUES (1954374645016928257, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 10:50:00');
INSERT INTO `quartz_log` VALUES (1954375902594953218, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 10:55:00');
INSERT INTO `quartz_log` VALUES (1954375903308128257, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 10:55:00');
INSERT INTO `quartz_log` VALUES (1954377161376886786, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 11:00:00');
INSERT INTO `quartz_log` VALUES (1954377161683070978, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 11:00:01');
INSERT INTO `quartz_log` VALUES (1954377162152976385, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-10 11:00:01');
INSERT INTO `quartz_log` VALUES (1954378419554840578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 11:05:00');
INSERT INTO `quartz_log` VALUES (1954378420318347265, '钱包任务', 'walletTaskService.task()', '总共耗时：81毫秒', 'Y', '2025-08-10 11:05:01');
INSERT INTO `quartz_log` VALUES (1954379677657296897, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 11:10:00');
INSERT INTO `quartz_log` VALUES (1954379677959286785, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 11:10:01');
INSERT INTO `quartz_log` VALUES (1954379678328528898, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-10 11:10:01');
INSERT INTO `quartz_log` VALUES (1954380935990439937, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 11:15:00');
INSERT INTO `quartz_log` VALUES (1954380936749752321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-10 11:15:01');
INSERT INTO `quartz_log` VALUES (1954382192587141121, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 11:20:00');
INSERT INTO `quartz_log` VALUES (1954382192876548098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 11:20:00');
INSERT INTO `quartz_log` VALUES (1954382197272322049, '用户解封', 'chatTaskService.banned()', '总共耗时：131毫秒', 'Y', '2025-08-10 11:20:01');
INSERT INTO `quartz_log` VALUES (1954383452358930434, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 11:25:00');
INSERT INTO `quartz_log` VALUES (1954383453135020034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 11:25:01');
INSERT INTO `quartz_log` VALUES (1954384710880817154, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 11:30:00');
INSERT INTO `quartz_log` VALUES (1954384711178612737, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 11:30:01');
INSERT INTO `quartz_log` VALUES (1954384711963095041, '用户解封', 'chatTaskService.banned()', '总共耗时：131毫秒', 'Y', '2025-08-10 11:30:01');
INSERT INTO `quartz_log` VALUES (1954385969201377282, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-10 11:35:00');
INSERT INTO `quartz_log` VALUES (1954385970120085506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：89毫秒', 'Y', '2025-08-10 11:35:01');
INSERT INTO `quartz_log` VALUES (1954387227819732994, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 11:40:01');
INSERT INTO `quartz_log` VALUES (1954387228151083009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 11:40:01');
INSERT INTO `quartz_log` VALUES (1954387228864274433, '用户解封', 'chatTaskService.banned()', '总共耗时：113毫秒', 'Y', '2025-08-10 11:40:01');
INSERT INTO `quartz_log` VALUES (1954388486278705153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 11:45:01');
INSERT INTO `quartz_log` VALUES (1954388487453274114, '钱包任务', 'walletTaskService.task()', '总共耗时：106毫秒', 'Y', '2025-08-10 11:45:01');
INSERT INTO `quartz_log` VALUES (1954389744687517697, '钱包任务', 'walletTaskService.task()', '总共耗时：41毫秒', 'Y', '2025-08-10 11:50:01');
INSERT INTO `quartz_log` VALUES (1954389749175422977, '用户解封', 'chatTaskService.banned()', '总共耗时：127毫秒', 'Y', '2025-08-10 11:50:02');
INSERT INTO `quartz_log` VALUES (1954389752581197826, '钱包补偿', 'walletReceiveService.task()', '总共耗时：46毫秒', 'Y', '2025-08-10 11:50:02');
INSERT INTO `quartz_log` VALUES (1954391002332622849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 11:55:00');
INSERT INTO `quartz_log` VALUES (1954391003234574337, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-10 11:55:01');
INSERT INTO `quartz_log` VALUES (1954392258904158210, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 12:00:00');
INSERT INTO `quartz_log` VALUES (1954392259176787970, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-10 12:00:00');
INSERT INTO `quartz_log` VALUES (1954392259407474690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 12:00:00');
INSERT INTO `quartz_log` VALUES (1954393518994714625, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 12:05:00');
INSERT INTO `quartz_log` VALUES (1954393519699537921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：72毫秒', 'Y', '2025-08-10 12:05:01');
INSERT INTO `quartz_log` VALUES (1954394777487241218, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 12:10:01');
INSERT INTO `quartz_log` VALUES (1954394777826979841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 12:10:01');
INSERT INTO `quartz_log` VALUES (1954394778192068610, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-10 12:10:01');
INSERT INTO `quartz_log` VALUES (1954396033777758210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 12:15:00');
INSERT INTO `quartz_log` VALUES (1954396036504240130, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-10 12:15:01');
INSERT INTO `quartz_log` VALUES (1954397292068958210, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 12:20:00');
INSERT INTO `quartz_log` VALUES (1954397294103195649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 12:20:01');
INSERT INTO `quartz_log` VALUES (1954397294543781889, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-10 12:20:01');
INSERT INTO `quartz_log` VALUES (1954398550372741122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 12:25:00');
INSERT INTO `quartz_log` VALUES (1954398552927256577, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-10 12:25:01');
INSERT INTO `quartz_log` VALUES (1954399808663941122, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 12:30:00');
INSERT INTO `quartz_log` VALUES (1954399808999485441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 12:30:00');
INSERT INTO `quartz_log` VALUES (1954399812355112962, '钱包任务', 'walletTaskService.task()', '总共耗时：100毫秒', 'Y', '2025-08-10 12:30:01');
INSERT INTO `quartz_log` VALUES (1954401066955141122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 12:35:00');
INSERT INTO `quartz_log` VALUES (1954401069463519234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：85毫秒', 'Y', '2025-08-10 12:35:01');
INSERT INTO `quartz_log` VALUES (1954402325237952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 12:40:00');
INSERT INTO `quartz_log` VALUES (1954402327205081090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 12:40:01');
INSERT INTO `quartz_log` VALUES (1954402327918297090, '用户解封', 'chatTaskService.banned()', '总共耗时：140毫秒', 'Y', '2025-08-10 12:40:01');
INSERT INTO `quartz_log` VALUES (1954403583512375298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 12:45:00');
INSERT INTO `quartz_log` VALUES (1954403585748123649, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 12:45:00');
INSERT INTO `quartz_log` VALUES (1954404841807769601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 12:50:00');
INSERT INTO `quartz_log` VALUES (1954404842088787970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：22毫秒', 'Y', '2025-08-10 12:50:00');
INSERT INTO `quartz_log` VALUES (1954404844353896449, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-10 12:50:01');
INSERT INTO `quartz_log` VALUES (1954406100124135426, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 12:55:00');
INSERT INTO `quartz_log` VALUES (1954406102255026178, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 12:55:00');
INSERT INTO `quartz_log` VALUES (1954407358390169602, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 13:00:00');
INSERT INTO `quartz_log` VALUES (1954407358725713922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 13:00:00');
INSERT INTO `quartz_log` VALUES (1954407360806273025, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-10 13:00:01');
INSERT INTO `quartz_log` VALUES (1954408616702341122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 13:05:00');
INSERT INTO `quartz_log` VALUES (1954408619122638850, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 13:05:01');
INSERT INTO `quartz_log` VALUES (1954409874980958210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:10:00');
INSERT INTO `quartz_log` VALUES (1954409875303919618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:10:00');
INSERT INTO `quartz_log` VALUES (1954409877422227458, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-10 13:10:01');
INSERT INTO `quartz_log` VALUES (1954411133280546818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:15:00');
INSERT INTO `quartz_log` VALUES (1954411135528878082, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 13:15:01');
INSERT INTO `quartz_log` VALUES (1954412391567552514, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:20:00');
INSERT INTO `quartz_log` VALUES (1954412391861153794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:20:00');
INSERT INTO `quartz_log` VALUES (1954412393849438210, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-10 13:20:01');
INSERT INTO `quartz_log` VALUES (1954413649871335426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 13:25:00');
INSERT INTO `quartz_log` VALUES (1954413652245495810, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-10 13:25:01');
INSERT INTO `quartz_log` VALUES (1954414908170924033, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 13:30:00');
INSERT INTO `quartz_log` VALUES (1954414908506468354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:30:00');
INSERT INTO `quartz_log` VALUES (1954414910507339777, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-10 13:30:01');
INSERT INTO `quartz_log` VALUES (1954416166428569602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 13:35:00');
INSERT INTO `quartz_log` VALUES (1954416168555270145, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 13:35:00');
INSERT INTO `quartz_log` VALUES (1954417424732352513, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 13:40:00');
INSERT INTO `quartz_log` VALUES (1954417425059508225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 13:40:00');
INSERT INTO `quartz_log` VALUES (1954417426909384706, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-10 13:40:00');
INSERT INTO `quartz_log` VALUES (1954418683010969602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 13:45:00');
INSERT INTO `quartz_log` VALUES (1954418685104115714, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 13:45:00');
INSERT INTO `quartz_log` VALUES (1954419941323141121, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 13:50:00');
INSERT INTO `quartz_log` VALUES (1954419941616742402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 13:50:00');
INSERT INTO `quartz_log` VALUES (1954419943865077761, '用户解封', 'chatTaskService.banned()', '总共耗时：165毫秒', 'Y', '2025-08-10 13:50:00');
INSERT INTO `quartz_log` VALUES (1954421199601758210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 13:55:00');
INSERT INTO `quartz_log` VALUES (1954421201741041666, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 13:55:00');
INSERT INTO `quartz_log` VALUES (1954422457905541121, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 14:00:00');
INSERT INTO `quartz_log` VALUES (1954422458236891137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 14:00:00');
INSERT INTO `quartz_log` VALUES (1954422460472643585, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 14:00:01');
INSERT INTO `quartz_log` VALUES (1954423716192546817, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 14:05:00');
INSERT INTO `quartz_log` VALUES (1954423718541545473, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 14:05:01');
INSERT INTO `quartz_log` VALUES (1954424974466969602, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 14:10:00');
INSERT INTO `quartz_log` VALUES (1954424974760570882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 14:10:00');
INSERT INTO `quartz_log` VALUES (1954424977050849282, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-10 14:10:01');
INSERT INTO `quartz_log` VALUES (1954426232758169601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 14:15:00');
INSERT INTO `quartz_log` VALUES (1954426235094585346, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-10 14:15:01');
INSERT INTO `quartz_log` VALUES (1954427491061952513, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 14:20:00');
INSERT INTO `quartz_log` VALUES (1954427491384913922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 14:20:00');
INSERT INTO `quartz_log` VALUES (1954427493322870786, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 14:20:01');
INSERT INTO `quartz_log` VALUES (1954428749353152514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 14:25:00');
INSERT INTO `quartz_log` VALUES (1954428751744094210, '钱包任务', 'walletTaskService.task()', '总共耗时：75毫秒', 'Y', '2025-08-10 14:25:01');
INSERT INTO `quartz_log` VALUES (1954430007640158209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 14:30:00');
INSERT INTO `quartz_log` VALUES (1954430007937953793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 14:30:00');
INSERT INTO `quartz_log` VALUES (1954430010043682818, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-10 14:30:01');
INSERT INTO `quartz_log` VALUES (1954431265948135426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 14:35:00');
INSERT INTO `quartz_log` VALUES (1954431268037087233, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-10 14:35:00');
INSERT INTO `quartz_log` VALUES (1954432524226752514, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 14:40:00');
INSERT INTO `quartz_log` VALUES (1954432524511965186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 14:40:00');
INSERT INTO `quartz_log` VALUES (1954432526483476481, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-10 14:40:01');
INSERT INTO `quartz_log` VALUES (1954433782492786689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 14:45:00');
INSERT INTO `quartz_log` VALUES (1954433784627875841, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-10 14:45:00');
INSERT INTO `quartz_log` VALUES (1954435040804958209, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 14:50:00');
INSERT INTO `quartz_log` VALUES (1954435041094365185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 14:50:00');
INSERT INTO `quartz_log` VALUES (1954435042889715714, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-10 14:50:00');
INSERT INTO `quartz_log` VALUES (1954436299066798081, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 14:55:00');
INSERT INTO `quartz_log` VALUES (1954436301201887234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 14:55:00');
INSERT INTO `quartz_log` VALUES (1954437557387358209, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-10 15:00:00');
INSERT INTO `quartz_log` VALUES (1954437557659987969, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 15:00:00');
INSERT INTO `quartz_log` VALUES (1954437559769911298, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 15:00:01');
INSERT INTO `quartz_log` VALUES (1954438815691141121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 15:05:00');
INSERT INTO `quartz_log` VALUES (1954438817884950530, '钱包任务', 'walletTaskService.task()', '总共耗时：87毫秒', 'Y', '2025-08-10 15:05:00');
INSERT INTO `quartz_log` VALUES (1954440073969758210, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 15:10:00');
INSERT INTO `quartz_log` VALUES (1954440074213027842, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 15:10:00');
INSERT INTO `quartz_log` VALUES (1954440076192927745, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-10 15:10:00');
INSERT INTO `quartz_log` VALUES (1954441332260958209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 15:15:00');
INSERT INTO `quartz_log` VALUES (1954441334391853057, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 15:15:00');
INSERT INTO `quartz_log` VALUES (1954442590560546817, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 15:20:00');
INSERT INTO `quartz_log` VALUES (1954442590891896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 15:20:00');
INSERT INTO `quartz_log` VALUES (1954442593081511937, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 15:20:01');
INSERT INTO `quartz_log` VALUES (1954443848855941121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 15:25:00');
INSERT INTO `quartz_log` VALUES (1954443851263660034, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-10 15:25:01');
INSERT INTO `quartz_log` VALUES (1954445107134558210, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 15:30:00');
INSERT INTO `quartz_log` VALUES (1954445107432353794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 15:30:00');
INSERT INTO `quartz_log` VALUES (1954445109626163202, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-10 15:30:01');
INSERT INTO `quartz_log` VALUES (1954446365438341121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 15:35:00');
INSERT INTO `quartz_log` VALUES (1954446367695065089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-10 15:35:01');
INSERT INTO `quartz_log` VALUES (1954447623725346818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 15:40:00');
INSERT INTO `quartz_log` VALUES (1954447624023142402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 15:40:00');
INSERT INTO `quartz_log` VALUES (1954447626091122689, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-10 15:40:01');
INSERT INTO `quartz_log` VALUES (1954448882016546817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 15:45:00');
INSERT INTO `quartz_log` VALUES (1954448884680118274, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-10 15:45:01');
INSERT INTO `quartz_log` VALUES (1954450140299358210, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 15:50:00');
INSERT INTO `quartz_log` VALUES (1954450140601348097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 15:50:00');
INSERT INTO `quartz_log` VALUES (1954450142736437249, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 15:50:01');
INSERT INTO `quartz_log` VALUES (1954451398594752514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 15:55:00');
INSERT INTO `quartz_log` VALUES (1954451402130739202, '钱包任务', 'walletTaskService.task()', '总共耗时：134毫秒', 'Y', '2025-08-10 15:55:01');
INSERT INTO `quartz_log` VALUES (1954452656885952514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 16:00:00');
INSERT INTO `quartz_log` VALUES (1954452657196331010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 16:00:00');
INSERT INTO `quartz_log` VALUES (1954452659599855618, '用户解封', 'chatTaskService.banned()', '总共耗时：78毫秒', 'Y', '2025-08-10 16:00:01');
INSERT INTO `quartz_log` VALUES (1954453915181346818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 16:05:00');
INSERT INTO `quartz_log` VALUES (1954453918989963266, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-10 16:05:01');
INSERT INTO `quartz_log` VALUES (1954455173472546817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 16:10:00');
INSERT INTO `quartz_log` VALUES (1954455173745176578, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 16:10:00');
INSERT INTO `quartz_log` VALUES (1954455175821545473, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-10 16:10:01');
INSERT INTO `quartz_log` VALUES (1954456431755358210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 16:15:00');
INSERT INTO `quartz_log` VALUES (1954456434330849281, '钱包补偿', 'walletReceiveService.task()', '总共耗时：81毫秒', 'Y', '2025-08-10 16:15:01');
INSERT INTO `quartz_log` VALUES (1954457690046558209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 16:20:00');
INSERT INTO `quartz_log` VALUES (1954457690407268354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 16:20:00');
INSERT INTO `quartz_log` VALUES (1954457692550746114, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-10 16:20:01');
INSERT INTO `quartz_log` VALUES (1954458948358729730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 16:25:00');
INSERT INTO `quartz_log` VALUES (1954458950640619522, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-10 16:25:01');
INSERT INTO `quartz_log` VALUES (1954460206637346818, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 16:30:00');
INSERT INTO `quartz_log` VALUES (1954460206939336705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 16:30:00');
INSERT INTO `quartz_log` VALUES (1954460208898265090, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 16:30:01');
INSERT INTO `quartz_log` VALUES (1954461464915963905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 16:35:00');
INSERT INTO `quartz_log` VALUES (1954461467134939138, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 16:35:00');
INSERT INTO `quartz_log` VALUES (1954462723211358210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 16:40:00');
INSERT INTO `quartz_log` VALUES (1954462723496570881, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 16:40:00');
INSERT INTO `quartz_log` VALUES (1954462725673603073, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-10 16:40:01');
INSERT INTO `quartz_log` VALUES (1954463981498363906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 16:45:00');
INSERT INTO `quartz_log` VALUES (1954463983876722690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-10 16:45:01');
INSERT INTO `quartz_log` VALUES (1954465239793758210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 16:50:00');
INSERT INTO `quartz_log` VALUES (1954465240120913921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 16:50:00');
INSERT INTO `quartz_log` VALUES (1954465242226642945, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-10 16:50:01');
INSERT INTO `quartz_log` VALUES (1954466498097541121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 16:55:00');
INSERT INTO `quartz_log` VALUES (1954466500509454337, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 16:55:01');
INSERT INTO `quartz_log` VALUES (1954467756384546818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 17:00:00');
INSERT INTO `quartz_log` VALUES (1954467756682342402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 17:00:00');
INSERT INTO `quartz_log` VALUES (1954467758779682818, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-10 17:00:01');
INSERT INTO `quartz_log` VALUES (1954469014658969601, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 17:05:00');
INSERT INTO `quartz_log` VALUES (1954469017049911298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 17:05:01');
INSERT INTO `quartz_log` VALUES (1954470272950169601, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 17:10:00');
INSERT INTO `quartz_log` VALUES (1954470273239576577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 17:10:00');
INSERT INTO `quartz_log` VALUES (1954470275500494850, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-10 17:10:01');
INSERT INTO `quartz_log` VALUES (1954471531224592385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 17:15:00');
INSERT INTO `quartz_log` VALUES (1954471533326127105, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 17:15:00');
INSERT INTO `quartz_log` VALUES (1954472789536763906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 17:20:00');
INSERT INTO `quartz_log` VALUES (1954472789830365185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 17:20:00');
INSERT INTO `quartz_log` VALUES (1954472792032563202, '用户解封', 'chatTaskService.banned()', '总共耗时：80毫秒', 'Y', '2025-08-10 17:20:01');
INSERT INTO `quartz_log` VALUES (1954474047823769602, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 17:25:00');
INSERT INTO `quartz_log` VALUES (1954474050051133441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：54毫秒', 'Y', '2025-08-10 17:25:01');
INSERT INTO `quartz_log` VALUES (1954475306127552513, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 17:30:00');
INSERT INTO `quartz_log` VALUES (1954475306429542402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 17:30:00');
INSERT INTO `quartz_log` VALUES (1954475308547854337, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-10 17:30:01');
INSERT INTO `quartz_log` VALUES (1954476564422946817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 17:35:00');
INSERT INTO `quartz_log` VALUES (1954476566616756225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：75毫秒', 'Y', '2025-08-10 17:35:00');
INSERT INTO `quartz_log` VALUES (1954477822705758210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 17:40:00');
INSERT INTO `quartz_log` VALUES (1954477823032913921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 17:40:00');
INSERT INTO `quartz_log` VALUES (1954477825117671426, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-10 17:40:01');
INSERT INTO `quartz_log` VALUES (1954479080967598081, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 17:45:00');
INSERT INTO `quartz_log` VALUES (1954479083379511297, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-10 17:45:01');
INSERT INTO `quartz_log` VALUES (1954480339304935426, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 17:50:00');
INSERT INTO `quartz_log` VALUES (1954480339602731009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 17:50:00');
INSERT INTO `quartz_log` VALUES (1954480341679099905, '用户解封', 'chatTaskService.banned()', '总共耗时：55毫秒', 'Y', '2025-08-10 17:50:01');
INSERT INTO `quartz_log` VALUES (1954481597558386690, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 17:55:00');
INSERT INTO `quartz_log` VALUES (1954481599978688513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-10 17:55:01');
INSERT INTO `quartz_log` VALUES (1954482855883141121, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 18:00:00');
INSERT INTO `quartz_log` VALUES (1954482856218685442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 18:00:00');
INSERT INTO `quartz_log` VALUES (1954482858253111297, '用户解封', 'chatTaskService.banned()', '总共耗时：54毫秒', 'Y', '2025-08-10 18:00:01');
INSERT INTO `quartz_log` VALUES (1954484114132398082, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:05:00');
INSERT INTO `quartz_log` VALUES (1954484116317818882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 18:05:00');
INSERT INTO `quartz_log` VALUES (1954485372440375298, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:10:00');
INSERT INTO `quartz_log` VALUES (1954485372658479105, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 18:10:00');
INSERT INTO `quartz_log` VALUES (1954485377029132290, '钱包任务', 'walletTaskService.task()', '总共耗时：116毫秒', 'Y', '2025-08-10 18:10:01');
INSERT INTO `quartz_log` VALUES (1954486630739963905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 18:15:00');
INSERT INTO `quartz_log` VALUES (1954486641590816770, '钱包任务', 'walletTaskService.task()', '总共耗时：113毫秒', 'Y', '2025-08-10 18:15:03');
INSERT INTO `quartz_log` VALUES (1954487889039552513, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 18:20:00');
INSERT INTO `quartz_log` VALUES (1954487889375096834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 18:20:00');
INSERT INTO `quartz_log` VALUES (1954487892273549313, '钱包任务', 'walletTaskService.task()', '总共耗时：107毫秒', 'Y', '2025-08-10 18:20:01');
INSERT INTO `quartz_log` VALUES (1954489147360112641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:25:00');
INSERT INTO `quartz_log` VALUES (1954489151072260097, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-10 18:25:01');
INSERT INTO `quartz_log` VALUES (1954490405647118337, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-10 18:30:00');
INSERT INTO `quartz_log` VALUES (1954490405978468353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:30:00');
INSERT INTO `quartz_log` VALUES (1954490407639601154, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-10 18:30:00');
INSERT INTO `quartz_log` VALUES (1954491663908958210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 18:35:00');
INSERT INTO `quartz_log` VALUES (1954491708058390530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10064毫秒', 'Y', '2025-08-10 18:35:00');
INSERT INTO `quartz_log` VALUES (1954492922208546818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:40:00');
INSERT INTO `quartz_log` VALUES (1954492922506342402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:40:00');
INSERT INTO `quartz_log` VALUES (1954492945323544577, '用户解封', 'chatTaskService.banned()', '总共耗时：5069毫秒', 'Y', '2025-08-10 18:40:00');
INSERT INTO `quartz_log` VALUES (1954494180478775298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 18:45:00');
INSERT INTO `quartz_log` VALUES (1954494182760665090, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-10 18:45:01');
INSERT INTO `quartz_log` VALUES (1954495438799335425, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-10 18:50:00');
INSERT INTO `quartz_log` VALUES (1954495439130685441, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 18:50:00');
INSERT INTO `quartz_log` VALUES (1954495441102196737, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 18:50:01');
INSERT INTO `quartz_log` VALUES (1954496697199587330, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 18:55:00');
INSERT INTO `quartz_log` VALUES (1954496699225624577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 18:55:00');
INSERT INTO `quartz_log` VALUES (1954497955377541122, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 19:00:00');
INSERT INTO `quartz_log` VALUES (1954497955679531009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 19:00:00');
INSERT INTO `quartz_log` VALUES (1954497957516824577, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-10 19:00:00');
INSERT INTO `quartz_log` VALUES (1954499213656158209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 19:05:00');
INSERT INTO `quartz_log` VALUES (1954499215975796738, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-10 19:05:01');
INSERT INTO `quartz_log` VALUES (1954500471947358210, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 19:10:00');
INSERT INTO `quartz_log` VALUES (1954500472236765186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 19:10:00');
INSERT INTO `quartz_log` VALUES (1954500474178916353, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-10 19:10:00');
INSERT INTO `quartz_log` VALUES (1954501730238558210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 19:15:00');
INSERT INTO `quartz_log` VALUES (1954501732717580289, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-10 19:15:01');
INSERT INTO `quartz_log` VALUES (1954502988542341121, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 19:20:00');
INSERT INTO `quartz_log` VALUES (1954502988856913921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 19:20:00');
INSERT INTO `quartz_log` VALUES (1954502991004585985, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-10 19:20:01');
INSERT INTO `quartz_log` VALUES (1954504246799986690, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 19:25:00');
INSERT INTO `quartz_log` VALUES (1954504249220288514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-10 19:25:01');
INSERT INTO `quartz_log` VALUES (1954505505095380994, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 19:30:00');
INSERT INTO `quartz_log` VALUES (1954505505334456322, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 19:30:00');
INSERT INTO `quartz_log` VALUES (1954505507645706242, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 19:30:01');
INSERT INTO `quartz_log` VALUES (1954506763373998082, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 19:35:00');
INSERT INTO `quartz_log` VALUES (1954506765769134082, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-10 19:35:01');
INSERT INTO `quartz_log` VALUES (1954508021677780993, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 19:40:00');
INSERT INTO `quartz_log` VALUES (1954508021962993666, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 19:40:00');
INSERT INTO `quartz_log` VALUES (1954508024081305601, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 19:40:01');
INSERT INTO `quartz_log` VALUES (1954509279989952513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 19:45:00');
INSERT INTO `quartz_log` VALUES (1954509282385088514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 19:45:01');
INSERT INTO `quartz_log` VALUES (1954510538302124033, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 19:50:00');
INSERT INTO `quartz_log` VALUES (1954510538587336705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 19:50:00');
INSERT INTO `quartz_log` VALUES (1954510540722425858, '用户解封', 'chatTaskService.banned()', '总共耗时：69毫秒', 'Y', '2025-08-10 19:50:01');
INSERT INTO `quartz_log` VALUES (1954511796593324033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-10 19:55:00');
INSERT INTO `quartz_log` VALUES (1954511799105900545, '钱包任务', 'walletTaskService.task()', '总共耗时：91毫秒', 'Y', '2025-08-10 19:55:01');
INSERT INTO `quartz_log` VALUES (1954513054863552514, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 20:00:00');
INSERT INTO `quartz_log` VALUES (1954513055186513921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 20:00:00');
INSERT INTO `quartz_log` VALUES (1954513057296437249, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-10 20:00:01');
INSERT INTO `quartz_log` VALUES (1954514313150558209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 20:05:00');
INSERT INTO `quartz_log` VALUES (1954514315579248641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 20:05:01');
INSERT INTO `quartz_log` VALUES (1954515571437563905, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 20:10:00');
INSERT INTO `quartz_log` VALUES (1954515571726970882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 20:10:00');
INSERT INTO `quartz_log` VALUES (1954515573887225857, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 20:10:01');
INSERT INTO `quartz_log` VALUES (1954516829732958209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 20:15:00');
INSERT INTO `quartz_log` VALUES (1954516832044208130, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 20:15:01');
INSERT INTO `quartz_log` VALUES (1954518088028352513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 20:20:00');
INSERT INTO `quartz_log` VALUES (1954518088313565185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 20:20:00');
INSERT INTO `quartz_log` VALUES (1954518090457042946, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-10 20:20:01');
INSERT INTO `quartz_log` VALUES (1954519346323746818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 20:25:00');
INSERT INTO `quartz_log` VALUES (1954519348739854337, '钱包补偿', 'walletReceiveService.task()', '总共耗时：76毫秒', 'Y', '2025-08-10 20:25:01');
INSERT INTO `quartz_log` VALUES (1954520604619141122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 20:30:00');
INSERT INTO `quartz_log` VALUES (1954520604929519618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 20:30:00');
INSERT INTO `quartz_log` VALUES (1954520606775201794, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-10 20:30:00');
INSERT INTO `quartz_log` VALUES (1954521862897758209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 20:35:00');
INSERT INTO `quartz_log` VALUES (1954521865175453697, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-10 20:35:01');
INSERT INTO `quartz_log` VALUES (1954523121180569602, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 20:40:00');
INSERT INTO `quartz_log` VALUES (1954523121503531010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 20:40:00');
INSERT INTO `quartz_log` VALUES (1954523123609260033, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-10 20:40:01');
INSERT INTO `quartz_log` VALUES (1954524379488546817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 20:45:00');
INSERT INTO `quartz_log` VALUES (1954524381971767298, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-10 20:45:01');
INSERT INTO `quartz_log` VALUES (1954525637800718337, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-10 20:50:00');
INSERT INTO `quartz_log` VALUES (1954525638140456962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 20:50:00');
INSERT INTO `quartz_log` VALUES (1954525640313298945, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-10 20:50:01');
INSERT INTO `quartz_log` VALUES (1954526896075141122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 20:55:00');
INSERT INTO `quartz_log` VALUES (1954526898608693249, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-10 20:55:01');
INSERT INTO `quartz_log` VALUES (1954528154324398081, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:00:00');
INSERT INTO `quartz_log` VALUES (1954528154655748097, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-10 21:00:00');
INSERT INTO `quartz_log` VALUES (1954528154953543681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 21:00:00');
INSERT INTO `quartz_log` VALUES (1954529412640763906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 21:05:00');
INSERT INTO `quartz_log` VALUES (1954529412997279746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 21:05:00');
INSERT INTO `quartz_log` VALUES (1954530670910992386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 21:10:00');
INSERT INTO `quartz_log` VALUES (1954530671233953794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:10:00');
INSERT INTO `quartz_log` VALUES (1954530674975473666, '用户解封', 'chatTaskService.banned()', '总共耗时：156毫秒', 'Y', '2025-08-10 21:10:01');
INSERT INTO `quartz_log` VALUES (1954531929223163906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:15:00');
INSERT INTO `quartz_log` VALUES (1954531931555401729, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 21:15:01');
INSERT INTO `quartz_log` VALUES (1954533187526946817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 21:20:00');
INSERT INTO `quartz_log` VALUES (1954533187824742401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:20:00');
INSERT INTO `quartz_log` VALUES (1954533190165372930, '用户解封', 'chatTaskService.banned()', '总共耗时：89毫秒', 'Y', '2025-08-10 21:20:01');
INSERT INTO `quartz_log` VALUES (1954534445830729729, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 21:25:00');
INSERT INTO `quartz_log` VALUES (1954534446124331009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 21:25:00');
INSERT INTO `quartz_log` VALUES (1954535704105152513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 21:30:00');
INSERT INTO `quartz_log` VALUES (1954535704402948098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 21:30:00');
INSERT INTO `quartz_log` VALUES (1954535706995249154, '用户解封', 'chatTaskService.banned()', '总共耗时：155毫秒', 'Y', '2025-08-10 21:30:01');
INSERT INTO `quartz_log` VALUES (1954536962387963906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:35:00');
INSERT INTO `quartz_log` VALUES (1954536962673176577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:35:00');
INSERT INTO `quartz_log` VALUES (1954538220649803777, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 21:40:00');
INSERT INTO `quartz_log` VALUES (1954538220985348098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:40:00');
INSERT INTO `quartz_log` VALUES (1954538223237918721, '用户解封', 'chatTaskService.banned()', '总共耗时：76毫秒', 'Y', '2025-08-10 21:40:01');
INSERT INTO `quartz_log` VALUES (1954539478978752513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 21:45:00');
INSERT INTO `quartz_log` VALUES (1954539481432649729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-10 21:45:01');
INSERT INTO `quartz_log` VALUES (1954540737274146818, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-10 21:50:00');
INSERT INTO `quartz_log` VALUES (1954540737576136705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 21:50:00');
INSERT INTO `quartz_log` VALUES (1954540740738871297, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-10 21:50:01');
INSERT INTO `quartz_log` VALUES (1954541995569541122, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 21:55:00');
INSERT INTO `quartz_log` VALUES (1954541997868249089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：29毫秒', 'Y', '2025-08-10 21:55:01');
INSERT INTO `quartz_log` VALUES (1954543253852352514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 22:00:00');
INSERT INTO `quartz_log` VALUES (1954543254154342401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 22:00:00');
INSERT INTO `quartz_log` VALUES (1954543256134283265, '用户解封', 'chatTaskService.banned()', '总共耗时：32毫秒', 'Y', '2025-08-10 22:00:01');
INSERT INTO `quartz_log` VALUES (1954544512139358209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 22:05:00');
INSERT INTO `quartz_log` VALUES (1954544514459037697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：31毫秒', 'Y', '2025-08-10 22:05:01');
INSERT INTO `quartz_log` VALUES (1954545770430558210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 22:10:00');
INSERT INTO `quartz_log` VALUES (1954545770740936705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 22:10:00');
INSERT INTO `quartz_log` VALUES (1954545773022867457, '用户解封', 'chatTaskService.banned()', '总共耗时：44毫秒', 'Y', '2025-08-10 22:10:01');
INSERT INTO `quartz_log` VALUES (1954547028717563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 22:15:00');
INSERT INTO `quartz_log` VALUES (1954547031179849729, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-10 22:15:01');
INSERT INTO `quartz_log` VALUES (1954548287025541121, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 22:20:00');
INSERT INTO `quartz_log` VALUES (1954548287377862657, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-10 22:20:00');
INSERT INTO `quartz_log` VALUES (1954548289777238017, '钱包任务', 'walletTaskService.task()', '总共耗时：75毫秒', 'Y', '2025-08-10 22:20:01');
INSERT INTO `quartz_log` VALUES (1954549545312546818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 22:25:00');
INSERT INTO `quartz_log` VALUES (1954549547636424706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-10 22:25:01');
INSERT INTO `quartz_log` VALUES (1954550803582775297, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 22:30:00');
INSERT INTO `quartz_log` VALUES (1954550803771518977, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-10 22:30:00');
INSERT INTO `quartz_log` VALUES (1954550806246391809, '用户解封', 'chatTaskService.banned()', '总共耗时：106毫秒', 'Y', '2025-08-10 22:30:01');
INSERT INTO `quartz_log` VALUES (1954552061882363905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 22:35:00');
INSERT INTO `quartz_log` VALUES (1954552064554369026, '钱包任务', 'walletTaskService.task()', '总共耗时：100毫秒', 'Y', '2025-08-10 22:35:01');
INSERT INTO `quartz_log` VALUES (1954553320177758210, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 22:40:00');
INSERT INTO `quartz_log` VALUES (1954553320500719617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 22:40:00');
INSERT INTO `quartz_log` VALUES (1954553322606493698, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-10 22:40:01');
INSERT INTO `quartz_log` VALUES (1954554578477346817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 22:45:00');
INSERT INTO `quartz_log` VALUES (1954554580834779137, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-10 22:45:01');
INSERT INTO `quartz_log` VALUES (1954555836768546818, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-10 22:50:00');
INSERT INTO `quartz_log` VALUES (1954555837062148098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 22:50:00');
INSERT INTO `quartz_log` VALUES (1954555839226642434, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-10 22:50:01');
INSERT INTO `quartz_log` VALUES (1954557095068135426, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-10 22:55:00');
INSERT INTO `quartz_log` VALUES (1954557097404596225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 22:55:01');
INSERT INTO `quartz_log` VALUES (1954558353350946818, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:00:00');
INSERT INTO `quartz_log` VALUES (1954558353673908225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:00:00');
INSERT INTO `quartz_log` VALUES (1954558355796459522, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-10 23:00:01');
INSERT INTO `quartz_log` VALUES (1954559611633758210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:05:00');
INSERT INTO `quartz_log` VALUES (1954559613949247489, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-10 23:05:01');
INSERT INTO `quartz_log` VALUES (1954560869895598082, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-10 23:10:00');
INSERT INTO `quartz_log` VALUES (1954560870143062018, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:10:00');
INSERT INTO `quartz_log` VALUES (1954560872265613313, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 23:10:01');
INSERT INTO `quartz_log` VALUES (1954562128195186689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:15:00');
INSERT INTO `quartz_log` VALUES (1954562130712002562, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-10 23:15:01');
INSERT INTO `quartz_log` VALUES (1954563386519941121, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 23:20:00');
INSERT INTO `quartz_log` VALUES (1954563386800959490, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 23:20:00');
INSERT INTO `quartz_log` VALUES (1954563388894150658, '钱包任务', 'walletTaskService.task()', '总共耗时：75毫秒', 'Y', '2025-08-10 23:20:01');
INSERT INTO `quartz_log` VALUES (1954564644802752514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 23:25:00');
INSERT INTO `quartz_log` VALUES (1954564646933692418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-10 23:25:00');
INSERT INTO `quartz_log` VALUES (1954565903098146817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-10 23:30:00');
INSERT INTO `quartz_log` VALUES (1954565903387553794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 23:30:00');
INSERT INTO `quartz_log` VALUES (1954565905459773441, '用户解封', 'chatTaskService.banned()', '总共耗时：77毫秒', 'Y', '2025-08-10 23:30:01');
INSERT INTO `quartz_log` VALUES (1954567161368375298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 23:35:00');
INSERT INTO `quartz_log` VALUES (1954567163532869634, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-10 23:35:00');
INSERT INTO `quartz_log` VALUES (1954568419655380994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:40:00');
INSERT INTO `quartz_log` VALUES (1954568419940593665, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-10 23:40:00');
INSERT INTO `quartz_log` VALUES (1954568422012813314, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-10 23:40:01');
INSERT INTO `quartz_log` VALUES (1954569677959163905, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:45:00');
INSERT INTO `quartz_log` VALUES (1954569681038016514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：223毫秒', 'Y', '2025-08-10 23:45:01');
INSERT INTO `quartz_log` VALUES (1954570936267141122, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-10 23:50:00');
INSERT INTO `quartz_log` VALUES (1954570936560742401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-10 23:50:00');
INSERT INTO `quartz_log` VALUES (1954570938565853186, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-10 23:50:01');
INSERT INTO `quartz_log` VALUES (1954572194545758210, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-10 23:55:00');
INSERT INTO `quartz_log` VALUES (1954572196806721538, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-10 23:55:01');
INSERT INTO `quartz_log` VALUES (1954573452836958209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 00:00:00');
INSERT INTO `quartz_log` VALUES (1954573453193474050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 00:00:00');
INSERT INTO `quartz_log` VALUES (1954573455198584834, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 00:00:01');
INSERT INTO `quartz_log` VALUES (1954574711140741121, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 00:05:00');
INSERT INTO `quartz_log` VALUES (1954574713506562050, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 00:05:01');
INSERT INTO `quartz_log` VALUES (1954575969415163905, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 00:10:00');
INSERT INTO `quartz_log` VALUES (1954575969608101890, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 00:10:00');
INSERT INTO `quartz_log` VALUES (1954575971747430402, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-11 00:10:01');
INSERT INTO `quartz_log` VALUES (1954577227702169602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 00:15:00');
INSERT INTO `quartz_log` VALUES (1954577230168653825, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 00:15:01');
INSERT INTO `quartz_log` VALUES (1954578486022729730, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-11 00:20:00');
INSERT INTO `quartz_log` VALUES (1954578486324719618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 00:20:00');
INSERT INTO `quartz_log` VALUES (1954578488434688002, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 00:20:01');
INSERT INTO `quartz_log` VALUES (1954579744313929729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 00:25:00');
INSERT INTO `quartz_log` VALUES (1954579746440675329, '钱包任务', 'walletTaskService.task()', '总共耗时：30毫秒', 'Y', '2025-08-11 00:25:01');
INSERT INTO `quartz_log` VALUES (1954581002596741121, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 00:30:00');
INSERT INTO `quartz_log` VALUES (1954581002923896833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 00:30:00');
INSERT INTO `quartz_log` VALUES (1954581005075808258, '钱包任务', 'walletTaskService.task()', '总共耗时：83毫秒', 'Y', '2025-08-11 00:30:01');
INSERT INTO `quartz_log` VALUES (1954582260858580994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 00:35:00');
INSERT INTO `quartz_log` VALUES (1954582263065018370, '钱包任务', 'walletTaskService.task()', '总共耗时：54毫秒', 'Y', '2025-08-11 00:35:00');
INSERT INTO `quartz_log` VALUES (1954583519153975298, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 00:40:00');
INSERT INTO `quartz_log` VALUES (1954583521083355137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 00:40:00');
INSERT INTO `quartz_log` VALUES (1954583521477853185, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 00:40:01');
INSERT INTO `quartz_log` VALUES (1954584777466146817, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 00:45:00');
INSERT INTO `quartz_log` VALUES (1954584779731304450, '钱包补偿', 'walletReceiveService.task()', '总共耗时：54毫秒', 'Y', '2025-08-11 00:45:01');
INSERT INTO `quartz_log` VALUES (1954586035765735425, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 00:50:00');
INSERT INTO `quartz_log` VALUES (1954586037724475394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 00:50:01');
INSERT INTO `quartz_log` VALUES (1954586038228025346, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 00:50:01');
INSERT INTO `quartz_log` VALUES (1954587294061129729, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 00:55:00');
INSERT INTO `quartz_log` VALUES (1954587296380813313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：54毫秒', 'Y', '2025-08-11 00:55:01');
INSERT INTO `quartz_log` VALUES (1954588552348135425, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 01:00:00');
INSERT INTO `quartz_log` VALUES (1954588554252349442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 01:00:00');
INSERT INTO `quartz_log` VALUES (1954588554596515842, '钱包任务', 'walletTaskService.task()', '总共耗时：53毫秒', 'Y', '2025-08-11 01:00:01');
INSERT INTO `quartz_log` VALUES (1954589810614169602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 01:05:00');
INSERT INTO `quartz_log` VALUES (1954589812682194945, '钱包补偿', 'walletReceiveService.task()', '总共耗时：80毫秒', 'Y', '2025-08-11 01:05:00');
INSERT INTO `quartz_log` VALUES (1954591068896980993, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 01:10:00');
INSERT INTO `quartz_log` VALUES (1954591069240913921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 01:10:00');
INSERT INTO `quartz_log` VALUES (1954591071111806978, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 01:10:00');
INSERT INTO `quartz_log` VALUES (1954592327213346817, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 01:15:00');
INSERT INTO `quartz_log` VALUES (1954592329554001921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 01:15:01');
INSERT INTO `quartz_log` VALUES (1954593585458409473, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 01:20:00');
INSERT INTO `quartz_log` VALUES (1954593585621987330, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 01:20:00');
INSERT INTO `quartz_log` VALUES (1954593587891339266, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 01:20:01');
INSERT INTO `quartz_log` VALUES (1954594843757998082, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 01:25:00');
INSERT INTO `quartz_log` VALUES (1954594846136401921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：76毫秒', 'Y', '2025-08-11 01:25:01');
INSERT INTO `quartz_log` VALUES (1954596102036615170, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 01:30:00');
INSERT INTO `quartz_log` VALUES (1954596102183415810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 01:30:00');
INSERT INTO `quartz_log` VALUES (1954596104402436098, '用户解封', 'chatTaskService.banned()', '总共耗时：71毫秒', 'Y', '2025-08-11 01:30:01');
INSERT INTO `quartz_log` VALUES (1954597360298455042, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 01:35:00');
INSERT INTO `quartz_log` VALUES (1954597362798493698, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 01:35:01');
INSERT INTO `quartz_log` VALUES (1954598618606432258, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 01:40:00');
INSERT INTO `quartz_log` VALUES (1954598618736455682, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 01:40:00');
INSERT INTO `quartz_log` VALUES (1954598620938698753, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-11 01:40:01');
INSERT INTO `quartz_log` VALUES (1954599876897632257, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 01:45:00');
INSERT INTO `quartz_log` VALUES (1954599879301201921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 01:45:01');
INSERT INTO `quartz_log` VALUES (1954601135234969602, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 01:50:00');
INSERT INTO `quartz_log` VALUES (1954601135490822146, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 01:50:00');
INSERT INTO `quartz_log` VALUES (1954601160447164418, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-11 01:50:06');
INSERT INTO `quartz_log` VALUES (1954602393576501249, '钱包任务', 'walletTaskService.task()', '总共耗时：12毫秒', 'Y', '2025-08-11 01:55:00');
INSERT INTO `quartz_log` VALUES (1954602395862630401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 01:55:01');
INSERT INTO `quartz_log` VALUES (1954603651829952513, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-11 02:00:00');
INSERT INTO `quartz_log` VALUES (1954603652098387970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 02:00:00');
INSERT INTO `quartz_log` VALUES (1954603654082527234, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 02:00:01');
INSERT INTO `quartz_log` VALUES (1954604910087598081, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 02:05:00');
INSERT INTO `quartz_log` VALUES (1954604912365338625, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 02:05:01');
INSERT INTO `quartz_log` VALUES (1954606168378798081, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-11 02:10:00');
INSERT INTO `quartz_log` VALUES (1954606168651427842, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 02:10:00');
INSERT INTO `quartz_log` VALUES (1954606170643955714, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 02:10:01');
INSERT INTO `quartz_log` VALUES (1954607426720329730, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 02:15:00');
INSERT INTO `quartz_log` VALUES (1954607428935155714, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 02:15:01');
INSERT INTO `quartz_log` VALUES (1954608685003141122, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 02:20:00');
INSERT INTO `quartz_log` VALUES (1954608685275770882, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 02:20:00');
INSERT INTO `quartz_log` VALUES (1954608688732110850, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-11 02:20:01');
INSERT INTO `quartz_log` VALUES (1954609943256592385, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 02:25:00');
INSERT INTO `quartz_log` VALUES (1954609945471418369, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 02:25:00');
INSERT INTO `quartz_log` VALUES (1954611201568763906, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 02:30:00');
INSERT INTO `quartz_log` VALUES (1954611201778479106, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 02:30:00');
INSERT INTO `quartz_log` VALUES (1954611203829727233, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-11 02:30:01');
INSERT INTO `quartz_log` VALUES (1954612459843186690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 02:35:00');
INSERT INTO `quartz_log` VALUES (1954612462070595585, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 02:35:00');
INSERT INTO `quartz_log` VALUES (1954613718155358209, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 02:40:00');
INSERT INTO `quartz_log` VALUES (1954613718436376577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 02:40:00');
INSERT INTO `quartz_log` VALUES (1954613720445681666, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 02:40:01');
INSERT INTO `quartz_log` VALUES (1954614976450752513, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 02:45:00');
INSERT INTO `quartz_log` VALUES (1954614978665578497, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 02:45:01');
INSERT INTO `quartz_log` VALUES (1954616234771312641, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 02:50:00');
INSERT INTO `quartz_log` VALUES (1954616235102662657, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 02:50:00');
INSERT INTO `quartz_log` VALUES (1954616237174882305, '用户解封', 'chatTaskService.banned()', '总共耗时：69毫秒', 'Y', '2025-08-11 02:50:01');
INSERT INTO `quartz_log` VALUES (1954617493037346818, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 02:55:00');
INSERT INTO `quartz_log` VALUES (1954617495193452545, '钱包任务', 'walletTaskService.task()', '总共耗时：31毫秒', 'Y', '2025-08-11 02:55:01');
INSERT INTO `quartz_log` VALUES (1954618751307575297, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 03:00:00');
INSERT INTO `quartz_log` VALUES (1954618751617953794, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 03:00:00');
INSERT INTO `quartz_log` VALUES (1954618753325035521, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 03:00:01');
INSERT INTO `quartz_log` VALUES (1954618754277376002, '用户日活', 'chatTaskService.visit()', '总共耗时：235毫秒', 'Y', '2025-08-11 03:00:01');
INSERT INTO `quartz_log` VALUES (1954620009598775298, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 03:05:00');
INSERT INTO `quartz_log` VALUES (1954620011754881025, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 03:05:00');
INSERT INTO `quartz_log` VALUES (1954621267889975297, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 03:10:00');
INSERT INTO `quartz_log` VALUES (1954621268116467714, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 03:10:00');
INSERT INTO `quartz_log` VALUES (1954621270092218370, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 03:10:00');
INSERT INTO `quartz_log` VALUES (1954622526193758210, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 03:15:00');
INSERT INTO `quartz_log` VALUES (1954622528307920897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 03:15:00');
INSERT INTO `quartz_log` VALUES (1954623784476569601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 03:20:00');
INSERT INTO `quartz_log` VALUES (1954623784749199361, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 03:20:00');
INSERT INTO `quartz_log` VALUES (1954623786850779137, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-11 03:20:01');
INSERT INTO `quartz_log` VALUES (1954625042776158209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 03:25:00');
INSERT INTO `quartz_log` VALUES (1954625045032927234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 03:25:01');
INSERT INTO `quartz_log` VALUES (1954626301079941122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 03:30:00');
INSERT INTO `quartz_log` VALUES (1954626301352570881, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 03:30:00');
INSERT INTO `quartz_log` VALUES (1954626303454150658, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-11 03:30:01');
INSERT INTO `quartz_log` VALUES (1954627559316615169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 03:35:00');
INSERT INTO `quartz_log` VALUES (1954627561585967105, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 03:35:00');
INSERT INTO `quartz_log` VALUES (1954628817641369601, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 03:40:00');
INSERT INTO `quartz_log` VALUES (1954628819415560194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 03:40:00');
INSERT INTO `quartz_log` VALUES (1954628819742949378, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 03:40:00');
INSERT INTO `quartz_log` VALUES (1954630075945152513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 03:45:00');
INSERT INTO `quartz_log` VALUES (1954630078264836098, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 03:45:01');
INSERT INTO `quartz_log` VALUES (1954631334244741121, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 03:50:00');
INSERT INTO `quartz_log` VALUES (1954631334525759489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 03:50:00');
INSERT INTO `quartz_log` VALUES (1954631336887386113, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 03:50:01');
INSERT INTO `quartz_log` VALUES (1954632592535941122, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 03:55:00');
INSERT INTO `quartz_log` VALUES (1954632595149225985, '钱包补偿', 'walletReceiveService.task()', '总共耗时：55毫秒', 'Y', '2025-08-11 03:55:01');
INSERT INTO `quartz_log` VALUES (1954633850814558209, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-11 04:00:00');
INSERT INTO `quartz_log` VALUES (1954633851108159490, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 04:00:00');
INSERT INTO `quartz_log` VALUES (1954633853461397505, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 04:00:01');
INSERT INTO `quartz_log` VALUES (1954635109093175298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 04:05:00');
INSERT INTO `quartz_log` VALUES (1954635111643545602, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 04:05:01');
INSERT INTO `quartz_log` VALUES (1954636367405346817, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 04:10:00');
INSERT INTO `quartz_log` VALUES (1954636367707336705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 04:10:00');
INSERT INTO `quartz_log` VALUES (1954636369993465858, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 04:10:01');
INSERT INTO `quartz_log` VALUES (1954637625734295553, '钱包补偿', 'walletReceiveService.task()', '总共耗时：14毫秒', 'Y', '2025-08-11 04:15:00');
INSERT INTO `quartz_log` VALUES (1954637627861041153, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 04:15:00');
INSERT INTO `quartz_log` VALUES (1954638883970969602, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 04:20:00');
INSERT INTO `quartz_log` VALUES (1954638884272959489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 04:20:00');
INSERT INTO `quartz_log` VALUES (1954638886521339905, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-11 04:20:01');
INSERT INTO `quartz_log` VALUES (1954640142262169602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 04:25:00');
INSERT INTO `quartz_log` VALUES (1954640144661544962, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 04:25:01');
INSERT INTO `quartz_log` VALUES (1954641400544980994, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 04:30:00');
INSERT INTO `quartz_log` VALUES (1954641400742113282, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 04:30:00');
INSERT INTO `quartz_log` VALUES (1954641402952744962, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 04:30:01');
INSERT INTO `quartz_log` VALUES (1954642658823598082, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 04:35:00');
INSERT INTO `quartz_log` VALUES (1954642659024924673, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 04:35:00');
INSERT INTO `quartz_log` VALUES (1954643917135769602, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 04:40:00');
INSERT INTO `quartz_log` VALUES (1954643917286764546, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 04:40:00');
INSERT INTO `quartz_log` VALUES (1954643919556116482, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-11 04:40:01');
INSERT INTO `quartz_log` VALUES (1954645175452135426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 04:45:00');
INSERT INTO `quartz_log` VALUES (1954645177696321537, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 04:45:01');
INSERT INTO `quartz_log` VALUES (1954646433747529730, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 04:50:00');
INSERT INTO `quartz_log` VALUES (1954646434074685442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 04:50:00');
INSERT INTO `quartz_log` VALUES (1954646436344037377, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 04:50:01');
INSERT INTO `quartz_log` VALUES (1954647692030341122, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 04:55:00');
INSERT INTO `quartz_log` VALUES (1954647694576517122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：72毫秒', 'Y', '2025-08-11 04:55:01');
INSERT INTO `quartz_log` VALUES (1954648950329929730, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 05:00:00');
INSERT INTO `quartz_log` VALUES (1954648950640308225, '群组降级', 'chatTaskService.level()', '总共耗时：9毫秒', 'Y', '2025-08-11 05:00:00');
INSERT INTO `quartz_log` VALUES (1954648952544522241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：14毫秒', 'Y', '2025-08-11 05:00:01');
INSERT INTO `quartz_log` VALUES (1954648952880300034, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-11 05:00:01');
INSERT INTO `quartz_log` VALUES (1954650208554020866, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 05:05:00');
INSERT INTO `quartz_log` VALUES (1954650211033088001, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 05:05:01');
INSERT INTO `quartz_log` VALUES (1954651466878775297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 05:10:00');
INSERT INTO `quartz_log` VALUES (1954651467151405057, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 05:10:00');
INSERT INTO `quartz_log` VALUES (1954651469508837377, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-11 05:10:01');
INSERT INTO `quartz_log` VALUES (1954652725190946818, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 05:15:00');
INSERT INTO `quartz_log` VALUES (1954652727653236737, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 05:15:01');
INSERT INTO `quartz_log` VALUES (1954653983482146817, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 05:20:00');
INSERT INTO `quartz_log` VALUES (1954653983779942402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 05:20:00');
INSERT INTO `quartz_log` VALUES (1954653985801830401, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-11 05:20:01');
INSERT INTO `quartz_log` VALUES (1954655241764958209, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 05:25:00');
INSERT INTO `quartz_log` VALUES (1954655244021727234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 05:25:01');
INSERT INTO `quartz_log` VALUES (1954656500035186690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 05:30:00');
INSERT INTO `quartz_log` VALUES (1954656500291039234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 05:30:00');
INSERT INTO `quartz_log` VALUES (1954656502363258881, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-11 05:30:01');
INSERT INTO `quartz_log` VALUES (1954657758305415170, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 05:35:00');
INSERT INTO `quartz_log` VALUES (1954657760587350018, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 05:35:01');
INSERT INTO `quartz_log` VALUES (1954659016638558209, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 05:40:00');
INSERT INTO `quartz_log` VALUES (1954659016932159489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 05:40:00');
INSERT INTO `quartz_log` VALUES (1954659018983407618, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 05:40:01');
INSERT INTO `quartz_log` VALUES (1954660274921369602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 05:45:00');
INSERT INTO `quartz_log` VALUES (1954660277123612674, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 05:45:00');
INSERT INTO `quartz_log` VALUES (1954661533246124034, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-11 05:50:00');
INSERT INTO `quartz_log` VALUES (1954661533543919617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 05:50:00');
INSERT INTO `quartz_log` VALUES (1954661535809077250, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 05:50:01');
INSERT INTO `quartz_log` VALUES (1954662791474409473, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 05:55:00');
INSERT INTO `quartz_log` VALUES (1954662793911533570, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 05:55:01');
INSERT INTO `quartz_log` VALUES (1954664049799163906, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:00:00');
INSERT INTO `quartz_log` VALUES (1954664050059210753, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:00:00');
INSERT INTO `quartz_log` VALUES (1954664052571832322, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 06:00:01');
INSERT INTO `quartz_log` VALUES (1954665308086169602, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:05:00');
INSERT INTO `quartz_log` VALUES (1954665310456184834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 06:05:01');
INSERT INTO `quartz_log` VALUES (1954666566385758210, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:10:00');
INSERT INTO `quartz_log` VALUES (1954666566742274050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:10:00');
INSERT INTO `quartz_log` VALUES (1954666568931934210, '用户解封', 'chatTaskService.banned()', '总共耗时：71毫秒', 'Y', '2025-08-11 06:10:01');
INSERT INTO `quartz_log` VALUES (1954667824681152514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 06:15:00');
INSERT INTO `quartz_log` VALUES (1954667827248300033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 06:15:01');
INSERT INTO `quartz_log` VALUES (1954669082968158210, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 06:20:00');
INSERT INTO `quartz_log` VALUES (1954669083236593665, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:20:00');
INSERT INTO `quartz_log` VALUES (1954669085275258882, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 06:20:01');
INSERT INTO `quartz_log` VALUES (1954670341255163905, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 06:25:00');
INSERT INTO `quartz_log` VALUES (1954670343637762050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 06:25:01');
INSERT INTO `quartz_log` VALUES (1954671599542169601, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 06:30:00');
INSERT INTO `quartz_log` VALUES (1954671599781244930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-11 06:30:00');
INSERT INTO `quartz_log` VALUES (1954671602402918402, '钱包任务', 'walletTaskService.task()', '总共耗时：206毫秒', 'Y', '2025-08-11 06:30:01');
INSERT INTO `quartz_log` VALUES (1954672857833369601, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:35:00');
INSERT INTO `quartz_log` VALUES (1954672860056584194, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 06:35:00');
INSERT INTO `quartz_log` VALUES (1954674116132958209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:40:00');
INSERT INTO `quartz_log` VALUES (1954674116401393666, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 06:40:00');
INSERT INTO `quartz_log` VALUES (1954674118402310145, '用户解封', 'chatTaskService.banned()', '总共耗时：57毫秒', 'Y', '2025-08-11 06:40:01');
INSERT INTO `quartz_log` VALUES (1954675374436741121, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 06:45:00');
INSERT INTO `quartz_log` VALUES (1954675376701898753, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 06:45:01');
INSERT INTO `quartz_log` VALUES (1954676632736329729, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 06:50:00');
INSERT INTO `quartz_log` VALUES (1954676633034125314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 06:50:00');
INSERT INTO `quartz_log` VALUES (1954676634993098753, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 06:50:01');
INSERT INTO `quartz_log` VALUES (1954677890998169602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 06:55:00');
INSERT INTO `quartz_log` VALUES (1954677893292687361, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 06:55:01');
INSERT INTO `quartz_log` VALUES (1954679149272592386, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 07:00:00');
INSERT INTO `quartz_log` VALUES (1954679149532639233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 07:00:00');
INSERT INTO `quartz_log` VALUES (1954679151571304449, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-11 07:00:01');
INSERT INTO `quartz_log` VALUES (1954680407593152513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 07:05:00');
INSERT INTO `quartz_log` VALUES (1954680409761841154, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 07:05:00');
INSERT INTO `quartz_log` VALUES (1954681665867575298, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 07:10:00');
INSERT INTO `quartz_log` VALUES (1954681666081484801, '钱包补偿', 'walletReceiveService.task()', '总共耗时：11毫秒', 'Y', '2025-08-11 07:10:00');
INSERT INTO `quartz_log` VALUES (1954681668149510145, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 07:10:01');
INSERT INTO `quartz_log` VALUES (1954682924171358210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 07:15:00');
INSERT INTO `quartz_log` VALUES (1954682926348435457, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 07:15:00');
INSERT INTO `quartz_log` VALUES (1954684182441586689, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 07:20:00');
INSERT INTO `quartz_log` VALUES (1954684182626136065, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 07:20:00');
INSERT INTO `quartz_log` VALUES (1954684184924848130, '用户解封', 'chatTaskService.banned()', '总共耗时：56毫秒', 'Y', '2025-08-11 07:20:01');
INSERT INTO `quartz_log` VALUES (1954685440749563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 07:25:00');
INSERT INTO `quartz_log` VALUES (1954685443216048130, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 07:25:01');
INSERT INTO `quartz_log` VALUES (1954686699036569601, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 07:30:00');
INSERT INTO `quartz_log` VALUES (1954686699237896194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 07:30:00');
INSERT INTO `quartz_log` VALUES (1954686701243006978, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 07:30:00');
INSERT INTO `quartz_log` VALUES (1954687957315186690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 07:35:00');
INSERT INTO `quartz_log` VALUES (1954687959450320898, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 07:35:00');
INSERT INTO `quartz_log` VALUES (1954689215614775297, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 07:40:00');
INSERT INTO `quartz_log` VALUES (1954689215912570881, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 07:40:00');
INSERT INTO `quartz_log` VALUES (1954689218093842433, '用户解封', 'chatTaskService.banned()', '总共耗时：57毫秒', 'Y', '2025-08-11 07:40:01');
INSERT INTO `quartz_log` VALUES (1954690473901780993, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 07:45:00');
INSERT INTO `quartz_log` VALUES (1954690476112412674, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 07:45:00');
INSERT INTO `quartz_log` VALUES (1954691732251701249, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-11 07:50:00');
INSERT INTO `quartz_log` VALUES (1954691732553691138, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 07:50:00');
INSERT INTO `quartz_log` VALUES (1954691734634299393, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-11 07:50:01');
INSERT INTO `quartz_log` VALUES (1954692990488375298, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 07:55:00');
INSERT INTO `quartz_log` VALUES (1954692992829030402, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 07:55:01');
INSERT INTO `quartz_log` VALUES (1954694248762798082, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 08:00:00');
INSERT INTO `quartz_log` VALUES (1954694249056399361, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 08:00:00');
INSERT INTO `quartz_log` VALUES (1954694251166367745, '用户解封', 'chatTaskService.banned()', '总共耗时：69毫秒', 'Y', '2025-08-11 08:00:01');
INSERT INTO `quartz_log` VALUES (1954695507083358209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 08:05:00');
INSERT INTO `quartz_log` VALUES (1954695509398847490, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 08:05:01');
INSERT INTO `quartz_log` VALUES (1954696765408112642, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 08:10:00');
INSERT INTO `quartz_log` VALUES (1954696765739462658, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 08:10:00');
INSERT INTO `quartz_log` VALUES (1954696767815876610, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-11 08:10:01');
INSERT INTO `quartz_log` VALUES (1954698023678341122, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 08:15:00');
INSERT INTO `quartz_log` VALUES (1954698025737977858, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 08:15:00');
INSERT INTO `quartz_log` VALUES (1954699281969541122, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 08:20:00');
INSERT INTO `quartz_log` VALUES (1954699282258948097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 08:20:00');
INSERT INTO `quartz_log` VALUES (1954699284587020289, '用户解封', 'chatTaskService.banned()', '总共耗时：53毫秒', 'Y', '2025-08-11 08:20:01');
INSERT INTO `quartz_log` VALUES (1954700540206215170, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 08:25:00');
INSERT INTO `quartz_log` VALUES (1954700542622371842, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-11 08:25:01');
INSERT INTO `quartz_log` VALUES (1954701798535163905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 08:30:00');
INSERT INTO `quartz_log` VALUES (1954701798828765186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 08:30:00');
INSERT INTO `quartz_log` VALUES (1954701801186201602, '用户解封', 'chatTaskService.banned()', '总共耗时：110毫秒', 'Y', '2025-08-11 08:30:01');
INSERT INTO `quartz_log` VALUES (1954703056809586689, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 08:35:00');
INSERT INTO `quartz_log` VALUES (1954703059141857282, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 08:35:01');
INSERT INTO `quartz_log` VALUES (1954704315138535425, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 08:40:00');
INSERT INTO `quartz_log` VALUES (1954704315469885442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 08:40:00');
INSERT INTO `quartz_log` VALUES (1954704317512749057, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-11 08:40:01');
INSERT INTO `quartz_log` VALUES (1954705573417152513, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 08:45:00');
INSERT INTO `quartz_log` VALUES (1954705575686508546, '钱包补偿', 'walletReceiveService.task()', '总共耗时：71毫秒', 'Y', '2025-08-11 08:45:01');
INSERT INTO `quartz_log` VALUES (1954706831737712642, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-11 08:50:00');
INSERT INTO `quartz_log` VALUES (1954706832043896834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 08:50:00');
INSERT INTO `quartz_log` VALUES (1954706834292285442, '钱包任务', 'walletTaskService.task()', '总共耗时：78毫秒', 'Y', '2025-08-11 08:50:01');
INSERT INTO `quartz_log` VALUES (1954708089991163905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 08:55:00');
INSERT INTO `quartz_log` VALUES (1954708092319244290, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 08:55:01');
INSERT INTO `quartz_log` VALUES (1954709348290752513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 09:00:00');
INSERT INTO `quartz_log` VALUES (1954709348559187970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 09:00:00');
INSERT INTO `quartz_log` VALUES (1954709350761439233, '用户解封', 'chatTaskService.banned()', '总共耗时：103毫秒', 'Y', '2025-08-11 09:00:01');
INSERT INTO `quartz_log` VALUES (1954710606573563906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 09:05:00');
INSERT INTO `quartz_log` VALUES (1954710608931004417, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-11 09:05:01');
INSERT INTO `quartz_log` VALUES (1954711864881541122, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 09:10:00');
INSERT INTO `quartz_log` VALUES (1954711865191919617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 09:10:00');
INSERT INTO `quartz_log` VALUES (1954711867264147458, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 09:10:01');
INSERT INTO `quartz_log` VALUES (1954713123172741122, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 09:15:00');
INSERT INTO `quartz_log` VALUES (1954713125576318977, '钱包补偿', 'walletReceiveService.task()', '总共耗时：74毫秒', 'Y', '2025-08-11 09:15:01');
INSERT INTO `quartz_log` VALUES (1954714381447163905, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 09:20:00');
INSERT INTO `quartz_log` VALUES (1954714381761736705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 09:20:00');
INSERT INTO `quartz_log` VALUES (1954714384408588290, '用户解封', 'chatTaskService.banned()', '总共耗时：158毫秒', 'Y', '2025-08-11 09:20:01');
INSERT INTO `quartz_log` VALUES (1954715639746752513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 09:25:00');
INSERT INTO `quartz_log` VALUES (1954715641881899010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：72毫秒', 'Y', '2025-08-11 09:25:00');
INSERT INTO `quartz_log` VALUES (1954716898016980993, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-11 09:30:00');
INSERT INTO `quartz_log` VALUES (1954716898243473409, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 09:30:00');
INSERT INTO `quartz_log` VALUES (1954716900412174337, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 09:30:01');
INSERT INTO `quartz_log` VALUES (1954718156320763906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 09:35:00');
INSERT INTO `quartz_log` VALUES (1954718158397190145, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 09:35:00');
INSERT INTO `quartz_log` VALUES (1954719414595186690, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 09:40:00');
INSERT INTO `quartz_log` VALUES (1954719414783930369, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 09:40:00');
INSERT INTO `quartz_log` VALUES (1954719416839385090, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 09:40:01');
INSERT INTO `quartz_log` VALUES (1954720672924135426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 09:45:00');
INSERT INTO `quartz_log` VALUES (1954720675118002178, '钱包补偿', 'walletReceiveService.task()', '总共耗时：79毫秒', 'Y', '2025-08-11 09:45:00');
INSERT INTO `quartz_log` VALUES (1954721931206946817, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 09:50:00');
INSERT INTO `quartz_log` VALUES (1954721931504742401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 09:50:00');
INSERT INTO `quartz_log` VALUES (1954721933761523713, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-11 09:50:01');
INSERT INTO `quartz_log` VALUES (1954723189468786690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 09:55:00');
INSERT INTO `quartz_log` VALUES (1954723192061112321, '钱包任务', 'walletTaskService.task()', '总共耗时：72毫秒', 'Y', '2025-08-11 09:55:01');
INSERT INTO `quartz_log` VALUES (1954724447759986690, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 10:00:00');
INSERT INTO `quartz_log` VALUES (1954724448049393665, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 10:00:00');
INSERT INTO `quartz_log` VALUES (1954724452835340289, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-11 10:00:01');
INSERT INTO `quartz_log` VALUES (1954725706046992385, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 10:05:00');
INSERT INTO `quartz_log` VALUES (1954725708471545858, '钱包任务', 'walletTaskService.task()', '总共耗时：52毫秒', 'Y', '2025-08-11 10:05:01');
INSERT INTO `quartz_log` VALUES (1954726964359163905, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 10:10:00');
INSERT INTO `quartz_log` VALUES (1954726964698902529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 10:10:00');
INSERT INTO `quartz_log` VALUES (1954726966741774338, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 10:10:01');
INSERT INTO `quartz_log` VALUES (1954728222671335425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 10:15:00');
INSERT INTO `quartz_log` VALUES (1954728225007808513, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-11 10:15:01');
INSERT INTO `quartz_log` VALUES (1954729480962535425, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 10:20:00');
INSERT INTO `quartz_log` VALUES (1954729481285496833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 10:20:00');
INSERT INTO `quartz_log` VALUES (1954729486528622593, '钱包任务', 'walletTaskService.task()', '总共耗时：82毫秒', 'Y', '2025-08-11 10:20:01');
INSERT INTO `quartz_log` VALUES (1954730739241152514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 10:25:00');
INSERT INTO `quartz_log` VALUES (1954730741602791426, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 10:25:01');
INSERT INTO `quartz_log` VALUES (1954731997511380993, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-11 10:30:00');
INSERT INTO `quartz_log` VALUES (1954731997804982273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 10:30:00');
INSERT INTO `quartz_log` VALUES (1954731999919157249, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 10:30:01');
INSERT INTO `quartz_log` VALUES (1954733255802580994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 10:35:00');
INSERT INTO `quartz_log` VALUES (1954733258273271809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：93毫秒', 'Y', '2025-08-11 10:35:01');
INSERT INTO `quartz_log` VALUES (1954734514135724034, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-11 10:40:00');
INSERT INTO `quartz_log` VALUES (1954734514433519618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 10:40:00');
INSERT INTO `quartz_log` VALUES (1954734516514140161, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 10:40:01');
INSERT INTO `quartz_log` VALUES (1954735772414341122, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 10:45:00');
INSERT INTO `quartz_log` VALUES (1954735774515933185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 10:45:00');
INSERT INTO `quartz_log` VALUES (1954737030718124034, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 10:50:00');
INSERT INTO `quartz_log` VALUES (1954737031129165826, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 10:50:00');
INSERT INTO `quartz_log` VALUES (1954737033104928769, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-11 10:50:01');
INSERT INTO `quartz_log` VALUES (1954738288967380994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 10:55:00');
INSERT INTO `quartz_log` VALUES (1954738291538739201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：77毫秒', 'Y', '2025-08-11 10:55:01');
INSERT INTO `quartz_log` VALUES (1954739547262775297, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:00:00');
INSERT INTO `quartz_log` VALUES (1954739547489267713, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 11:00:00');
INSERT INTO `quartz_log` VALUES (1954739549997711362, '钱包任务', 'walletTaskService.task()', '总共耗时：86毫秒', 'Y', '2025-08-11 11:00:01');
INSERT INTO `quartz_log` VALUES (1954740805533003778, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 11:05:00');
INSERT INTO `quartz_log` VALUES (1954740808465080321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：77毫秒', 'Y', '2025-08-11 11:05:01');
INSERT INTO `quartz_log` VALUES (1954742063887118337, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-11 11:10:00');
INSERT INTO `quartz_log` VALUES (1954742064197496833, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 11:10:00');
INSERT INTO `quartz_log` VALUES (1954742095814160386, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:10:08');
INSERT INTO `quartz_log` VALUES (1954743322165735426, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:15:00');
INSERT INTO `quartz_log` VALUES (1954743324460281858, '钱包补偿', 'walletReceiveService.task()', '总共耗时：81毫秒', 'Y', '2025-08-11 11:15:00');
INSERT INTO `quartz_log` VALUES (1954744580448546818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 11:20:00');
INSERT INTO `quartz_log` VALUES (1954744580779896834, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:20:00');
INSERT INTO `quartz_log` VALUES (1954744581069303810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 11:20:00');
INSERT INTO `quartz_log` VALUES (1954745838727163906, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:25:00');
INSERT INTO `quartz_log` VALUES (1954745840988164097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-11 11:25:00');
INSERT INTO `quartz_log` VALUES (1954747096989003777, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 11:30:00');
INSERT INTO `quartz_log` VALUES (1954747097219690498, '用户解封', 'chatTaskService.banned()', '总共耗时：1毫秒', 'Y', '2025-08-11 11:30:00');
INSERT INTO `quartz_log` VALUES (1954747097383268353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 11:30:00');
INSERT INTO `quartz_log` VALUES (1954748355305369602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 11:35:00');
INSERT INTO `quartz_log` VALUES (1954748358132604930, '钱包任务', 'walletTaskService.task()', '总共耗时：94毫秒', 'Y', '2025-08-11 11:35:01');
INSERT INTO `quartz_log` VALUES (1954749613625929729, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 11:40:00');
INSERT INTO `quartz_log` VALUES (1954749613919531009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:40:00');
INSERT INTO `quartz_log` VALUES (1954749616297975809, '用户解封', 'chatTaskService.banned()', '总共耗时：106毫秒', 'Y', '2025-08-11 11:40:01');
INSERT INTO `quartz_log` VALUES (1954750871917129730, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 11:45:00');
INSERT INTO `quartz_log` VALUES (1954750881245540353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：237毫秒', 'Y', '2025-08-11 11:45:02');
INSERT INTO `quartz_log` VALUES (1954752130191552513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:50:00');
INSERT INTO `quartz_log` VALUES (1954752130518708226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 11:50:00');
INSERT INTO `quartz_log` VALUES (1954752137867407361, '用户解封', 'chatTaskService.banned()', '总共耗时：177毫秒', 'Y', '2025-08-11 11:50:02');
INSERT INTO `quartz_log` VALUES (1954753388461780994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 11:55:00');
INSERT INTO `quartz_log` VALUES (1954753391301607426, '钱包任务', 'walletTaskService.task()', '总共耗时：89毫秒', 'Y', '2025-08-11 11:55:01');
INSERT INTO `quartz_log` VALUES (1954754646744592385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:00:00');
INSERT INTO `quartz_log` VALUES (1954754647029805058, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:00:00');
INSERT INTO `quartz_log` VALUES (1954754649399869441, '用户解封', 'chatTaskService.banned()', '总共耗时：83毫秒', 'Y', '2025-08-11 12:00:01');
INSERT INTO `quartz_log` VALUES (1954755905056763906, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:05:00');
INSERT INTO `quartz_log` VALUES (1954755907472965633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 12:05:01');
INSERT INTO `quartz_log` VALUES (1954757163373129730, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 12:10:00');
INSERT INTO `quartz_log` VALUES (1954757163708674050, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 12:10:00');
INSERT INTO `quartz_log` VALUES (1954757165944520706, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-11 12:10:01');
INSERT INTO `quartz_log` VALUES (1954758421647552513, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 12:15:00');
INSERT INTO `quartz_log` VALUES (1954758424072142849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：54毫秒', 'Y', '2025-08-11 12:15:01');
INSERT INTO `quartz_log` VALUES (1954759679930363906, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 12:20:00');
INSERT INTO `quartz_log` VALUES (1954759680119107586, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 12:20:00');
INSERT INTO `quartz_log` VALUES (1954759682388508673, '钱包任务', 'walletTaskService.task()', '总共耗时：54毫秒', 'Y', '2025-08-11 12:20:01');
INSERT INTO `quartz_log` VALUES (1954760938204786689, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:25:00');
INSERT INTO `quartz_log` VALUES (1954760940260278274, '钱包补偿', 'walletReceiveService.task()', '总共耗时：53毫秒', 'Y', '2025-08-11 12:25:00');
INSERT INTO `quartz_log` VALUES (1954762196495986689, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:30:00');
INSERT INTO `quartz_log` VALUES (1954762196785393666, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:30:00');
INSERT INTO `quartz_log` VALUES (1954762198639558658, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 12:30:00');
INSERT INTO `quartz_log` VALUES (1954763454791380994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 12:35:00');
INSERT INTO `quartz_log` VALUES (1954763456842678273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：55毫秒', 'Y', '2025-08-11 12:35:00');
INSERT INTO `quartz_log` VALUES (1954764713095163906, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 12:40:00');
INSERT INTO `quartz_log` VALUES (1954764713330044930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-11 12:40:00');
INSERT INTO `quartz_log` VALUES (1954764715687526401, '用户解封', 'chatTaskService.banned()', '总共耗时：177毫秒', 'Y', '2025-08-11 12:40:00');
INSERT INTO `quartz_log` VALUES (1954765971415724033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 12:45:00');
INSERT INTO `quartz_log` VALUES (1954765973366358018, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 12:45:00');
INSERT INTO `quartz_log` VALUES (1954767229673369602, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 12:50:00');
INSERT INTO `quartz_log` VALUES (1954767229996331010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 12:50:00');
INSERT INTO `quartz_log` VALUES (1954767231678529537, '用户解封', 'chatTaskService.banned()', '总共耗时：55毫秒', 'Y', '2025-08-11 12:50:00');
INSERT INTO `quartz_log` VALUES (1954768487951986690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 12:55:00');
INSERT INTO `quartz_log` VALUES (1954768490326245377, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-11 12:55:01');
INSERT INTO `quartz_log` VALUES (1954769746247380994, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 13:00:00');
INSERT INTO `quartz_log` VALUES (1954769746473873410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 13:00:00');
INSERT INTO `quartz_log` VALUES (1954769748625833986, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 13:00:01');
INSERT INTO `quartz_log` VALUES (1954771004551163906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 13:05:00');
INSERT INTO `quartz_log` VALUES (1954771006745067522, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 13:05:00');
INSERT INTO `quartz_log` VALUES (1954772262871724033, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 13:10:00');
INSERT INTO `quartz_log` VALUES (1954772263207268354, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 13:10:00');
INSERT INTO `quartz_log` VALUES (1954772265187262466, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-11 13:10:01');
INSERT INTO `quartz_log` VALUES (1954773521141952514, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 13:15:00');
INSERT INTO `quartz_log` VALUES (1954773523386187777, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 13:15:01');
INSERT INTO `quartz_log` VALUES (1954774779424763906, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 13:20:00');
INSERT INTO `quartz_log` VALUES (1954774779613507586, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 13:20:00');
INSERT INTO `quartz_log` VALUES (1954774781710942210, '用户解封', 'chatTaskService.banned()', '总共耗时：57毫秒', 'Y', '2025-08-11 13:20:01');
INSERT INTO `quartz_log` VALUES (1954776037724352513, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 13:25:00');
INSERT INTO `quartz_log` VALUES (1954776039897284609, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 13:25:00');
INSERT INTO `quartz_log` VALUES (1954777295986192385, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 13:30:00');
INSERT INTO `quartz_log` VALUES (1954777296279793665, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 13:30:00');
INSERT INTO `quartz_log` VALUES (1954777298322702338, '用户解封', 'chatTaskService.banned()', '总共耗时：76毫秒', 'Y', '2025-08-11 13:30:01');
INSERT INTO `quartz_log` VALUES (1954778554273198081, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 13:35:00');
INSERT INTO `quartz_log` VALUES (1954778556462907394, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 13:35:00');
INSERT INTO `quartz_log` VALUES (1954779812593758209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 13:40:00');
INSERT INTO `quartz_log` VALUES (1954779812946079745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 13:40:00');
INSERT INTO `quartz_log` VALUES (1954779815072874498, '用户解封', 'chatTaskService.banned()', '总共耗时：71毫秒', 'Y', '2025-08-11 13:40:01');
INSERT INTO `quartz_log` VALUES (1954781070905929729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 13:45:00');
INSERT INTO `quartz_log` VALUES (1954781073213079554, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-11 13:45:01');
INSERT INTO `quartz_log` VALUES (1954782329167769601, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 13:50:00');
INSERT INTO `quartz_log` VALUES (1954782329457176577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 13:50:00');
INSERT INTO `quartz_log` VALUES (1954782331667857410, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 13:50:01');
INSERT INTO `quartz_log` VALUES (1954783587442192385, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 13:55:00');
INSERT INTO `quartz_log` VALUES (1954783589883559937, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 13:55:01');
INSERT INTO `quartz_log` VALUES (1954784845758558209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 14:00:00');
INSERT INTO `quartz_log` VALUES (1954784847830544386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 14:00:01');
INSERT INTO `quartz_log` VALUES (1954784848258646017, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-11 14:00:01');
INSERT INTO `quartz_log` VALUES (1954786104032980994, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-11 14:05:00');
INSERT INTO `quartz_log` VALUES (1954786106428211201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 14:05:01');
INSERT INTO `quartz_log` VALUES (1954787362378706946, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 14:10:00');
INSERT INTO `quartz_log` VALUES (1954787362722639873, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 14:10:00');
INSERT INTO `quartz_log` VALUES (1954787364836851713, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-11 14:10:01');
INSERT INTO `quartz_log` VALUES (1954788620648935426, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 14:15:00');
INSERT INTO `quartz_log` VALUES (1954788623161606146, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 14:15:01');
INSERT INTO `quartz_log` VALUES (1954789878927552514, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 14:20:00');
INSERT INTO `quartz_log` VALUES (1954789879254708226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 14:20:00');
INSERT INTO `quartz_log` VALUES (1954789881306005506, '用户解封', 'chatTaskService.banned()', '总共耗时：57毫秒', 'Y', '2025-08-11 14:20:01');
INSERT INTO `quartz_log` VALUES (1954791137214558209, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 14:25:00');
INSERT INTO `quartz_log` VALUES (1954791139630759938, '钱包补偿', 'walletReceiveService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 14:25:01');
INSERT INTO `quartz_log` VALUES (1954792395505758210, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 14:30:00');
INSERT INTO `quartz_log` VALUES (1954792395795165186, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 14:30:00');
INSERT INTO `quartz_log` VALUES (1954792397766770689, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 14:30:01');
INSERT INTO `quartz_log` VALUES (1954793653775986689, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 14:35:00');
INSERT INTO `quartz_log` VALUES (1954793656074752001, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 14:35:01');
INSERT INTO `quartz_log` VALUES (1954794912079769602, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 14:40:00');
INSERT INTO `quartz_log` VALUES (1954794912369176577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 14:40:00');
INSERT INTO `quartz_log` VALUES (1954794914458230786, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 14:40:01');
INSERT INTO `quartz_log` VALUES (1954796170366775298, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 14:45:00');
INSERT INTO `quartz_log` VALUES (1954796172665544706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：77毫秒', 'Y', '2025-08-11 14:45:01');
INSERT INTO `quartz_log` VALUES (1954797428683141122, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-11 14:50:00');
INSERT INTO `quartz_log` VALUES (1954797428989325313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 14:50:00');
INSERT INTO `quartz_log` VALUES (1954797431044825090, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 14:50:01');
INSERT INTO `quartz_log` VALUES (1954798686961758210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 14:55:00');
INSERT INTO `quartz_log` VALUES (1954798689491214338, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 14:55:01');
INSERT INTO `quartz_log` VALUES (1954799945240375297, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 15:00:00');
INSERT INTO `quartz_log` VALUES (1954799945445896194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-11 15:00:00');
INSERT INTO `quartz_log` VALUES (1954799947727888386, '用户解封', 'chatTaskService.banned()', '总共耗时：81毫秒', 'Y', '2025-08-11 15:00:01');
INSERT INTO `quartz_log` VALUES (1954801203556741122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 15:05:00');
INSERT INTO `quartz_log` VALUES (1954801205943590913, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 15:05:01');
INSERT INTO `quartz_log` VALUES (1954802461852135426, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-11 15:10:00');
INSERT INTO `quartz_log` VALUES (1954802462053462018, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 15:10:00');
INSERT INTO `quartz_log` VALUES (1954802464381591554, '钱包任务', 'walletTaskService.task()', '总共耗时：104毫秒', 'Y', '2025-08-11 15:10:01');
INSERT INTO `quartz_log` VALUES (1954803720134946817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 15:15:00');
INSERT INTO `quartz_log` VALUES (1954803722714738690, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 15:15:01');
INSERT INTO `quartz_log` VALUES (1954804978413563905, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 15:20:00');
INSERT INTO `quartz_log` VALUES (1954804978719748097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 15:20:00');
INSERT INTO `quartz_log` VALUES (1954804980846555137, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 15:20:01');
INSERT INTO `quartz_log` VALUES (1954806236700569602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 15:25:00');
INSERT INTO `quartz_log` VALUES (1954806239708180482, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 15:25:01');
INSERT INTO `quartz_log` VALUES (1954807494983380993, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 15:30:00');
INSERT INTO `quartz_log` VALUES (1954807495281176577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 15:30:00');
INSERT INTO `quartz_log` VALUES (1954807497466703874, '用户解封', 'chatTaskService.banned()', '总共耗时：101毫秒', 'Y', '2025-08-11 15:30:01');
INSERT INTO `quartz_log` VALUES (1954808753291358209, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 15:35:00');
INSERT INTO `quartz_log` VALUES (1954808755711766529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 15:35:01');
INSERT INTO `quartz_log` VALUES (1954810011595141122, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 15:40:00');
INSERT INTO `quartz_log` VALUES (1954810011897131009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 15:40:00');
INSERT INTO `quartz_log` VALUES (1954810013990383617, '钱包任务', 'walletTaskService.task()', '总共耗时：78毫秒', 'Y', '2025-08-11 15:40:01');
INSERT INTO `quartz_log` VALUES (1954811269919895553, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 15:45:00');
INSERT INTO `quartz_log` VALUES (1954811272872980482, '钱包补偿', 'walletReceiveService.task()', '总共耗时：118毫秒', 'Y', '2025-08-11 15:45:01');
INSERT INTO `quartz_log` VALUES (1954812528148180994, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 15:50:00');
INSERT INTO `quartz_log` VALUES (1954812528441782273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 15:50:00');
INSERT INTO `quartz_log` VALUES (1954812530778304514, '用户解封', 'chatTaskService.banned()', '总共耗时：76毫秒', 'Y', '2025-08-11 15:50:01');
INSERT INTO `quartz_log` VALUES (1954813786464546818, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 15:55:00');
INSERT INTO `quartz_log` VALUES (1954813788968841217, '钱包补偿', 'walletReceiveService.task()', '总共耗时：82毫秒', 'Y', '2025-08-11 15:55:01');
INSERT INTO `quartz_log` VALUES (1954815044730580993, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 16:00:00');
INSERT INTO `quartz_log` VALUES (1954815044940296194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 16:00:00');
INSERT INTO `quartz_log` VALUES (1954815047268429825, '钱包任务', 'walletTaskService.task()', '总共耗时：33毫秒', 'Y', '2025-08-11 16:00:01');
INSERT INTO `quartz_log` VALUES (1954816303063724034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 16:05:00');
INSERT INTO `quartz_log` VALUES (1954816305618350082, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 16:05:01');
INSERT INTO `quartz_log` VALUES (1954817561367506946, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-11 16:10:00');
INSERT INTO `quartz_log` VALUES (1954817561724022785, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 16:10:00');
INSERT INTO `quartz_log` VALUES (1954817564018601986, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 16:10:01');
INSERT INTO `quartz_log` VALUES (1954818819646124033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 16:15:00');
INSERT INTO `quartz_log` VALUES (1954818821865205761, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 16:15:01');
INSERT INTO `quartz_log` VALUES (1954820077937324034, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-11 16:20:00');
INSERT INTO `quartz_log` VALUES (1954820078239313921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 16:20:00');
INSERT INTO `quartz_log` VALUES (1954820080655527938, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 16:20:01');
INSERT INTO `quartz_log` VALUES (1954821336182386690, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 16:25:00');
INSERT INTO `quartz_log` VALUES (1954821338342748161, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 16:25:00');
INSERT INTO `quartz_log` VALUES (1954822594494558210, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 16:30:00');
INSERT INTO `quartz_log` VALUES (1954822594796548097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 16:30:00');
INSERT INTO `quartz_log` VALUES (1954822596759777282, '用户解封', 'chatTaskService.banned()', '总共耗时：57毫秒', 'Y', '2025-08-11 16:30:01');
INSERT INTO `quartz_log` VALUES (1954823852794146817, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 16:35:00');
INSERT INTO `quartz_log` VALUES (1954823854967091202, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 16:35:00');
INSERT INTO `quartz_log` VALUES (1954825111064375298, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-11 16:40:00');
INSERT INTO `quartz_log` VALUES (1954825111366365185, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 16:40:00');
INSERT INTO `quartz_log` VALUES (1954825113535115265, '钱包任务', 'walletTaskService.task()', '总共耗时：29毫秒', 'Y', '2025-08-11 16:40:01');
INSERT INTO `quartz_log` VALUES (1954826369380741122, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 16:45:00');
INSERT INTO `quartz_log` VALUES (1954826375462776834, '钱包任务', 'walletTaskService.task()', '总共耗时：132毫秒', 'Y', '2025-08-11 16:45:01');
INSERT INTO `quartz_log` VALUES (1954827627667746818, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-11 16:50:00');
INSERT INTO `quartz_log` VALUES (1954827627990708226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 16:50:00');
INSERT INTO `quartz_log` VALUES (1954827630222372865, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 16:50:01');
INSERT INTO `quartz_log` VALUES (1954828885954752513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 16:55:00');
INSERT INTO `quartz_log` VALUES (1954828888752648194, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 16:55:01');
INSERT INTO `quartz_log` VALUES (1954830144220786690, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 17:00:00');
INSERT INTO `quartz_log` VALUES (1954830144510193666, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 17:00:00');
INSERT INTO `quartz_log` VALUES (1954830150785167361, '用户解封', 'chatTaskService.banned()', '总共耗时：103毫秒', 'Y', '2025-08-11 17:00:01');
INSERT INTO `quartz_log` VALUES (1954831402549735425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 17:05:00');
INSERT INTO `quartz_log` VALUES (1954831405527986177, '钱包任务', 'walletTaskService.task()', '总共耗时：92毫秒', 'Y', '2025-08-11 17:05:01');
INSERT INTO `quartz_log` VALUES (1954832660824158209, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 17:10:00');
INSERT INTO `quartz_log` VALUES (1954832661142925313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 17:10:00');
INSERT INTO `quartz_log` VALUES (1954832663739494402, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-11 17:10:01');
INSERT INTO `quartz_log` VALUES (1954833919106969601, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 17:15:00');
INSERT INTO `quartz_log` VALUES (1954833921321857025, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 17:15:00');
INSERT INTO `quartz_log` VALUES (1954835177419141121, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 17:20:00');
INSERT INTO `quartz_log` VALUES (1954835177737908226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 17:20:00');
INSERT INTO `quartz_log` VALUES (1954835180179288065, '用户解封', 'chatTaskService.banned()', '总共耗时：121毫秒', 'Y', '2025-08-11 17:20:01');
INSERT INTO `quartz_log` VALUES (1954836436138459137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：29毫秒', 'Y', '2025-08-11 17:25:00');
INSERT INTO `quartz_log` VALUES (1954836437795205122, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 17:25:00');
INSERT INTO `quartz_log` VALUES (1954837694178000898, '钱包任务', 'walletTaskService.task()', '总共耗时：32毫秒', 'Y', '2025-08-11 17:30:00');
INSERT INTO `quartz_log` VALUES (1954837694312218626, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 17:30:00');
INSERT INTO `quartz_log` VALUES (1954837697080455169, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-11 17:30:01');
INSERT INTO `quartz_log` VALUES (1954838952368537602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 17:35:00');
INSERT INTO `quartz_log` VALUES (1954838954977390593, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-11 17:35:01');
INSERT INTO `quartz_log` VALUES (1954840210903007234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 17:40:00');
INSERT INTO `quartz_log` VALUES (1954840211519569921, '用户解封', 'chatTaskService.banned()', '总共耗时：219毫秒', 'Y', '2025-08-11 17:40:00');
INSERT INTO `quartz_log` VALUES (1954840212941434882, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 17:40:01');
INSERT INTO `quartz_log` VALUES (1954841469453864961, '钱包任务', 'walletTaskService.task()', '总共耗时：40毫秒', 'Y', '2025-08-11 17:45:00');
INSERT INTO `quartz_log` VALUES (1954841471329103874, '钱包补偿', 'walletReceiveService.task()', '总共耗时：79毫秒', 'Y', '2025-08-11 17:45:01');
INSERT INTO `quartz_log` VALUES (1954842727489212417, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-11 17:50:00');
INSERT INTO `quartz_log` VALUES (1954842727543738370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：15毫秒', 'Y', '2025-08-11 17:50:00');
INSERT INTO `quartz_log` VALUES (1954842729825824769, '钱包任务', 'walletTaskService.task()', '总共耗时：72毫秒', 'Y', '2025-08-11 17:50:01');
INSERT INTO `quartz_log` VALUES (1954843985537142786, '钱包补偿', 'walletReceiveService.task()', '总共耗时：10毫秒', 'Y', '2025-08-11 17:55:00');
INSERT INTO `quartz_log` VALUES (1954843987781480449, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 17:55:01');
INSERT INTO `quartz_log` VALUES (1954845243832537090, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-11 18:00:00');
INSERT INTO `quartz_log` VALUES (1954845244080001026, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 18:00:00');
INSERT INTO `quartz_log` VALUES (1954845246294978562, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 18:00:01');
INSERT INTO `quartz_log` VALUES (1954846502115348481, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 18:05:00');
INSERT INTO `quartz_log` VALUES (1954846504405823489, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 18:05:01');
INSERT INTO `quartz_log` VALUES (1954847760389771265, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 18:10:00');
INSERT INTO `quartz_log` VALUES (1954847760599486465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 18:10:00');
INSERT INTO `quartz_log` VALUES (1954847762965458945, '用户解封', 'chatTaskService.banned()', '总共耗时：101毫秒', 'Y', '2025-08-11 18:10:01');
INSERT INTO `quartz_log` VALUES (1954849018672582658, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 18:15:00');
INSERT INTO `quartz_log` VALUES (1954849020841422850, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 18:15:01');
INSERT INTO `quartz_log` VALUES (1954850276921839618, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 18:20:00');
INSERT INTO `quartz_log` VALUES (1954850277093806082, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 18:20:00');
INSERT INTO `quartz_log` VALUES (1954850279187148802, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 18:20:01');
INSERT INTO `quartz_log` VALUES (1954851535187873793, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 18:25:00');
INSERT INTO `quartz_log` VALUES (1954851537524486146, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 18:25:01');
INSERT INTO `quartz_log` VALUES (1954852793479073794, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 18:30:00');
INSERT INTO `quartz_log` VALUES (1954852793642651650, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 18:30:00');
INSERT INTO `quartz_log` VALUES (1954852795857629186, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-11 18:30:01');
INSERT INTO `quartz_log` VALUES (1954854051879325697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 18:35:00');
INSERT INTO `quartz_log` VALUES (1954854063258857473, '钱包任务', 'walletTaskService.task()', '总共耗时：276毫秒', 'Y', '2025-08-11 18:35:02');
INSERT INTO `quartz_log` VALUES (1954855310153748481, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-11 18:40:00');
INSERT INTO `quartz_log` VALUES (1954855310371852290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 18:40:00');
INSERT INTO `quartz_log` VALUES (1954855312729436161, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 18:40:01');
INSERT INTO `quartz_log` VALUES (1954856568449142786, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 18:45:00');
INSERT INTO `quartz_log` VALUES (1954856570882224129, '钱包补偿', 'walletReceiveService.task()', '总共耗时：57毫秒', 'Y', '2025-08-11 18:45:01');
INSERT INTO `quartz_log` VALUES (1954857826723565570, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 18:50:00');
INSERT INTO `quartz_log` VALUES (1954857828606808065, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 18:50:00');
INSERT INTO `quartz_log` VALUES (1954857828892405762, '钱包任务', 'walletTaskService.task()', '总共耗时：82毫秒', 'Y', '2025-08-11 18:50:00');
INSERT INTO `quartz_log` VALUES (1954859085010571266, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 18:55:00');
INSERT INTO `quartz_log` VALUES (1954859087015833602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 18:55:00');
INSERT INTO `quartz_log` VALUES (1954860343314354177, '用户解封', 'chatTaskService.banned()', '总共耗时：14毫秒', 'Y', '2025-08-11 19:00:00');
INSERT INTO `quartz_log` VALUES (1954860343519875074, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 19:00:00');
INSERT INTO `quartz_log` VALUES (1954860345848098817, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-11 19:00:01');
INSERT INTO `quartz_log` VALUES (1954861601584582658, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 19:05:00');
INSERT INTO `quartz_log` VALUES (1954861604193824770, '钱包补偿', 'walletReceiveService.task()', '总共耗时：81毫秒', 'Y', '2025-08-11 19:05:01');
INSERT INTO `quartz_log` VALUES (1954862859909337089, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-11 19:10:00');
INSERT INTO `quartz_log` VALUES (1954862860186161153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 19:10:00');
INSERT INTO `quartz_log` VALUES (1954862862753460225, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 19:10:01');
INSERT INTO `quartz_log` VALUES (1954864118166982658, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 19:15:00');
INSERT INTO `quartz_log` VALUES (1954864120683950082, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-11 19:15:01');
INSERT INTO `quartz_log` VALUES (1954865376470765569, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 19:20:00');
INSERT INTO `quartz_log` VALUES (1954865376684675073, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 19:20:00');
INSERT INTO `quartz_log` VALUES (1954865378975150082, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-11 19:20:01');
INSERT INTO `quartz_log` VALUES (1954866634686468097, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 19:25:00');
INSERT INTO `quartz_log` VALUES (1954866637098577921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 19:25:01');
INSERT INTO `quartz_log` VALUES (1954867893007028225, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 19:30:00');
INSERT INTO `quartz_log` VALUES (1954867893329989633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 19:30:00');
INSERT INTO `quartz_log` VALUES (1954867896140558337, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-11 19:30:01');
INSERT INTO `quartz_log` VALUES (1954869151327588353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-11 19:35:00');
INSERT INTO `quartz_log` VALUES (1954869153500622850, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 19:35:00');
INSERT INTO `quartz_log` VALUES (1954870409606205442, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-11 19:40:00');
INSERT INTO `quartz_log` VALUES (1954870409723645954, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 19:40:00');
INSERT INTO `quartz_log` VALUES (1954870411993149442, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-11 19:40:01');
INSERT INTO `quartz_log` VALUES (1954871667914182658, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 19:45:00');
INSERT INTO `quartz_log` VALUES (1954871668128092162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 19:45:00');
INSERT INTO `quartz_log` VALUES (1954872926205382658, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 19:50:00');
INSERT INTO `quartz_log` VALUES (1954872926419292162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 19:50:00');
INSERT INTO `quartz_log` VALUES (1954872928583938049, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 19:50:01');
INSERT INTO `quartz_log` VALUES (1954874184500776961, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 19:55:00');
INSERT INTO `quartz_log` VALUES (1954874186862555138, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 19:55:01');
INSERT INTO `quartz_log` VALUES (1954875442783588354, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-11 20:00:00');
INSERT INTO `quartz_log` VALUES (1954875443001692162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 20:00:00');
INSERT INTO `quartz_log` VALUES (1954875445304750082, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 20:00:01');
INSERT INTO `quartz_log` VALUES (1954876701066399746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 20:05:00');
INSERT INTO `quartz_log` VALUES (1954876703302348801, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 20:05:01');
INSERT INTO `quartz_log` VALUES (1954877959353405442, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 20:10:00');
INSERT INTO `quartz_log` VALUES (1954877959613452290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 20:10:00');
INSERT INTO `quartz_log` VALUES (1954877962038145025, '用户解封', 'chatTaskService.banned()', '总共耗时：91毫秒', 'Y', '2025-08-11 20:10:01');
INSERT INTO `quartz_log` VALUES (1954879217636216834, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 20:15:00');
INSERT INTO `quartz_log` VALUES (1954879220899770369, '钱包任务', 'walletTaskService.task()', '总共耗时：97毫秒', 'Y', '2025-08-11 20:15:01');
INSERT INTO `quartz_log` VALUES (1954880475948388353, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 20:20:00');
INSERT INTO `quartz_log` VALUES (1954880478443999233, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 20:20:01');
INSERT INTO `quartz_log` VALUES (1954880478788317186, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 20:20:01');
INSERT INTO `quartz_log` VALUES (1954881734214422530, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 20:25:00');
INSERT INTO `quartz_log` VALUES (1954881736760750082, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-11 20:25:01');
INSERT INTO `quartz_log` VALUES (1954882992547565570, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 20:30:00');
INSERT INTO `quartz_log` VALUES (1954882992757280769, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 20:30:00');
INSERT INTO `quartz_log` VALUES (1954882995018395649, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 20:30:01');
INSERT INTO `quartz_log` VALUES (1954884250801016833, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 20:35:00');
INSERT INTO `quartz_log` VALUES (1954884253166989313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 20:35:01');
INSERT INTO `quartz_log` VALUES (1954885509108994049, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-11 20:40:00');
INSERT INTO `quartz_log` VALUES (1954885509322903554, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 20:40:00');
INSERT INTO `quartz_log` VALUES (1954885511655321601, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-11 20:40:01');
INSERT INTO `quartz_log` VALUES (1954886767354056705, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 20:45:00');
INSERT INTO `quartz_log` VALUES (1954886769657114625, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-11 20:45:01');
INSERT INTO `quartz_log` VALUES (1954888025674616834, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-11 20:50:00');
INSERT INTO `quartz_log` VALUES (1954888025875943426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 20:50:00');
INSERT INTO `quartz_log` VALUES (1954888028128669698, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 20:50:01');
INSERT INTO `quartz_log` VALUES (1954889283953233921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 20:55:00');
INSERT INTO `quartz_log` VALUES (1954889286273069058, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-11 20:55:01');
INSERT INTO `quartz_log` VALUES (1954890542240239617, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 21:00:00');
INSERT INTO `quartz_log` VALUES (1954890542571589634, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 21:00:00');
INSERT INTO `quartz_log` VALUES (1954890544711069697, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-11 21:00:01');
INSERT INTO `quartz_log` VALUES (1954891800569188353, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-11 21:05:00');
INSERT INTO `quartz_log` VALUES (1954891800799875074, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 21:05:00');
INSERT INTO `quartz_log` VALUES (1954893058831028226, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 21:10:00');
INSERT INTO `quartz_log` VALUES (1954893059002994689, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 21:10:00');
INSERT INTO `quartz_log` VALUES (1954893061209202690, '钱包任务', 'walletTaskService.task()', '总共耗时：89毫秒', 'Y', '2025-08-11 21:10:01');
INSERT INTO `quartz_log` VALUES (1954894317122228225, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 21:15:00');
INSERT INTO `quartz_log` VALUES (1954894319294881793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：75毫秒', 'Y', '2025-08-11 21:15:00');
INSERT INTO `quartz_log` VALUES (1954895575392456706, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 21:20:00');
INSERT INTO `quartz_log` VALUES (1954895575551840257, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 21:20:00');
INSERT INTO `quartz_log` VALUES (1954895577904848897, '用户解封', 'chatTaskService.banned()', '总共耗时：144毫秒', 'Y', '2025-08-11 21:20:00');
INSERT INTO `quartz_log` VALUES (1954896833725599746, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 21:25:00');
INSERT INTO `quartz_log` VALUES (1954896836229603329, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 21:25:01');
INSERT INTO `quartz_log` VALUES (1954898092025188353, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 21:30:00');
INSERT INTO `quartz_log` VALUES (1954898093698715649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 21:30:00');
INSERT INTO `quartz_log` VALUES (1954898094046846977, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 21:30:00');
INSERT INTO `quartz_log` VALUES (1954899350282833922, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 21:35:00');
INSERT INTO `quartz_log` VALUES (1954899352644231169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：90毫秒', 'Y', '2025-08-11 21:35:01');
INSERT INTO `quartz_log` VALUES (1954900608611782658, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 21:40:00');
INSERT INTO `quartz_log` VALUES (1954900610495025154, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 21:40:00');
INSERT INTO `quartz_log` VALUES (1954900610956402689, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 21:40:01');
INSERT INTO `quartz_log` VALUES (1954901866907176962, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 21:45:00');
INSERT INTO `quartz_log` VALUES (1954901869797060609, '钱包补偿', 'walletReceiveService.task()', '总共耗时：209毫秒', 'Y', '2025-08-11 21:45:01');
INSERT INTO `quartz_log` VALUES (1954903125177405441, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-11 21:50:00');
INSERT INTO `quartz_log` VALUES (1954903125378732033, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 21:50:00');
INSERT INTO `quartz_log` VALUES (1954903127819825153, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 21:50:01');
INSERT INTO `quartz_log` VALUES (1954904383447633921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 21:55:00');
INSERT INTO `quartz_log` VALUES (1954904385897119746, '钱包任务', 'walletTaskService.task()', '总共耗时：85毫秒', 'Y', '2025-08-11 21:55:01');
INSERT INTO `quartz_log` VALUES (1954905641789165570, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-11 22:00:00');
INSERT INTO `quartz_log` VALUES (1954905643513024514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 22:00:00');
INSERT INTO `quartz_log` VALUES (1954905643936661506, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 22:00:01');
INSERT INTO `quartz_log` VALUES (1954906900030033921, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 22:05:00');
INSERT INTO `quartz_log` VALUES (1954906902278193153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 22:05:01');
INSERT INTO `quartz_log` VALUES (1954908158338011137, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 22:10:00');
INSERT INTO `quartz_log` VALUES (1954908160091230209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 22:10:00');
INSERT INTO `quartz_log` VALUES (1954908160842022914, '用户解封', 'chatTaskService.banned()', '总共耗时：130毫秒', 'Y', '2025-08-11 22:10:01');
INSERT INTO `quartz_log` VALUES (1954909416633405442, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 22:15:00');
INSERT INTO `quartz_log` VALUES (1954909418839621634, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-11 22:15:01');
INSERT INTO `quartz_log` VALUES (1954910674924605442, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 22:20:00');
INSERT INTO `quartz_log` VALUES (1954910676518440962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 22:20:00');
INSERT INTO `quartz_log` VALUES (1954910677021769729, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-11 22:20:00');
INSERT INTO `quartz_log` VALUES (1954911933194833921, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 22:25:00');
INSERT INTO `quartz_log` VALUES (1954911935753371649, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-11 22:25:01');
INSERT INTO `quartz_log` VALUES (1954913191498616833, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 22:30:00');
INSERT INTO `quartz_log` VALUES (1954913193356693505, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 22:30:00');
INSERT INTO `quartz_log` VALUES (1954913193864216578, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-11 22:30:01');
INSERT INTO `quartz_log` VALUES (1954914449768845314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 22:35:00');
INSERT INTO `quartz_log` VALUES (1954914452440633345, '钱包任务', 'walletTaskService.task()', '总共耗时：88毫秒', 'Y', '2025-08-11 22:35:01');
INSERT INTO `quartz_log` VALUES (1954915708055851010, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 22:40:00');
INSERT INTO `quartz_log` VALUES (1954915710022979585, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 22:40:01');
INSERT INTO `quartz_log` VALUES (1954915710924771330, '用户解封', 'chatTaskService.banned()', '总共耗时：164毫秒', 'Y', '2025-08-11 22:40:01');
INSERT INTO `quartz_log` VALUES (1954916966355439618, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 22:45:00');
INSERT INTO `quartz_log` VALUES (1954916969178222593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：82毫秒', 'Y', '2025-08-11 22:45:01');
INSERT INTO `quartz_log` VALUES (1954918224667611138, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-11 22:50:00');
INSERT INTO `quartz_log` VALUES (1954918226596990978, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 22:50:00');
INSERT INTO `quartz_log` VALUES (1954918227196792834, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-11 22:50:01');
INSERT INTO `quartz_log` VALUES (1954919482954616834, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 22:55:00');
INSERT INTO `quartz_log` VALUES (1954919485412495362, '钱包补偿', 'walletReceiveService.task()', '总共耗时：66毫秒', 'Y', '2025-08-11 22:55:01');
INSERT INTO `quartz_log` VALUES (1954920741229039617, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 23:00:00');
INSERT INTO `quartz_log` VALUES (1954920743280054274, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 23:00:01');
INSERT INTO `quartz_log` VALUES (1954920743699501058, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-11 23:00:01');
INSERT INTO `quartz_log` VALUES (1954921999532822529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 23:05:00');
INSERT INTO `quartz_log` VALUES (1954922001948758017, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-11 23:05:01');
INSERT INTO `quartz_log` VALUES (1954923257815633921, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 23:10:00');
INSERT INTO `quartz_log` VALUES (1954923259954728962, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 23:10:01');
INSERT INTO `quartz_log` VALUES (1954923260386758658, '用户解封', 'chatTaskService.banned()', '总共耗时：68毫秒', 'Y', '2025-08-11 23:10:01');
INSERT INTO `quartz_log` VALUES (1954924516111028225, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 23:15:00');
INSERT INTO `quartz_log` VALUES (1954924518636015618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-11 23:15:01');
INSERT INTO `quartz_log` VALUES (1954925774377062401, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 23:20:00');
INSERT INTO `quartz_log` VALUES (1954925776159641602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 23:20:00');
INSERT INTO `quartz_log` VALUES (1954925777376010242, '用户解封', 'chatTaskService.banned()', '总共耗时：206毫秒', 'Y', '2025-08-11 23:20:01');
INSERT INTO `quartz_log` VALUES (1954927032706011138, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-11 23:25:00');
INSERT INTO `quartz_log` VALUES (1954927035004510210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-11 23:25:01');
INSERT INTO `quartz_log` VALUES (1954928290972045314, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-11 23:30:00');
INSERT INTO `quartz_log` VALUES (1954928292863676418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 23:30:00');
INSERT INTO `quartz_log` VALUES (1954928293283127298, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-11 23:30:01');
INSERT INTO `quartz_log` VALUES (1954929549280022530, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 23:35:00');
INSERT INTO `quartz_log` VALUES (1954929551461081090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：58毫秒', 'Y', '2025-08-11 23:35:01');
INSERT INTO `quartz_log` VALUES (1954930807550251010, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-11 23:40:00');
INSERT INTO `quartz_log` VALUES (1954930809773232129, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-11 23:40:01');
INSERT INTO `quartz_log` VALUES (1954930810205265921, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-11 23:40:01');
INSERT INTO `quartz_log` VALUES (1954932065841451010, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 23:45:00');
INSERT INTO `quartz_log` VALUES (1954932067963789314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-11 23:45:00');
INSERT INTO `quartz_log` VALUES (1954933324182982658, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-11 23:50:00');
INSERT INTO `quartz_log` VALUES (1954933324405280769, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-11 23:50:00');
INSERT INTO `quartz_log` VALUES (1954933324736630786, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-11 23:50:00');
INSERT INTO `quartz_log` VALUES (1954934582453211137, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-11 23:55:00');
INSERT INTO `quartz_log` VALUES (1954934584814632961, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-11 23:55:01');
INSERT INTO `quartz_log` VALUES (1954935840756994049, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 00:00:00');
INSERT INTO `quartz_log` VALUES (1954935842795425794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 00:00:01');
INSERT INTO `quartz_log` VALUES (1954935843504295937, '用户解封', 'chatTaskService.banned()', '总共耗时：118毫秒', 'Y', '2025-08-12 00:00:01');
INSERT INTO `quartz_log` VALUES (1954937099010445314, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 00:05:00');
INSERT INTO `quartz_log` VALUES (1954937101757747202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 00:05:01');
INSERT INTO `quartz_log` VALUES (1954938357310033921, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 00:10:00');
INSERT INTO `quartz_log` VALUES (1954938357620412418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 00:10:00');
INSERT INTO `quartz_log` VALUES (1954938360774561794, '用户解封', 'chatTaskService.banned()', '总共耗时：91毫秒', 'Y', '2025-08-12 00:10:01');
INSERT INTO `quartz_log` VALUES (1954939615601233922, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 00:15:00');
INSERT INTO `quartz_log` VALUES (1954939618302398466, '钱包任务', 'walletTaskService.task()', '总共耗时：88毫秒', 'Y', '2025-08-12 00:15:01');
INSERT INTO `quartz_log` VALUES (1954940873879851010, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 00:20:00');
INSERT INTO `quartz_log` VALUES (1954940874085371906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 00:20:00');
INSERT INTO `quartz_log` VALUES (1954940876610375682, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 00:20:01');
INSERT INTO `quartz_log` VALUES (1954942132183633922, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 00:25:00');
INSERT INTO `quartz_log` VALUES (1954942134813503490, '钱包补偿', 'walletReceiveService.task()', '总共耗时：93毫秒', 'Y', '2025-08-12 00:25:01');
INSERT INTO `quartz_log` VALUES (1954943390445473793, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 00:30:00');
INSERT INTO `quartz_log` VALUES (1954943390776823809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 00:30:00');
INSERT INTO `quartz_log` VALUES (1954943393272475650, '用户解封', 'chatTaskService.banned()', '总共耗时：119毫秒', 'Y', '2025-08-12 00:30:01');
INSERT INTO `quartz_log` VALUES (1954944648766033921, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 00:35:00');
INSERT INTO `quartz_log` VALUES (1954944651110694914, '钱包补偿', 'walletReceiveService.task()', '总共耗时：82毫秒', 'Y', '2025-08-12 00:35:01');
INSERT INTO `quartz_log` VALUES (1954945907061428226, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 00:40:00');
INSERT INTO `quartz_log` VALUES (1954945907258560514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 00:40:00');
INSERT INTO `quartz_log` VALUES (1954945909607415809, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 00:40:01');
INSERT INTO `quartz_log` VALUES (1954947165335851010, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 00:45:00');
INSERT INTO `quartz_log` VALUES (1954947167642763266, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-12 00:45:01');
INSERT INTO `quartz_log` VALUES (1954948423631245313, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 00:50:00');
INSERT INTO `quartz_log` VALUES (1954948425501904898, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 00:50:00');
INSERT INTO `quartz_log` VALUES (1954948425787162626, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-12 00:50:00');
INSERT INTO `quartz_log` VALUES (1954949681918251009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 00:55:00');
INSERT INTO `quartz_log` VALUES (1954949684090945538, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-12 00:55:00');
INSERT INTO `quartz_log` VALUES (1954950940201062401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 01:00:00');
INSERT INTO `quartz_log` VALUES (1954950942289825794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:00:01');
INSERT INTO `quartz_log` VALUES (1954950942851907586, '用户解封', 'chatTaskService.banned()', '总共耗时：114毫秒', 'Y', '2025-08-12 01:00:01');
INSERT INTO `quartz_log` VALUES (1954952198509039618, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 01:05:00');
INSERT INTO `quartz_log` VALUES (1954952198685200386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 01:05:00');
INSERT INTO `quartz_log` VALUES (1954953456787656705, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:10:00');
INSERT INTO `quartz_log` VALUES (1954953457127395330, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:10:00');
INSERT INTO `quartz_log` VALUES (1954953457324527618, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:10:00');
INSERT INTO `quartz_log` VALUES (1954954715083051009, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:15:00');
INSERT INTO `quartz_log` VALUES (1954954715313737730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:15:00');
INSERT INTO `quartz_log` VALUES (1954955973411999746, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-12 01:20:00');
INSERT INTO `quartz_log` VALUES (1954955973646880770, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 01:20:00');
INSERT INTO `quartz_log` VALUES (1954955973978230785, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 01:20:00');
INSERT INTO `quartz_log` VALUES (1954957231665451009, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:25:00');
INSERT INTO `quartz_log` VALUES (1954957231992606721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:25:00');
INSERT INTO `quartz_log` VALUES (1954958489973428226, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 01:30:00');
INSERT INTO `quartz_log` VALUES (1954958490208309249, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:30:00');
INSERT INTO `quartz_log` VALUES (1954958490564825090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 01:30:00');
INSERT INTO `quartz_log` VALUES (1954959748247851010, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 01:35:00');
INSERT INTO `quartz_log` VALUES (1954959748549840898, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 01:35:00');
INSERT INTO `quartz_log` VALUES (1954961006555828225, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 01:40:00');
INSERT INTO `quartz_log` VALUES (1954961006794903553, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 01:40:00');
INSERT INTO `quartz_log` VALUES (1954961007130447874, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:40:00');
INSERT INTO `quartz_log` VALUES (1954962264842833922, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:45:00');
INSERT INTO `quartz_log` VALUES (1954962265178378241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 01:45:00');
INSERT INTO `quartz_log` VALUES (1954963523138228225, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 01:50:00');
INSERT INTO `quartz_log` VALUES (1954963523410857986, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 01:50:00');
INSERT INTO `quartz_log` VALUES (1954963523746402305, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:50:00');
INSERT INTO `quartz_log` VALUES (1954964781408456706, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 01:55:00');
INSERT INTO `quartz_log` VALUES (1954964781756583938, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 01:55:00');
INSERT INTO `quartz_log` VALUES (1954966039695462402, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 02:00:00');
INSERT INTO `quartz_log` VALUES (1954966040026812418, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 02:00:00');
INSERT INTO `quartz_log` VALUES (1954966040337190914, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:00:00');
INSERT INTO `quartz_log` VALUES (1954967297986662401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 02:05:00');
INSERT INTO `quartz_log` VALUES (1954967298313818114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:05:00');
INSERT INTO `quartz_log` VALUES (1954968556311416834, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 02:10:00');
INSERT INTO `quartz_log` VALUES (1954968556554686466, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 02:10:00');
INSERT INTO `quartz_log` VALUES (1954968556894425089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 02:10:00');
INSERT INTO `quartz_log` VALUES (1954969814581645313, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 02:15:00');
INSERT INTO `quartz_log` VALUES (1954969814887829506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 02:15:00');
INSERT INTO `quartz_log` VALUES (1954971072910594049, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 02:20:00');
INSERT INTO `quartz_log` VALUES (1954971073258721282, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 02:20:00');
INSERT INTO `quartz_log` VALUES (1954971073560711170, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:20:00');
INSERT INTO `quartz_log` VALUES (1954972331168239618, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 02:25:00');
INSERT INTO `quartz_log` VALUES (1954972331491201025, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:25:00');
INSERT INTO `quartz_log` VALUES (1954973589480411138, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 02:30:00');
INSERT INTO `quartz_log` VALUES (1954973589723680769, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 02:30:00');
INSERT INTO `quartz_log` VALUES (1954973590013087746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:30:00');
INSERT INTO `quartz_log` VALUES (1954974847746445314, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 02:35:00');
INSERT INTO `quartz_log` VALUES (1954974848073601026, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 02:35:00');
INSERT INTO `quartz_log` VALUES (1954976106029256706, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 02:40:00');
INSERT INTO `quartz_log` VALUES (1954976106360606721, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 02:40:00');
INSERT INTO `quartz_log` VALUES (1954976106662596609, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:40:00');
INSERT INTO `quartz_log` VALUES (1954977364312068098, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 02:45:00');
INSERT INTO `quartz_log` VALUES (1954977364639223809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 02:45:00');
INSERT INTO `quartz_log` VALUES (1954978622620045313, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 02:50:00');
INSERT INTO `quartz_log` VALUES (1954978622859120642, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 02:50:00');
INSERT INTO `quartz_log` VALUES (1954978623186276353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 02:50:00');
INSERT INTO `quartz_log` VALUES (1954979880902856705, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 02:55:00');
INSERT INTO `quartz_log` VALUES (1954979881230012417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 02:55:00');
INSERT INTO `quartz_log` VALUES (1954981139194056705, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:00:00');
INSERT INTO `quartz_log` VALUES (1954981139760287746, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:00:00');
INSERT INTO `quartz_log` VALUES (1954981140028723201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:00:00');
INSERT INTO `quartz_log` VALUES (1954981140234244097, '用户日活', 'chatTaskService.visit()', '总共耗时：169毫秒', 'Y', '2025-08-12 03:00:00');
INSERT INTO `quartz_log` VALUES (1954982397506228225, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:05:00');
INSERT INTO `quartz_log` VALUES (1954982397837578242, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 03:05:00');
INSERT INTO `quartz_log` VALUES (1954983655751290882, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:10:00');
INSERT INTO `quartz_log` VALUES (1954983655973588994, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:10:00');
INSERT INTO `quartz_log` VALUES (1954983656313327617, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 03:10:00');
INSERT INTO `quartz_log` VALUES (1954984914080239618, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:15:00');
INSERT INTO `quartz_log` VALUES (1954984914424172545, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:15:00');
INSERT INTO `quartz_log` VALUES (1954986172358856705, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:20:00');
INSERT INTO `quartz_log` VALUES (1954986172690206722, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:20:00');
INSERT INTO `quartz_log` VALUES (1954986172983808002, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:20:00');
INSERT INTO `quartz_log` VALUES (1954987430650056706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:25:00');
INSERT INTO `quartz_log` VALUES (1954987430981406721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:25:00');
INSERT INTO `quartz_log` VALUES (1954988688949645314, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:30:00');
INSERT INTO `quartz_log` VALUES (1954988689285189633, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:30:00');
INSERT INTO `quartz_log` VALUES (1954988689578790914, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:30:00');
INSERT INTO `quartz_log` VALUES (1954989947207290881, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:35:00');
INSERT INTO `quartz_log` VALUES (1954989947391840257, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 03:35:00');
INSERT INTO `quartz_log` VALUES (1954991205527851010, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:40:00');
INSERT INTO `quartz_log` VALUES (1954991205871783938, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:40:00');
INSERT INTO `quartz_log` VALUES (1954991206182162433, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 03:40:00');
INSERT INTO `quartz_log` VALUES (1954992463835828225, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 03:45:00');
INSERT INTO `quartz_log` VALUES (1954992464070709249, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:45:00');
INSERT INTO `quartz_log` VALUES (1954993722127028225, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 03:50:00');
INSERT INTO `quartz_log` VALUES (1954993722470961154, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 03:50:00');
INSERT INTO `quartz_log` VALUES (1954993722777145345, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:50:00');
INSERT INTO `quartz_log` VALUES (1954994980397256706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 03:55:00');
INSERT INTO `quartz_log` VALUES (1954994980736995329, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 03:55:00');
INSERT INTO `quartz_log` VALUES (1954996238688456705, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:00:00');
INSERT INTO `quartz_log` VALUES (1954996239028195329, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 04:00:00');
INSERT INTO `quartz_log` VALUES (1954996239325990914, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 04:00:00');
INSERT INTO `quartz_log` VALUES (1954997496996433921, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 04:05:00');
INSERT INTO `quartz_log` VALUES (1954997497231314945, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:05:00');
INSERT INTO `quartz_log` VALUES (1954998755270856705, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 04:10:00');
INSERT INTO `quartz_log` VALUES (1954998755639955458, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 04:10:00');
INSERT INTO `quartz_log` VALUES (1954998755837087745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:10:00');
INSERT INTO `quartz_log` VALUES (1955000013562056705, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:15:00');
INSERT INTO `quartz_log` VALUES (1955000013893406722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 04:15:00');
INSERT INTO `quartz_log` VALUES (1955001271844868098, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 04:20:00');
INSERT INTO `quartz_log` VALUES (1955001272113303553, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 04:20:00');
INSERT INTO `quartz_log` VALUES (1955001272297852930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 04:20:00');
INSERT INTO `quartz_log` VALUES (1955002530140262402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:25:00');
INSERT INTO `quartz_log` VALUES (1955002530463223809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:25:00');
INSERT INTO `quartz_log` VALUES (1955003788456628226, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 04:30:00');
INSERT INTO `quartz_log` VALUES (1955003788695703553, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 04:30:00');
INSERT INTO `quartz_log` VALUES (1955003789035442178, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 04:30:00');
INSERT INTO `quartz_log` VALUES (1955005046726856706, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:35:00');
INSERT INTO `quartz_log` VALUES (1955005047049818114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 04:35:00');
INSERT INTO `quartz_log` VALUES (1955006305022251009, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 04:40:00');
INSERT INTO `quartz_log` VALUES (1955006305332629505, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:40:00');
INSERT INTO `quartz_log` VALUES (1955006305580093442, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 04:40:00');
INSERT INTO `quartz_log` VALUES (1955007563305062402, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 04:45:00');
INSERT INTO `quartz_log` VALUES (1955007563628023810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 04:45:00');
INSERT INTO `quartz_log` VALUES (1955008821608845313, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 04:50:00');
INSERT INTO `quartz_log` VALUES (1955008821843726338, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 04:50:00');
INSERT INTO `quartz_log` VALUES (1955008822175076353, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:50:00');
INSERT INTO `quartz_log` VALUES (1955010079887462402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:55:00');
INSERT INTO `quartz_log` VALUES (1955010080218812418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 04:55:00');
INSERT INTO `quartz_log` VALUES (1955011338170273794, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:00:00');
INSERT INTO `quartz_log` VALUES (1955011338501623809, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 05:00:00');
INSERT INTO `quartz_log` VALUES (1955011339021717506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:00:00');
INSERT INTO `quartz_log` VALUES (1955011339021717507, '群组降级', 'chatTaskService.level()', '总共耗时：56毫秒', 'Y', '2025-08-12 05:00:00');
INSERT INTO `quartz_log` VALUES (1955012596490833922, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:05:00');
INSERT INTO `quartz_log` VALUES (1955012596817989633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:05:00');
INSERT INTO `quartz_log` VALUES (1955013854782033922, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 05:10:00');
INSERT INTO `quartz_log` VALUES (1955013855025303553, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 05:10:00');
INSERT INTO `quartz_log` VALUES (1955013855352459265, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:10:00');
INSERT INTO `quartz_log` VALUES (1955015113094205441, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:15:00');
INSERT INTO `quartz_log` VALUES (1955015113425555457, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:15:00');
INSERT INTO `quartz_log` VALUES (1955016371372822529, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 05:20:00');
INSERT INTO `quartz_log` VALUES (1955016371850973186, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 05:20:00');
INSERT INTO `quartz_log` VALUES (1955016372052299778, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:20:00');
INSERT INTO `quartz_log` VALUES (1955017629634662401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:25:00');
INSERT INTO `quartz_log` VALUES (1955017629949235202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:25:00');
INSERT INTO `quartz_log` VALUES (1955018887934251010, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:30:00');
INSERT INTO `quartz_log` VALUES (1955018888278183938, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 05:30:00');
INSERT INTO `quartz_log` VALUES (1955018888555008002, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 05:30:00');
INSERT INTO `quartz_log` VALUES (1955020146229645313, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 05:35:00');
INSERT INTO `quartz_log` VALUES (1955020146451943425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:35:00');
INSERT INTO `quartz_log` VALUES (1955021404508262401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:40:00');
INSERT INTO `quartz_log` VALUES (1955021404835418114, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:40:00');
INSERT INTO `quartz_log` VALUES (1955021405158379522, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:40:00');
INSERT INTO `quartz_log` VALUES (1955022662799462401, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 05:45:00');
INSERT INTO `quartz_log` VALUES (1955022663122423810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:45:00');
INSERT INTO `quartz_log` VALUES (1955023921094856706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:50:00');
INSERT INTO `quartz_log` VALUES (1955023921426206721, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:50:00');
INSERT INTO `quartz_log` VALUES (1955023921715613698, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:50:00');
INSERT INTO `quartz_log` VALUES (1955025179390251010, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 05:55:00');
INSERT INTO `quartz_log` VALUES (1955025179721601025, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 05:55:00');
INSERT INTO `quartz_log` VALUES (1955026437677256706, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 06:00:00');
INSERT INTO `quartz_log` VALUES (1955026437996023810, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:00:00');
INSERT INTO `quartz_log` VALUES (1955026438298013697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:00:00');
INSERT INTO `quartz_log` VALUES (1955027695960068097, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 06:05:00');
INSERT INTO `quartz_log` VALUES (1955027696291418113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:05:00');
INSERT INTO `quartz_log` VALUES (1955028954276433922, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 06:10:00');
INSERT INTO `quartz_log` VALUES (1955028954502926338, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 06:10:00');
INSERT INTO `quartz_log` VALUES (1955028954855247873, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:10:00');
INSERT INTO `quartz_log` VALUES (1955030212555051009, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:15:00');
INSERT INTO `quartz_log` VALUES (1955030212882206721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:15:00');
INSERT INTO `quartz_log` VALUES (1955031470833668098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 06:20:00');
INSERT INTO `quartz_log` VALUES (1955031471165018113, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:20:00');
INSERT INTO `quartz_log` VALUES (1955031471462813697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:20:00');
INSERT INTO `quartz_log` VALUES (1955032729141645313, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 06:25:00');
INSERT INTO `quartz_log` VALUES (1955032729363943425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 06:25:00');
INSERT INTO `quartz_log` VALUES (1955033987424456706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:30:00');
INSERT INTO `quartz_log` VALUES (1955033987755806722, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 06:30:00');
INSERT INTO `quartz_log` VALUES (1955033988045213697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:30:00');
INSERT INTO `quartz_log` VALUES (1955035245711462401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:35:00');
INSERT INTO `quartz_log` VALUES (1955035246042812418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:35:00');
INSERT INTO `quartz_log` VALUES (1955036504015245314, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 06:40:00');
INSERT INTO `quartz_log` VALUES (1955036504266903554, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 06:40:00');
INSERT INTO `quartz_log` VALUES (1955036504594059266, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:40:00');
INSERT INTO `quartz_log` VALUES (1955037762289668098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 06:45:00');
INSERT INTO `quartz_log` VALUES (1955037762612629506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:45:00');
INSERT INTO `quartz_log` VALUES (1955039020580868097, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:50:00');
INSERT INTO `quartz_log` VALUES (1955039020937383937, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 06:50:00');
INSERT INTO `quartz_log` VALUES (1955039021226790913, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:50:00');
INSERT INTO `quartz_log` VALUES (1955040278884651009, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 06:55:00');
INSERT INTO `quartz_log` VALUES (1955040279111143426, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 06:55:00');
INSERT INTO `quartz_log` VALUES (1955041537163268097, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:00:00');
INSERT INTO `quartz_log` VALUES (1955041537490423810, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 07:00:00');
INSERT INTO `quartz_log` VALUES (1955041537779830785, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:00:00');
INSERT INTO `quartz_log` VALUES (1955042795450273794, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:05:00');
INSERT INTO `quartz_log` VALUES (1955042795718709250, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 07:05:00');
INSERT INTO `quartz_log` VALUES (1955044053745668098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:10:00');
INSERT INTO `quartz_log` VALUES (1955044054072823809, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 07:10:00');
INSERT INTO `quartz_log` VALUES (1955044054362230786, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:10:00');
INSERT INTO `quartz_log` VALUES (1955045312041062401, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 07:15:00');
INSERT INTO `quartz_log` VALUES (1955045312208834562, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:15:00');
INSERT INTO `quartz_log` VALUES (1955046570332262402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:20:00');
INSERT INTO `quartz_log` VALUES (1955046570663612418, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:20:00');
INSERT INTO `quartz_log` VALUES (1955046570953019394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:20:00');
INSERT INTO `quartz_log` VALUES (1955047828623462402, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 07:25:00');
INSERT INTO `quartz_log` VALUES (1955047828925452289, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:25:00');
INSERT INTO `quartz_log` VALUES (1955049086910468098, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 07:30:00');
INSERT INTO `quartz_log` VALUES (1955049087204069377, '用户解封', 'chatTaskService.banned()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:30:00');
INSERT INTO `quartz_log` VALUES (1955049087485087745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:30:00');
INSERT INTO `quartz_log` VALUES (1955050345235222530, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 07:35:00');
INSERT INTO `quartz_log` VALUES (1955050345478492162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:35:00');
INSERT INTO `quartz_log` VALUES (1955051603564171265, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 07:40:00');
INSERT INTO `quartz_log` VALUES (1955051603941658625, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 07:40:00');
INSERT INTO `quartz_log` VALUES (1955051604239454210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:40:00');
INSERT INTO `quartz_log` VALUES (1955052861792456706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 07:45:00');
INSERT INTO `quartz_log` VALUES (1955052862119612418, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:45:00');
INSERT INTO `quartz_log` VALUES (1955054120092045313, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 07:50:00');
INSERT INTO `quartz_log` VALUES (1955054120322732034, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 07:50:00');
INSERT INTO `quartz_log` VALUES (1955054120683442177, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:50:00');
INSERT INTO `quartz_log` VALUES (1955055378374856706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 07:55:00');
INSERT INTO `quartz_log` VALUES (1955055378693623809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 07:55:00');
INSERT INTO `quartz_log` VALUES (1955056636687028226, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 08:00:00');
INSERT INTO `quartz_log` VALUES (1955056637186150401, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 08:00:00');
INSERT INTO `quartz_log` VALUES (1955056637475557378, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:00:00');
INSERT INTO `quartz_log` VALUES (1955057894944673794, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:05:00');
INSERT INTO `quartz_log` VALUES (1955057895259246593, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:05:00');
INSERT INTO `quartz_log` VALUES (1955059153244262402, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 08:10:00');
INSERT INTO `quartz_log` VALUES (1955059153550446594, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 08:10:00');
INSERT INTO `quartz_log` VALUES (1955059153789521921, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:10:00');
INSERT INTO `quartz_log` VALUES (1955060411548045313, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 08:15:00');
INSERT INTO `quartz_log` VALUES (1955060411728400385, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:15:00');
INSERT INTO `quartz_log` VALUES (1955061669822468098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 08:20:00');
INSERT INTO `quartz_log` VALUES (1955061670141235202, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 08:20:00');
INSERT INTO `quartz_log` VALUES (1955061670313201666, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:20:00');
INSERT INTO `quartz_log` VALUES (1955062928105279490, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 08:25:00');
INSERT INTO `quartz_log` VALUES (1955062928415657986, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:25:00');
INSERT INTO `quartz_log` VALUES (1955064186434228226, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 08:30:00');
INSERT INTO `quartz_log` VALUES (1955064186664914946, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 08:30:00');
INSERT INTO `quartz_log` VALUES (1955064187008847873, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:30:00');
INSERT INTO `quartz_log` VALUES (1955065444696068098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 08:35:00');
INSERT INTO `quartz_log` VALUES (1955065445023223810, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:35:00');
INSERT INTO `quartz_log` VALUES (1955066702991462401, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 08:40:00');
INSERT INTO `quartz_log` VALUES (1955066703377338370, '用户解封', 'chatTaskService.banned()', '总共耗时：16毫秒', 'Y', '2025-08-12 08:40:00');
INSERT INTO `quartz_log` VALUES (1955066703779991553, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:40:00');
INSERT INTO `quartz_log` VALUES (1955067961291051009, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 08:45:00');
INSERT INTO `quartz_log` VALUES (1955067961609818114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:45:00');
INSERT INTO `quartz_log` VALUES (1955069219599028225, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 08:50:00');
INSERT INTO `quartz_log` VALUES (1955069219829714945, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 08:50:00');
INSERT INTO `quartz_log` VALUES (1955069220161064961, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:50:00');
INSERT INTO `quartz_log` VALUES (1955070477865062402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 08:55:00');
INSERT INTO `quartz_log` VALUES (1955070478192218114, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 08:55:00');
INSERT INTO `quartz_log` VALUES (1955071736152068098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:00:00');
INSERT INTO `quartz_log` VALUES (1955071736483418113, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 09:00:00');
INSERT INTO `quartz_log` VALUES (1955071736772825090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 09:00:00');
INSERT INTO `quartz_log` VALUES (1955072994443268097, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 09:05:00');
INSERT INTO `quartz_log` VALUES (1955072994757840897, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 09:05:00');
INSERT INTO `quartz_log` VALUES (1955074252738662402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:10:00');
INSERT INTO `quartz_log` VALUES (1955074253070012417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 09:10:00');
INSERT INTO `quartz_log` VALUES (1955074255423066114, '用户解封', 'chatTaskService.banned()', '总共耗时：126毫秒', 'Y', '2025-08-12 09:10:01');
INSERT INTO `quartz_log` VALUES (1955075511025668098, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:15:00');
INSERT INTO `quartz_log` VALUES (1955075513202561026, '钱包补偿', 'walletReceiveService.task()', '总共耗时：40毫秒', 'Y', '2025-08-12 09:15:01');
INSERT INTO `quartz_log` VALUES (1955076769321062401, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:20:00');
INSERT INTO `quartz_log` VALUES (1955076769597886465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 09:20:00');
INSERT INTO `quartz_log` VALUES (1955076771707670530, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-12 09:20:01');
INSERT INTO `quartz_log` VALUES (1955078027637428225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 09:25:00');
INSERT INTO `quartz_log` VALUES (1955078029889818625, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-12 09:25:01');
INSERT INTO `quartz_log` VALUES (1955079285916045314, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 09:30:00');
INSERT INTO `quartz_log` VALUES (1955079286104788993, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:30:00');
INSERT INTO `quartz_log` VALUES (1955079288256516097, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-12 09:30:01');
INSERT INTO `quartz_log` VALUES (1955080544194662401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 09:35:00');
INSERT INTO `quartz_log` VALUES (1955080546543521794, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 09:35:01');
INSERT INTO `quartz_log` VALUES (1955081802490056706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 09:40:00');
INSERT INTO `quartz_log` VALUES (1955081802787852290, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 09:40:00');
INSERT INTO `quartz_log` VALUES (1955081805031854082, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-12 09:40:01');
INSERT INTO `quartz_log` VALUES (1955083060768673793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:45:00');
INSERT INTO `quartz_log` VALUES (1955083063335636994, '钱包任务', 'walletTaskService.task()', '总共耗时：86毫秒', 'Y', '2025-08-12 09:45:01');
INSERT INTO `quartz_log` VALUES (1955084319072456706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 09:50:00');
INSERT INTO `quartz_log` VALUES (1955084319395418113, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 09:50:00');
INSERT INTO `quartz_log` VALUES (1955084319689019394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 09:50:00');
INSERT INTO `quartz_log` VALUES (1955085577355268097, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 09:55:00');
INSERT INTO `quartz_log` VALUES (1955085579947401218, '钱包补偿', 'walletReceiveService.task()', '总共耗时：79毫秒', 'Y', '2025-08-12 09:55:01');
INSERT INTO `quartz_log` VALUES (1955086835675828226, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-12 10:00:00');
INSERT INTO `quartz_log` VALUES (1955086835868766210, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 10:00:00');
INSERT INTO `quartz_log` VALUES (1955086838314098690, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-12 10:00:01');
INSERT INTO `quartz_log` VALUES (1955088093929279490, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:05:00');
INSERT INTO `quartz_log` VALUES (1955088096383000577, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 10:05:01');
INSERT INTO `quartz_log` VALUES (1955089352241451009, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 10:10:00');
INSERT INTO `quartz_log` VALUES (1955089352530857986, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 10:10:00');
INSERT INTO `quartz_log` VALUES (1955089354938441730, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-12 10:10:01');
INSERT INTO `quartz_log` VALUES (1955090610528456706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:15:00');
INSERT INTO `quartz_log` VALUES (1955090613435166721, '钱包任务', 'walletTaskService.task()', '总共耗时：108毫秒', 'Y', '2025-08-12 10:15:01');
INSERT INTO `quartz_log` VALUES (1955091868811268098, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 10:20:00');
INSERT INTO `quartz_log` VALUES (1955091869104869377, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 10:20:00');
INSERT INTO `quartz_log` VALUES (1955091871629905921, '钱包任务', 'walletTaskService.task()', '总共耗时：94毫秒', 'Y', '2025-08-12 10:20:01');
INSERT INTO `quartz_log` VALUES (1955093127102468098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:25:00');
INSERT INTO `quartz_log` VALUES (1955093130147598338, '钱包任务', 'walletTaskService.task()', '总共耗时：82毫秒', 'Y', '2025-08-12 10:25:01');
INSERT INTO `quartz_log` VALUES (1955094385406251010, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 10:30:00');
INSERT INTO `quartz_log` VALUES (1955094385611771905, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:30:00');
INSERT INTO `quartz_log` VALUES (1955094388111642625, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-12 10:30:01');
INSERT INTO `quartz_log` VALUES (1955095643693256706, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:35:00');
INSERT INTO `quartz_log` VALUES (1955095646046334977, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 10:35:01');
INSERT INTO `quartz_log` VALUES (1955096902005428226, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 10:40:00');
INSERT INTO `quartz_log` VALUES (1955096902202560513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:40:00');
INSERT INTO `quartz_log` VALUES (1955096904320757761, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 10:40:01');
INSERT INTO `quartz_log` VALUES (1955098160267268097, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:45:00');
INSERT INTO `quartz_log` VALUES (1955098162502905858, '钱包补偿', 'walletReceiveService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 10:45:00');
INSERT INTO `quartz_log` VALUES (1955099418575245313, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 10:50:00');
INSERT INTO `quartz_log` VALUES (1955099418881429506, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 10:50:00');
INSERT INTO `quartz_log` VALUES (1955099421565861889, '用户解封', 'chatTaskService.banned()', '总共耗时：152毫秒', 'Y', '2025-08-12 10:50:01');
INSERT INTO `quartz_log` VALUES (1955100676820307970, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 10:55:00');
INSERT INTO `quartz_log` VALUES (1955100679592828930, '钱包补偿', 'walletReceiveService.task()', '总共耗时：84毫秒', 'Y', '2025-08-12 10:55:01');
INSERT INTO `quartz_log` VALUES (1955101935145062402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:00:00');
INSERT INTO `quartz_log` VALUES (1955101937460318209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 11:00:01');
INSERT INTO `quartz_log` VALUES (1955101938701922306, '用户解封', 'chatTaskService.banned()', '总共耗时：246毫秒', 'Y', '2025-08-12 11:00:01');
INSERT INTO `quartz_log` VALUES (1955103193427873794, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:05:00');
INSERT INTO `quartz_log` VALUES (1955103195722248193, '钱包补偿', 'walletReceiveService.task()', '总共耗时：78毫秒', 'Y', '2025-08-12 11:05:01');
INSERT INTO `quartz_log` VALUES (1955104451765211137, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-12 11:10:00');
INSERT INTO `quartz_log` VALUES (1955104453564567553, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:10:00');
INSERT INTO `quartz_log` VALUES (1955104454088945666, '钱包任务', 'walletTaskService.task()', '总共耗时：72毫秒', 'Y', '2025-08-12 11:10:01');
INSERT INTO `quartz_log` VALUES (1955105710014468097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:15:00');
INSERT INTO `quartz_log` VALUES (1955105712464031746, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-12 11:15:01');
INSERT INTO `quartz_log` VALUES (1955106968309862402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:20:00');
INSERT INTO `quartz_log` VALUES (1955106970063081473, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 11:20:00');
INSERT INTO `quartz_log` VALUES (1955106970461630466, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-12 11:20:00');
INSERT INTO `quartz_log` VALUES (1955108226601062401, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:25:00');
INSERT INTO `quartz_log` VALUES (1955108228777996290, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 11:25:00');
INSERT INTO `quartz_log` VALUES (1955109484892262402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:30:00');
INSERT INTO `quartz_log` VALUES (1955109486658064386, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 11:30:00');
INSERT INTO `quartz_log` VALUES (1955109487081779201, '用户解封', 'chatTaskService.banned()', '总共耗时：70毫秒', 'Y', '2025-08-12 11:30:00');
INSERT INTO `quartz_log` VALUES (1955110743200239617, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 11:35:00');
INSERT INTO `quartz_log` VALUES (1955110745452670977, '钱包补偿', 'walletReceiveService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 11:35:01');
INSERT INTO `quartz_log` VALUES (1955112001478856706, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 11:40:00');
INSERT INTO `quartz_log` VALUES (1955112003143995394, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 11:40:00');
INSERT INTO `quartz_log` VALUES (1955112003639013377, '用户解封', 'chatTaskService.banned()', '总共耗时：71毫秒', 'Y', '2025-08-12 11:40:00');
INSERT INTO `quartz_log` VALUES (1955113259778445313, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 11:45:00');
INSERT INTO `quartz_log` VALUES (1955113261930213378, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-12 11:45:00');
INSERT INTO `quartz_log` VALUES (1955114518052868097, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:50:00');
INSERT INTO `quartz_log` VALUES (1955114519864807425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 11:50:00');
INSERT INTO `quartz_log` VALUES (1955114520326270978, '用户解封', 'chatTaskService.banned()', '总共耗时：65毫秒', 'Y', '2025-08-12 11:50:01');
INSERT INTO `quartz_log` VALUES (1955115776348262402, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 11:55:00');
INSERT INTO `quartz_log` VALUES (1955115778604888065, '钱包补偿', 'walletReceiveService.task()', '总共耗时：54毫秒', 'Y', '2025-08-12 11:55:01');
INSERT INTO `quartz_log` VALUES (1955117034652045313, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 12:00:00');
INSERT INTO `quartz_log` VALUES (1955117036623368194, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:00:01');
INSERT INTO `quartz_log` VALUES (1955117037260992513, '用户解封', 'chatTaskService.banned()', '总共耗时：84毫秒', 'Y', '2025-08-12 12:00:01');
INSERT INTO `quartz_log` VALUES (1955118292884525057, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:05:00');
INSERT INTO `quartz_log` VALUES (1955118295401197569, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 12:05:01');
INSERT INTO `quartz_log` VALUES (1955119551226056705, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 12:10:00');
INSERT INTO `quartz_log` VALUES (1955119553109299202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 12:10:00');
INSERT INTO `quartz_log` VALUES (1955119553725952001, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 12:10:01');
INSERT INTO `quartz_log` VALUES (1955120809513062401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 12:15:00');
INSERT INTO `quartz_log` VALUES (1955120811912294402, '钱包补偿', 'walletReceiveService.task()', '总共耗时：56毫秒', 'Y', '2025-08-12 12:15:01');
INSERT INTO `quartz_log` VALUES (1955122069410680833, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:20:00');
INSERT INTO `quartz_log` VALUES (1955122069708476417, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 12:20:00');
INSERT INTO `quartz_log` VALUES (1955122069838589954, '用户解封', 'chatTaskService.banned()', '总共耗时：33毫秒', 'Y', '2025-08-12 12:20:00');
INSERT INTO `quartz_log` VALUES (1955123326108045314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 12:25:00');
INSERT INTO `quartz_log` VALUES (1955123328385642498, '钱包任务', 'walletTaskService.task()', '总共耗时：68毫秒', 'Y', '2025-08-12 12:25:01');
INSERT INTO `quartz_log` VALUES (1955124584390856705, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:30:00');
INSERT INTO `quartz_log` VALUES (1955124586194407425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 12:30:00');
INSERT INTO `quartz_log` VALUES (1955124586668453889, '用户解封', 'chatTaskService.banned()', '总共耗时：69毫秒', 'Y', '2025-08-12 12:30:01');
INSERT INTO `quartz_log` VALUES (1955125842673668098, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:35:00');
INSERT INTO `quartz_log` VALUES (1955125845035151361, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-12 12:35:01');
INSERT INTO `quartz_log` VALUES (1955127101002616833, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-12 12:40:00');
INSERT INTO `quartz_log` VALUES (1955127102688727041, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:40:00');
INSERT INTO `quartz_log` VALUES (1955127103213105154, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-12 12:40:00');
INSERT INTO `quartz_log` VALUES (1955128359256068097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:45:00');
INSERT INTO `quartz_log` VALUES (1955128361483333633, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-12 12:45:00');
INSERT INTO `quartz_log` VALUES (1955129617559851009, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 12:50:00');
INSERT INTO `quartz_log` VALUES (1955129617882812418, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 12:50:00');
INSERT INTO `quartz_log` VALUES (1955129618176413697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 12:50:00');
INSERT INTO `quartz_log` VALUES (1955130875834273793, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 12:55:00');
INSERT INTO `quartz_log` VALUES (1955130878296428546, '钱包任务', 'walletTaskService.task()', '总共耗时：77毫秒', 'Y', '2025-08-12 12:55:01');
INSERT INTO `quartz_log` VALUES (1955132134150639617, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 13:00:00');
INSERT INTO `quartz_log` VALUES (1955132135912247297, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 13:00:00');
INSERT INTO `quartz_log` VALUES (1955132136986087426, '用户解封', 'chatTaskService.banned()', '总共耗时：183毫秒', 'Y', '2025-08-12 13:00:01');
INSERT INTO `quartz_log` VALUES (1955133392425062401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:05:00');
INSERT INTO `quartz_log` VALUES (1955133394807525377, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-12 13:05:01');
INSERT INTO `quartz_log` VALUES (1955134650674319362, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-12 13:10:00');
INSERT INTO `quartz_log` VALUES (1955134652440121346, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 13:10:00');
INSERT INTO `quartz_log` VALUES (1955134653115502594, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-12 13:10:01');
INSERT INTO `quartz_log` VALUES (1955135909007462401, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:15:00');
INSERT INTO `quartz_log` VALUES (1955135911595450370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：82毫秒', 'Y', '2025-08-12 13:15:01');
INSERT INTO `quartz_log` VALUES (1955137168913469441, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:20:00');
INSERT INTO `quartz_log` VALUES (1955137169228042241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 13:20:00');
INSERT INTO `quartz_log` VALUES (1955137169567883265, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 13:20:01');
INSERT INTO `quartz_log` VALUES (1955138427296944130, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:25:00');
INSERT INTO `quartz_log` VALUES (1955138427976523778, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 13:25:01');
INSERT INTO `quartz_log` VALUES (1955139685495869441, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 13:30:00');
INSERT INTO `quartz_log` VALUES (1955139685693001730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 13:30:00');
INSERT INTO `quartz_log` VALUES (1955139686175449089, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 13:30:01');
INSERT INTO `quartz_log` VALUES (1955140943657046017, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 13:35:00');
INSERT INTO `quartz_log` VALUES (1955140944365985794, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 13:35:00');
INSERT INTO `quartz_log` VALUES (1955142201965023234, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:40:00');
INSERT INTO `quartz_log` VALUES (1955142202254430209, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 13:40:00');
INSERT INTO `quartz_log` VALUES (1955142203030478850, '用户解封', 'chatTaskService.banned()', '总共耗时：148毫秒', 'Y', '2025-08-12 13:40:00');
INSERT INTO `quartz_log` VALUES (1955143460579184642, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:45:00');
INSERT INTO `quartz_log` VALUES (1955143461367816193, '钱包任务', 'walletTaskService.task()', '总共耗时：73毫秒', 'Y', '2025-08-12 13:45:01');
INSERT INTO `quartz_log` VALUES (1955144718832635905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 13:50:00');
INSERT INTO `quartz_log` VALUES (1955144719130431489, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 13:50:01');
INSERT INTO `quartz_log` VALUES (1955144719575130113, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-12 13:50:01');
INSERT INTO `quartz_log` VALUES (1955145977341939713, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 13:55:01');
INSERT INTO `quartz_log` VALUES (1955145978126376962, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 13:55:01');
INSERT INTO `quartz_log` VALUES (1955147235406647298, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 14:00:00');
INSERT INTO `quartz_log` VALUES (1955147235733803010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 14:00:01');
INSERT INTO `quartz_log` VALUES (1955147236182695938, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-12 14:00:01');
INSERT INTO `quartz_log` VALUES (1955148493601378306, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 14:05:00');
INSERT INTO `quartz_log` VALUES (1955148494377426946, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-12 14:05:01');
INSERT INTO `quartz_log` VALUES (1955149751498313730, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 14:10:00');
INSERT INTO `quartz_log` VALUES (1955149751829663745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 14:10:00');
INSERT INTO `quartz_log` VALUES (1955149752282750978, '用户解封', 'chatTaskService.banned()', '总共耗时：69毫秒', 'Y', '2025-08-12 14:10:00');
INSERT INTO `quartz_log` VALUES (1955151009793708034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 14:15:00');
INSERT INTO `quartz_log` VALUES (1955151010599116802, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-12 14:15:00');
INSERT INTO `quartz_log` VALUES (1955152268357537794, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 14:20:00');
INSERT INTO `quartz_log` VALUES (1955152268546281473, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 14:20:00');
INSERT INTO `quartz_log` VALUES (1955152269141975042, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 14:20:01');
INSERT INTO `quartz_log` VALUES (1955153526447411201, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 14:25:00');
INSERT INTO `quartz_log` VALUES (1955153527248625666, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 14:25:00');
INSERT INTO `quartz_log` VALUES (1955154784621170690, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 14:30:00');
INSERT INTO `quartz_log` VALUES (1955154784986075137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 14:30:00');
INSERT INTO `quartz_log` VALUES (1955154785413996545, '用户解封', 'chatTaskService.banned()', '总共耗时：61毫秒', 'Y', '2025-08-12 14:30:00');
INSERT INTO `quartz_log` VALUES (1955156042950119425, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 14:35:00');
INSERT INTO `quartz_log` VALUES (1955156043742945282, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 14:35:00');
INSERT INTO `quartz_log` VALUES (1955157301207764994, '用户解封', 'chatTaskService.banned()', '总共耗时：4毫秒', 'Y', '2025-08-12 14:40:00');
INSERT INTO `quartz_log` VALUES (1955157301497171970, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 14:40:00');
INSERT INTO `quartz_log` VALUES (1955157302050922498, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 14:40:00');
INSERT INTO `quartz_log` VALUES (1955158559700291585, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 14:45:00');
INSERT INTO `quartz_log` VALUES (1955158560530866177, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 14:45:01');
INSERT INTO `quartz_log` VALUES (1955159817832108033, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 14:50:00');
INSERT INTO `quartz_log` VALUES (1955159818029240321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 14:50:00');
INSERT INTO `quartz_log` VALUES (1955159818624933889, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-12 14:50:00');
INSERT INTO `quartz_log` VALUES (1955161076093947905, '钱包任务', 'walletTaskService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 14:55:00');
INSERT INTO `quartz_log` VALUES (1955161076949688321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 14:55:00');
INSERT INTO `quartz_log` VALUES (1955162334544531457, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 15:00:00');
INSERT INTO `quartz_log` VALUES (1955162334741663745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 15:00:00');
INSERT INTO `quartz_log` VALUES (1955162335446413314, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-12 15:00:01');
INSERT INTO `quartz_log` VALUES (1955163592965754882, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 15:05:00');
INSERT INTO `quartz_log` VALUES (1955163594010247169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：88毫秒', 'Y', '2025-08-12 15:05:01');
INSERT INTO `quartz_log` VALUES (1955164849721839617, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 15:10:00');
INSERT INTO `quartz_log` VALUES (1955164849956720642, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 15:10:00');
INSERT INTO `quartz_log` VALUES (1955164850275487746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 15:10:00');
INSERT INTO `quartz_log` VALUES (1955166109384577025, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 15:15:00');
INSERT INTO `quartz_log` VALUES (1955166110424879106, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 15:15:01');
INSERT INTO `quartz_log` VALUES (1955167367575113730, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 15:20:00');
INSERT INTO `quartz_log` VALUES (1955167367872909313, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 15:20:00');
INSERT INTO `quartz_log` VALUES (1955167368900628482, '用户解封', 'chatTaskService.banned()', '总共耗时：132毫秒', 'Y', '2025-08-12 15:20:01');
INSERT INTO `quartz_log` VALUES (1955168625899868162, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 15:25:00');
INSERT INTO `quartz_log` VALUES (1955168626898227202, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 15:25:01');
INSERT INTO `quartz_log` VALUES (1955169884010713090, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 15:30:00');
INSERT INTO `quartz_log` VALUES (1955169884304314370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 15:30:00');
INSERT INTO `quartz_log` VALUES (1955169885080375298, '用户解封', 'chatTaskService.banned()', '总共耗时：66毫秒', 'Y', '2025-08-12 15:30:00');
INSERT INTO `quartz_log` VALUES (1955171142431936513, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 15:35:00');
INSERT INTO `quartz_log` VALUES (1955171143702929410, '钱包任务', 'walletTaskService.task()', '总共耗时：90毫秒', 'Y', '2025-08-12 15:35:01');
INSERT INTO `quartz_log` VALUES (1955172401033515010, '用户解封', 'chatTaskService.banned()', '总共耗时：6毫秒', 'Y', '2025-08-12 15:40:00');
INSERT INTO `quartz_log` VALUES (1955172401234841602, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 15:40:00');
INSERT INTO `quartz_log` VALUES (1955172402338066433, '钱包任务', 'walletTaskService.task()', '总共耗时：120毫秒', 'Y', '2025-08-12 15:40:01');
INSERT INTO `quartz_log` VALUES (1955173659018530818, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 15:45:00');
INSERT INTO `quartz_log` VALUES (1955173660058841090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：70毫秒', 'Y', '2025-08-12 15:45:01');
INSERT INTO `quartz_log` VALUES (1955174916038856705, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 15:50:00');
INSERT INTO `quartz_log` VALUES (1955174916370206722, '用户解封', 'chatTaskService.banned()', '总共耗时：3毫秒', 'Y', '2025-08-12 15:50:00');
INSERT INTO `quartz_log` VALUES (1955174916659613697, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 15:50:00');
INSERT INTO `quartz_log` VALUES (1955176175877754881, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 15:55:00');
INSERT INTO `quartz_log` VALUES (1955176177769517058, '钱包补偿', 'walletReceiveService.task()', '总共耗时：254毫秒', 'Y', '2025-08-12 15:55:01');
INSERT INTO `quartz_log` VALUES (1955177433850187777, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 16:00:00');
INSERT INTO `quartz_log` VALUES (1955177434147983362, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 16:00:00');
INSERT INTO `quartz_log` VALUES (1955177435280580609, '用户解封', 'chatTaskService.banned()', '总共耗时：143毫秒', 'Y', '2025-08-12 16:00:01');
INSERT INTO `quartz_log` VALUES (1955178692212690945, '钱包任务', 'walletTaskService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 16:05:00');
INSERT INTO `quartz_log` VALUES (1955178693357875202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：73毫秒', 'Y', '2025-08-12 16:05:01');
INSERT INTO `quartz_log` VALUES (1955179950675857409, '钱包任务', 'walletTaskService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 16:10:00');
INSERT INTO `quartz_log` VALUES (1955179950948487170, '钱包补偿', 'walletReceiveService.task()', '总共耗时：1毫秒', 'Y', '2025-08-12 16:10:00');
INSERT INTO `quartz_log` VALUES (1955179952190144513, '用户解封', 'chatTaskService.banned()', '总共耗时：151毫秒', 'Y', '2025-08-12 16:10:01');
INSERT INTO `quartz_log` VALUES (1955181208887365633, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 16:15:00');
INSERT INTO `quartz_log` VALUES (1955181210066108418, '钱包任务', 'walletTaskService.task()', '总共耗时：87毫秒', 'Y', '2025-08-12 16:15:01');
INSERT INTO `quartz_log` VALUES (1955182467220508674, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 16:20:00');
INSERT INTO `quartz_log` VALUES (1955182467447001089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 16:20:00');
INSERT INTO `quartz_log` VALUES (1955182468269228034, '用户解封', 'chatTaskService.banned()', '总共耗时：59毫秒', 'Y', '2025-08-12 16:20:01');
INSERT INTO `quartz_log` VALUES (1955183725473959938, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 16:25:00');
INSERT INTO `quartz_log` VALUES (1955183726585593857, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 16:25:01');
INSERT INTO `quartz_log` VALUES (1955184983685468161, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 16:30:00');
INSERT INTO `quartz_log` VALUES (1955184984008429569, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 16:30:00');
INSERT INTO `quartz_log` VALUES (1955184984771936257, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-12 16:30:01');
INSERT INTO `quartz_log` VALUES (1955186241964085250, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 16:35:00');
INSERT INTO `quartz_log` VALUES (1955186243075719169, '钱包任务', 'walletTaskService.task()', '总共耗时：56毫秒', 'Y', '2025-08-12 16:35:01');
INSERT INTO `quartz_log` VALUES (1955187499974266881, '用户解封', 'chatTaskService.banned()', '总共耗时：5毫秒', 'Y', '2025-08-12 16:40:00');
INSERT INTO `quartz_log` VALUES (1955187500272062465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 16:40:00');
INSERT INTO `quartz_log` VALUES (1955187501090095105, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-12 16:40:00');
INSERT INTO `quartz_log` VALUES (1955188758710210561, '钱包补偿', 'walletReceiveService.task()', '总共耗时：51毫秒', 'Y', '2025-08-12 16:45:00');
INSERT INTO `quartz_log` VALUES (1955188759351934977, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-12 16:45:00');
INSERT INTO `quartz_log` VALUES (1955190016972050434, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 16:50:00');
INSERT INTO `quartz_log` VALUES (1955190017794134017, '用户解封', 'chatTaskService.banned()', '总共耗时：268毫秒', 'Y', '2025-08-12 16:50:00');
INSERT INTO `quartz_log` VALUES (1955190017831878657, '钱包任务', 'walletTaskService.task()', '总共耗时：76毫秒', 'Y', '2025-08-12 16:50:01');
INSERT INTO `quartz_log` VALUES (1955191274994814977, '钱包任务', 'walletTaskService.task()', '总共耗时：34毫秒', 'Y', '2025-08-12 16:55:00');
INSERT INTO `quartz_log` VALUES (1955191276060164097, '钱包补偿', 'walletReceiveService.task()', '总共耗时：87毫秒', 'Y', '2025-08-12 16:55:00');
INSERT INTO `quartz_log` VALUES (1955192533185351681, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-12 17:00:00');
INSERT INTO `quartz_log` VALUES (1955192533453787137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 17:00:00');
INSERT INTO `quartz_log` VALUES (1955192534280060929, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 17:00:00');
INSERT INTO `quartz_log` VALUES (1955193791732404225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：12毫秒', 'Y', '2025-08-12 17:05:00');
INSERT INTO `quartz_log` VALUES (1955193792839696386, '钱包任务', 'walletTaskService.task()', '总共耗时：55毫秒', 'Y', '2025-08-12 17:05:01');
INSERT INTO `quartz_log` VALUES (1955195049834860546, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-12 17:10:00');
INSERT INTO `quartz_log` VALUES (1955195050090713089, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 17:10:00');
INSERT INTO `quartz_log` VALUES (1955195051034427393, '用户解封', 'chatTaskService.banned()', '总共耗时：73毫秒', 'Y', '2025-08-12 17:10:01');
INSERT INTO `quartz_log` VALUES (1955196307920539650, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 17:15:00');
INSERT INTO `quartz_log` VALUES (1955196309073969154, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 17:15:00');
INSERT INTO `quartz_log` VALUES (1955197566308208641, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 17:20:00');
INSERT INTO `quartz_log` VALUES (1955197566543089665, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 17:20:00');
INSERT INTO `quartz_log` VALUES (1955197567495192578, '用户解封', 'chatTaskService.banned()', '总共耗时：74毫秒', 'Y', '2025-08-12 17:20:00');
INSERT INTO `quartz_log` VALUES (1955198824591020034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 17:25:00');
INSERT INTO `quartz_log` VALUES (1955198825807364097, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-12 17:25:01');
INSERT INTO `quartz_log` VALUES (1955200082890608642, '钱包任务', 'walletTaskService.task()', '总共耗时：13毫秒', 'Y', '2025-08-12 17:30:00');
INSERT INTO `quartz_log` VALUES (1955200083108712450, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 17:30:00');
INSERT INTO `quartz_log` VALUES (1955200084094369794, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-12 17:30:01');
INSERT INTO `quartz_log` VALUES (1955201341324414978, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 17:35:00');
INSERT INTO `quartz_log` VALUES (1955201342532370433, '钱包补偿', 'walletReceiveService.task()', '总共耗时：60毫秒', 'Y', '2025-08-12 17:35:01');
INSERT INTO `quartz_log` VALUES (1955202599628197889, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-12 17:40:00');
INSERT INTO `quartz_log` VALUES (1955202599837913090, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 17:40:00');
INSERT INTO `quartz_log` VALUES (1955202600865513473, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-12 17:40:01');
INSERT INTO `quartz_log` VALUES (1955203857877454850, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 17:45:00');
INSERT INTO `quartz_log` VALUES (1955203859144130562, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-12 17:45:01');
INSERT INTO `quartz_log` VALUES (1955205116156071938, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-12 17:50:00');
INSERT INTO `quartz_log` VALUES (1955205116374175745, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 17:50:00');
INSERT INTO `quartz_log` VALUES (1955205117443719169, '钱包任务', 'walletTaskService.task()', '总共耗时：57毫秒', 'Y', '2025-08-12 17:50:01');
INSERT INTO `quartz_log` VALUES (1955206375881719810, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 17:55:01');
INSERT INTO `quartz_log` VALUES (1955206380076023809, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 17:55:02');
INSERT INTO `quartz_log` VALUES (1955207632721694722, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 18:00:00');
INSERT INTO `quartz_log` VALUES (1955207632956575746, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 18:00:00');
INSERT INTO `quartz_log` VALUES (1955207634047090690, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 18:00:01');
INSERT INTO `quartz_log` VALUES (1955208890790596610, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 18:05:00');
INSERT INTO `quartz_log` VALUES (1955208892149547010, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 18:05:01');
INSERT INTO `quartz_log` VALUES (1955210149153099778, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-12 18:10:00');
INSERT INTO `quartz_log` VALUES (1955210149383786498, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 18:10:00');
INSERT INTO `quartz_log` VALUES (1955210150491078658, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 18:10:01');
INSERT INTO `quartz_log` VALUES (1955211407461076994, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 18:15:00');
INSERT INTO `quartz_log` VALUES (1955211408815833090, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 18:15:01');
INSERT INTO `quartz_log` VALUES (1955212665802608642, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-12 18:20:00');
INSERT INTO `quartz_log` VALUES (1955212666083627009, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 18:20:00');
INSERT INTO `quartz_log` VALUES (1955212667186724865, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-12 18:20:01');
INSERT INTO `quartz_log` VALUES (1955213923967979521, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 18:25:00');
INSERT INTO `quartz_log` VALUES (1955213925427593218, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-12 18:25:01');
INSERT INTO `quartz_log` VALUES (1955215182183682049, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-12 18:30:00');
INSERT INTO `quartz_log` VALUES (1955215182410174465, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 18:30:00');
INSERT INTO `quartz_log` VALUES (1955215183613935618, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 18:30:01');
INSERT INTO `quartz_log` VALUES (1955216440877535233, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 18:35:00');
INSERT INTO `quartz_log` VALUES (1955216442240679938, '钱包补偿', 'walletReceiveService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 18:35:01');
INSERT INTO `quartz_log` VALUES (1955217698946437122, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 18:40:00');
INSERT INTO `quartz_log` VALUES (1955217699160346625, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 18:40:00');
INSERT INTO `quartz_log` VALUES (1955217700192141313, '用户解封', 'chatTaskService.banned()', '总共耗时：63毫秒', 'Y', '2025-08-12 18:40:01');
INSERT INTO `quartz_log` VALUES (1955218957447352321, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 18:45:00');
INSERT INTO `quartz_log` VALUES (1955218958663696386, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 18:45:01');
INSERT INTO `quartz_log` VALUES (1955220215805661186, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-12 18:50:00');
INSERT INTO `quartz_log` VALUES (1955220216027959297, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 18:50:00');
INSERT INTO `quartz_log` VALUES (1955220216904564738, '钱包任务', 'walletTaskService.task()', '总共耗时：62毫秒', 'Y', '2025-08-12 18:50:01');
INSERT INTO `quartz_log` VALUES (1955221474163970049, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 18:55:00');
INSERT INTO `quartz_log` VALUES (1955221475267067906, '钱包补偿', 'walletReceiveService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 18:55:01');
INSERT INTO `quartz_log` VALUES (1955222732287397889, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 19:00:00');
INSERT INTO `quartz_log` VALUES (1955222732656496641, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 19:00:00');
INSERT INTO `quartz_log` VALUES (1955222733361135618, '用户解封', 'chatTaskService.banned()', '总共耗时：74毫秒', 'Y', '2025-08-12 19:00:00');
INSERT INTO `quartz_log` VALUES (1955223990872199169, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 19:05:00');
INSERT INTO `quartz_log` VALUES (1955223991966908417, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-12 19:05:01');
INSERT INTO `quartz_log` VALUES (1955225249159204865, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 19:10:00');
INSERT INTO `quartz_log` VALUES (1955225249356337153, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 19:10:00');
INSERT INTO `quartz_log` VALUES (1955225250161639426, '用户解封', 'chatTaskService.banned()', '总共耗时：58毫秒', 'Y', '2025-08-12 19:10:01');
INSERT INTO `quartz_log` VALUES (1955226507534290945, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 19:15:00');
INSERT INTO `quartz_log` VALUES (1955226508461228034, '钱包补偿', 'walletReceiveService.task()', '总共耗时：64毫秒', 'Y', '2025-08-12 19:15:01');
INSERT INTO `quartz_log` VALUES (1955227765624164353, '用户解封', 'chatTaskService.banned()', '总共耗时：14毫秒', 'Y', '2025-08-12 19:20:00');
INSERT INTO `quartz_log` VALUES (1955227765808713729, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 19:20:00');
INSERT INTO `quartz_log` VALUES (1955227766471409666, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 19:20:00');
INSERT INTO `quartz_log` VALUES (1955229025391759361, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 19:25:01');
INSERT INTO `quartz_log` VALUES (1955229026561966082, '钱包任务', 'walletTaskService.task()', '总共耗时：105毫秒', 'Y', '2025-08-12 19:25:01');
INSERT INTO `quartz_log` VALUES (1955230282189787138, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-12 19:30:00');
INSERT INTO `quartz_log` VALUES (1955230282428862466, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 19:30:00');
INSERT INTO `quartz_log` VALUES (1955230282995089409, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-12 19:30:00');
INSERT INTO `quartz_log` VALUES (1955231540619399170, '钱包任务', 'walletTaskService.task()', '总共耗时：11毫秒', 'Y', '2025-08-12 19:35:00');
INSERT INTO `quartz_log` VALUES (1955231541420507137, '钱包补偿', 'walletReceiveService.task()', '总共耗时：71毫秒', 'Y', '2025-08-12 19:35:01');
INSERT INTO `quartz_log` VALUES (1955232799107731458, '钱包任务', 'walletTaskService.task()', '总共耗时：10毫秒', 'Y', '2025-08-12 19:40:00');
INSERT INTO `quartz_log` VALUES (1955232799321640961, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 19:40:00');
INSERT INTO `quartz_log` VALUES (1955232799900450817, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-12 19:40:01');
INSERT INTO `quartz_log` VALUES (1955234057352794113, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 19:45:00');
INSERT INTO `quartz_log` VALUES (1955234058174873602, '钱包任务', 'walletTaskService.task()', '总共耗时：69毫秒', 'Y', '2025-08-12 19:45:01');
INSERT INTO `quartz_log` VALUES (1955235316013092865, '钱包任务', 'walletTaskService.task()', '总共耗时：11毫秒', 'Y', '2025-08-12 19:50:00');
INSERT INTO `quartz_log` VALUES (1955235316197642241, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 19:50:01');
INSERT INTO `quartz_log` VALUES (1955235316893892610, '用户解封', 'chatTaskService.banned()', '总共耗时：80毫秒', 'Y', '2025-08-12 19:50:01');
INSERT INTO `quartz_log` VALUES (1955236573943582721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 19:55:00');
INSERT INTO `quartz_log` VALUES (1955236574732107778, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-12 19:55:01');
INSERT INTO `quartz_log` VALUES (1955237832234782722, '用户解封', 'chatTaskService.banned()', '总共耗时：10毫秒', 'Y', '2025-08-12 20:00:00');
INSERT INTO `quartz_log` VALUES (1955237832448692225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 20:00:00');
INSERT INTO `quartz_log` VALUES (1955237833002336257, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 20:00:01');
INSERT INTO `quartz_log` VALUES (1955239090521788417, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 20:05:00');
INSERT INTO `quartz_log` VALUES (1955239091243204610, '钱包补偿', 'walletReceiveService.task()', '总共耗时：59毫秒', 'Y', '2025-08-12 20:05:01');
INSERT INTO `quartz_log` VALUES (1955240348762656770, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 20:10:00');
INSERT INTO `quartz_log` VALUES (1955240348976566273, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 20:10:00');
INSERT INTO `quartz_log` VALUES (1955240349412769794, '用户解封', 'chatTaskService.banned()', '总共耗时：32毫秒', 'Y', '2025-08-12 20:10:01');
INSERT INTO `quartz_log` VALUES (1955241607137742849, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 20:15:00');
INSERT INTO `quartz_log` VALUES (1955241607943045121, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-12 20:15:01');
INSERT INTO `quartz_log` VALUES (1955242865143730177, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-12 20:20:00');
INSERT INTO `quartz_log` VALUES (1955242865357639681, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 20:20:00');
INSERT INTO `quartz_log` VALUES (1955242865894506498, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 20:20:00');
INSERT INTO `quartz_log` VALUES (1955244123481067522, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 20:25:00');
INSERT INTO `quartz_log` VALUES (1955244124236038146, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 20:25:00');
INSERT INTO `quartz_log` VALUES (1955245382346887170, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 20:30:01');
INSERT INTO `quartz_log` VALUES (1955245382531436545, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 20:30:01');
INSERT INTO `quartz_log` VALUES (1955245383127023617, '用户解封', 'chatTaskService.banned()', '总共耗时：60毫秒', 'Y', '2025-08-12 20:30:01');
INSERT INTO `quartz_log` VALUES (1955246640105410562, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 20:35:00');
INSERT INTO `quartz_log` VALUES (1955246640902324226, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 20:35:01');
INSERT INTO `quartz_log` VALUES (1955247898396610562, '钱包任务', 'walletTaskService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 20:40:00');
INSERT INTO `quartz_log` VALUES (1955247898610520065, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 20:40:00');
INSERT INTO `quartz_log` VALUES (1955247899185135617, '用户解封', 'chatTaskService.banned()', '总共耗时：64毫秒', 'Y', '2025-08-12 20:40:01');
INSERT INTO `quartz_log` VALUES (1955249156666839041, '钱包补偿', 'walletReceiveService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 20:45:00');
INSERT INTO `quartz_log` VALUES (1955249157463752705, '钱包任务', 'walletTaskService.task()', '总共耗时：64毫秒', 'Y', '2025-08-12 20:45:01');
INSERT INTO `quartz_log` VALUES (1955250414987399170, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-12 20:50:00');
INSERT INTO `quartz_log` VALUES (1955250415192920066, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 20:50:00');
INSERT INTO `quartz_log` VALUES (1955250415775924226, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 20:50:01');
INSERT INTO `quartz_log` VALUES (1955251673127604225, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 20:55:00');
INSERT INTO `quartz_log` VALUES (1955251673945489410, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-12 20:55:00');
INSERT INTO `quartz_log` VALUES (1955252931628519425, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-12 21:00:00');
INSERT INTO `quartz_log` VALUES (1955252931821457410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 21:00:00');
INSERT INTO `quartz_log` VALUES (1955252932358324226, '钱包任务', 'walletTaskService.task()', '总共耗时：59毫秒', 'Y', '2025-08-12 21:00:01');
INSERT INTO `quartz_log` VALUES (1955254190020382721, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 21:05:00');
INSERT INTO `quartz_log` VALUES (1955254190871822337, '钱包任务', 'walletTaskService.task()', '总共耗时：71毫秒', 'Y', '2025-08-12 21:05:01');
INSERT INTO `quartz_log` VALUES (1955255448311582721, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 21:10:00');
INSERT INTO `quartz_log` VALUES (1955255448663904258, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 21:10:01');
INSERT INTO `quartz_log` VALUES (1955255449179799553, '用户解封', 'chatTaskService.banned()', '总共耗时：75毫秒', 'Y', '2025-08-12 21:10:01');
INSERT INTO `quartz_log` VALUES (1955256706657308674, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 21:15:00');
INSERT INTO `quartz_log` VALUES (1955256707592634370, '钱包补偿', 'walletReceiveService.task()', '总共耗时：68毫秒', 'Y', '2025-08-12 21:15:01');
INSERT INTO `quartz_log` VALUES (1955257963270787074, '钱包任务', 'walletTaskService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 21:20:00');
INSERT INTO `quartz_log` VALUES (1955257963547611138, '用户解封', 'chatTaskService.banned()', '总共耗时：11毫秒', 'Y', '2025-08-12 21:20:00');
INSERT INTO `quartz_log` VALUES (1955257963887349762, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 21:20:00');
INSERT INTO `quartz_log` VALUES (1955259223180988417, '钱包任务', 'walletTaskService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 21:25:00');
INSERT INTO `quartz_log` VALUES (1955259224028233730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 21:25:01');
INSERT INTO `quartz_log` VALUES (1955260481371525121, '用户解封', 'chatTaskService.banned()', '总共耗时：14毫秒', 'Y', '2025-08-12 21:30:00');
INSERT INTO `quartz_log` VALUES (1955260481551880193, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 21:30:00');
INSERT INTO `quartz_log` VALUES (1955260482252324866, '钱包任务', 'walletTaskService.task()', '总共耗时：70毫秒', 'Y', '2025-08-12 21:30:01');
INSERT INTO `quartz_log` VALUES (1955261739897606145, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 21:35:00');
INSERT INTO `quartz_log` VALUES (1955261740799377410, '钱包补偿', 'walletReceiveService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 21:35:01');
INSERT INTO `quartz_log` VALUES (1955262997714849794, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 21:40:00');
INSERT INTO `quartz_log` VALUES (1955262997924564993, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 21:40:00');
INSERT INTO `quartz_log` VALUES (1955262998599843842, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-12 21:40:00');
INSERT INTO `quartz_log` VALUES (1955264256027021314, '钱包补偿', 'walletReceiveService.task()', '总共耗时：2毫秒', 'Y', '2025-08-12 21:45:00');
INSERT INTO `quartz_log` VALUES (1955264256937181186, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 21:45:01');
INSERT INTO `quartz_log` VALUES (1955265514209169410, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 21:50:00');
INSERT INTO `quartz_log` VALUES (1955265514423078913, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 21:50:00');
INSERT INTO `quartz_log` VALUES (1955265515127717890, '用户解封', 'chatTaskService.banned()', '总共耗时：62毫秒', 'Y', '2025-08-12 21:50:00');
INSERT INTO `quartz_log` VALUES (1955266772525535234, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 21:55:00');
INSERT INTO `quartz_log` VALUES (1955266773452472321, '钱包任务', 'walletTaskService.task()', '总共耗时：58毫秒', 'Y', '2025-08-12 21:55:00');
INSERT INTO `quartz_log` VALUES (1955268030917398529, '用户解封', 'chatTaskService.banned()', '总共耗时：12毫秒', 'Y', '2025-08-12 22:00:00');
INSERT INTO `quartz_log` VALUES (1955268031110336514, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 22:00:00');
INSERT INTO `quartz_log` VALUES (1955268031840141313, '钱包任务', 'walletTaskService.task()', '总共耗时：63毫秒', 'Y', '2025-08-12 22:00:01');
INSERT INTO `quartz_log` VALUES (1955269289263124481, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 22:05:00');
INSERT INTO `quartz_log` VALUES (1955269290286530561, '钱包任务', 'walletTaskService.task()', '总共耗时：66毫秒', 'Y', '2025-08-12 22:05:01');
INSERT INTO `quartz_log` VALUES (1955270547634016258, '钱包任务', 'walletTaskService.task()', '总共耗时：7毫秒', 'Y', '2025-08-12 22:10:00');
INSERT INTO `quartz_log` VALUES (1955270547847925762, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 22:10:00');
INSERT INTO `quartz_log` VALUES (1955270548607090689, '用户解封', 'chatTaskService.banned()', '总共耗时：67毫秒', 'Y', '2025-08-12 22:10:01');
INSERT INTO `quartz_log` VALUES (1955271806097182722, '钱包补偿', 'walletReceiveService.task()', '总共耗时：9毫秒', 'Y', '2025-08-12 22:15:00');
INSERT INTO `quartz_log` VALUES (1955271807032508418, '钱包任务', 'walletTaskService.task()', '总共耗时：60毫秒', 'Y', '2025-08-12 22:15:01');
INSERT INTO `quartz_log` VALUES (1955273064090587137, '用户解封', 'chatTaskService.banned()', '总共耗时：9毫秒', 'Y', '2025-08-12 22:20:00');
INSERT INTO `quartz_log` VALUES (1955273064291913730, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 22:20:00');
INSERT INTO `quartz_log` VALUES (1955273065051078658, '钱包任务', 'walletTaskService.task()', '总共耗时：61毫秒', 'Y', '2025-08-12 22:20:01');
INSERT INTO `quartz_log` VALUES (1955274322293706754, '钱包补偿', 'walletReceiveService.task()', '总共耗时：8毫秒', 'Y', '2025-08-12 22:25:00');
INSERT INTO `quartz_log` VALUES (1955274323317112833, '钱包任务', 'walletTaskService.task()', '总共耗时：65毫秒', 'Y', '2025-08-12 22:25:01');
INSERT INTO `quartz_log` VALUES (1955275580454883329, '用户解封', 'chatTaskService.banned()', '总共耗时：7毫秒', 'Y', '2025-08-12 22:30:00');
INSERT INTO `quartz_log` VALUES (1955275580664598529, '钱包补偿', 'walletReceiveService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 22:30:00');
INSERT INTO `quartz_log` VALUES (1955275581457317889, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 22:30:00');
INSERT INTO `quartz_log` VALUES (1955276837647175681, '钱包任务', 'walletTaskService.task()', '总共耗时：5毫秒', 'Y', '2025-08-12 22:35:00');
INSERT INTO `quartz_log` VALUES (1955276837907222530, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 22:35:00');
INSERT INTO `quartz_log` VALUES (1955278097158918146, '钱包任务', 'walletTaskService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 22:40:00');
INSERT INTO `quartz_log` VALUES (1955278097473490946, '钱包补偿', 'walletReceiveService.task()', '总共耗时：3毫秒', 'Y', '2025-08-12 22:40:00');
INSERT INTO `quartz_log` VALUES (1955278098710827009, '用户解封', 'chatTaskService.banned()', '总共耗时：179毫秒', 'Y', '2025-08-12 22:40:01');
INSERT INTO `quartz_log` VALUES (1955279355634667521, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 22:45:00');
INSERT INTO `quartz_log` VALUES (1955279356934926338, '钱包任务', 'walletTaskService.task()', '总共耗时：74毫秒', 'Y', '2025-08-12 22:45:01');
INSERT INTO `quartz_log` VALUES (1955280613904896001, '用户解封', 'chatTaskService.banned()', '总共耗时：8毫秒', 'Y', '2025-08-12 22:50:00');
INSERT INTO `quartz_log` VALUES (1955280614114611202, '钱包补偿', 'walletReceiveService.task()', '总共耗时：4毫秒', 'Y', '2025-08-12 22:50:00');
INSERT INTO `quartz_log` VALUES (1955280614961889281, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 22:50:01');
INSERT INTO `quartz_log` VALUES (1955281872682635265, '钱包补偿', 'walletReceiveService.task()', '总共耗时：6毫秒', 'Y', '2025-08-12 22:55:00');
INSERT INTO `quartz_log` VALUES (1955281873731239937, '钱包任务', 'walletTaskService.task()', '总共耗时：67毫秒', 'Y', '2025-08-12 22:55:01');

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
INSERT INTO `sys_error` VALUES (1953400719038058497, 1952279326569910274, '数据不存在', '2025-08-07 18:19:59');
INSERT INTO `sys_error` VALUES (1954023466722226177, 1952278488039825409, '数据不存在', '2025-08-09 11:34:33');
INSERT INTO `sys_error` VALUES (1954023630778232834, 1952278488039825409, '数据不存在', '2025-08-09 11:35:12');
INSERT INTO `sys_error` VALUES (1954028740958842882, 1952278488039825409, '数据不存在', '2025-08-09 11:55:31');
INSERT INTO `sys_error` VALUES (1954028801537175554, 1952278488039825409, NULL, '2025-08-09 11:55:45');
INSERT INTO `sys_error` VALUES (1954119500752437250, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: WRONGTYPE Operation against a key holding the wrong kind of value', '2025-08-09 17:56:09');
INSERT INTO `sys_error` VALUES (1954141684099137538, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 19:24:18');
INSERT INTO `sys_error` VALUES (1954141684589871106, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 19:24:18');
INSERT INTO `sys_error` VALUES (1954141684749254658, 1953400949577977858, 'Redis exception; nested exception is io.lettuce.core.RedisException: java.io.IOException: 远程主机强迫关闭了一个现有的连接。', '2025-08-09 19:24:18');
INSERT INTO `sys_error` VALUES (1954148888080498689, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 19:52:56');
INSERT INTO `sys_error` VALUES (1954148888374099970, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 19:52:56');
INSERT INTO `sys_error` VALUES (1954150017212301314, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 19:57:25');
INSERT INTO `sys_error` VALUES (1954150017384267778, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 19:57:25');
INSERT INTO `sys_error` VALUES (1954151730220580865, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:04:14');
INSERT INTO `sys_error` VALUES (1954151730472239105, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:04:14');
INSERT INTO `sys_error` VALUES (1954151730958778369, 1953400949577977858, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:04:14');
INSERT INTO `sys_error` VALUES (1954152139492376578, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:05:51');
INSERT INTO `sys_error` VALUES (1954152153836896257, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:05:55');
INSERT INTO `sys_error` VALUES (1954152190184734721, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:03');
INSERT INTO `sys_error` VALUES (1954152206106312705, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:07');
INSERT INTO `sys_error` VALUES (1954152240080175106, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:15');
INSERT INTO `sys_error` VALUES (1954152268681134081, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:22');
INSERT INTO `sys_error` VALUES (1954152268681134082, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:22');
INSERT INTO `sys_error` VALUES (1954152268798574593, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:22');
INSERT INTO `sys_error` VALUES (1954152312431919105, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:32');
INSERT INTO `sys_error` VALUES (1954152366592966658, 1954076247092981761, 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: READONLY You can\'t write against a read only replica.', '2025-08-09 20:06:45');
INSERT INTO `sys_error` VALUES (1954384228334678018, 1953400949577977858, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n        SELECT\n        visibility,\n        user_id AS moment_us\' at line 2\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: -- 先获取指定moment_id的visibility和相关字段         WITH moment_info AS (         SELECT         visibility,         user_id AS moment_user_id,         visuser         FROM friend_moments         WHERE moment_id = ?         )         -- 根据不同visibility返回不同的user_id列表         SELECT user_id FROM (         -- 情况1：visibility为0时，返回所有用户ID         SELECT cu.user_id         FROM chat_user cu, moment_info mi         WHERE mi.visibility = 0          UNION          -- 情况2：visibility为1时，返回当前用户的所有好友ID         SELECT cf.user_id         FROM chat_friend cf, moment_info mi         WHERE mi.visibility = 1         AND cf.current_id = mi.moment_user_id          UNION          -- 情况3：visibility为2时，仅返回发布者自己的ID         SELECT mi.moment_user_id         FROM moment_info mi         WHERE mi.visibility = 2          UNION          -- 情况4：visibility为3时，返回visuser中指定的用户ID,这个单独处理         UNION          -- 情况5：visibility为4时，返回当前用户的好友中不在visuser中的ID         SELECT cf.user_id         FROM chat_friend cf, moment_info mi         WHERE mi.visibility = 4         AND cf.current_id = mi.moment_user_id         AND NOT FIND_IN_SET(cf.user_id, mi.visuser)         ) AS user_ids\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n        SELECT\n        visibility,\n        user_id AS moment_us\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n        SELECT\n        visibility,\n        user_id AS moment_us\' at line 2', '2025-08-10 11:28:05');
INSERT INTO `sys_error` VALUES (1954384856385568770, 1953400949577977858, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n        SELECT\n        visibility,\n        user_id AS moment_us\' at line 2\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: -- 先获取指定moment_id的visibility和相关字段         WITH moment_info AS (         SELECT         visibility,         user_id AS moment_user_id,         visuser         FROM friend_moments         WHERE moment_id = ?         )         -- 根据不同visibility返回不同的user_id列表         SELECT user_id FROM (         -- 情况1：visibility为0时，返回所有用户ID         SELECT cu.user_id         FROM chat_user cu, moment_info mi         WHERE mi.visibility = 0          UNION          -- 情况2：visibility为1时，返回当前用户的所有好友ID         SELECT cf.user_id         FROM chat_friend cf, moment_info mi         WHERE mi.visibility = 1         AND cf.current_id = mi.moment_user_id          UNION          -- 情况3：visibility为2时，仅返回发布者自己的ID         SELECT mi.moment_user_id         FROM moment_info mi         WHERE mi.visibility = 2          -- 情况4：visibility为3时，返回visuser中指定的用户ID,这个单独处理         UNION         SELECT cf.user_id         FROM chat_friend cf, moment_info mi         WHERE mi.visibility = 4         AND cf.current_id = mi.moment_user_id         AND NOT FIND_IN_SET(cf.user_id, mi.visuser)         ) AS user_ids\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n        SELECT\n        visibility,\n        user_id AS moment_us\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n        SELECT\n        visibility,\n        user_id AS moment_us\' at line 2', '2025-08-10 11:30:35');
INSERT INTO `sys_error` VALUES (1954385572726558721, 1953400949577977858, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n    SELECT\n    visibility,\n    user_id AS moment_user_id,\n    v\' at line 1\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: WITH moment_info AS (     SELECT     visibility,     user_id AS moment_user_id,     visuser     FROM friend_moments     WHERE moment_id = ?     )              SELECT user_id FROM (          SELECT cu.user_id     FROM chat_user cu, moment_info mi     WHERE mi.visibility = 0      UNION          SELECT cf.user_id     FROM chat_friend cf, moment_info mi     WHERE mi.visibility = 1     AND cf.current_id = mi.moment_user_id      UNION          SELECT mi.moment_user_id     FROM moment_info mi     WHERE mi.visibility = 2           UNION     SELECT cf.user_id     FROM chat_friend cf, moment_info mi     WHERE mi.visibility = 4     AND cf.current_id = mi.moment_user_id     AND NOT FIND_IN_SET(cf.user_id, mi.visuser)     ) AS user_ids\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n    SELECT\n    visibility,\n    user_id AS moment_user_id,\n    v\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'moment_info AS (\n    SELECT\n    visibility,\n    user_id AS moment_user_id,\n    v\' at line 1', '2025-08-10 11:33:26');
INSERT INTO `sys_error` VALUES (1954413686278078466, 1953400949577977858, 'Redis exception; nested exception is io.lettuce.core.RedisException: java.io.IOException: 远程主机强迫关闭了一个现有的连接。', '2025-08-10 13:25:09');
INSERT INTO `sys_error` VALUES (1954470403959443458, 1953400949577977858, 'Redis exception; nested exception is io.lettuce.core.RedisException: java.io.IOException: 远程主机强迫关闭了一个现有的连接。', '2025-08-10 17:10:31');
INSERT INTO `sys_error` VALUES (1954497297467592705, 1953400949577977858, 'Redis command timed out; nested exception is io.lettuce.core.RedisCommandTimeoutException: Command timed out after 5 second(s)', '2025-08-10 18:57:23');
INSERT INTO `sys_error` VALUES (1954532409496342529, 1954076247092981761, 'com.platform.modules.friend.vo.MomentVo01 cannot be cast to com.platform.modules.friend.vo.MomentVo03', '2025-08-10 21:16:55');
INSERT INTO `sys_error` VALUES (1954533083370004482, 1954076247092981761, NULL, '2025-08-10 21:19:35');
INSERT INTO `sys_error` VALUES (1954534066871382017, 1954076247092981761, NULL, '2025-08-10 21:23:30');
INSERT INTO `sys_error` VALUES (1954534513208246274, 1954076247092981761, NULL, '2025-08-10 21:25:16');
INSERT INTO `sys_error` VALUES (1954537101542612994, 1954076247092981761, NULL, '2025-08-10 21:35:33');
INSERT INTO `sys_error` VALUES (1954826938870755330, 1954076247092981761, 'No handler found for GET /friend/moments/pullMsg', '2025-08-11 16:47:16');
INSERT INTO `sys_error` VALUES (1954826948811255810, 1954076247092981761, 'No handler found for GET /friend/moments/pullMsg', '2025-08-11 16:47:18');
INSERT INTO `sys_error` VALUES (1954827353645477889, 1954076247092981761, 'No handler found for GET /friend/moments/pullMsg', '2025-08-11 16:48:55');
INSERT INTO `sys_error` VALUES (1954827837965955073, 1954076247092981761, 'No handler found for GET /friend/moments/pullMsg', '2025-08-11 16:50:50');
INSERT INTO `sys_error` VALUES (1954836572080041986, 1953400949577977858, 'Redis command timed out; nested exception is io.lettuce.core.RedisCommandTimeoutException: Command timed out after 5 second(s)', '2025-08-11 17:25:33');
INSERT INTO `sys_error` VALUES (1954836580288294914, 1953400949577977858, 'Redis command timed out; nested exception is io.lettuce.core.RedisCommandTimeoutException: Command timed out after 5 second(s)', '2025-08-11 17:25:35');
INSERT INTO `sys_error` VALUES (1954836587041124354, 1953400949577977858, 'Redis command timed out; nested exception is io.lettuce.core.RedisCommandTimeoutException: Command timed out after 5 second(s)', '2025-08-11 17:25:36');
INSERT INTO `sys_error` VALUES (1954908427306156034, 1954024510055346177, 'Redis exception; nested exception is io.lettuce.core.RedisException: java.io.IOException: 远程主机强迫关闭了一个现有的连接。', '2025-08-11 22:11:04');
INSERT INTO `sys_error` VALUES (1955127833479180289, 1953400949577977858, 'Redis exception; nested exception is io.lettuce.core.RedisException: java.io.IOException: 远程主机强迫关闭了一个现有的连接。', '2025-08-12 12:42:55');
INSERT INTO `sys_error` VALUES (1955137503287681026, 1953400949577977858, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'visuser\'. It was either not specified and/or could not be found for the javaType (java.util.List) : jdbcType (null) combination.\r\n### The error may exist in com/platform/modules/friend/dao/FriendMomentsDao.java (best guess)\r\n### The error may involve com.platform.modules.friend.dao.FriendMomentsDao.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'visuser\'. It was either not specified and/or could not be found for the javaType (java.util.List) : jdbcType (null) combination.', '2025-08-12 13:21:20');
INSERT INTO `sys_error` VALUES (1955162086317338626, 1953400949577977858, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'visuser\'. It was either not specified and/or could not be found for the javaType (java.util.List) : jdbcType (null) combination.\r\n### The error may exist in com/platform/modules/friend/dao/FriendMomentsDao.java (best guess)\r\n### The error may involve com.platform.modules.friend.dao.FriendMomentsDao.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'visuser\'. It was either not specified and/or could not be found for the javaType (java.util.List) : jdbcType (null) combination.', '2025-08-12 14:59:01');
INSERT INTO `sys_error` VALUES (1955165953851510786, 1953400949577977858, NULL, '2025-08-12 15:14:23');
INSERT INTO `sys_error` VALUES (1955178473853169666, 1953400949577977858, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: java.lang.NullPointerException\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT user_id FROM (                  SELECT cu.user_id         FROM chat_user cu,         (SELECT visibility, user_id AS moment_user_id, visuser         FROM friend_moments         WHERE moment_id = ?) mi         WHERE mi.visibility = 0          UNION                   SELECT cf.user_id         FROM chat_friend cf,         (SELECT visibility, user_id AS moment_user_id, visuser         FROM friend_moments         WHERE moment_id = ?) mi         WHERE mi.visibility = 1         AND cf.current_id = mi.moment_user_id          UNION                   SELECT mi.moment_user_id         FROM (SELECT visibility, user_id AS moment_user_id, visuser         FROM friend_moments         WHERE moment_id = ?) mi         WHERE mi.visibility = 2          UNION                   SELECT cf.user_id         FROM chat_friend cf,         (SELECT visibility, user_id AS moment_user_id, visuser         FROM friend_moments         WHERE moment_id = ?) mi         WHERE mi.visibility = 4         AND cf.current_id = mi.moment_user_id         -- 核心修改：使用JSON_CONTAINS判断ID是否在JSON数组中         AND NOT JSON_CONTAINS(mi.visuser, CONCAT(\'\"\', cf.user_id, \'\"\'), \'$\')\r\n### Cause: java.lang.NullPointerException', '2025-08-12 16:04:08');
INSERT INTO `sys_error` VALUES (1955185900493213697, 1954024510055346177, 'For input string: \"[\"1954024510055346177\"]\"', '2025-08-12 16:33:39');
INSERT INTO `sys_error` VALUES (1955277293005996034, 1953400949577977858, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'fm\' not found. Available parameters are [userIdSelf, userId, param1, param2]', '2025-08-12 22:36:49');
INSERT INTO `sys_error` VALUES (1955278094961119234, 1953400949577977858, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: java.lang.NullPointerException\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select count(0) from (  select fm.moment_id,                fm.user_id,                fm.content,                fm.location,                fm.visibility,                fm.create_time,                fm.visuser,                fm.update_time,                fm.is_deleted,                cu.nickname,                cu.portrait         from friend_moments fm                  left join chat_user cu on fm.user_id = cu.user_id               INNER JOIN (SELECT DISTINCT moment_id FROM friend_medias) fm2         ON fm.moment_id = fm2.moment_id          WHERE fm.user_id = ?                                            1 = 1          ORDER BY fm.create_time DESC  ) tmp_count\r\n### Cause: java.lang.NullPointerException', '2025-08-12 22:40:00');
INSERT INTO `sys_error` VALUES (1955278782239776770, 1953400949577977858, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'visibility\' not found. Available parameters are [userIdSelf, userId, param1, param2]', '2025-08-12 22:42:44');
INSERT INTO `sys_error` VALUES (1955279967931772929, 1953400949577977858, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select count(0) from (  select fm.moment_id,                fm.user_id,                fm.content,                fm.location,                fm.visibility,                fm.create_time,                fm.visuser,                fm.update_time,                fm.is_deleted,                cu.nickname,                cu.portrait         from friend_moments fm                  left join chat_user cu on fm.user_id = cu.user_id               INNER JOIN (SELECT DISTINCT moment_id FROM friend_medias) fm2         ON fm.moment_id = fm2.moment_id          WHERE fm.user_id = ?                                                                       (                 -- 2.1：visibility=0（公开）                 fm.visibility = 0                 OR                 -- 2.2：visibility=1（好友可见），需判断好友关系                 (                 fm.visibility = 1                 AND EXISTS (                 SELECT 1 FROM chat_friend                 WHERE chat_friend.user_id = fm.user_id                 AND chat_friend.current_id = ?                 )                 )                 OR                 -- 2.3：visibility=3（部分可见），检查JSON包含                 (                 fm.visibility = 3                 AND JSON_CONTAINS(fm.visuser, CONCAT(\'\"\', ?, \'\"\'), \'$\')                 )                 OR                 -- 2.4：visibility=4（不给谁看），检查JSON不包含                 (                 fm.visibility = 4                 AND NOT JSON_CONTAINS(fm.visuser, CONCAT(\'\"\', ?, \'\"\'), \'$\')                 )                 )          ORDER BY fm.create_time DESC  ) tmp_count\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25', '2025-08-12 22:47:26');
INSERT INTO `sys_error` VALUES (1955280018628325377, 1953400949577977858, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select count(0) from (  select fm.moment_id,                fm.user_id,                fm.content,                fm.location,                fm.visibility,                fm.create_time,                fm.visuser,                fm.update_time,                fm.is_deleted,                cu.nickname,                cu.portrait         from friend_moments fm                  left join chat_user cu on fm.user_id = cu.user_id               INNER JOIN (SELECT DISTINCT moment_id FROM friend_medias) fm2         ON fm.moment_id = fm2.moment_id          WHERE fm.user_id = ?                                                                       (                 -- 2.1：visibility=0（公开）                 fm.visibility = 0                 OR                 -- 2.2：visibility=1（好友可见），需判断好友关系                 (                 fm.visibility = 1                 AND EXISTS (                 SELECT 1 FROM chat_friend                 WHERE chat_friend.user_id = fm.user_id                 AND chat_friend.current_id = ?                 )                 )                 OR                 -- 2.3：visibility=3（部分可见），检查JSON包含                 (                 fm.visibility = 3                 AND JSON_CONTAINS(fm.visuser, CONCAT(\'\"\', ?, \'\"\'), \'$\')                 )                 OR                 -- 2.4：visibility=4（不给谁看），检查JSON不包含                 (                 fm.visibility = 4                 AND NOT JSON_CONTAINS(fm.visuser, CONCAT(\'\"\', ?, \'\"\'), \'$\')                 )                 )          ORDER BY fm.create_time DESC  ) tmp_count\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25', '2025-08-12 22:47:38');
INSERT INTO `sys_error` VALUES (1955280063939391490, 1953400949577977858, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25\r\n### The error may exist in file [E:\\Xim\\Nim\\alpaca-api\\target\\classes\\mapper\\friend\\FriendMomentsDao.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select count(0) from (  select fm.moment_id,                fm.user_id,                fm.content,                fm.location,                fm.visibility,                fm.create_time,                fm.visuser,                fm.update_time,                fm.is_deleted,                cu.nickname,                cu.portrait         from friend_moments fm                  left join chat_user cu on fm.user_id = cu.user_id               INNER JOIN (SELECT DISTINCT moment_id FROM friend_medias) fm2         ON fm.moment_id = fm2.moment_id          WHERE fm.user_id = ?                                                                       (                 -- 2.1：visibility=0（公开）                 fm.visibility = 0                 OR                 -- 2.2：visibility=1（好友可见），需判断好友关系                 (                 fm.visibility = 1                 AND EXISTS (                 SELECT 1 FROM chat_friend                 WHERE chat_friend.user_id = fm.user_id                 AND chat_friend.current_id = ?                 )                 )                 OR                 -- 2.3：visibility=3（部分可见），检查JSON包含                 (                 fm.visibility = 3                 AND JSON_CONTAINS(fm.visuser, CONCAT(\'\"\', ?, \'\"\'), \'$\')                 )                 OR                 -- 2.4：visibility=4（不给谁看），检查JSON不包含                 (                 fm.visibility = 4                 AND NOT JSON_CONTAINS(fm.visuser, CONCAT(\'\"\', ?, \'\"\'), \'$\')                 )                 )          ORDER BY fm.create_time DESC  ) tmp_count\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'(\n                -- 2.1：visibility=0（公开）\n                fm.visibilit\' at line 25', '2025-08-12 22:47:49');

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
INSERT INTO `uni_item` VALUES (10001, NULL, '百度一下', 'http://110.42.56.25:19000/xim/root/4.png', 100, 'https://www.baidu.com/', 'url', 'Y');
INSERT INTO `uni_item` VALUES (10002, '__UNI__E28E426', '天气预报', 'http://110.42.56.25:19000/xim/root/5.png', 100, 'https://baidu.com/alpaca/wgt/__UNI__E28E426.wgt', 'mini', 'Y');
INSERT INTO `uni_item` VALUES (10003, '__UNI__50FBB74', '授权示例', 'http://110.42.56.25:19000/xim/root/6.png', 100, 'https://baidu.com/alpaca/wgt/__UNI__50FBB74.wgt', 'mini', 'Y');

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
INSERT INTO `wallet_info` VALUES (1953400949577977858, 12.00, 'zlpg', '557c6116ec50a936ecab306de423a9dd', 4);
INSERT INTO `wallet_info` VALUES (1954021065327996929, 6.00, 'c0m1', 'd81072d4aaac3a677f047bad0a2e7c65', 2);
INSERT INTO `wallet_info` VALUES (1954024510055346177, 3.00, 'h8zx', 'cd68daa6d783b272c26cc08ec9cf1929', 1);
INSERT INTO `wallet_info` VALUES (1954042044259332098, 0.00, 'l4l8', '439cae15f1f31bbb80a0d3bbac53b3f2', 0);
INSERT INTO `wallet_info` VALUES (1954076247092981761, 3.00, 'egrf', '16027b51e78a820d629941025c707b93', 1);
INSERT INTO `wallet_info` VALUES (1954840748109074433, 0.00, 'i23k', 'f2c94938e3c27b6582dec87233342877', 0);

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
INSERT INTO `wallet_trade` VALUES (1953402780299399170, '1019', 'N', 3.00, 1, '每日签到', 3.00, '1', 1953402780299399169, '1019', 1953400949577977858, '10045995', '濮阳棒风', '13955555555', 'http://192.168.0.1:19000/xim/att/4.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-07 18:28:10', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1954021097473142786, '1019', 'N', 3.00, 1, '每日签到', 3.00, '1', 1954021097473142785, '1019', 1954021065327996929, '10076419', '钟离寞寒', '13977777777', 'http://110.42.56.25:19000/xim/att/11.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-09 11:25:08', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1954169435778670595, '1019', 'N', 3.00, 1, '每日签到', 6.00, '1', 1954169435778670594, '1019', 1953400949577977858, '10045995', '濮阳棒风', '13955555555', 'http://192.168.0.1:19000/xim/att/4.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-09 21:14:35', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1954331019008110595, '1019', 'N', 3.00, 1, '每日签到', 6.00, '1', 1954331019008110594, '1019', 1954021065327996929, '10076419', '钟离寞寒', '13977777777', 'http://110.42.56.25:19000/xim/att/11.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-10 07:56:39', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1954827100242407427, '1019', 'N', 3.00, 1, '每日签到', 3.00, '1', 1954827100242407426, '1019', 1954076247092981761, '12596108', '熊真', '13188888888', 'http://110.42.56.25:19000/xim/att/9.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-11 16:47:54', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1954907296853147651, '1019', 'N', 3.00, 1, '每日签到', 9.00, '1', 1954907296853147650, '1019', 1953400949577977858, '10045995', '濮阳棒风', '13955555555', 'http://110.42.56.25:19000/xim/att/4.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-11 22:06:35', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1954946568696152066, '1019', 'N', 3.00, 1, '每日签到', 12.00, '1', 1954946568696152065, '1019', 1953400949577977858, '10045995', '濮阳棒风', '13955555555', 'http://110.42.56.25:19000/xim/att/4.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-12 00:42:38', NULL, 0);
INSERT INTO `wallet_trade` VALUES (1955263655100698627, '1019', 'N', 3.00, 1, '每日签到', 3.00, '1', 1955263655100698626, '1019', 1954024510055346177, '11028524', '诸葛暑狐', '13988888888', 'http://110.42.56.25:19000/xim/att/16.png', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2025-08-12 21:42:37', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
