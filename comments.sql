/*
 Navicat Premium Data Transfer

 Source Server         : 阿里
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : rm-2vcq9o3ckk8z27469oo.mysql.cn-chengdu.rds.aliyuncs.com:3306
 Source Schema         : kaolaim

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 02/07/2025 17:19:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '好友表' ROW_FORMAT = Dynamic;

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
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`, `deleted`) USING BTREE,
  UNIQUE INDEX `chat_no`(`user_no`, `deleted`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天用户' ROW_FORMAT = Dynamic;

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
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `idx_moment_time`(`moment_id`, `create_time`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `reply_to`(`reply_to`) USING BTREE,
  CONSTRAINT `friend_comments_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `friend_moments` (`moment_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `friend_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `chat_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `friend_comments_ibfk_3` FOREIGN KEY (`reply_to`) REFERENCES `friend_comments` (`comment_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈评论表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for friend_media_resources
-- ----------------------------
DROP TABLE IF EXISTS `friend_media_resources`;
CREATE TABLE `friend_media_resources`  (
  `media_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '媒体资源ID',
  `moment_id` bigint(20) NOT NULL COMMENT '关联动态ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源URL',
  `type` tinyint(4) NOT NULL COMMENT '类型：0-图片，1-视频，2-音频',
  `sort_order` tinyint(4) NULL DEFAULT 0 COMMENT '排序顺序',
  `width` smallint(6) NULL DEFAULT 0 COMMENT '宽度（图片/视频）',
  `height` smallint(6) NULL DEFAULT 0 COMMENT '高度（图片/视频）',
  `duration` int(11) NULL DEFAULT 0 COMMENT '时长（视频/音频，单位：秒）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`media_id`) USING BTREE,
  INDEX `idx_moment_sort`(`moment_id`, `sort_order`) USING BTREE,
  CONSTRAINT `friend_media_resources_ibfk_1` FOREIGN KEY (`moment_id`) REFERENCES `friend_moments` (`moment_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈媒体资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for friend_moments
-- ----------------------------
DROP TABLE IF EXISTS `friend_moments`;
CREATE TABLE `friend_moments`  (
  `moment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '动态ID',
  `user_id` bigint(20) NOT NULL COMMENT '发布用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文字内容',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置信息',
  `visibility` tinyint(4) NULL DEFAULT 0 COMMENT '可见性：0-公开，1-私密，2-部分可见，3-不给谁看',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除标记',
  PRIMARY KEY (`moment_id`) USING BTREE,
  INDEX `idx_user_time`(`user_id`, `create_time`) USING BTREE,
  CONSTRAINT `friend_moments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `chat_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '朋友圈动态表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
