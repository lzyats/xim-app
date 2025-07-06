import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_kicked_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 移出群聊
class GroupKickedPage extends GetView<GroupKickedController> {
  // 路由地址
  static const String routeName = '/group_kicked';
  const GroupKickedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupKickedController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('移除成员'),
        actions: [
          WidgetAction(
            onTap: () {
              if (controller.selectList.isEmpty) {
                throw Exception('请至少选择一个成员哦');
              }
              _kicked(context);
            },
          ),
        ],
      ),
      body: GetBuilder<GroupKickedController>(
        builder: (builder) {
          if (controller.dataList.isEmpty) {
            return WidgetCommon.none();
          }
          return WidgetContact(
            dataList: controller.dataList,
            onSelect: (selectList) {
              controller.selectList = selectList;
            },
          );
        },
      ),
    );
  }

  // 踢人
  _kicked(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认要移除当前成员吗？',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () {
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.kicked();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
