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

 Date: 02/08/2025 20:26:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat_user_sign
-- ----------------------------
DROP TABLE IF EXISTS `chat_user_sign`;
CREATE TABLE `chat_user_sign`  (
  `signid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户ID（关联用户表）',
  `sign_date` date NOT NULL COMMENT '签到日期（仅记录年月日，精确到天）',
  `reward_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '签到奖励（如USDT数量）',
  `sign_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '签到类型：1-正常签到，2-补签',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效：1-有效，0-无效（如取消签到）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间（精确到秒）',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`signid`) USING BTREE,
  UNIQUE INDEX `uk_user_date`(`user_id`, `sign_date`) USING BTREE COMMENT '唯一索引：防止用户同一天重复签到',
  INDEX `idx_user_id`(`user_id`) USING BTREE COMMENT '用户ID索引：优化查询用户签到记录',
  INDEX `idx_sign_date`(`sign_date`) USING BTREE COMMENT '日期索引：优化查询某天的签到统计'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户按天签到记录' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
