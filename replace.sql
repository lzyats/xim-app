-- 定义替换变量（请根据实际需求修改新值）
SET @old_value = '110.42.56.25';  -- 原始需要替换的字符
SET @new_value = '你的指定字符';   -- 替换后的目标字符

-- 1. 更新chat_portrait表的portrait字段
UPDATE chat_portrait
SET portrait = REPLACE(portrait, @old_value, @new_value)
WHERE portrait LIKE CONCAT('%', @old_value, '%');

-- 2. 更新chat_robot表的portrait字段
UPDATE chat_robot
SET portrait = REPLACE(portrait, @old_value, @new_value)
WHERE portrait LIKE CONCAT('%', @old_value, '%');

-- 3. 更新uni_item表的icon字段
UPDATE uni_item
SET icon = REPLACE(icon, @old_value, @new_value)
WHERE icon LIKE CONCAT('%', @old_value, '%');

-- 可选：查看更新结果（验证用）
-- SELECT 'chat_portrait' AS table_name, COUNT(*) AS updated_rows 
-- FROM chat_portrait 
-- WHERE portrait LIKE CONCAT('%', @new_value, '%')
-- UNION ALL
-- SELECT 'chat_robot' AS table_name, COUNT(*) AS updated_rows 
-- FROM chat_robot 
-- WHERE portrait LIKE CONCAT('%', @new_value, '%')
-- UNION ALL
-- SELECT 'uni_item' AS table_name, COUNT(*) AS updated_rows 
-- FROM uni_item 
-- WHERE icon LIKE CONCAT('%', @new_value, '%');
