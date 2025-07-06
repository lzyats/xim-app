import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/group/group_level_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 群聊扩容
class GroupLevelPage extends GetView<GroupLevelController> {
  // 路由地址
  static const String routeName = '/group_level';
  const GroupLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupLevelController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('群聊扩容'),
        actions: [
          WidgetAction(
            label: '确认',
            onTap: () {
              // 校验
              if (controller.level == 0) {
                throw Exception('请选择扩容套餐');
              }
              _showKeyboard(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: GetBuilder<GroupLevelController>(
          builder: (builder) {
            if (controller.refreshList.isEmpty) {
              return WidgetCommon.none();
            }
            return ListView.builder(
              itemCount: controller.refreshList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == controller.refreshList.length) {
                  return Column(
                    children: [
                      WidgetCommon.tips(
                        '当前群容量：${controller.chatGroup.memberTotal}人',
                        textAlign: TextAlign.left,
                      ),
                      WidgetCommon.tips(
                        controller.refreshList.first.remark,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  );
                }
                return _buildItem(controller.refreshList[index]);
              },
            );
          },
        ),
      ),
    );
  }

  _buildItem(GroupModel04 model) {
    Color color = Colors.grey[100] ?? Colors.grey;
    TextStyle style = const TextStyle(fontSize: 16);
    if (controller.level == model.level) {
      style = const TextStyle(fontSize: 16, color: Colors.white);
      color = AppTheme.color;
    }
    return GestureDetector(
      onTap: () {
        controller.changeLevel(model.level);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.extend,
              style: style,
            ),
            Text(
              '${model.count}人',
              style: style,
            ),
            Text(
              '¥ ${model.amount}/${model.between}天',
              style: style,
            ),
          ],
        ),
      ),
    );
  }

  _showKeyboard(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    WidgetCommon.showKeyboard(
      context,
      onPressed: (value) {
        if (ToolsSubmit.call()) {
          // 提交
          controller.groupLevelPay(value);
        }
      },
    );
  }
}
