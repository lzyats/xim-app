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

 Date: 07/08/2025 17:46:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
