import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_manager_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 设置管理员
class GroupManagerPage extends GetView<GroupManagerController> {
  // 路由地址
  static const String routeName = '/group_manager';
  const GroupManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManagerController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('设置管理员'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.call()) {
                // 提交
                controller.setManager();
              }
            },
          ),
        ],
      ),
      body: GetBuilder<GroupManagerController>(builder: (builder) {
        return WidgetContact(
          dataList: controller.dataList,
          selectList: controller.selectList,
          mark: '管理员',
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }
}
