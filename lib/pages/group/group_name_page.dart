import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_manage_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 设置群名
class GroupNamePage extends GetView<GroupManageController> {
  // 路由地址
  static const String routeName = '/group_name';
  const GroupNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('修改群名'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              _checkGroupName();
              if (ToolsSubmit.call()) {
                // 提交
                controller.editGroupName();
              }
            },
          ),
        ],
      ),
      body: _buildGroupName(),
    );
  }

  // 群名
  _buildGroupName() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: TextField(
        maxLength: 15,
        controller: controller.nameController,
        decoration: const InputDecoration(
          hintText: '请输入群名',
        ),
      ),
    );
  }

  // 校验
  _checkGroupName() {
    var nickname = controller.nameController.text.trim();
    if (nickname.isEmpty) {
      throw Exception('请输入群名');
    }
  }
}
