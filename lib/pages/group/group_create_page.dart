import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_create_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 群聊建群
class GroupCreatePage extends GetView<GroupCreateController> {
  // 路由地址
  static const String routeName = '/group_create';
  const GroupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupCreateController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '新建群聊',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                onTap: () {
                  _submit(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<GroupCreateController>(builder: (builder) {
        return WidgetContact(
          dataList: controller.dataList,
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }

  // 提交
  _submit(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    // 校验
    if (controller.selectList.isEmpty) {
      throw Exception('请至少选择一个好友哦');
    }
    // 弹窗
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          title: const Text('提示'),
          content: const Text('确认创建新的群聊吗？'),
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
                // 返回
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.create();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
