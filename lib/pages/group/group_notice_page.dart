import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_manage_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 群聊公告
class GroupNoticePage extends GetView<GroupManageController> {
  // 路由地址
  static const String routeName = '/group_notice';
  const GroupNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改公告'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.call()) {
                // 提交
                controller.editNotice();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildNotice(),
          ],
        ),
      ),
    );
  }

  _buildNotice() {
    return TextField(
      minLines: 5,
      maxLines: null,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\n')),
      ],
      maxLength: 100,
      controller: controller.noticeController,
      decoration: const InputDecoration(
        hintText: '请输入公告',
      ),
    );
  }
}
